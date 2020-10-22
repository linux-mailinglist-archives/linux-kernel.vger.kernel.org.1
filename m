Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96490295891
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440846AbgJVGv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405139AbgJVGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:51:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1336C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 23:51:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w23so664025edl.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 23:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83WaSwSjuw+5p/FwjUSXyrPazCj9QLrPDjKBSL0j68I=;
        b=XW8VcTgNWSBX9ZRx6R0cOXlNGg07ZkU2zI/qkfhZD51+qIvk6yJMY/4ska7xYpkkPs
         oJUFlge2Pwuv4dmUGr2CwCWLrC2zD6AhVUx19LOsjrn/mrteyyoceldP7qXhlTSdwQk8
         QXBXDqVsEEIsCA2jpmZDYl2osBA0hGlO1i6xT1S9Jvgz6AwCoKOgiRlsaxbXgMHH2CQX
         VKcJB5rugckficd1IZtz/E8S+1NOFAVo0NXtbQEhLGq8vaZphnsir+1nG1M6FonLbEX5
         BV5XvDNizbyyuxbEDglljjC1vg1wPvUsfhjJpSOW97XgfW8W18GpgWwEvwmmCyWKkQmN
         QtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83WaSwSjuw+5p/FwjUSXyrPazCj9QLrPDjKBSL0j68I=;
        b=Cpg1jDWpJb6cniVlk6xZ5x2gnqdLdM+OpX8i5W6SOHWlf5gw4AS2BiyTfH1CDzIssO
         BqYAWMSlK/wF7tEFL73IoVbRYwI4YQadxXmtSybSWWmOZ+C4zu/Z9MXj/CACwxZjzIia
         LoXbFHZ5JFiUjo3i8TDljVyGC8rIeMyGKR2yhyFfH8vPBwEfmFjAqmnV+KM5LmjOD0hR
         4PR4CTUz/ESM5SG6BPcqycfAANg9GoQp0qwu5KSn2U0pzkpqezP6XcQlxzxn3mRVo6ur
         uRUvMQTfpFYfCTpwrpWVkPLOhSVaJihKBp6ksnCrNS+9165EyP3Cf+rLXsAdHx++Wo1e
         yNNQ==
X-Gm-Message-State: AOAM530zwhvUD8edswzsmki7k4wiWvf0fpS2a+cTRhkQ9LDfjjJ56oCH
        lFoUXe8M71i5HrDL6u568/o=
X-Google-Smtp-Source: ABdhPJwZBzBdphPetBP0IJSt6mlMSX0ojTkIOiLLlGN3oY0PLWU9ycw3CX8yZpK2pF16dZtCPBnLdw==
X-Received: by 2002:a50:fe98:: with SMTP id d24mr905626edt.223.1603349485438;
        Wed, 21 Oct 2020 23:51:25 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q9sm276282ejd.66.2020.10.21.23.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 23:51:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1D42E27C0054;
        Thu, 22 Oct 2020 02:51:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 22 Oct 2020 02:51:22 -0400
X-ME-Sender: <xms:6SuRX3UiIOxdZZi3knddG1LyQl204wbojrHbZA7Z9bikX1IgkDOOFQ>
    <xme:6SuRX_nlder7mDYSFGJiR7nL0XMUws0G1M61k1-dBlVRSh0175PcnBJKuMe97tZuf
    L9SVy0JWI4JvFgheA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepieevheevhfelgeejleehheeghffgvdejfeduieevtddutddtteefiefhffel
    tddvnecuffhomhgrihhnpegvfhhfihgtihhoshdrtghomhenucfkphepudefuddruddtje
    drudegjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeile
    dvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgt
    ohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:6SuRXzb5vKdzIpcV04IThPRVpeuKP9_9h8sfD82s2TmpNemzk7CjPQ>
    <xmx:6SuRXyUMCApUPXLiVMZwzFaHN_8jliHq22zHUr_2bvRN2CmRkBfdag>
    <xmx:6SuRXxkutgRI3y5KukO5xKawrtnpceUVNxtSJeiNBkAgLwf3RYrMwA>
    <xmx:6iuRXyiA_BlA6skP5xib8GpezsjBhxCUd1DY7Xer6yshKJDD0Bk2kKfTASE>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id F29A93064610;
        Thu, 22 Oct 2020 02:51:20 -0400 (EDT)
