Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F992747EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIVSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVSCV (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:02:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2112376F;
        Tue, 22 Sep 2020 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600797740;
        bh=Lz7Zq7qfizx32DWgiFyMSsCnnePT3u5M3aWpR9FNypg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0CdsgYoxYm0CrmhKkNbWV2HEJv3DM4mfLCkk3lGylxzXSVX5XsaaaakRpTM4Fjtj
         7EEE3Lf19JHeWR7PqC6wNGX44ojv8J7I27enVBLbE5/6qCsi/GoIH4x05DYfSE5RsP
         s18TgwLVcS4fbIZL7DD9CctCIYV8ERtWVBehrz7E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A996A400E9; Tue, 22 Sep 2020 15:02:18 -0300 (-03)
Date:   Tue, 22 Sep 2020 15:02:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Skip duration_time in setup_system_wide
Message-ID: <20200922180218.GC2248446@kernel.org>
References: <20200922015004.30114-1-yao.jin@linux.intel.com>
 <20200922175630.GB2248446@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922175630.GB2248446@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 22, 2020 at 02:56:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Sep 22, 2020 at 09:50:04AM +0800, Jin Yao escreveu:
> > Some metrics (such as DRAM_BW_Use) consists of uncore events and
> > duration_time. For uncore events, counter->core.system_wide is
> > true. But for duration_time, counter->core.system_wide is false
> > so target.system_wide is set to false.
> > 
> > Then 'enable_on_exec' is set in perf_event_attr of uncore event.
> > Kernel will return error when trying to open the uncore event.
> > 
> > This patch skips the duration_time in setup_system_wide then
> > target.system_wide will be set to true for the evlist of uncore
> > events + duration_time.
> > 
> > Before (tested on skylake desktop):
> > 
> >  # perf stat -M DRAM_BW_Use -- sleep 1
> >  Error:
> >  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (arb/event=0x84,umask=0x1/).
> >  /bin/dmesg | grep -i perf may provide additional information.
> > 
> > After:
> > 
> >  # perf stat -M DRAM_BW_Use -- sleep 1
> > 
> >   Performance counter stats for 'system wide':
> > 
> >                 169      arb/event=0x84,umask=0x1/ #     0.00 DRAM_BW_Use
> >              40,427      arb/event=0x81,umask=0x1/
> >       1,000,902,197 ns   duration_time
> > 
> >         1.000902197 seconds time elapsed
> > 
> > Fixes: 648b5af3f3ae ("libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'")
> 
> Humm, what makes you think that this cset was the one introducing this
> problem? It just moves evsel->system_wide to evsel->core.system_wide.

Apart from that I reproduced the problem and after applying your patch
it seems cured:

  [acme@quaco perf]$ grep 'model name' -m1 /proc/cpuinfo
  model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz

Before (with -v to see details):

  [root@quaco ~]# perf stat -v -M DRAM_BW_Use -- sleep 1
  Using CPUID GenuineIntel-6-8E-A
  metric expr 64 * ( arb@event\=0x81\,umask\=0x1@ + arb@event\=0x84\,umask\=0x1@ ) / 1000000 / duration_time / 1000 for DRAM_BW_Use
  found event duration_time
  found event arb/event=0x84,umask=0x1/
  found event arb/event=0x81,umask=0x1/
  adding {arb/event=0x84,umask=0x1/,arb/event=0x81,umask=0x1/}:W,duration_time
  Control descriptor is not initialized
  Warning:
  arb/event=0x84,umask=0x1/ event is not supported by the kernel.
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (arb/event=0x84,umask=0x1/).
  /bin/dmesg | grep -i perf may provide additional information.
  
  [root@quaco ~]#

After:

  [root@quaco ~]# perf stat -M DRAM_BW_Use -- sleep 1
  
   Performance counter stats for 'system wide':
  
               2,806      arb/event=0x84,umask=0x1/ #     0.63 DRAM_BW_Use
          10,001,820      arb/event=0x81,umask=0x1/
       1,016,875,686 ns   duration_time
  
         1.016875686 seconds time elapsed
  
  [root@quaco ~]#

So I'm removing that fixes and adding this one, that I think is where
"duration_time" was being considered...

Fixes: e3ba76deef23064f ("perf tools: Force uncore events to system wide monitoring")

Also, wouldn't it be better to have the duration_time event with its
evsel->core.system_wide set to true?

- Arnaldo
