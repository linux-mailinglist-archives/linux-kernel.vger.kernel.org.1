Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167152A2CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgKBOYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgKBOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:24:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A514C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vmZQGXhr/jEYo+bkYxLp/RFU2upV3lt62CYecpxWWes=; b=OL3poVY+epsp5Rm8joo++Dgvmy
        lvqfm528TUDx3/iqxd8XGCdjUX+YOvvpmXdFy08mIkHLhADlQe3r8noxzWFLeMwOaU6PUZCJZ32np
        l3VaVtFkGhZkGRpmYzkdCuo0hVgDqlDSVq2KLSh0cBzv/S9zl8MCbWLhRluTKOrWmjpxLf8K5o4Oz
        4NVoCi6hWsdNNrVpZnvSu+eT4hrwJBnMhpZE+dipYRwojWWNLLQvNZtSkrjquxXePAdXQn8ffj/nm
        ri8fongNZJ1U3oajsHSwFJeLr1/+tkCNY1X/e1c2NjCGLbMLnXKbY+4ZgkVMTs0wyvHOmopwzxyUV
        niR4yxoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZakS-0005iT-E3; Mon, 02 Nov 2020 14:23:52 +0000
Date:   Mon, 2 Nov 2020 14:23:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rong Chen <rong.a.chen@intel.com>
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
Message-ID: <20201102142352.GK27442@casper.infradead.org>
References: <20201030071715.GV31092@shao2-debian>
 <20201030131711.GJ27442@casper.infradead.org>
 <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
 <20201030145835.GL27442@casper.infradead.org>
 <d57f327c-a22e-1fb0-26fe-68b4964e75dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d57f327c-a22e-1fb0-26fe-68b4964e75dc@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:21:39PM +0800, Rong Chen wrote:
> On 10/30/20 10:58 PM, Matthew Wilcox wrote:
> > Can you reproduce this?  Here's my results:
[snipped]
> 
> Hi Matthew,
> 
> IIUC, yes, we can reproduce it, here is the result from the server:
> 
> $ stress-ng --timeout 100 --times --verify --metrics-brief --sequential 96
> --class memory --minimize --exclude spawn,exec,swap,stack,atomic,bad-altstack,bsearch,context,full,heapsort,hsearch,judy,lockbus,lsearch,malloc,matrix-3d,matrix,mcontend,membarrier,memcpy,memfd,memrate,memthrash,mergesort,mincore,null,numa,pipe,pipeherd,qsort,radixsort,remap,resources,rmap,shellsort,skiplist,stackmmap,str,stream,tlb-shootdown,tree,tsearch,vm-addr,vm-rw,vm-segv,vm,wcs,zero,zlib
> 
> stress-ng: info:  [2765] disabled 'oom-pipe' as it may hang or reboot the
> machine (enable it with the --pathological option)
> stress-ng: info:  [2765] dispatching hogs: 96 tmpfs
> stress-ng: info:  [2765] successful run completed in 104.67s (1 min, 44.67
> secs)
> stress-ng: info:  [2765] stressor       bogo ops real time  usr time  sys
> time   bogo ops/s   bogo ops/s
> stress-ng: info:  [2765]                           (secs) (secs)    (secs)  
> (real time) (usr+sys time)
> stress-ng: info:  [2765] tmpfs               363    103.02 622.07  
> 7289.85         3.52         0.05
> stress-ng: info:  [2765] for a 104.67s run time:
> stress-ng: info:  [2765]   10047.98s available CPU time
> stress-ng: info:  [2765]     622.46s user time   (  6.19%)
> stress-ng: info:  [2765]    7290.66s system time ( 72.56%)
> stress-ng: info:  [2765]    7913.12s total time  ( 78.75%)
> stress-ng: info:  [2765] load average: 79.62 28.89 10.45
> 
> we compared the tmpfs.ops_per_sec: (363 / 103.02) between this commit and
> parent commit.

Ah, so this was the 60-70% regression reported in the subject, not the 100%
reported in the body.  I'd assumed the latter was the intended message.

I'll have another look at this later today.  At first glance, I don't
see why it _should_ regress.  It would seem to be doing fewer atomic
operations (avoiding getting the page reference) and walks the XArray more
efficiently.  I wonder if it's walking the XArray _too_ efficiently --
holding the rcu read lock for too long.  I'll try putting a rescheduling
point in the middle and see what happens.
