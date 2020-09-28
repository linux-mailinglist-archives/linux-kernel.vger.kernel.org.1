Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5385F27AFD4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1OQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgI1OQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:16:52 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DDC2075A;
        Mon, 28 Sep 2020 14:16:51 +0000 (UTC)
Date:   Mon, 28 Sep 2020 15:16:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next 3/5] mm/kmemleak: Add support for percpu memory
 leak detect
Message-ID: <20200928141643.GB27500@gaia>
References: <20200921020007.35803-1-chenjun102@huawei.com>
 <20200921020007.35803-4-chenjun102@huawei.com>
 <20200922095736.GB15643@gaia>
 <CE1E7D7EFA066443B6454A6A5063B502209EB04F@DGGEML529-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CE1E7D7EFA066443B6454A6A5063B502209EB04F@DGGEML529-MBS.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 02:08:29PM +0000, chenjun (AM) wrote:
> On Mon, Sep 21, 2020 at 02:00:05AM +0000, Chen Jun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >> @@ -651,6 +672,19 @@ static void create_object(unsigned long ptr, size_t size, int min_count,
> >>   	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> >>   }
> >>   
> >> +static void create_object(unsigned long ptr, size_t size, int min_count,
> >> +			  gfp_t gfp)
> >> +{
> >> +	__create_object(ptr, size, min_count, 0, gfp);
> >> +}
> >> +
> >> +static void create_object_percpu(unsigned long ptr, size_t size, int min_count,
> >> +				 gfp_t gfp)
> >> +{
> >> +	__create_object(ptr, size, min_count, OBJECT_PERCPU | OBJECT_NO_SCAN,
> >> +			gfp);
> >> +}
> >> +
> >>   /*
> >>    * Mark the object as not allocated and schedule RCU freeing via put_object().
> >>    */
> >> @@ -912,10 +946,12 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
> >>   	 * Percpu allocations are only scanned and not reported as leaks
> >>   	 * (min_count is set to 0).
> >>   	 */
> >> -	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> >> +	if (kmemleak_enabled && ptr && !IS_ERR(ptr)) {
> >>   		for_each_possible_cpu(cpu)
> >>   			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
> >>   				      size, 0, gfp);
> >> +		create_object_percpu((unsigned long)ptr, size, 1, gfp);
> >> +	}
> >>   }
> > 
> > A concern I have here is that ptr may overlap with an existing object
> > and the insertion in the rb tree will fail. For example, with !SMP,
> > ptr == per_cpu_ptr(ptr, 0), so create_object() will fail and kmemleak
> > gets disabled.
> > 
> > An option would to figure out how to allow overlapping ranges with rb
> > tree (or find a replacement for it if not possible).
> > 
> > Another option would be to have an additional structure to track the
> > __percpu pointers since they have their own range. If size is not
> > relevant, maybe go for an xarray, otherwise another rb tree (do we have
> > any instance of pointers referring some inner member of a __percpu
> > object?). The scan_object() function will have to search two trees.
> 
> I would like to use CONFIG_SMP to seprate code:
> if SMP, we will create some objects for per_cpu_ptr(ptr, cpu) and an 
> object with OBJECT_NO_ACCESS for ptr.
> if !SMP, we will not create object for per_cpu_ptr(ptr,cpu), but an 
> object without OBJECT_NO_ACCESS for ptr will be created.
> What do you think about this opinion.

The !SMP case was just an example. Do you have a guarantee that the
value of the __percpu ptr doesn't clash with a linear map address?

-- 
Catalin
