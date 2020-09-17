Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0080026E4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIQS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgIQSy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:54:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFB221973;
        Thu, 17 Sep 2020 18:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368898;
        bh=xAk3qdsUbhtQaZ/9TR/OB0g8G/EgH0aSevHCNvrdDVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rvash5Aui1WJesHIICvfQDKy5zdvQ3e2Y8681vCTMOIBHVpLtfJrzOYEdRPKR218B
         iuvlfmieHHAe9v4b27VxxdNOstA/QU6ScmBDt3MmZnpg+TzMp6JsCuqtecH1Ypm9mZ
         jgIlRoqKk7uEnMf7Vgzj20Gp3Xa4CTIeSd6U1yTg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0DD3400E9; Thu, 17 Sep 2020 15:54:55 -0300 (-03)
Date:   Thu, 17 Sep 2020 15:54:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 04/26] perf tools: Add filename__decompress function
Message-ID: <20200917185455.GA1426933@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-5-jolsa@kernel.org>
 <20200914153554.GF160517@kernel.org>
 <20200914204326.GY1714160@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914204326.GY1714160@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 14, 2020 at 10:43:26PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 14, 2020 at 12:35:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Sep 13, 2020 at 11:02:51PM +0200, Jiri Olsa escreveu:
> > > Factor filename__decompress from decompress_kmodule function.
> > > It can decompress files with compressions supported in perf -
> > > xz and gz, the support needs to be compiled in.
> > > 
> > > It will to be used in following changes to get build id out of
> > > compressed elf objects.
> > 
> > This is prep work, can be applied now, done.
> 
> thanks,
> jirka

So, I take that back, one of these decompress patches is causing this:

[root@five ~]# perf list syscalls:sys_enter_open |& tail
lzma: fopen failed on /usr/lib/modules/5.6.19-200.fc31.x86_64/kernel/drivers/acpi/video.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.5.8-200.fc31.x86_64/kernel/net/ipv4/netfilter/nf_reject_ipv4.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.5.9-200.fc31.x86_64/kernel/net/ipv6/netfilter/ip6_tables.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.5.5-200.fc31.x86_64/kernel/drivers/crypto/ccp/ccp.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.4.20-200.fc31.x86_64/kernel/sound/pci/hda/snd-hda-codec.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.5.15-200.fc31.x86_64/kernel/drivers/target/target_core_mod.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.3.7-301.fc31.x86_64/kernel/drivers/iommu/amd_iommu_v2.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.3.7-301.fc31.x86_64/kernel/drivers/media/v4l2-core/videodev.ko.xz: 'No such file or directory'
lzma: fopen failed on /usr/lib/modules/5.6.19-200.fc31.x86_64/kernel/net/ipv4/netfilter/iptable_filter.ko.xz: 'No such file or directory'
  syscalls:sys_enter_open                            [Tracepoint event]
[root@five ~]# perf test 78
78: Check open filename arg using perf trace + vfs_getname          : FAILED!
[root@five ~]#
[root@five ~]# uname -a
Linux five 5.9.0-rc3 #1 SMP Mon Aug 31 08:38:27 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]#

So I removed them from my local branch, I'll rerun the build tests and
then push perf/core when all tests pass.

The test uses 'perf probe' and I noticed it when processing Masami's
debuginfod patches to make 'perf probe' use it, I thought it was his
patches, looking only at the 'perf test 78' output, but ended up being
the decompress ones.

- Arnaldo
