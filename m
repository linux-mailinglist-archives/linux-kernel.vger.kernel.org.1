Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A2298DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780059AbgJZNag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:30:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34416 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775160AbgJZNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:30:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id k3so7394929otp.1;
        Mon, 26 Oct 2020 06:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPBCTWshldNb+DyrWEllGuNdGSidH3ORsb+qdtp0qFc=;
        b=rCYLp0lKLhilYMH4M1V1NMurIX+CU4bJZ4Qe15QwngOWgfzMzhkhYeUHV6/jf26b29
         RT1C3l7ztJ/lVyyUWCJo7rZtFd+KKnw82TGab0LWtftIRDHfzU6alSuK6wSDZrYvAJgW
         OftFHbJHPap44zYcZDr3Oa2RMvsvO6tW3+YezCsSdbFNpccgKF/xv1bq3fG9DBbAnHJq
         Cz/mln2Tt5pc6KPrLa74RApqvj7O6ojC5J3Haow4hqXZ955bj8e+kABgb1tyFByoeDC2
         h2V/8nf2MPl/KWJ7GqlgDxb0+zRhEZmAPi94kMnkII0EE+4mT0ABrh5JVGfE1c1Br6Qg
         VfQw==
X-Gm-Message-State: AOAM533K3Dr8RCYUx7zOe5HhgjBUWw85sZz5+eCwm2iYRy5tuJy/ed8B
        K/xiReZasIhzFbpD5+PXwA==
X-Google-Smtp-Source: ABdhPJzw6SoFVouAT7FkD/EIAwqrhDs04Eu79z3EyjHzdSZ38W/xzJ6Hl2NKvxsG0Ebl93ht3jFp6Q==
X-Received: by 2002:a05:6830:17d8:: with SMTP id p24mr13901537ota.111.1603719025655;
        Mon, 26 Oct 2020 06:30:25 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm3884802ooj.28.2020.10.26.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:30:25 -0700 (PDT)
Received: (nullmailer pid 33081 invoked by uid 1000);
        Mon, 26 Oct 2020 13:30:24 -0000
Date:   Mon, 26 Oct 2020 08:30:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     robh+dt@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, daniel.lezcano@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: timer: mtk-timer: add optional 13m and
 bus clock
Message-ID: <20201026133024.GA33031@bogus>
References: <20201017153857.2494845-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017153857.2494845-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Oct 2020 17:38:56 +0200, Fabien Parent wrote:
> The timer IP on MT8516 requires two clocks to be enabled. Add both
> clocks.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/timer/mediatek,mtk-timer.txt         | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
