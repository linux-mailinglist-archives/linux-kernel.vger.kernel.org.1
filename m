Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B262DB11E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbgLOQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:17:34 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:46026 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730839AbgLOQRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:17:19 -0500
Received: by mail-oo1-f67.google.com with SMTP id o5so1139505oop.12;
        Tue, 15 Dec 2020 08:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JCp0YIgPUuzIMIdJ9vQl9c0q2/kiCX2Sl1pTBGFGABg=;
        b=sYHyrSQRgyWzSN8whiiQgyrLv98Fx6ooT3ONeQ+85cZvW7vNJeR4EJxHLh9SYzhuGI
         beiQreiANAxOurXJkQ3fh5nl3Iv8BmHFyJyASpTGyjOEXmYFsnBk2wd/u/dJBaF1YGw0
         awXdVm82+/J23cZrQ7D5rUazKagoEmczgy7sxt2y9hRi24o0arkxmUW2h+OJ3cs/8py9
         HVJZxg0Z8lBZWdirhii9ZzWNGpYhN++XCh5xEyCoUyG/SC8Wic2+m+nNXrffouwtV6u7
         bYGTXHr/z2SySdUy+iJa2w2ZlBvO2uq+LYexWxltOvz9Hk2Cdl8vAzdX4lmkZkYMg9us
         Um9w==
X-Gm-Message-State: AOAM530L8LQACbAZRZ6PRD5bNvhEsYs/RxNwrm5qKLDeqIMPo2q4w5rK
        fuj7/bqnw4qOO4T67Stkww==
X-Google-Smtp-Source: ABdhPJxCHnIh4PidpUMSVjSkEq+/wiiHBcx7VoFDsQFXpS7PW6w+e0euJuxIjTLgLSazMzFYrDwwCA==
X-Received: by 2002:a4a:e1b5:: with SMTP id 21mr23174996ooy.64.1608048998308;
        Tue, 15 Dec 2020 08:16:38 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s139sm5122420oih.10.2020.12.15.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:16:37 -0800 (PST)
Received: (nullmailer pid 3955309 invoked by uid 1000);
        Tue, 15 Dec 2020 16:16:36 -0000
Date:   Tue, 15 Dec 2020 10:16:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [RFC PATCH 01/12] dt-bindings: clock: sunxi-ng: add compatible
 for V831/V833 CCU
Message-ID: <20201215161636.GA3955251@robh.at.kernel.org>
References: <20201212040157.3639864-1-icenowy@aosc.io>
 <20201212040157.3639864-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212040157.3639864-2-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Dec 2020 12:01:57 +0800, Icenowy Zheng wrote:
> V831/V833 has a CCU similar to the ones on H6/A100.
> 
> Add a compatible string for it.
> 
> As the user manual do not mention the difference between V831 and V833
> in the CCU chapter, only a single compatible string for V833
> (full-functional chip) is made.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
