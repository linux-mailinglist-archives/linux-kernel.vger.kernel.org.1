Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4172D87E4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437629AbgLLQSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 11:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405775AbgLLQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:18:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D58C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 08:17:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c79so9141539pfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRbYY02f9clS43YVleEXwolZohCb1GhkfTVXt9QbL0E=;
        b=vsjgYUTfNCCtDgpjPI/UNREc9kslTmeGhTtJqe29o5slFUu5D0I4gqrHyaQZFtNNE5
         PxOEsyYzaRPefon/bTcQZ1nSPKPuwcIlAcjAsiOqPCmjNBV/SssN4m/0PT8NsVH0t/4x
         v0vmoyHnwGrvChvbpBG5n3T7sepacpniirwjkrfEUwXVyD/tIZyLcrPldT75Gg09qmKa
         ucChMtWnvvBZhWDPn1eNNYMW26Y+dHEJNpyh/PC3L/bQwOECLdPFW4vBm4gnHMrv3amr
         gaLX1ASHPhFah+SWDlL7SiK/qAeaVq2wf9mVa0HBpqQga48sOgwKupTFKa955IeAH8vP
         +XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRbYY02f9clS43YVleEXwolZohCb1GhkfTVXt9QbL0E=;
        b=iw5nwnxp7Q62uset0f0A0gQDrLf6c7AEmRMG7pT98PRL3i7N7sF3s0Ya2LqCNX8wa2
         mrVtobN9IRC7N9YmNYrLrP+AFk2v/cm94KDUylWH+dDU3yXAG4JRkEsa/vxy7B2SBzKZ
         KaHhmDlzO+KtlrB/9p4/ekTvwtT+zJLYwotny4R6hvBAwEdtGVmo5xmHExGmnDuBw2g6
         bfgu6BOaMhm4NiOd3w6WrPT7Hc9PCvmNnk7qZ4ssalZCGFK6y9UrD1l6SYJQEu5wA1I6
         S/OSf9gbJuMu4FoeOTl+YtQugMPc4DaBsV7HQYO3s9EpAYdOWvDMaimTqFY3fmumzlDv
         WuiQ==
X-Gm-Message-State: AOAM531pshkI+yKdjiV0mQzVtl17U9DnRnTlYr+D5rKZOSeJj5/zMAMz
        jSDHpbFz45knYXTwZFqoPfgDIQ==
X-Google-Smtp-Source: ABdhPJzfQ1TvWSFFxUgORBv80/YGd8iJqo6CVFEw9wWbphuPqyp5Jh7hNOjT/EUYQphXwzY7Jiw9Tg==
X-Received: by 2002:a63:f02:: with SMTP id e2mr16867120pgl.148.1607789869753;
        Sat, 12 Dec 2020 08:17:49 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g26sm14323628pfo.35.2020.12.12.08.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 08:17:49 -0800 (PST)
Subject: Re: [PATCH -next] c6x: fix build of signal.c using _TIF_SIGNALs
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-c6x-dev@linux-c6x.org, Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
References: <20201210031742.14534-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe4f2b2e-66e6-94f2-d878-08a8e926cd4d@kernel.dk>
Date:   Sat, 12 Dec 2020 09:17:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210031742.14534-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 8:17 PM, Randy Dunlap wrote:
> kernel/signal.c in arch/c6x/ needs <asm/asm-offsets.h> to build
> since it contains _TIF_SIGNALfoobar #defines, so add it.
> 
> Placates these build errors:
> 
> ../arch/c6x/kernel/signal.c: In function 'do_notify_resume':
> ../arch/c6x/kernel/signal.c:316:27: error: '_TIF_SIGPENDING' undeclared (first use in this function); did you mean 'TIF_SIGPENDING'?
>   316 |  if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>       |                           ^~~~~~~~~~~~~~~
> ../arch/c6x/kernel/signal.c:316:27: note: each undeclared identifier is reported only once for each function it appears in
> ../arch/c6x/kernel/signal.c:316:45: error: '_TIF_NOTIFY_SIGNAL' undeclared (first use in this function); did you mean 'TIF_NOTIFY_SIGNAL'?
>   316 |  if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>       |                                             ^~~~~~~~~~~~~~~~~~

Thanks Randy, folded in.

-- 
Jens Axboe

