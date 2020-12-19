Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B172DEEB8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgLSMZf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Dec 2020 07:25:35 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:47058 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgLSMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:25:34 -0500
Received: by mail-ej1-f46.google.com with SMTP id j22so7037191eja.13;
        Sat, 19 Dec 2020 04:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QJTTKnZRfkcqF9wDHW0U+xjAjeKRMjIdWaAAHbUog2Y=;
        b=j1R29oFyL8xEsw91hy81Ur5JXccn66vu3gCUgMnBJ14K+bCKqr7D8i19BsNmCAdggV
         F2k4+4I6ox9DEGdj5KwoJHlJ/fT3Zt3PmMLjo9omyAZ/aYrpsWTi2LyMVv6IgOepEsts
         YCxhRpbUv5erU6Uh1t5L7Db+ZhtggKadWJo52keIhYVZaXtWOL79ZSDsPbIpMlSNdVRp
         ygtUNsmhoDPBIcY7NwJCGN24wKF1Vw2oqqsAha1yi38RHyrKUw90/xz26rt3WNWTRgAP
         N5nPMJwd8zA6/v9G4bVLdGSL3mr1HFY8tQCBrWk+cCPu8pum8kbIl1MaoSXrsf6+eval
         TcEg==
X-Gm-Message-State: AOAM531v0FTJDA2iw7rHJ1Lr+EeecKgsEwJGh6O8xzckQa+gUSOx9OXk
        vSBITIGcgCjGnXRvLyRA0ZY=
X-Google-Smtp-Source: ABdhPJyuhzVXe+hj/sQomptxPPVWlsKZQKFwfFXyqsvColc8AAQnixoFwtppqCsgCNbtthIZTOUu7A==
X-Received: by 2002:a17:906:7f0b:: with SMTP id d11mr8275994ejr.7.1608380691879;
        Sat, 19 Dec 2020 04:24:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k2sm6657160ejp.6.2020.12.19.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:24:50 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:24:49 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: dts: imx8mq-librem5-devkit: Drop custom
 clock settings
Message-ID: <20201219122449.GF13886@kozik-lap>
References: <cover.1608216796.git.agx@sigxcpu.org>
 <3343e82ab52e753b385a3e451c07b774920790fc.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3343e82ab52e753b385a3e451c07b774920790fc.1608216796.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:13:15PM +0100, Guido Günther wrote:
> Otherwise the boot hangs early on and the resulting clock tree without
> this already closely matches the selected rates (722534400 and
> 786432000).
> 
>   audio_pll2                  0        0        0   722534397          0     0  50000
>      audio_pll2_bypass        0        0        0   722534397          0     0  50000
>         audio_pll2_out        0        0        0   722534397          0     0  50000
>   audio_pll1                  1        1        0   786431998          0     0  50000
>      audio_pll1_bypass        1        1        0   786431998          0     0  50000
>         audio_pll1_out        1        1        0   786431998          0     0  50000
>            sai2               1        1        0    24576000          0     0  50000
>               sai2_root_clk       1        1        0    24576000          0     0  50000
>            sai6               0        0        0    24576000          0     0  50000
>               sai6_root_clk       0        0        0    24576000          0     0  50000
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
