Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A862F6386
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbhANOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhANOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:53:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF5C061574;
        Thu, 14 Jan 2021 06:53:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v184so722948wma.1;
        Thu, 14 Jan 2021 06:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vXE0mmnItBS+KOK1GpktK7ApVoMKmWB/4ok6x8HwdfM=;
        b=jHKAOq//l2Pley5Km6YuU8Jma6GOwF+kNpi7TkY/zxiAoL8GRi2qrXlYbw3UlUZB/7
         HAUsgaiHFnnp0CyG/6a2ZBGVqhM7kC0jEqafupGq00ScQq4jSlYaHMVY/sgdZSaAIdtD
         pp6KHJ13IBJTw73SHxBdwmt+WtvxNS0v1CUSWJ4TlepWuszH8pXzQoHKDPI06wQ0JjZL
         s5AeRvVpnH2sFCUXSLJ8CZxMbPrrD6fdvbbxSzoPCR3Ha9iMqX3hgvsi1Q8agZOEGl+N
         M/bv/G5rx7kmr41TWvz4dLobEuNWq3UppgNrSjUSM9ZigeLxP8f3UUnEhJzj6oW09wxT
         MSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vXE0mmnItBS+KOK1GpktK7ApVoMKmWB/4ok6x8HwdfM=;
        b=S95kGPNzlH45ITIO6ijE5XzprRNfwtMnRKXq5L6AH/iU6BH+eFJoRx2QtaZF4/ctY4
         d+mJbEB7qpAB750wdmRKKHhnU0iUBjgOXfisDT+1tECySjBlA8EFPhDmwfK3gvJWD0/3
         MPMFl0PDsVoxlIF0nJ+6qD/CbT7ajeIwDeHNjjgDsQXqxkcxbnQN0h3qm1Mjjv63WkJ7
         zb0+A2VpBrpgBgcgCpvH3CnfrNVSuRAGZRwHRvMrPEyvPFJawXhl0xiG7GRQ/3UzMQIl
         BqFdx6UgVU3tq6OjfOElJ7DiC+AJHtAYgL/rkmhcdwBbF77iGOBoUGrt+kK6DQQAouXi
         rR0w==
X-Gm-Message-State: AOAM532twithCGWBe6LNGPUI/UvlZLNoXB4iqQ51JrtoYSTTDA0+UqlF
        gKlyEvns+RSz9e6Rys7szDe2dVgxWYN2Gg==
X-Google-Smtp-Source: ABdhPJxOolToRV7rsm7AM/M2dtx01MzWVdtFIzvgwYSxVJrhI5i4OC9R/mBmRffoi18w3syOBSwIkw==
X-Received: by 2002:a1c:6283:: with SMTP id w125mr4271505wmb.155.1610635989142;
        Thu, 14 Jan 2021 06:53:09 -0800 (PST)
Received: from [192.168.2.202] (pd9e5aa30.dip0.t-ipconnect.de. [217.229.170.48])
        by smtp.gmail.com with ESMTPSA id q15sm10441410wrw.75.2021.01.14.06.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 06:53:08 -0800 (PST)
Subject: Re: [PATCH v6 16/16] platform/surface: aggregator: fix a kernel-doc
 markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <cover.1610610937.git.mchehab+huawei@kernel.org>
 <4a6bf33cfbd06654d78294127f2b6d354d073089.1610610937.git.mchehab+huawei@kernel.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <a0cb2b1a-4546-7864-faaf-3a1db8223189@gmail.com>
Date:   Thu, 14 Jan 2021 15:53:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4a6bf33cfbd06654d78294127f2b6d354d073089.1610610937.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/21 9:04 AM, Mauro Carvalho Chehab wrote:
> A function has a different name between their prototype
> and its kernel-doc markup:
> 
> 	../drivers/platform/surface/aggregator/ssh_request_layer.c:1065: warning: expecting prototype for ssh_rtl_tx_start(). Prototype was for ssh_rtl_start() instead
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   drivers/platform/surface/aggregator/ssh_request_layer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
> index bb1c862411a2..25db4d638cfa 100644
> --- a/drivers/platform/surface/aggregator/ssh_request_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
> @@ -1056,7 +1056,7 @@ void ssh_rtl_destroy(struct ssh_rtl *rtl)
>   }
>   
>   /**
> - * ssh_rtl_tx_start() - Start request transmitter and receiver.
> + * ssh_rtl_start() - Start request transmitter and receiver.
>    * @rtl: The request transport layer.
>    *
>    * Return: Returns zero on success, a negative error code on failure.
> 

Thanks! Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

There seems to be another issue similar to this, specifically the
non-existing ssh_rtl_tx_start() and ssh_rtl_tx_start() are referenced.
Both should point to to ssh_rtl_start() instead. I'll start working on a
patch to fix that right away.

Regards,
Max
