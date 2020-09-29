Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955ED27D797
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgI2UHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgI2UHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:07:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD822C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:07:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601410038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15VZJ11fwIaIVYLeO03Rq08ZZiuF4zqt1gejxvSenWc=;
        b=m874V7voFEjl8f8dCJCy2KtxrYOE0gHomHcbuUnjCVwUx6SrZHZhd1tw6XTUrJyTcmKcC3
        7mtSQVdBGewA66HTL6QwYuqdr8JGVGtImxAeoPHgG9OeZs6BlFFchILflylVlLF9V7x8Ho
        bcr7UYiFPP8Hux1AvA0J9cGBKp1lUr7QC8/10wZXvshehDnwwEsQkjsJ2d3EMLc9bBDX7n
        CPP1FuVf9GUYB71TY6CQ0jdbDuyVtBu/AhDAbK6reDCtwg7IxgkUAFXAZQh8tWLdIIsD2D
        2axZ0lN5pbsXYjDvDkjFhVjphkWQdr00QkCQ/Q2+nvnAWxD5b+KmwIvay8jGlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601410038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15VZJ11fwIaIVYLeO03Rq08ZZiuF4zqt1gejxvSenWc=;
        b=bXi4OqcTfSOQ1eeteiOBT8qpP8crvpzG+7+IYyTIOHquDzo/JGR2AP6ruSZ9sENydeaflV
        BxJgB+KytYXnWnDw==
To:     Borislav Petkov <bp@alien8.de>, shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 02/17] x86/acrn: Introduce acrn_{setup, remove}_intr_handler()
In-Reply-To: <20200929175947.GL21110@zn.tnic>
References: <20200922114311.38804-1-shuo.a.liu@intel.com> <20200922114311.38804-3-shuo.a.liu@intel.com> <20200929175947.GL21110@zn.tnic>
Date:   Tue, 29 Sep 2020 22:07:17 +0200
Message-ID: <873630jqiy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29 2020 at 20:01, Borislav Petkov wrote:
> On Tue, Sep 22, 2020 at 07:42:56PM +0800, shuo.a.liu@intel.com wrote:
>> +void acrn_setup_intr_handler(void (*handler)(void))
>> +{
>> +	acrn_intr_handler = handler;
>> +}
>> +EXPORT_SYMBOL_GPL(acrn_setup_intr_handler);
>> +
>> +void acrn_remove_intr_handler(void)
>> +{
>> +	acrn_intr_handler = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(acrn_remove_intr_handler);
>
> I don't like this one bit.
>
> Also, what stops the module from doing acrn_remove_intr_handler()
> while it gets a HYPERVISOR_CALLBACK_VECTOR interrupt and the handler
> disappearing from under it?
>
> IOW, this should be an atomic notifier instead.

That does not prevent that either and notifiers suck. The pointer is
fine and if something removes the handler before all of the muck is
shutdown then the author can keep the pieces and mop up the remains.

Thanks,

        tglx
