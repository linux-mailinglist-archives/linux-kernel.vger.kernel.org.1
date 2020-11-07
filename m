Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9862AA548
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 14:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKGNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 08:12:06 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43117 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 08:12:05 -0500
Received: by mail-ej1-f67.google.com with SMTP id k3so5799358ejj.10;
        Sat, 07 Nov 2020 05:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XVsoSiNOG2ZeQffdB9mLyCGHMPhp7xk8bmoPiQjJ1Bk=;
        b=KuF77aBgSQcmkMzqOJxwWq57QFKgJj/MBPolOfm2eTrE5BB9bgM4jxLR3XsKcWfq84
         v82ar8J0HfLfw+mIZKY3M+JW+U4F647npyN1xInhF8JvDdfm+zPeQDXTtkPR70l+KkH4
         WHpQG2J0B8kDJXworSyw1yL++yJxnmBObbJGh9HjHQSwXXJcROjiWWzvwHA+K/V6w1HW
         7L8m0XStd2fVPQa5BUyLaMZqmsing1La7IPpuUKszJBkWggHBofdoYCJGpyEaFpSmCma
         X8A2u9z8PnBPdQrtym2gy6nV0m4DpC0gdCaJu1btH6g3TUhTB7JXTSX2s4cI6kG5ZFrF
         +i1w==
X-Gm-Message-State: AOAM533SaPRs8hLpN9WAjUcZE4itpu71Rfjb0fuyRYH1LSLCIwHap6FU
        punH1CgATj0f5qCMIBDMzLs=
X-Google-Smtp-Source: ABdhPJxzmQXCTWOXV/UbYlZZ554A51S2YKgeTlTmdKJFHRwNNbH7wUxcZBdw9kIUGxWJOyMdgm49hQ==
X-Received: by 2002:a17:906:2490:: with SMTP id e16mr6604816ejb.17.1604754723704;
        Sat, 07 Nov 2020 05:12:03 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h23sm3302518ejf.120.2020.11.07.05.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 05:12:02 -0800 (PST)
Date:   Sat, 7 Nov 2020 14:12:01 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] arm64: dts: imx: Add Beacon i.MX8M Nano
 development kit
Message-ID: <20201107131201.GB4761@kozik-lap>
References: <20201107123334.1868360-1-aford173@gmail.com>
 <20201107123334.1868360-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107123334.1868360-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 06:33:32AM -0600, Adam Ford wrote:
> Beacon Embeddedworks is launching a development kit based on the
> i.MX8M Nano SoC.  The kit consists of a System on Module (SOM)
> + baseboard.  The SOM has the SoC, eMMC, and Ethernet. The baseboard
> has an wm8962 audio CODEC, a PDM microphone, and a single USB OTG.
> 
> The baseboard is capable of two different, mutually exclusive video
> outputs, so the common items are in the baseboard file.  When
> the video becomes available, LVDS output will be added to this kit
> file, and a second kit file will be added to support HDMI.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> V3:  Correct name

I don't think you corrected the name. It's still there.

Best regards,
Krzysztof
