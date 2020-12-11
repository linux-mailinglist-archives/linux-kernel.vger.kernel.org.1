Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA1D2D6EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbgLKDkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:40:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41919 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388990AbgLKDkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:40:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id x13so7081732oto.8;
        Thu, 10 Dec 2020 19:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LOjNdqCDIPCW9nzt1/d/vtXHN7EsbrrpKY6lZwmye5s=;
        b=VI54F/DOdtLEdsy0rw9LAYcctJiWahRbhjAdZqxOqa7K4+Y2leSidKjNCmnl8TjspY
         Vwu3IiwAmM78eS5Bzul5j+epKO8N+8imqpUoQhqOBHkZkoj2SDMHVOt6GRLS+Qw36Xrz
         d1kofm0hKeIr3AF3gBHfibRFEYVUjch2bepfd/JBI5YQ7jMiumY0n9Zu+uM+b/Ky5JJx
         FGbHKKEnhZIVgbwvE3Dw1UqSBPvM7NoepZOKj9h96tAIPEn52tRfA4pMciY+BfkHPOYX
         EDXx7FGcb/SVqnMD+rMTN7OnH5wXVGIzTuUcdABcdFBX8vpd2i5ghE03Bf/adqv/AO1T
         dFHg==
X-Gm-Message-State: AOAM533zmg66OAljhe5pTMVSmOTZeqLC3KruD8d3OqOVyjxNjoeiPJv9
        u9cIZYyMnIW8UCsFSHmdUQ==
X-Google-Smtp-Source: ABdhPJxQbrJG789lq6XonvOFgsDfT/Dn1oRgxe+n9Wg4IUeU7dSxVYB5J/YK/AKOllcqq0DI08tVxg==
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr8172762otc.43.1607657979774;
        Thu, 10 Dec 2020 19:39:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t26sm920601otm.17.2020.12.10.19.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:39:38 -0800 (PST)
Received: (nullmailer pid 3593171 invoked by uid 1000);
        Fri, 11 Dec 2020 03:39:37 -0000
Date:   Thu, 10 Dec 2020 21:39:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: sunxi: add PineTab new panel DT
 binding
Message-ID: <20201211033937.GA3593126@robh.at.kernel.org>
References: <20201210083722.1912981-1-icenowy@aosc.io>
 <20201210084232.1913871-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210084232.1913871-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 16:42:32 +0800, Icenowy Zheng wrote:
> Early adopters' PineTabs (and all further releases) will have a new LCD
> panel different with the one that is used when in development (because
> the old panel's supply discontinued).
> 
> Add a new DT compatible for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
