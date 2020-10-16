Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A1290DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409648AbgJPXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408364AbgJPXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:09:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0150C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602889786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cA4HbeG5F1/kkAuX6BXrrQBRE+JeZsIFauduiNTWrGw=;
        b=RNzrE8wzQHrE2DB0dNM9+GZsQsAQd6BWjIQLZ5fw/O/ynEcg06oJuUpqNvEfKeuy72r2uf
        mCP0D+MJF4rfVyv5RHklWgQ7zaFAqpIZi56QXlE3zN/ggIamWQ6UKNbW1yWbj9glyeA3DX
        L2/ltrDE7ywr9n9wfJ90qE2+vK3F2veVKc8H/oN784yACwrwq6uclWJ2lUH/yvFytsQKCB
        r6UnUiPZ2lKXgyVqAK5EZJ9jahoGudSjZX5UHicTbAwS9AL16ssXZXFNcZrjh2A+TFetsG
        y5gY9X06/lreOS0rtowN0ogpYhxMqa0TVtqa8jhAlyzqrlU3V6f8R92lcRzqWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602889786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cA4HbeG5F1/kkAuX6BXrrQBRE+JeZsIFauduiNTWrGw=;
        b=3cowJjfPa/UmRjdjY/eQshugOr19LwaW4JzZ7BHeIMLSuXN1jCqjqI2rBjNqpWtzlTYns+
        AOTOP8FELsfyoVCw==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: cleanup notification modes
In-Reply-To: <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk> <87tuutalre.fsf@nanos.tec.linutronix.de> <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk>
Date:   Sat, 17 Oct 2020 01:09:46 +0200
Message-ID: <87zh4lix8l.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16 2020 at 16:39, Jens Axboe wrote:
> On 10/16/20 3:44 PM, Thomas Gleixner wrote:
>>> - * @notify: send the notification if true
>>> + * @notify: send chosen notification, if any
>> 
>> Is that really all you found to be wrong in that comment?
>
> There really is nothing wrong, but it's not very descriptive (wasn't
> before either).

 * This is like the signal handler which runs in kernel mode, but it doesn't                                                                                                                                                                                                   
 * try to wake up the @task.   

If find a lot of wrongs in that sentence in context of TWA_SIGNAL.

Agreed, it was hard to understand before that, but with TWA_SIGNAL it
does not make sense at all.

Thanks,

        tglx
