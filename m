Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE828B570
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgJLNEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:04:47 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42809 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgJLNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:04:47 -0400
Received: by mail-ej1-f67.google.com with SMTP id h24so23044105ejg.9;
        Mon, 12 Oct 2020 06:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBSC1L14aODojvS84MshxRPw6wp9K3Se6pbpNxJH76o=;
        b=UokMqcmdloTstZv/Cs5p+4qR/UAa5VxN+EQrpkeaCspCtapy1VE5yBow4Go/vkTTc0
         BMnGzdOF2SS0mKrkHHEsUf7fVQu7L5aayQBexRSzftIpHo+55vT5tizXL/QXJtDzl0YR
         ORm5Hj/azJ61QZpb/jd+Bc/LAWbRSoXctyuopDYzm19HN23tXfMtFni6aF5ruOfpmSW1
         RoJlED0mhA8yDC2jQ+Atqid31RWSfWyVrmxilkOzfgv0Auy8FhJa+D8P8CxlIPtZDzuW
         cxAew8Mqup8pOH2MhgY41EPtPQ+SpqxArXOUAHSixlkbwE9gFKYv412P4pXsXMleVaB2
         pJdA==
X-Gm-Message-State: AOAM532ZEnb01dM/3O94rwcMHSOyy7EuJ3Sm27Uy/8zWTMn9nWXggr9y
        xibqy1/zPFawD2C1KgsM48U=
X-Google-Smtp-Source: ABdhPJyrBRuKfwAvIEb0BAfwEfuiA4d9/Ym01zd/j4aP5SQ43xyQOlj21q/KSm2l3xcMXWDjeRkEmg==
X-Received: by 2002:a17:907:20e6:: with SMTP id rh6mr27243130ejb.169.1602507885060;
        Mon, 12 Oct 2020 06:04:45 -0700 (PDT)
Received: from kozik-lap ([194.230.155.215])
        by smtp.googlemail.com with ESMTPSA id v23sm10502289edq.86.2020.10.12.06.04.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 06:04:43 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:04:40 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aford173@gmail.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, peter.chen@nxp.com,
        alifer.wsdm@gmail.com, abel.vesa@nxp.com, yibin.gong@nxp.com,
        jun.li@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] arm64: dts: imx8mm: Correct WDOG_B pin
 configuration
Message-ID: <20201012130440.GA6468@kozik-lap>
References: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 08:44:00PM +0800, Anson Huang wrote:
> Different revision of i.MX8MM EVK boards may have different external
> pull up registor design, some are enabled while some are NOT, to make
> sure the WDOG_B pin works properly, better to enable internal pull up
> resistor. Since enabling internal pull up resistor is NOT harmful and
> having benefit of flexibility on different board design, just enable
> it for all i.MX8MM boards; And schmitt input is NOT necessary for this
> WDOG_B output pin, so remove it; Open drain outputs provide more
> flexibility to a designer as they can be pulled-up to any voltage found
> in the system, so enable it as well.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Provide more explanation of removing schmitt input and enabling open drain in commit msg.
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi        | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
