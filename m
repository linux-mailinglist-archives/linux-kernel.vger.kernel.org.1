Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1ED2A0907
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgJ3PCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgJ3PCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:02:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C62AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kxl8Z1hkovowUCo7WLKdimdgnLlbvbHVA4wKUlwczWQ=; b=tPoHzA/U6BXDdJfXPTKU0BetKr
        Mpk2VMOB6WPYrrTh8UrpDhizP5NF4jKLglJlADsbu2CTaYHhJi5p5sI07LzAsrjXqJRPYXeEa9UR0
        BF+/y/A/WlbZ1D0iUeTxE0fJs5LSqhaIDVZ5vnZ3iuu/5aO2lGv72UtFjlkZd0Fmksc6yXT0bW3ih
        87XDMcro3NOHhLplBjjKjdoezLbmw0lyU/o63V8UD2eKFHgBhuLGlovxO1cQGCeI6QZKHrQbmNyQD
        KOc71O+NvlgmT+mBMXP2l/cbrHFasr45lrL0xyqUEfXXd1A1RuJ05YDC4FQ29asWOikgklOdL1T27
        UpYq1tkA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYVrP-000134-3M; Fri, 30 Oct 2020 14:58:35 +0000
Date:   Fri, 30 Oct 2020 14:58:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7% regression
Message-ID: <20201030145835.GL27442@casper.infradead.org>
References: <20201030071715.GV31092@shao2-debian>
 <20201030131711.GJ27442@casper.infradead.org>
 <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:02:45PM +0800, Chen, Rong A wrote:
> On 10/30/2020 9:17 PM, Matthew Wilcox wrote:
> > On Fri, Oct 30, 2020 at 03:17:15PM +0800, kernel test robot wrote:
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > > 
> > > 
> > > To reproduce:
> > > 
> > >          git clone https://github.com/intel/lkp-tests.git
> > >          cd lkp-tests
> > >          bin/lkp install job.yaml  # job file is attached in this email
> > >          bin/lkp run     job.yaml
> > 
> > Do you actually test these instructions before you send them out?
> > 
> > hdd_partitions: "/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WX11A23L4840-part
> > 1"
> > ssd_partitions: "/dev/nvme1n1p1 /dev/nvme0n1p1"
> > rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2CW240A3_CVCV204303WP240CGN-part1"
> > 
> > That's _very_ specific to a given machine.  I'm not familiar with
> > this test, so I don't know what I need to change.
> 
> 
> Hi Matthew,
> 
> Sorry about that, I copied the job.yaml file from the server,
> the right way to do is to set your disk partitions in the yaml,
> please see https://github.com/intel/lkp-tests#run-your-own-disk-partitions.
> 
> there is another reproduce script attached in the original mail
> for your reference.

Can you reproduce this?  Here's my results:

# stress-ng "--timeout" "100" "--times" "--verify" "--metrics-brief" "--sequential" "96" "--class" "memory" "--minimize" "--exclude" "spawn,exec,swap,stack,atomic,bad-altstack,bsearch,context,full,heapsort,hsearch,judy,lockbus,lsearch,malloc,matrix-3d,matrix,mcontend,membarrier,memcpy,memfd,memrate,memthrash,mergesort,mincore,null,numa,pipe,pipeherd,qsort,radixsort,remap,resources,rmap,shellsort,skiplist,stackmmap,str,stream,tlb-shootdown,tree,tsearch,vm-addr,vm-rw,vm-segv,vm,wcs,zero,zlib"
stress-ng: info:  [7670] disabled 'oom-pipe' as it may hang or reboot the machine (enable it with the --pathological option)
stress-ng: info:  [7670] dispatching hogs: 96 tmpfs
stress-ng: info:  [7670] successful run completed in 100.23s (1 min, 40.23 secs)
stress-ng: info:  [7670] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [7670]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [7670] tmpfs              8216    100.10    368.02    230.89        82.08        13.72
stress-ng: info:  [7670] for a 100.23s run time:
stress-ng: info:  [7670]     601.38s available CPU time
stress-ng: info:  [7670]     368.71s user time   ( 61.31%)
stress-ng: info:  [7670]     231.55s system time ( 38.50%)
stress-ng: info:  [7670]     600.26s total time  ( 99.81%)
stress-ng: info:  [7670] load average: 78.32 27.87 10.10

