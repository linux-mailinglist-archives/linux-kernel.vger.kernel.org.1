Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F492DA94D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgLOIi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgLOIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:38:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28559C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TC51uqq1p8Gvk7HbcRNA0jHcvsxuvd5APsCIWt526AE=; b=aGm10r7IVXL1/fXK43FKlaSU8H
        LQzPhd/c+VtzszxRf2uOnIMeeDdTscI1bwkI7d1pmEPQD52JJdZQk2SByV2TC4MVkUX1O05sX8MlK
        3lHHC9XdVDepTIdiFaWw/Tpnwkm7P7gtck9JuFmA8mfpTzJtHrlli9iqwDeXfaICmCrM3mCXojeyw
        z6P2IE04PiIKeTOgfSnBX4X/tdCitARCeAuAsexgm+bVDfPhlMsdYO96ukXx/eitdxig1HxQ3It9Q
        8pshYx6zbzVTW6RK+OwWBiMOp8ePpaaiy/lG0qKkvmhD7vd08sHtsoPFtTNqAJuVtaVO7cVEDnQUV
        vfbkn5tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp5pu-0003h8-GT; Tue, 15 Dec 2020 08:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E1F75302753;
        Tue, 15 Dec 2020 09:37:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D007120218DB9; Tue, 15 Dec 2020 09:37:32 +0100 (CET)
Date:   Tue, 15 Dec 2020 09:37:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, zhengjun.xing@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [LKP] Re: [sched/hotplug] 2558aacff8:
 will-it-scale.per_thread_ops -1.6% regression
Message-ID: <20201215083732.GC3040@hirez.programming.kicks-ass.net>
References: <20201210081859.GA19784@xsang-OptiPlex-9020>
 <20201210161408.GX3021@hirez.programming.kicks-ass.net>
 <33c543f8-97c9-cb18-a2f8-a90b8a5769cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c543f8-97c9-cb18-a2f8-a90b8a5769cc@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:35:46PM +0800, Xing Zhengjun wrote:
> On 12/11/2020 12:14 AM, Peter Zijlstra wrote:
> > On Thu, Dec 10, 2020 at 04:18:59PM +0800, kernel test robot wrote:
> > > FYI, we noticed a -1.6% regression of will-it-scale.per_thread_ops due to commit:
> > > commit: 2558aacff8586699bcd248b406febb28b0a25de2 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")
> > 
> > Mooo, weird but whatever. Does the below help at all?
> 
> I test the patch

Thanks!

> , the regression reduced to -0.6%.
> 
> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode:
> 
> lkp-cpl-4sp1/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/100%/thread/sched_yield/performance/0x700001e
> 
> commit:
>   565790d28b1e33ee2f77bad5348b99f6dfc366fd
>   2558aacff8586699bcd248b406febb28b0a25de2
>   4b26139b8db627a55043183614a32b0aba799d27 (this test patch)
> 
> 565790d28b1e33ee 2558aacff8586699bcd248b406f 4b26139b8db627a55043183614a
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>  4.011e+08            -1.6%  3.945e+08            -0.6%  3.989e+08 will-it-scale.144.threads
>    2785455            -1.6%    2739520            -0.6%    2769967 will-it-scale.per_thread_ops
>  4.011e+08            -1.6%  3.945e+08            -0.6%  3.989e+08 will-it-scale.workload

Well, that's better. But I'm rather confused now, because with this new
patch, the actual hot paths are identical, so I've no idea what is
actually causing the regression :/

The above numbers don't seem to have variance, how sure are we the
results are stable? The thing is, when I tried reproducing this locally,
I was mostly looking at noise.

> > ---
> >   kernel/sched/core.c  | 40 +++++++++++++++-------------------------
> >   kernel/sched/sched.h | 13 +++++--------
> >   2 files changed, 20 insertions(+), 33 deletions(-)

Anyway, let me queue this in sched/urgent, it's simpler code and has
less regression.
