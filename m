Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5136C28B57B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgJLNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:05:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33831 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgJLNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:05:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id x1so16850507eds.1;
        Mon, 12 Oct 2020 06:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ydwIlTuEwN4EX6ZQ9wz8gbjgf5SQz/6nMZbwr7W7Vk=;
        b=GGmcQDLzHcKBLQeXzhhixc87eSaqAadqglxOVk3Cqvqa+MsSTMMTeO708FJo20C9fT
         DwPC1BMBv1QwoGLPqHGyZH0jv8eDtsZ1nLSnF7scUQbX36Yj47c9FjtWwxNqT9lFRuXk
         9XEoVbmlEH9qdauevbOU56gQkkuDZIGW6czvCJOYML5daxSlwbB1ZY3WO2Wmez3erA7q
         kkAWWu4YjBO6qorG6dc/63vGpMLPPZ8uIANuN+9hrenKYCAuq2WFVZd0RMUMVXJfi+xY
         0aU/gsr9UGVXdrNp3GI9avXVbkzdB3dpXDX+JOsKeMSpVjwA0IBxBoO/HAPNTuKIC1TE
         nv5g==
X-Gm-Message-State: AOAM530PoP/r7JXU2cgeskzFfgvJF/CdAJW4Xj/lyjy6p3rzP/t5rCLP
        5WhiXABQ8na5NNEm6bsrAiU=
X-Google-Smtp-Source: ABdhPJwG6YJ/YqbFjWqAQPFEIXmQsIVRi4YwedcPF81udFn+oBoRWG37Rp2oByAd+zGy1ereOMMvPw==
X-Received: by 2002:a50:cd51:: with SMTP id d17mr13794841edj.93.1602507947594;
        Mon, 12 Oct 2020 06:05:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.215])
        by smtp.googlemail.com with ESMTPSA id f28sm10591423edc.94.2020.10.12.06.05.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 06:05:46 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:05:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aford173@gmail.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, peter.chen@nxp.com,
        alifer.wsdm@gmail.com, abel.vesa@nxp.com, yibin.gong@nxp.com,
        jun.li@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/3] arm64: dts: imx8mp-evk: Correct WDOG_B pin
 configuration
Message-ID: <20201012130534.GC6468@kozik-lap>
References: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
 <1602506642-5262-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602506642-5262-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 08:44:02PM +0800, Anson Huang wrote:
> Different revision of i.MX8MP EVK boards may have different external
> pull up registor design, some are enabled while some are NOT, to make
> sure the WDOG_B pin works properly, better to enable internal pull up
> resistor. Since enabling internal pull up resistor is NOT harmful and
> having benefit of flexibility on different board design, just enable
> it for all i.MX8MP boards; And schmitt input is NOT necessary for this
> WDOG_B output pin, so remove it; Open drain outputs provide more
> flexibility to a designer as they can be pulled-up to any voltage found
> in the system, so enable it as well.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Provide more explanation of removing schmitt input and enabling open drain in commit msg.
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
