Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492A12E92C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbhADJo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbhADJo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:44:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC8C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 01:43:45 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x16so36000459ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 01:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uJuIYYwoE287hbbRthIn2gLK/51W7Mu+HB+BN/G4lP4=;
        b=0mSQFd2JziCGzEoWCmFl6JEC0Q23Na1lEuc1RCadqex0lCr9azthWKy87TMGa9s88i
         Zn5bNJUqoc0z9hyZcZLEZRfifbu/W1e2e/guFgKnV1AMbxF5X74Yz9TbDERKuKVGQa9t
         wLthqSybMavH6SQyOByADlaZ7yXQLU89cps6wbG5rDmy0zHcyWE3ohfk5FZVPikBz9Q7
         U12nFyx8y6ReAz0QmvFheuzp6gx/tfraKtDhz5E6Qy6BwIhsbl2o45yoIoiomRI/g7Do
         1P0k0AumL3iprXnffVf40r+3aNaMktRoqMuby1TxikIkuTMqUTDnoUHYNzU9sUPqc0Uf
         a8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uJuIYYwoE287hbbRthIn2gLK/51W7Mu+HB+BN/G4lP4=;
        b=Q23lVPwcWXhmq7hBFmBmL/Y+r23lokLj37NqnfiR+8LqkUdbk6Sqo0iXEtrHyxCz2F
         O1Y/k4e1JKjtkA4gVlfwwnNSEsgtMSzfcC1510m3qMmwux6y+5uMyCuWtSkQ4WdvNdps
         Nzeql80tp6CsLwqvtggem92Te/uDrWIHpwCw9ixnI0PfwMegYpDWAMEZE4ovq2cb+vzG
         V3EJKG5WPVAJGveIQAKjCCQ5CHgrr+h8PheDbvTobrhaiuQHcCV7Ubcy3xJhLkDUHeOw
         SNTv9xrzP/JDufq1GUxtri1AjHAq+sfG7EtHef2YUVLuoT2tSFPEKUIkdfc/6XVV0TFj
         gv7g==
X-Gm-Message-State: AOAM530UG6+0tCWRhx0O2W9eRcbzm1g7utATh89VU0WUGAjbCIZVrVY7
        x7kfNmhNr7Cbo6vcOuZYTQWLnOFvy8nuefv8
X-Google-Smtp-Source: ABdhPJwdegxWYTA2k4+J7Tl8lGvb5AWmZSYUyfgNWSbnIBu/YFo/4XPBGxHhJkADX5StpLnVYsH8zA==
X-Received: by 2002:a17:906:b04f:: with SMTP id bj15mr63892693ejb.383.1609753424266;
        Mon, 04 Jan 2021 01:43:44 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j7sm44418898edp.52.2021.01.04.01.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 01:43:43 -0800 (PST)
Subject: Re: [PATCH] microblaze: do not select TRACING_SUPPORT directly
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20201223152947.698744-1-masahiroy@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <bf6e0579-c403-8e82-9672-eb0f55c042c2@monstr.eu>
Date:   Mon, 4 Jan 2021 10:43:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201223152947.698744-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23. 12. 20 16:29, Masahiro Yamada wrote:
> Microblaze is the only architecture that selects TRACING_SUPPORT.
> 
> In my understanding, it is computed by kernel/trace/Kconfig:
> 
>   config TRACING_SUPPORT
>           bool
>           depends on TRACE_IRQFLAGS_SUPPORT
>           depends on STACKTRACE_SUPPORT
>           default y
> 
> Microblaze enables both TRACE_IRQFLAGS_SUPPORT and STACKTRACE_SUPPORT,
> so there is no change in the resulted configuration.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/microblaze/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index a0e0c43a2852..acd6d0e68089 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -39,7 +39,6 @@ config MICROBLAZE
>  	select OF_EARLY_FLATTREE
>  	select PCI_DOMAINS_GENERIC if PCI
>  	select PCI_SYSCALL if PCI
> -	select TRACING_SUPPORT
>  	select VIRT_TO_BUS
>  	select CPU_NO_EFFICIENT_FFS
>  	select MMU_GATHER_NO_RANGE
> 

make sense.

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

