Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3704528B575
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgJLNFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:05:21 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42912 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgJLNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:05:20 -0400
Received: by mail-ej1-f67.google.com with SMTP id h24so23046704ejg.9;
        Mon, 12 Oct 2020 06:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0XrI3+HoVHG4WGLdvd3nsIAb7cMN2XARLbCLmhFRck=;
        b=ZZ6iYz/KVhpbxCd+swWdrsdgzt+iYAkrX9i0RHy0yej5da3rmqv+WxyyFQlrYF7NLD
         u78yzYCVKlkC29RrM26W2pct1E3cxlY0Qd91emRbqevaT/9Cw14yAoSZAMksPBfTtSL+
         AIQ+n0eez63bQjnHkoQbskej9RXSpcQeAvm/MLr/tPo8eOB/ff+eVmel5Xnnqa2AiQF5
         a6jp5o5nfaFe9z8hm8nNFl/JdezRQH431Rxs/WA6zYaZ+YdvRghCoAy9eD3DX6OjVPVq
         sSoA1x3H/eq4GcrqEIDm2fOViDysqxe3Xo3NKZJJ5Qr7O8RY/Pes43Pscy6ZGImfZBA0
         Az4g==
X-Gm-Message-State: AOAM530rOWAO5ayFP9sz5MGCCqJBfq0CQc4VVRl8IYHHlfpptMB1owz0
        2zZYY+ZG58ggTpgtuH/gV2I9KuUDgww=
X-Google-Smtp-Source: ABdhPJwC6oQJ24XDfTrndQhWNvDhYkGiqCuRzbTjAdIEBKJ9fjEf9t9J+CEXTs7ayDrZEQBHv/0+MA==
X-Received: by 2002:a17:906:ad94:: with SMTP id la20mr27351161ejb.522.1602507918789;
        Mon, 12 Oct 2020 06:05:18 -0700 (PDT)
Received: from kozik-lap ([194.230.155.215])
        by smtp.googlemail.com with ESMTPSA id t7sm4629018edj.45.2020.10.12.06.05.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 06:05:17 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:05:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aford173@gmail.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, peter.chen@nxp.com,
        alifer.wsdm@gmail.com, abel.vesa@nxp.com, yibin.gong@nxp.com,
        jun.li@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] arm64: dts: imx8mn: Correct WDOG_B pin
 configuration
Message-ID: <20201012130510.GB6468@kozik-lap>
References: <1602506642-5262-1-git-send-email-Anson.Huang@nxp.com>
 <1602506642-5262-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602506642-5262-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 08:44:01PM +0800, Anson Huang wrote:
> Different revision of i.MX8MN EVK boards may have different external
> pull up registor design, some are enabled while some are NOT, to make
> sure the WDOG_B pin works properly, better to enable internal pull up
> resistor. Since enabling internal pull up resistor is NOT harmful and
> having benefit of flexibility on different board design, just enable
> it for all i.MX8MN boards; And schmitt input is NOT necessary for this
> WDOG_B output pin, so remove it; Open drain outputs provide more
> flexibility to a designer as they can be pulled-up to any voltage found
> in the system, so enable it as well.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Provide more explanation of removing schmitt input and enabling open drain in commit msg.
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
