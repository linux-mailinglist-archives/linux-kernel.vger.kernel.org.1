Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93982C1124
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbgKWQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:57:31 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44207 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733040AbgKWQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:57:31 -0500
Received: by mail-ej1-f67.google.com with SMTP id k9so9482710ejc.11;
        Mon, 23 Nov 2020 08:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FDTzpyzF2DN1Mg4t0JUh2J5S8cLzcIfU/it/EqYgEgo=;
        b=XXUPiqJG8YBFZ+0JHz3FILakvpVtAP76b7JFQpXUtxc0aSsmjex5WFpf81Sk8WnUuy
         dWJHMNXfY4AonHFCdKpOzzNvEjcAN7TV0ha99igZBNmjD7wx41JfwcjpZ1f8rKJGDwEV
         DAZ4c2O7X2CvD3ehPPJ0GBz4onASHNCDiJJIGD1a+uFPj1C60lSiQLDMr7W6QavI5t6t
         1jVoBp9vO67fDSxZJrrtGceoimBy6jPobUyOJ55cH95eH/HT8tR/hnkPcOz1EasJeqZB
         O3Xfc2yQzek8c3325YUGBuZN/AooBpj0WIWL0qXBiIxx4i782hYupobanP4IF32g62VW
         OjSw==
X-Gm-Message-State: AOAM532OS5KP+YXgWtK/Fu/kxgKWaV7Ez5FYO6+6yVXgVNcxm2rzKAwB
        6yKZiLpSlLG2MH3rLSiiSqAeVBAOnBo=
X-Google-Smtp-Source: ABdhPJwlKD7A2VPoUG19J+VI6X2YyyF/8ZHT0seUtON6L5NLGwv9+YR1xkpyGksSFfLCSkWdARAReg==
X-Received: by 2002:a17:906:c04d:: with SMTP id bm13mr421373ejb.519.1606150649803;
        Mon, 23 Nov 2020 08:57:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d19sm5418201eds.31.2020.11.23.08.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:57:28 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:57:27 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] arm64: dts: imx8m: add SoC ID compatible
Message-ID: <20201123165727.GB214677@kozik-lap>
References: <20201123095108.19724-1-alice.guo@nxp.com>
 <20201123095108.19724-2-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123095108.19724-2-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:51:06PM +0800, Alice Guo wrote:
> Add compatible string to .dtsi files for binding of imx8_soc_info and
> device.
> 
> v2: remove the subject prefix "LF-2571-2"
> v3: none
> v4: change subject and commit message, add Reviewed-by

You have here duplicated changelog. Leave only the one under '---'.
Thanks!


Best regards,
Krzysztof

> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> v2: remove the subject prefix "LF-2571-2"
> v3: none
> v4: change subject and commit message, add Reviewed-by
> v5: none
> 
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
