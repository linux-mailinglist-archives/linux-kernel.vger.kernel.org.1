Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD22FDF21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbhAUAyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:54:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732524AbhAUAEi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 19:04:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6476523715;
        Thu, 21 Jan 2021 00:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611187437;
        bh=5fr4z5/rmbcCQOdmoOF/n3lxb1XPUGiO7WPhD1Lx9rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcbzaI657iesOt4GyEiDhf/28WQQz0Npes1+o/o1TfQ2MlC2PgO3gi8X7mktdff0z
         y4oLOF74BURA8AIgOEkfa5P/nwF6t9JhQ07bZeJSsM/jgaKhoFmBlsXYj+7pd3BRnh
         Y1DNO9oAIySwphO/i+zFXwzP778YIDT9SFp/nPH3eCJk1Lctj6VGLN8ceR2MOrWDLZ
         tdawvUvsGCOTLioJJLS33I5cAwNbgakmnT96FtCxgtKhQTN8JCpo0OIZuO2uYr7kbp
         OzzI9IRaZenmq6PxhToaXHpAPhfOLvoL3C+UBKlZzrsXavj7tgf596TPk0Sbw2/C65
         huFfelaYgiuow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1945540513; Wed, 20 Jan 2021 21:03:55 -0300 (-03)
Date:   Wed, 20 Jan 2021 21:03:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Append to default list if use -e +event
Message-ID: <20210121000355.GB106434@kernel.org>
References: <20210104021837.30473-1-yao.jin@linux.intel.com>
 <20210112100807.GB1273297@krava>
 <64dba2a3-0bf2-3af3-6f54-6e200840017d@linux.intel.com>
 <20210120212553.GA1798087@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120212553.GA1798087@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 20, 2021 at 10:25:53PM +0100, Jiri Olsa escreveu:
> On Mon, Jan 18, 2021 at 12:54:37PM +0800, Jin, Yao wrote:
> > root@kbl-ppc:# ./perf stat -e +power/energy-pkg/ -a -- sleep 1

> >  Performance counter stats for 'system wide':

> >               2.02 Joules +power/energy-pkg/

> >        1.000859434 seconds time elapsed

> > The '+' prefix is printed. So I finally decide not to remove the '+' prefix
> > in order to keep original behavior.
 
> hm, originaly there's no purpose for the '+', right?
> it seems it's more like bug then anything else
 
> you added function to the '+' to add default events to specified event,
> which I think is good idea, but I don't think we should display the
> extra '+' in output

The value would be to stress that that is an event added to the ones
without the + prefix, i.e. the default ones.

But by having the command line copied over and the added events at the
first lines we should have that abundantly clear.

Also we won't print removed events (using -), is that available already?

Nope:

[root@quaco ~]# perf stat -e -cycles sleep
event syntax error: '-cycles'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[root@quaco ~]#

Like with:

[root@quaco ~]# perf stat -d sleep 1

 Performance counter stats for 'sleep 1':

              0.80 msec task-clock                #    0.001 CPUs utilized
                 1      context-switches          #    0.001 M/sec
                 0      cpu-migrations            #    0.000 K/sec
                59      page-faults               #    0.073 M/sec
         2,215,522      cycles                    #    2.757 GHz                      (7.40%)
         1,073,189      instructions              #    0.48  insn per cycle           (80.59%)
           203,615      branches                  #  253.392 M/sec
             8,309      branch-misses             #    4.08% of all branches
           245,866      L1-dcache-loads           #  305.972 M/sec
            14,024      L1-dcache-load-misses     #    5.70% of all L1-dcache accesses  (92.60%)
     <not counted>      LLC-loads                                                     (0.00%)
     <not counted>      LLC-load-misses                                               (0.00%)

       1.001887261 seconds time elapsed

       0.000000000 seconds user
       0.001413000 seconds sys


Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
[root@quaco ~]# perf stat -e -LLC* -d sleep 1
event syntax error: '-LLC*'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[root@quaco ~]#

- Arnaldo
