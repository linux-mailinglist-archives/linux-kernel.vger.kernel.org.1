Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914532FEC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbhAUN5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbhAUN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:57:14 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D3C061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:55:58 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 15so1389979pgx.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/a08dp79Xs1XwsKpDBNf3caoVWhir+wyUETQwU1GNxg=;
        b=U0moNAp99t3atjptt4L6uJVYc1+cd+VZOr3KmaFs1uGE/cQgm8XpY6ooTKtNmnCm4b
         rOHuUab4Zaia96Mky4AC4wVd8o27tVdj1yFkDobBRCZ6D0Qe776pk/NOlzte79OGmXLt
         yDI4S9l2UGrzoavMt8K0s5J2LZ2IRjWnubVAVQCERQERDxEkd6HENDVg4qRaNnpXxnaw
         bS2gHqxry+VKE3ROy93YAm5zcuH15/tj3bloTQOVA2Mon9MaputwPOHL1NggsNorwfKh
         asFM76B/HBcepkt2pvFrRxB0htN6MwnCQVP1HxhVRQYGrR729gMefh1bSiESZ5AxjaUB
         2AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/a08dp79Xs1XwsKpDBNf3caoVWhir+wyUETQwU1GNxg=;
        b=W6Qruys5R3zfPDAwUp769qHuh+o6R05aYhH0BFy6f4p7dmFTrsTIBZM1EBD9s0KPzV
         rRYNCRoqTYhejaX+5MFZKRcBXikSEHbnWFUO6rlsXcZU4ePo1d8gRcHYpNxPSC+pDeMK
         +bDkYGSebEx8Xi3ORVDRgo4OvoUwScdj3tMEG5xCE4Io42PgHFP49cL8Xe7Ih2ns5ej8
         0Gl9A+u+Np3K7G12LP2PRUDAyKO9ZnGNQtvdgzzI5GZSb7zRZQI27m6I9pYByqMX1Xb4
         wKrNJsfp6WIKqGTnSxFdNLAX+gTv9Izt9Mkj1hKhIyHbFpqEjN1AMV0im+RLraEaDoOO
         jU+g==
X-Gm-Message-State: AOAM5336xxeHTfHYX9l6xBQgslU1t2CxbJMv59A+R8AbsVwHwvY5uNl9
        rAiIlHJ8IFWq8Y+dOKUKJSAI3J7uPhiE+Q==
X-Google-Smtp-Source: ABdhPJwDU+Y+IFK+npoNeio6kU5ulsKaxLIuxIGOWAyxDlB0kXesgjAWCsAWHP6p9Xb/lWqJAf5Gvw==
X-Received: by 2002:a63:703:: with SMTP id 3mr14436436pgh.272.1611237357718;
        Thu, 21 Jan 2021 05:55:57 -0800 (PST)
Received: from [10.225.164.3] ([129.253.240.67])
        by smtp.gmail.com with ESMTPSA id y6sm5688245pfn.123.2021.01.21.05.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 05:55:56 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     Jens Axboe <axboe@kernel.dk>, Pan Bian <bianpan2016@163.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210121072202.120810-1-bianpan2016@163.com>
 <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
Date:   Thu, 21 Jan 2021 14:55:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 13.47, Jens Axboe wrote:
> On 1/21/21 12:22 AM, Pan Bian wrote:
>> The allocated page is not released if error occurs in
>> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
>> possible memory leak issue.
> Applied, thanks.
>
> General question for Matias - is lightnvm maintained anymore at all, or
> should we remove it? The project seems dead from my pov, and I don't
> even remember anyone even reviewing fixes from other people.
>
Hi Jens,

ZNS has superseded OCSSD/lightnvm. As a result, the hardware and 
software development around OCSSD have also moved on to ZNS. To my 
knowledge, there is not anyone implementing OCSSD1.2/2.0 commercially at 
this point, and what has been deployed in production does not utilize 
the Linux kernel stack.

I do not mind continuing to keep an eye on it, but on the other hand, it 
has served its purpose. It enabled the "Open-Channel SSD architectures" 
of the world to take hold in the market and thereby gained enough 
momentum to be standardized in NVMe as ZNS.

Would you like me to send a PR to remove lightnvm immediately, or should 
we mark it as deprecated for a while before pulling it?

Best, Matias


