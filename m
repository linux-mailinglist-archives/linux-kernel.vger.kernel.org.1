Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDB2E00A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgLUTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:03:40 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:37972 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgLUTDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:03:39 -0500
Received: by mail-oo1-f49.google.com with SMTP id i18so2451169ooh.5;
        Mon, 21 Dec 2020 11:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Earwzkg2j67FO3Ak/SUyX6/pJix93QKNyv4RXTk8VKs=;
        b=dmUdC2PSkN7EJTzP/40dSYtyUC8eFtd/3rEenb6keewQjE9/QzOmYshmYUfTzrby2h
         qu/T2fXiseEzk6/P72k4KePcrZ2U81shG3L/+NFElSjUkK8hROnst2JBbJzqc8XM1ThA
         Un/bEAk7NCxvO46U6QVsEOIzKr3oEze8PmOvs8x0RK6u+VTnX3KgbQJuAOuEdD3EjHco
         IpBgCNnaxwI0J9n+wDNfVod2oYwgllZJhDvT818GRHb8iR6Q6VSdhM2luemzH6fpW7az
         6sqJ4Ss9DUhTkXeTr7OVu+HsrkHB9fDvfiO8vVkE4kUOhhZb5UKj44EH793iKNgWODTA
         sE0A==
X-Gm-Message-State: AOAM533cAXZZj8DXkedBUj2QT8A4zgIp75NfRsiQ+leQc+esZJSSwMN8
        vMPO+iL/7ybpICZjxRMkpcMTwulGqQ==
X-Google-Smtp-Source: ABdhPJzAcjCETSKeMR/A226dBBPX14G7rMH/HBR+hTsu4ZRtW8IqQTSzYObPT/YSJAFLylMUyVeNMw==
X-Received: by 2002:a4a:ddd2:: with SMTP id i18mr12494663oov.10.1608577378282;
        Mon, 21 Dec 2020 11:02:58 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l6sm3968928otf.34.2020.12.21.11.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:02:57 -0800 (PST)
Received: (nullmailer pid 369568 invoked by uid 1000);
        Mon, 21 Dec 2020 19:02:54 -0000
Date:   Mon, 21 Dec 2020 12:02:54 -0700
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: Re: [PATCH] dt-bindings: phy: Rename Intel Keem Bay USB PHY bindings
Message-ID: <20201221190254.GA369513@robh.at.kernel.org>
References: <20201216084729.3811627-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216084729.3811627-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 09:47:29 +0100, Geert Uytterhoeven wrote:
> This is the only file not using the "intel,keembay-*" pattern.
> Fortunately the actual compatible value is already following the
> standard scheme.
> 
> Fixes: 4086afa2a1627939 ("dt-bindings: phy: Add Intel Keem Bay USB PHY bindings")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../{intel,phy-keembay-usb.yaml => intel,keembay-phy-usb.yaml}  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/phy/{intel,phy-keembay-usb.yaml => intel,keembay-phy-usb.yaml} (93%)
> 

Acked-by: Rob Herring <robh@kernel.org>
