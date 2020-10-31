Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880AD2A13C6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 07:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJaGNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 02:13:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:37317 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgJaGNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 02:13:19 -0400
IronPort-SDR: RCIdDTfKnxrGxnZMzPkKIpV30dYnAdL98CBUmGVYmIgq6qHc58Zx5tpiUlPXXsnf7SHb8rkYTb
 1wpaN+hgnixA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="167920955"
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="167920955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 23:13:18 -0700
IronPort-SDR: m8OptJHe7GVN0XuuZk1BZ8n105zf0kQnyCVJFMlwQ7k2HvGH7SbwLrporojD5r+MbzIeBXTXvo
 Ji3rQSpejidg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; 
   d="scan'208";a="537321337"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2020 23:13:14 -0700
Date:   Sat, 31 Oct 2020 14:10:49 +0800
From:   Philip Li <philip.li@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, zhengjun.xing@intel.com
Subject: Re: [LKP] Re: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7%
 regression
Message-ID: <20201031061049.GA25495@intel.com>
References: <20201030071715.GV31092@shao2-debian>
 <20201030131711.GJ27442@casper.infradead.org>
 <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
 <20201030145835.GL27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030145835.GL27442@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 02:58:35PM +0000, Matthew Wilcox wrote:
> On Fri, Oct 30, 2020 at 10:02:45PM +0800, Chen, Rong A wrote:
> > On 10/30/2020 9:17 PM, Matthew Wilcox wrote:
> > > On Fri, Oct 30, 2020 at 03:17:15PM +0800, kernel test robot wrote:
> > > > Details are as below:
> > > > -------------------------------------------------------------------------------------------------->
> > > > 
> > > > 
> > > > To reproduce:
> > > > 
> > > >          git clone https://github.com/intel/lkp-tests.git
> > > >          cd lkp-tests
> > > >          bin/lkp install job.yaml  # job file is attached in this email
> > > >          bin/lkp run     job.yaml
> > > 
> > > Do you actually test these instructions before you send them out?
> > > 
> > > hdd_partitions: "/dev/disk/by-id/ata-WDC_WD2500BEKT-00PVMT0_WD-WX11A23L4840-part
> > > 1"
> > > ssd_partitions: "/dev/nvme1n1p1 /dev/nvme0n1p1"
> > > rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2CW240A3_CVCV204303WP240CGN-part1"
> > > 
> > > That's _very_ specific to a given machine.  I'm not familiar with
> > > this test, so I don't know what I need to change.
> > 
> > 
> > Hi Matthew,
> > 
> > Sorry about that, I copied the job.yaml file from the server,
> > the right way to do is to set your disk partitions in the yaml,
> > please see https://github.com/intel/lkp-tests#run-your-own-disk-partitions.
> > 
> > there is another reproduce script attached in the original mail
> > for your reference.
> 
> Can you reproduce this?  Here's my results:
thanks for quick check, we will provide update right after the weekend. Sorry
for any inconvenience for the reproduction side so far. We need to improve
this part.

> 
> # stress-ng "--timeout" "100" "--times" "--verify" "--metrics-brief" "--sequential" "96" "--class" "memory" "--minimize" "--exclude" "spawn,exec,swap,stack,atomic,bad-altstack,bsearch,context,full,heapsort,hsearch,judy,lockbus,lsearch,malloc,matrix-3d,matrix,mcontend,membarrier,memcpy,memfd,memrate,memthrash,mergesort,mincore,null,numa,pipe,pipeherd,qsort,radixsort,remap,resources,rmap,shellsort,skiplist,stackmmap,str,stream,tlb-shootdown,tree,tsearch,vm-addr,vm-rw,vm-segv,vm,wcs,zero,zlib"
> stress-ng: info:  [7670] disabled 'oom-pipe' as it may hang or reboot the machine (enable it with the --pathological option)
> stress-ng: info:  [7670] dispatching hogs: 96 tmpfs
> stress-ng: info:  [7670] successful run completed in 100.23s (1 min, 40.23 secs)
> stress-ng: info:  [7670] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
> stress-ng: info:  [7670]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
> stress-ng: info:  [7670] tmpfs              8216    100.10    368.02    230.89        82.08        13.72
> stress-ng: info:  [7670] for a 100.23s run time:
> stress-ng: info:  [7670]     601.38s available CPU time
> stress-ng: info:  [7670]     368.71s user time   ( 61.31%)
> stress-ng: info:  [7670]     231.55s system time ( 38.50%)
> stress-ng: info:  [7670]     600.26s total time  ( 99.81%)
> stress-ng: info:  [7670] load average: 78.32 27.87 10.10
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