Date:   Thu, 22 Oct 2020 14:51:00 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] sched: fix exit_mm vs membarrier (v4)
Message-ID: <20201022065100.GA855403@boqun-archlinux>
References: <20201020134715.13909-1-mathieu.desnoyers@efficios.com>
 <20201020134715.13909-2-mathieu.desnoyers@efficios.com>
 <20201020143648.GU2628@hirez.programming.kicks-ass.net>
 <1123875792.30589.1603205998119.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123875792.30589.1603205998119.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 20, 2020 at 10:59:58AM -0400, Mathieu Desnoyers wrote:
> ----- On Oct 20, 2020, at 10:36 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, Oct 20, 2020 at 09:47:13AM -0400, Mathieu Desnoyers wrote:
> >> +void membarrier_update_current_mm(struct mm_struct *next_mm)
> >> +{
> >> +	struct rq *rq = this_rq();
> >> +	int membarrier_state = 0;
> >> +
> >> +	if (next_mm)
> >> +		membarrier_state = atomic_read(&next_mm->membarrier_state);
> >> +	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
> >> +		return;
> >> +	WRITE_ONCE(rq->membarrier_state, membarrier_state);
> >> +}
> > 
> > This is suspisioucly similar to membarrier_switch_mm().
> > 
> > Would something like so make sense?
> 
> Very much yes. Do you want me to re-send the series, or you
> want to fold this in as you merge it ?
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > ---
> > --- a/kernel/sched/membarrier.c
> > +++ b/kernel/sched/membarrier.c
> > @@ -206,14 +206,7 @@ void membarrier_exec_mmap(struct mm_stru
> > 
> > void membarrier_update_current_mm(struct mm_struct *next_mm)
> > {
> > -	struct rq *rq = this_rq();
> > -	int membarrier_state = 0;
> > -
> > -	if (next_mm)
> > -		membarrier_state = atomic_read(&next_mm->membarrier_state);
> > -	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
> > -		return;
> > -	WRITE_ONCE(rq->membarrier_state, membarrier_state);
> > +	membarrier_switch_mm(this_rq(), NULL, next_mm);
> > }
> > 
> > static int membarrier_global_expedited(void)
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index d2621155393c..3d589c2ffd28 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2645,12 +2645,14 @@ static inline void membarrier_switch_mm(struct rq *rq,
> > 					struct mm_struct *prev_mm,
> > 					struct mm_struct *next_mm)
> > {
> > -	int membarrier_state;
> > +	int membarrier_state = 0;
> > 
> > 	if (prev_mm == next_mm)

Unless I'm missing something subtle, in exit_mm(),
membarrier_update_current_mm() is called with @next_mm == NULL, and
inside membarrier_update_current_mm(), membarrier_switch_mm() is called
wiht @prev_mm == NULL. As a result, the branch above is taken, so
membarrier_update_current_mm() becomes a nop. I think we should use the
previous value of current->mm as the @prev_mm, something like below
maybe?

void update_current_mm(struct mm_struct *next_mm)
{
	struct mm_struct *prev_mm;
	unsigned long flags;

	local_irq_save(flags);
	prev_mm = current->mm;
	current->mm = next_mm;
	membarrier_switch_mm(this_rq(), prev_mm, next_mm);
	local_irq_restore(flags);
}

, and replace all settings for "current->mm" in kernel with
update_current_mm().

Thoughts?

Regards,
Boqun

> > 		return;
> > 
> > -	membarrier_state = atomic_read(&next_mm->membarrier_state);
> > +	if (next_mm)
> > +		membarrier_state = atomic_read(&next_mm->membarrier_state);
> > +
> > 	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
> >  		return;
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
