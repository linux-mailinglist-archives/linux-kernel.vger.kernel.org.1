Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66A2B82B7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgKRRI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgKRRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:08:56 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A578FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:08:56 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id x18so2662536ilq.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 09:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t0xp18kbqZ7c9+DaDbe3VSi72SFiEvBg3iQH+LM4aUs=;
        b=H1pI2wFuis1TDuErW4J8ilZ1MQa3Pj5BDz809I8/t0fqSJDnX/qF25TUipHqYJhY7a
         nf5aJcXFJa+6EPkLlFjWScBQlbRvXSqjhltQ1d+0B+p2PmAPS/g+hG8M5ox8oJvpxN6U
         d7lRyaH0X4nQ5Ge2izargKmvqsDzTy/CWRnio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t0xp18kbqZ7c9+DaDbe3VSi72SFiEvBg3iQH+LM4aUs=;
        b=Qbarao5BNfEkjMADFMHRjUy0NEMSxUbVEQ5/bo+by/d0vuNYviRa151CXwlkYMEYCs
         Gw93cNmf8a/G86dOoiFu2fUkAScsyAIy19gtIiOmfl5sx44Lb54LNqg9YrhCdTNR5Xwh
         jMniSk1QNkoPawV05cZcG3Rb34M4N+/qafc8veY9DYkF2zQdZ5DTB1HEIUyY9cCRMT/g
         GSq6mXzJryzh9jQrp3yxIy51ghA4ep734oJTWPLlk4Go2Hj/xCuo27Pde76+d/QUdECD
         YxVnDh+HjpQYWPCsROQwDoLl1hQwdNiLrKQVBq0Y864MT2RgPf+Msknj7F3Sh88fdd1P
         5lPA==
X-Gm-Message-State: AOAM530uV0sdbtlKMXCvPhvL5qwL0NotvCa+MVZFSx23W8HBXAHu05BS
        dwzUcYotAkiz3XY4BYUnKLgE7w==
X-Google-Smtp-Source: ABdhPJyVmugXt2QgeDvVeEfk31H/WCfKjtfU5IHkfi0rGTd9Hu+kCWeLhBwrMVGdc6My1gKCO6elag==
X-Received: by 2002:a92:cd51:: with SMTP id v17mr16641744ilq.98.1605719335444;
        Wed, 18 Nov 2020 09:08:55 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t78sm12043078ill.36.2020.11.18.09.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 09:08:54 -0800 (PST)
Subject: Re: [PATCH v2] android/ion: fix error return code in opensocket()
To:     Wang Hai <wanghai38@huawei.com>, shuah@kernel.org,
        pintu.ping@gmail.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201118104742.62817-1-wanghai38@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0c54d6d-2b3a-2053-edfe-6fff32feed41@linuxfoundation.org>
Date:   Wed, 18 Nov 2020 10:08:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201118104742.62817-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 3:47 AM, Wang Hai wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 47a18c42d992 ("android/ion: userspace test utility for ion buffer sharing")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: add missing ";"
>   tools/testing/selftests/android/ion/ipcsocket.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/android/ion/ipcsocket.c b/tools/testing/selftests/android/ion/ipcsocket.c
> index 7dc521002095..13b3455ba39c 100644
> --- a/tools/testing/selftests/android/ion/ipcsocket.c
> +++ b/tools/testing/selftests/android/ion/ipcsocket.c
> @@ -28,8 +28,9 @@ int opensocket(int *sockfd, const char *name, int connecttype)
>   	}
>   
>   	*sockfd = ret;
> -	if (setsockopt(*sockfd, SOL_SOCKET, SO_REUSEADDR,
> -		(char *)&temp, sizeof(int)) < 0) {
> +	ret = setsockopt(*sockfd, SOL_SOCKET, SO_REUSEADDR, (char *)&temp,
> +			 sizeof(int));
> +	if (ret < 0) {
>   		fprintf(stderr, "<%s>: Failed setsockopt: <%s>\n",
>   		__func__, strerror(errno));
>   		goto err;
> 

This test is slated removal and I have stopped accepting patches that
aren't critical fixes at this time.

thanks,
-- Shuah
