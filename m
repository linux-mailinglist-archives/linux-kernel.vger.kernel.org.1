Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC02AFA26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgKKVFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:05:45 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130AAC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:05:45 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so2255695pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z+2udwxiAxBk6/DCWd+2SzZP73LvSWIE1rQ3M1Od0yU=;
        b=ht5CA0vVvyATd5B9VYHEhdxuPsMJlSFdlBRKP9s6tzdt2WQeIKCi91m4/04bXLC58C
         o0akJkBRT1djzEQPOaUqPB2aH5NcGR5tpco2B8MgNCzXljH6fR3xnUTKYI+497XC5N8r
         hUnxD4/0BwL6+1+yPzBEdjoOk+0yod2halcjN4dt1+3NEzOWGGsk9cV5c4rpJo83Gqmq
         peM6G5otwPs/NeOxTxTVACJAK15JK09pR9VwXGXoN9LoVCWGwFb0D4yWN9WkojlFVObh
         SIti7htUngyY3KKBn2JzGtviemQjpQbkWBZbLMY1BPQsh9jUa16F66lvICgLPPAFBpbC
         xEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z+2udwxiAxBk6/DCWd+2SzZP73LvSWIE1rQ3M1Od0yU=;
        b=kfmUtP0/decR+bsNvMIyHvoSkWnkXWxMAiWgmlLrXL2jc0j3U56MD1evQ2NrVWC5Cm
         N2uZQdJNhlULT3Iw7oPoaVSDoYpZYQ8kpvnHROX8BOC3gh7LaI6lpMyJNACLzjwxdmXB
         qOykQtZvq2VbiRgVCpvBel2PhnEkwOZ7V/ysgBqCyDcuCtXtXNX7Cbt/vh5KcqQ3v6zO
         2SXr/CVuGazfechH+Z4J3zV5AUvq1o3jAwXkOVgSRHLiBk+XhKrv5nT6jTkfdy2uy3Tz
         FzBAJDFIPv20yw0FpzNxJnvkVjxMUcX40utQBZnFHKZN9fD1aGtuVgf4204X1Txcg06V
         6ARg==
X-Gm-Message-State: AOAM530ZSA67m+KOvhQBWAYr7XlT1VRn1YneTPewvicF4GtmXNhlnkKa
        f8XuPHa/+jI3oXijEJLRdjmVffqk+DJClA==
X-Google-Smtp-Source: ABdhPJyH8d1fZj7x9u9zuXrCoi1lrZu4NMdP38V6nc/GDnmYusTaCJ1PgJ56TUP51114Npr+I/5QQQ==
X-Received: by 2002:a17:90b:a05:: with SMTP id gg5mr5726977pjb.227.1605128744127;
        Wed, 11 Nov 2020 13:05:44 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c28sm3952863pfj.108.2020.11.11.13.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 13:05:43 -0800 (PST)
Subject: Re: [PATCH v2] xtensa: fix broken TIF_NOTIFY_SIGNAL assembly
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
References: <20201111205349.24815-1-jcmvbkbc@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <faf78325-3aef-e4aa-ddc6-c21e84a8c7ef@kernel.dk>
Date:   Wed, 11 Nov 2020 14:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111205349.24815-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/20 1:53 PM, Max Filippov wrote:
> TIF_NOTIFY_SIGNAL handling in xtensa assembly is implemented
> incorrectly: there should be a call to do_notify_resume when either
> TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_NOTIFY_SIGNAL bit is set in the
> thread_info::flags. The straightforward way to do it would be
> 
>     _bbsi.l a4, TIF_NEED_RESCHED, 3f
>     _bbsi.l a4, TIF_NOTIFY_RESUME, 2f
>     _bbsi.l a4, TIF_NOTIFY_SIGNAL, 2f
>     _bbci.l a4, TIF_SIGPENDING, 5f
> 
> Optimize it a little bit and use bit mask and bnone opcode to skip
> do_notify_resume invocation. Shuffle _TIF_* flags a bit so that used bit
> mask fits into the immediate field of movi opcode.

Thanks - do you mind if I fold this in with a reference to your
changes? Seems like that'd be a better option than leaving it
broken for a bit.

-- 
Jens Axboe

