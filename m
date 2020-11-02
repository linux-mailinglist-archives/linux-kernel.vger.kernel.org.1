Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35FA2A2655
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgKBIoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 03:44:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52836 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgKBIoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:44:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id c18so8528660wme.2;
        Mon, 02 Nov 2020 00:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OCGK4HKfRunlqVPbFzQqyT4WldI8LCXHm3dcWydo1j4=;
        b=qpvRYVvIpLkC/JneZ3xn+tW+mBG05+KEE4oVl3I5gEMvSqhNTEfPfcLg3j3cNP1jSP
         rKKtQKM0CZGCzG6Mze6ZMazmy11mkOaB8cUAEKWLhAfl4N8Nn5aagU69zT0TxlkJku23
         Ehn74qPAP9bpr+d/vb85RWDlOvMPIOD5H4fz+3ZfxviU4l8VsrXCZBtvDQBCNaBzDnmm
         amYl4ZEA4GJlFCpbZYLwCT0jfWb9eqj/Rn2BSkjiboGzly3a2/3ZtynR7nDs0R1cNH0+
         2h4cqeXadoB4GdMSQhYGDc6GdJfYNGw+NVbLrUTxlrwYa5ID/f63ZyBw1Hr6x/DDRRjP
         h97A==
X-Gm-Message-State: AOAM530wdHG+Y7QdKy6vGqRPnbFKcHaFs9DuywyEc2lntqZHeMsAIwAF
        QqStwEeu7Wm72yRJSF4gVGU=
X-Google-Smtp-Source: ABdhPJyKkkAQ9NQegXxdeGCKIH1PWUPYg/7zgzF1OtV79sTD75Sq+EeGSOlMGpymduisdGAkbS7w8Q==
X-Received: by 2002:a1c:6355:: with SMTP id x82mr17377148wmb.177.1604306676290;
        Mon, 02 Nov 2020 00:44:36 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f7sm22322272wrx.64.2020.11.02.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:44:35 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:44:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx50-kobo-aura: Add 'grp' suffix to pinctrl
 node names
Message-ID: <20201102084433.GB7331@kozik-lap>
References: <20201031210729.2804471-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201031210729.2804471-1-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:07:29PM +0100, Jonathan Neuschäfer wrote:
> i.MX pinctrl group nodes should have names that ends with 'grp'.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  arch/arm/boot/dts/imx50-kobo-aura.dts | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
