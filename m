Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647332A8F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgKFF5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgKFF5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:57:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED18C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:57:52 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e6so59691wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 21:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=WBwQhu+LINdjSc01CIfpHkedwYCmrzSUtNkN+YX3PyQ=;
        b=E9HIsj73KjSUWkq3TcQNLTUF8kA6LtvZugYocFgC8PdNhP2Tx/3PmAIjLmMkx49U5n
         YDI9oUxNc93GBT3OEbcP1XKNiugy5mduN1A1AJpkmXXXVN0jlFqr9hHmaw9OAy7VrZAk
         KiqExGadUoAnIB7cokwOlwcu6nLDdjMuA3ZHcAElnwaF8kwl3E1qSbbqmdfRppTJUvJ7
         wdep0R3lk54JxLtGL+vWfTB2iVvG2Mzxs6amppcBi+DkTH7WrFi2yGc95r5ovQ5XkWfe
         Tb68rlA0HeqD8bKIFdpBqaa3Oc7m2DdU/5bDg7b1QJ5AqxLAHKt0GNHxENhcr1UQRpaX
         ZP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WBwQhu+LINdjSc01CIfpHkedwYCmrzSUtNkN+YX3PyQ=;
        b=lFra5MUsB44vtoDnn+P6basDjbXeRQWWTpUGo/ifKVwGJbInroUcFu1UYM4R2BT328
         N3NvwB4o6RIXFnQ5aUjeTOUMt3UTwuYndNfJHj8TfUEo3Y5b6edrApkrbX+vYXJ0PRNg
         7YbF2IlXEH8jg9lo1Z5t3YxHr225gGt3XLvcYxCDQPMWZQYMyWYMUOMHp2kGPTrV9Bs0
         h/tm5wc8KoumnTQtylGSJ9h6xzDtnCkwqfaXKGzsQoyDc88WJkc4nG5uJjwIawbQwLHs
         8f3U2T/2yMak71v1nwgOYTZSQDYtQGjfakrLxYkiTcyWa76ZmUwkuQYnUty/bgZvwfwg
         tnJg==
X-Gm-Message-State: AOAM532uZDDnD3KEfhrwjbTagVwJza13AdSZs112nkcp5fNuuG8D3fbe
        uu5rCctlkg3dC99sgwURLiw=
X-Google-Smtp-Source: ABdhPJwFxGFXFy7XLj+JPBAaPjnMY4vqiwkTLvfSFGv31k7+PSXlVScopKpiuWPX/GkPRaAIuHiuyQ==
X-Received: by 2002:adf:c547:: with SMTP id s7mr692502wrf.222.1604642271534;
        Thu, 05 Nov 2020 21:57:51 -0800 (PST)
Received: from giga-mm ([195.245.17.255])
        by smtp.gmail.com with ESMTPSA id d134sm573172wmd.8.2020.11.05.21.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 21:57:50 -0800 (PST)
Message-ID: <15cc973a481dea85081c4466b18df6a3e0cb280f.camel@gmail.com>
Subject: Re: [PATCH] arm: Add clk_get_rate input parameter null check
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Wang Qing <wangqing@vivo.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Nov 2020 06:57:49 +0100
In-Reply-To: <1604627175-16710-1-git-send-email-wangqing@vivo.com>
References: <1604627175-16710-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wang!

On Fri, 2020-11-06 at 09:46 +0800, Wang Qing wrote:
> The input parameter of clk_get_rate() is checked with IS_ERR(),
> so here we need to check null on clk.

Thank you for the patch!

> Signed-off-by: Wang Qing <wangqing@vivo.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/mach-ep93xx/clock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-
> ep93xx/clock.c
> index 2810eb5..4313b2f
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -321,6 +321,9 @@ static unsigned long get_uart_rate(struct clk
> *clk)
>  
>  unsigned long clk_get_rate(struct clk *clk)
>  {
> +	if (!clk)
> +		return 0;
> +
>  	if (clk->get_rate)
>  		return clk->get_rate(clk);
>  
-- 
Alexander Sverdlin.


