Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F58128E9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgJOBZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgJOBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:24:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B2EC0F26F4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:06:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so2239263ion.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nuoA4nhqaT2r5Q46oH6MDqZrYkcrLiu5o7waToPeU4U=;
        b=ZfM2dR1TVM9711DQqLS1u7B81AJpL280LQQTwlJw+3/gMKiDTmwBAI85Q+aCbOog6r
         xyaCpCPr5oP/gIjJF4y8l7sZYHvPdjj6tGZuEZud6PFI7d6Gw154k4gtiTvQvaQho3TP
         8LSCyi4Xajhw1knanNXpifLBMBtJd4S2L1MdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nuoA4nhqaT2r5Q46oH6MDqZrYkcrLiu5o7waToPeU4U=;
        b=jqacmAHor4TPBcQke41ih0Sg3xtLDktocJCTHWAP9q34sIHW41NmCw/wyZePbqJLq0
         FKtTMYI21BZgsc6NatihHui+HTnKGowvG6vkBRWpE30nmOTTIh14QvHcvFq1aJfDBpGQ
         P6zXAIHS1QLS4Sb1hA7VzndyLSUtRsCpnf+YcfqdWw91JztFPE8j9Wzq2Uke15XcZNIP
         NvU7LyiBcMluNaznwMNg8LML/NBqt7MZ2IURFeenKcS0VXzUihExNLsRL54pZIdezhhA
         axR04n8qh5HBxX75+WPJ7dWTSxerQS1KPr/GpMHb8bGezI537KhxIqxQgkXuEPwzY3bp
         YQdg==
X-Gm-Message-State: AOAM5305zRMppqtINa5n/HJNI04P0IVRsqyvcvHb0W3I14WHBo950nWH
        xrLvCKYcLsdOTkr3ybypALpJ5A==
X-Google-Smtp-Source: ABdhPJwZ8n+nuyRdHP5Sff3yx8mk/bObtC07yQCShDgVe4UfTBPTIBPbPI99IitZ3cn80JwKdFFEQg==
X-Received: by 2002:a02:380c:: with SMTP id b12mr1734863jaa.9.1602724014000;
        Wed, 14 Oct 2020 18:06:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b2sm1042048ila.62.2020.10.14.18.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 18:06:53 -0700 (PDT)
Subject: Re: [PATCH v2 24/24] counters: docs: add a missing include
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <74814cc3d2b2ac3fe7c10ff2045c77691bacf64b.1602590106.git.mchehab+huawei@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <982ecabd-330d-7ef9-9287-0eda5ba399b3@linuxfoundation.org>
Date:   Wed, 14 Oct 2020 19:06:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <74814cc3d2b2ac3fe7c10ff2045c77691bacf64b.1602590106.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 6:14 AM, Mauro Carvalho Chehab wrote:
> Changeset 37a0dbf631f6 ("counters: Introduce counter_atomic* counters")
> 
> Is causing two new warnings:
> 
> 	.../Documentation/core-api/counters.rst:8: WARNING: Undefined substitution referenced: "copy".
> 	.../Documentation/core-api/counters.rst:9: WARNING: Undefined substitution referenced: "copy".
> 
> Because it forgot to include isonum.txt, which defines |copy|
> macro.
> 
> While here, also add it to core-api index file, in order to
> solve this warning:
> 
> 	.../Documentation/core-api/counters.rst: WARNING: document isn't included in any toctree
> 
> Fixes: 37a0dbf631f6 ("counters: Introduce counter_atomic* counters")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/core-api/counters.rst | 1 +
>   Documentation/core-api/index.rst    | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/core-api/counters.rst b/Documentation/core-api/counters.rst
> index 642d907f4d3a..2821aebf3f45 100644
> --- a/Documentation/core-api/counters.rst
> +++ b/Documentation/core-api/counters.rst
> @@ -1,4 +1,5 @@
>   .. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
>   
>   ======================
>   Simple atomic counters
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 69171b1799f2..cf9cd44c1191 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -43,6 +43,7 @@ Library functionality that is used throughout the kernel.
>      this_cpu_ops
>      timekeeping
>      errseq
> +   counters
>   
>   Concurrency primitives
>   ======================
> 

Thank you for the patch. I will add this to my patch series.

thanks,
-- Shuah
