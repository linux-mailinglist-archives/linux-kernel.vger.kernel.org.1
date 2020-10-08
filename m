Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD49287BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgJHSeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:34:36 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:47071 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgJHSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:34:35 -0400
Received: by mail-ej1-f68.google.com with SMTP id t25so9473206ejd.13;
        Thu, 08 Oct 2020 11:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i7b9X3nds8peQcVaYclS5mD2puw87C7sBbw/G1KblVs=;
        b=LIPWMV9qz5NB0JsyAMMW88/EKVusQXYguET4mLbHTCGzWhCEEI7YsbFT8UBm3rf63u
         a/z/jiMxFvcXj/XJUZgWiLYPvAfrbsNw8iy0t6Kc9kqE5p3BNMn9/CpRbG6GO+COcY9j
         hGCbftfa8j8lcLSu184YYJTCd8mZCB5vy5j3LMpuxoqw/7h/+PJGI50YnHl3MIuA3S06
         qSlVyO7bkr/NjyPU4ZspStsqbeK42INsJ7/jo9EPda3OAQmz+F1CQkR9R37/pRmZtsCJ
         6J1KDgcSUMn4zmDsy2zwDH12JKDf8nzP0SkGpTUQrfbc2svBfkGJcSQ6Wc66xMvuYn5+
         kAVQ==
X-Gm-Message-State: AOAM530vwa3uO2kQqBkLT33oXlVzktXbxpnCxhpwAdTAPlHic0B/KwHn
        uecCHC/dAQTNUGXv2WjNDcQ=
X-Google-Smtp-Source: ABdhPJyazWgB0XXPndhGp+zYquDO5v6iKY8GnFcJ0JrwFJ6JQLACrREOvNMeO0r8NItwBCFm4cjhyg==
X-Received: by 2002:a17:906:eb02:: with SMTP id mb2mr9763257ejb.506.1602182073646;
        Thu, 08 Oct 2020 11:34:33 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id bw25sm4644834ejb.119.2020.10.08.11.34.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 11:34:32 -0700 (PDT)
Date:   Thu, 8 Oct 2020 20:34:29 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts imx8mn: Remove non-existent USB OTG2
Message-ID: <20201008183429.GA11355@kozik-lap>
References: <20201008183300.726756-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008183300.726756-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 01:33:00PM -0500, Adam Ford wrote:
> According to the i.MX8MN TRM, there is only one OTG port.  The
> address for OTG2 is reserved on Nano.
> 
> This patch removes the non-existent OTG2, usbphynop2, and the usbmisc2
> nodes.
> 
> Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Remove usbmisc2 and usbphynop2 in addition to the otg2 node.
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
