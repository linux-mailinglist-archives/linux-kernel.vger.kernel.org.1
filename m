Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1E2F22C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbhAKWah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:30:37 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40628 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390006AbhAKWaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:30:35 -0500
Received: by mail-ot1-f50.google.com with SMTP id j12so429558ota.7;
        Mon, 11 Jan 2021 14:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7XYI5ixUdl8zcNOGwqMvrBnJ9rU7UxjoQBZ/8cBFks=;
        b=Nh8rb+d+bXU9yD3D0mAOE3gqKIEmXSj2/0PVVyQmBnM86a7a/f97Go3NNZhDkJh6NO
         3TGliXfMC8iF/PnDZOEcteqLMWMG3i8hbdvMeVwOjo2vnZnGjTo3e/dfXhBZn4nvP7nh
         T7/wISfrsOZElwj5H1Qe6nhSBCnmrXEz4/KXTeHH5NJedgqtOrZGctJCgj9Kbt6vDL5F
         RjvaHWIxbac8+/VlSZb3YVxGWSL5bmtKuxX7G57TLy1MvKtaZFXURY/QaIG2SJGhsJMz
         bcYW9cr7B78Euv9aXkV4i2YoFMaWEcbcDLHMG7r2OcMb3qyxuLpGh1dj/AdAnQ0gXi1j
         lvIw==
X-Gm-Message-State: AOAM533cl9UY06jG7qlSGshUrOLdtOZrMJ2VIzDYMx01XU0lBuyJ0WQ3
        qR8icFltuIC+xv9cUNa1zQ==
X-Google-Smtp-Source: ABdhPJy0TzmNq9Z/UXXl+2y6PP76YHYP8nSGVx/GI/nsSOzXowyHL5/YFDVrz+u82BTyso1TQBl+xw==
X-Received: by 2002:a9d:71cf:: with SMTP id z15mr842784otj.259.1610404194767;
        Mon, 11 Jan 2021 14:29:54 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t26sm240818otm.17.2021.01.11.14.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:29:53 -0800 (PST)
Received: (nullmailer pid 3174678 invoked by uid 1000);
        Mon, 11 Jan 2021 22:29:52 -0000
Date:   Mon, 11 Jan 2021 16:29:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ondrej Jirman <megous@megous.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 02/10] dt-bindings: irq: sun6i-r: Add a compatible for
 the H3
Message-ID: <20210111222952.GA3174647@robh.at.kernel.org>
References: <20210103103101.33603-1-samuel@sholland.org>
 <20210103103101.33603-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103103101.33603-3-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021 04:30:53 -0600, Samuel Holland wrote:
> The Allwinner H3 SoC contains an R_INTC that is, as far as we know,
> compatible with the R_INTC present in other sun8i/sun50i SoCs starting
> with the A31. Since the R_INTC hardware is undocumented, introduce a new
> compatible for the R_INTC variant in this SoC, in case there turns out
> to be some difference.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../interrupt-controller/allwinner,sun6i-a31-r-intc.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
