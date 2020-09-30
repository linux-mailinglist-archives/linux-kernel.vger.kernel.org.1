Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C65227E39A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgI3IV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:21:59 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36625 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3IV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:21:58 -0400
Received: by mail-ej1-f68.google.com with SMTP id qp15so596118ejb.3;
        Wed, 30 Sep 2020 01:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AnmAiSuhryQgiuxCIfxiMUZ49Ib7mZfhe2r0FxsXtiE=;
        b=GtKPAZXKGPXwppctpag5iZuRloh9/fyKcCxqy4bhe9U3jwXoNYsg5Tf5eX+2C2/P+b
         pjE+J7kPwywHNqZhPcTyalxi13yyxu7JNFykkthO5gTsGYMiLgjru/jOi75nMVTSq27K
         +RB63Vt+HXFvYFMne0zFXXXRPPsq0XsshdNXtQA8p0m5oUUSXYDGy5ZCTa6dtfD+0nau
         lPFHSfLdbc0lyInXtduUU2z0ImQKN90ub/FARlximRnQpiEpAjPua846XF9HF57c8kK9
         LLdlhd8agzd6NKc/WhhqSpKhYkAbHPwWh1D3Blj03Iy5yA5/kiacPT4/cgws+sZCHcP5
         mitg==
X-Gm-Message-State: AOAM532c4HnvWZzTGrvg8u72paR6RvtmCYEdzn9jC1tzYKZUapwqfNvl
        8ue0wxECtjsbcedQQMjU/vA=
X-Google-Smtp-Source: ABdhPJw6bec972tmVwZG7C2+NMX7qUMnT5frUQjSPPMYma2uOjjVneMUDze1KIu5PUu2+7riorwpWw==
X-Received: by 2002:a17:906:7f15:: with SMTP id d21mr1674985ejr.470.1601454116954;
        Wed, 30 Sep 2020 01:21:56 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j15sm925412ejs.5.2020.09.30.01.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 01:21:56 -0700 (PDT)
Subject: Re: [PATCH] tty: serial: mvebu-uart: Remove unused variable 'ret'
To:     Pujin Shi <shipujin.t@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        hankinsea@gmail.com
References: <20200930081459.1269-1-shipujin.t@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <bfa595ba-52a1-aab7-d6c8-8af7607b3281@kernel.org>
Date:   Wed, 30 Sep 2020 10:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930081459.1269-1-shipujin.t@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 09. 20, 10:14, Pujin Shi wrote:
> 'ret' variable is now defined but not used in mvebu_uart_probe(),
> causing this warning:
> 
>   drivers/tty/serial/mvebu-uart.c: In function ‘mvebu_uart_probe’:
>   drivers/tty/serial/mvebu-uart.c:806:6: warning: unused variable ‘ret’ [-Wunused-variable]
> 
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>  drivers/tty/serial/mvebu-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index 7443c0506eb4..118b29912289 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -803,7 +803,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
>  							   &pdev->dev);
>  	struct uart_port *port;
>  	struct mvebu_uart *mvuart;
> -	int ret, id, irq;
> +	int id, irq;
>  
>  	if (!reg) {
>  		dev_err(&pdev->dev, "no registers defined\n");
> 

thanks,
-- 
js
suse labs
