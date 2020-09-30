Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124ED27E686
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgI3KYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgI3KYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:24:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07EFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:24:52 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601461491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gKnkuO8al5P4LoWzeLQveTlvMQw18ZxOIr1o+kYlmtc=;
        b=pV+NhretosWvlPSntcohS9342jI6wQ3lO+LllvYpf7nbV5fI4Ujd+nsHkOSsw3IQhEe3Dd
        WI2zC4ZsxHGHYRbxgM10clyTpHkqm0F5ZOKbWsdjfBwnhqiQ1/KtNRM6Xroe6/Qo/Tk8L5
        IQ40+2b5uY0bYBlPOwr0FKGjDFmySR0UvSNo3dprVBIO/e9o0SjeXa0mSUbp5rojWzxfwV
        QODCVIv7fsvtzbwveVo7+4LD+MVVZzeD6n0ygpNttA1kbkSdktYRhW26CJgHKn8AMHXUbz
        Iyy3s6TafEG0UCF9xxAXBW3L3QLv17D8Y0kBqYEhg3CH+7kld48R/NgSnl4Chg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601461491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gKnkuO8al5P4LoWzeLQveTlvMQw18ZxOIr1o+kYlmtc=;
        b=ihpvh3Xd80g8wEwiOtdPxyf/5yP+VA9PCAkAKSgbWPX3AQ2kO5gaTDbIL1DQa9pymaLW72
        CQj4K9pubrMNvcDQ==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
In-Reply-To: <20200930094316.GB987@jagdpanzerIV.localdomain>
References: <20200930090134.8723-1-john.ogness@linutronix.de> <20200930090134.8723-2-john.ogness@linutronix.de> <20200930094316.GB987@jagdpanzerIV.localdomain>
Date:   Wed, 30 Sep 2020 12:30:50 +0206
Message-ID: <87imbv1s0d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-30, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> On (20/09/30 11:07), John Ogness wrote:
>>  bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>> -			 struct printk_record *r, u32 caller_id);
>> +			 struct printk_record *r, u32 caller_id, unsigned int max_size);
>
> Isn't `max_size' always LOG_LINE_MAX?

Yes. But I still think it makes sense that it is an argument of the
function. It is quite an important setting and hard-coding it within the
ringbuffer code might lead to hidden problems later.

John Ogness
