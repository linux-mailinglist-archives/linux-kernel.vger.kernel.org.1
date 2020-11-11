Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AC82AF58E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgKKP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgKKP4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:56:52 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07AC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:56:50 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id z2so2382316ilh.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YDgipb1HR2hGS/gHOTc8hqAiYPDroS+EmqylMHoG/n8=;
        b=GuB/0hI3E5vSmIG4CpSmbdZGcM7VO2xLhQ5PtKbk94AD01gJdqjxahwy8U9adTGITd
         3bwOAcZs/M3fUl6jqwPu947IK7LDhLPaUhkLnuUduK0aVob3bdqJTGyjwakaufWOYM/z
         sth8C05Ut6bmFZlHEDRRUzVLCHzgyVY+hL3NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YDgipb1HR2hGS/gHOTc8hqAiYPDroS+EmqylMHoG/n8=;
        b=qgxhZjAyl+BIzErJ7jOTcIfSy0Cb6+evCceDxxzNOmV/vPjjONG4HMzQwYbzmXgFJO
         X+cZdrbHT7cuBPDYH7K7yjbjCz9llhD6eXgoqoc8QpU77C9LT+/JllzNPFlbh63UTNtt
         fqFQSXRMn523WB2FB2jg4etUDzRC61Sq+YtZhK5bW0gZI8V5bkMMtL3J6Q0PSVHqZCKR
         /tkXRwd9Xd3NKQ4Vb0jgqFL99x41QEcg4/2icWS29b4lPr99/nP1HZ7vAfpEWEnw4O5I
         Zcryv/uF44QjRnQ5XWT7PT2DXrX0kIeIB2YkX/mOirU8bl0nBRa0euVZ27S/rJOB0o0f
         MpUg==
X-Gm-Message-State: AOAM533NbBewH0fdhCnQs3H8FW/w/9Ut+Wc3MgCYyQPE+tz7m/v8qYc3
        C4IXQue2E8jF8D5kdyR983quIQ==
X-Google-Smtp-Source: ABdhPJxZw7470w91IrHbuN/mFFQ6wUMQn8CYV0L4g72lUUBr68hOojGMnxOA7lSWGjhxpltYrpKonA==
X-Received: by 2002:a92:ca90:: with SMTP id t16mr17411487ilo.33.1605110210331;
        Wed, 11 Nov 2020 07:56:50 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i201sm1412763ild.12.2020.11.11.07.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 07:56:49 -0800 (PST)
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201111082320.GR2611@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
Date:   Wed, 11 Nov 2020 08:56:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201111082320.GR2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 1:23 AM, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 12:53:27PM -0700, Shuah Khan wrote:
> 
>> + * The interface provides:
>> + * seqnum32 & seqnum64 functions:
>> + *	initialization
>> + *	set
>> + *	read
>> + *	increment and no return
>> + *	decrement and no return
> 
> NAK, this is batshit insane again.

Gosh that is a bit much. Definitely will never be part of my kernel
review/response vocabulary.

If you want a sequence number, the
> one and _ONLY_ primitive you want to expose is inc_return.
> 
> No set, no read, no inc, and most certainly, not dec.
> 

Agree with you on removing dec(). It isn't needed or up counting.
set() can go and use just init instead of set.

read and inc are needed for sure though. The reason being numbers
could be incremented in one place and read in other places. In some
cases inc_return is used.

Why would you say no to read and inc?

init, read, inc, and inc_return are necessary to be able to implement
up counters.

thanks,
-- Shuah
