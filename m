Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6459D275A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIWOg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:36:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07AC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:36:25 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600871784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ui7hpnIyys5luJxbofLseLzGkNTuHdJO8ux+tEPyvJU=;
        b=yOyV2uWsIg9LUUjzUTl8eu5WA+0E5YuR9NvSp/L/orUvArKuUK4t7MWZ18I015rqWpXCpu
        Mex4GpXHKlZO74/FEmY5Zy8+FfermPCNUt6ox3rQNzmkY/3djLcsiPiPc2nRbz5IFFRdjD
        wla9M7WWfDpzj0LDSiA1r5jJ6B4mXh7Gm61QdKCltSlbN8XrA2j6XzJHXBo10ZxHkxQCle
        3xGPUeZ+4MyHB/G8VjaXfsTUe5H7zXA6yq4oWEOWuL8MOXBsmVA+S4SSCvniEJzokIecDG
        0Da9kwgPcGr68S5ct9bs2zRDviWeY61XtyKoHjXqPqhUOnd3392iMlJisn4Msg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600871784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ui7hpnIyys5luJxbofLseLzGkNTuHdJO8ux+tEPyvJU=;
        b=kwk7s2XbtBU8ItKHtNn5xC2hVF5Fbgm/Y51llw0Wj6+oONG0HOIYNUQ2lu6eLPOywh2VMz
        LcTk3Y7sQh5AQICg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 1/5] printk: get new seq before enabling interrupts
In-Reply-To: <20200923141723.GA6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de> <20200922153816.5883-2-john.ogness@linutronix.de> <20200923141723.GA6442@alley>
Date:   Wed, 23 Sep 2020 16:42:23 +0206
Message-ID: <87r1qszhjs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-23, Petr Mladek <pmladek@suse.com> wrote:
>> After copying all records to the dynamic ringbuffer, setup_log_buf()
>> checks to see if any records were dropped during the switch. However,
>> it needs to check before enabling interrupts since new records could
>> arrive in an interrupt, thus causing setup_log_buf() to erroneously
>> think that it had dropped messages.
>
> Have you seen the problem, please?
>
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  kernel/printk/printk.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 1fe3d0cb2fe0..00bc1fce3299 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1181,12 +1181,12 @@ void __init setup_log_buf(int early)
>>  	 */
>>  	prb = &printk_rb_dynamic;
>>  
>> +	seq = prb_next_seq(&printk_rb_static) - seq;
>> +
>>  	logbuf_unlock_irqrestore(flags);
>>  
>> -	if (seq != prb_next_seq(&printk_rb_static)) {
>
> I can't see how these two values could get modified after enabling interrupts.
>
>   + @seq is set in the for-cycle before the interrupts are enabled.
>
>   + @prb is updated before the interrupts are  enabled. So that
>     the static buffer should not longer be used after that.

You are correct. This patch should be disregarded.

John Ogness
