Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49BF27944B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgIYWm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgIYWm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:42:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE09C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:42:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601073746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96DtGBOKlktmzwXCdWvNdJ/FfKuTcoDytGwfHRLJ2JQ=;
        b=kAl5/ji287iqEKcRhfXaGLJK5jamwYS2UuZXDnkuXaH+caUP2jjwS0fPG+8SQUkWVnNohP
        vCsy9ysVVZOIkq7LOhsHk8TrGWMPrAxPkVntJbwekiV/s6M6HUbACemPmQ5IgrQyQi0WX9
        G4gLmoifeudRRLgOLBOG8dFV6T3LmtPx9LtSon1uOJ5M/UCuh2/RTAVp4PCTmy3Javw2BE
        VGRaiSACLD/q54Pm4NGg18wfPqFR97FEVizIYXSonQVBBYT8Wq+HXw/BHotw5hPjR7dUkF
        KVq/pzXLK6nWpai/DdGIkbXdAUVNgQM916yQqAhE91eMYAjyW5WtVhzv+pXDOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601073746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96DtGBOKlktmzwXCdWvNdJ/FfKuTcoDytGwfHRLJ2JQ=;
        b=2PkO+cku2+w7r3yuyP07bNRX4ZxPPQd1zrzEF2aOsjdmXUw+6JEjg7fVfnhe6BELclzdAq
        tgHC0zM/KixRI2CA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
In-Reply-To: <20200925004207.GE19346@lenoir>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com> <20200915115609.85106-5-qianjun.kernel@gmail.com> <878scz89tl.fsf@nanos.tec.linutronix.de> <20200925004207.GE19346@lenoir>
Date:   Sat, 26 Sep 2020 00:42:25 +0200
Message-ID: <874knlv5pq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25 2020 at 02:42, Frederic Weisbecker wrote:

> On Thu, Sep 24, 2020 at 05:37:42PM +0200, Thomas Gleixner wrote:
>> Subject: softirq; Prevent starvation of higher softirq vectors
> [...]
>> +	/*
>> +	 * Word swap pending to move the not yet handled bits of the previous
>> +	 * run first and then clear the duplicates in the newly raised ones.
>> +	 */
>> +	swahw32s(&cur_pending);
>> +	pending = cur_pending & ~(cur_pending << SIRQ_PREV_SHIFT);
>> +
>>  	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
>>  		int prev_count;
>>  
>> +		vec_nr &= SIRQ_VECTOR_MASK;
>
> Shouldn't NR_SOFTIRQS above protect from that?

It does, but that's wrong. The bitmap size in that for_each() loop must
obviously be SIRQ_PREV_SHIFT + NR_SOFTIRQS for this to work.

>> +	} else {
>> +		/*
>> +		 * Retain the unprocessed bits and swap @cur_pending back
>> +		 * into normal ordering
>> +		 */
>> +		cur_pending = (u32)pending;
>> +		swahw32s(&cur_pending);
>> +		/*
>> +		 * If the previous bits are done move the low word of
>> +		 * @pending into the high word so it's processed first.
>> +		 */
>> +		if (!(cur_pending & SIRQ_PREV_MASK))
>> +			cur_pending <<= SIRQ_PREV_SHIFT;
>
> If the previous bits are done and there is no timeout, should
> we consider to restart a loop?

We only enter this code path if there was a timeout. Otherwise pending
would be 0.

Thanks,

        tglx
