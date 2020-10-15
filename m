Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B828F4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbgJOOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgJOOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:33:41 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AEDC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:33:39 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so4728059ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XOgG5mhAn69DYbnkby1OfMXUNhYU9SfwTkzz6HCQ+CA=;
        b=GCwfdwqumfwqe+c65BGUp/h3eJXia4upa7fM1vDfP1vrkxGKGGiOLwSbseeyigDfQd
         tBzpxN1SkyJ+jjMVJzhq8KFKEbg2fxDaSjKmt2Vrh7YN1rCISHMi9T5AoavQDTZTGeYN
         j5gLJMUdRSJ3r5BiLUL6WBIqZGXFr6zMZCZ6Z2WlH/5Rs3Wdv5atF4lHRSUeppA7ar+7
         wW5oDCCHFSutyJHriJAqzYaOp0/J3DbxYymfR57uO7VYx6x+xfx+4XMRlFlQh6JK3UoT
         3EJ6hLCcGj23bZToN3NvuZZi2NitCPp72RFcDsptaLZ5QNdLkFoV2AzlbVt98rtULj7d
         i/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOgG5mhAn69DYbnkby1OfMXUNhYU9SfwTkzz6HCQ+CA=;
        b=osrkkw+zw45wUUA7zzBDbBxENcrxk+T/wN+8GnqgBkHxPeaK2Jn1mLLxue/n4n1qBH
         0+F/6zLyppVlLVQIoEkt7lNCucuFZXYojhTqbgB6A4RNCFafRi67pn71i082CqqW2SmF
         H7vc3F7i3i44uqBxUd2riGk6ssGsta+usRa/co2XciaIUaY96WKomrXd+fclRQivCt2U
         AAtM5gwVfjkLHBJPviC+2aeDKGoRg8UrX3jYSaGLPVqEy+XlAVj388M43RW3cn98bzK+
         hWXsTW3LD/2jl4s3nV61YuQyrDccAk3MxWc0T9x5sk41WpV0wRGkhsoypgFCW25wIr5Y
         qO0A==
X-Gm-Message-State: AOAM530LQNvQV4lmlrDKWXIz4ApRbOAK0scM+YMqOPi5ryVXdVXFp42i
        0A+5GUETOcHY2SCyWCZIoQ0IsA==
X-Google-Smtp-Source: ABdhPJz6HCRgxHE/VdHqY2c+6G/morl849JJpM7idNUx8P3Z+O1zmATZwYNE2M+6h4i/XBhMlcoV4g==
X-Received: by 2002:a02:a10f:: with SMTP id f15mr3731510jag.62.1602772419025;
        Thu, 15 Oct 2020 07:33:39 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m7sm2730534iop.13.2020.10.15.07.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:33:38 -0700 (PDT)
Subject: Re: [PATCH 3/5] kernel: add support for TIF_NOTIFY_SIGNAL
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-4-axboe@kernel.dk> <20201015143151.GB24156@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d231aa1-b8c7-ae4e-90bb-211f82b57547@kernel.dk>
Date:   Thu, 15 Oct 2020 08:33:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015143151.GB24156@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 8:31 AM, Oleg Nesterov wrote:
> On 10/15, Jens Axboe wrote:
>>
>>  static inline int signal_pending(struct task_struct *p)
>>  {
>> +#if defined(CONFIG_GENERIC_ENTRY) && defined(TIF_NOTIFY_SIGNAL)
>> +	/*
>> +	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
>> +	 * behavior in terms of ensuring that we break out of wait loops
>> +	 * so that notify signal callbacks can be processed.
>> +	 */
>> +	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>> +		return 1;
>> +#endif
>>  	return task_sigpending(p);
>>  }
> 
> I don't understand why does this version requires CONFIG_GENERIC_ENTRY.
> 
> Afaics, it is very easy to change all the non-x86 arches to support
> TIF_NOTIFY_SIGNAL, but it is not trivial to change them all to use
> kernel/entry/common.c ?

I think that Thomas wants to gate TIF_NOTIFY_SIGNAL on conversion to
the generic entry code? Because you are right, it's usually pretty
trivial to wire up the arch code, regardless of whether it uses the
generic entry handling or not.

-- 
Jens Axboe

