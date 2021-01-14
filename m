Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965E82F628D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhANN52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbhANN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:57:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB59CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:56:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610632606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0aqKZSXeBiEhVKURYghLpSr/Q4mAUlW73CTEg1V1Kw=;
        b=fAVY06fRICdCKmHRmpOF0tm8fvA43nOTyJx1xSCY4mBAH9nJQnKZ156csPoGh8TU9rcNpz
        UURsEOyZUxt+58UFRuYQy9yAuk6K1QjX5W39v6kOhP5dted5s6MFRpKf5tJXinbQUnPjJ9
        jLXCEJ0kLKi4y3VwRWJdQ22EleOBJdeZzOfz7ZHzNvwoYUanhdixmsqBgXzqr2iwCi5s4Z
        MHUFLLcTl8d1ikc6yJae0eg1nQTaWPYK2qeGqd3ZXSFczqmI38lryl4PLiXtEfgREGw5Z1
        6xPQZ4cqjjjAaAU2DSUIlFtomtDk7njN2Djt3Pnckm4Cy9pz80r+UB/CpsvCVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610632606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0aqKZSXeBiEhVKURYghLpSr/Q4mAUlW73CTEg1V1Kw=;
        b=GT9pxMUCBmnd1tdq7+fCvCZX2rVDeTIUUQojR9THYqInvxYmvh8nuWdnjJpMzASljr0Nq0
        Bvs6Sj8veDQCTOBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: ringbuffer: fix line counting
In-Reply-To: <YABDAPYB4URXtpJD@alley>
References: <20210113144234.6545-1-john.ogness@linutronix.de> <YABDAPYB4URXtpJD@alley>
Date:   Thu, 14 Jan 2021 15:02:43 +0106
Message-ID: <87r1mnei5g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-14, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1718,7 +1718,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
>>  
>>  	/* Caller interested in the line count? */
>>  	if (line_count)
>> -		*line_count = count_lines(data, data_size);
>> +		*line_count = count_lines(data, len);
>>  
>>  	/* Caller interested in the data content? */
>>  	if (!buf || !buf_size)
>
> Another question is what line count should be returned when
> the data are copied into the buffer. In this case, the text
> might get shrunken even more.

Good point. The code could look like this:

        if (!buf || !buf_size) {
                data_size = len;
        } else {
                data_size = min_t(u16, buf_size, len);
                memcpy(&buf[0], data, data_size);
        }

        if (line_count)
                *line_count = count_lines(data, data_size);
                
        return true;

John Ogness
