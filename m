Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1672A1707
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 12:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgJaLty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 07:49:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37238 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgJaLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 07:49:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so9226279wrm.4;
        Sat, 31 Oct 2020 04:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jmCpYBfXj/alF1GCJp4WztkBY7re+xKGrdnAZBvCpgY=;
        b=qpziCzPJcETYsWRxXVMoTKi/irFKbDxQDG6jZBz5fHTwhVw5P8Q78aevPJXF5qvLnt
         bd8CqbhYi1Lvij6MGKSdI02k/HNqWDZKtgnMVFvljNWmUwsvpIM4ik5gYLne8DDa8NPB
         e6siqbA0+GEN4QdZDw8+yJf19zwrlq0QXihg/0DZYgfIsMph5zVdNikRwok38icL6WXw
         h6sBI6e7KRnb2+optPdT5VyQTZlO3DvfjHcgMXiqXhLsbGMDGNiY8byDf6q/J++8NDx7
         wpwcEnnW9Gg3V8BVpVqYHmBqmErV1uDf2NuOLSA8WxkW1drB0ElcG4xuDuXBmu/a18Qm
         sLLg==
X-Gm-Message-State: AOAM532LEXID3/R4ggLR7KTwsbWK1g7VHe8Bc8MZcnDsKMtzHELJEjNu
        ls+o5kW1/cQnM4DBxUnuyA7J0YfaM3wU/g==
X-Google-Smtp-Source: ABdhPJxAD2Ex1+dgpGUJV177Yy9TLp5/bVuFc5qttwldwhp14T+XR2FuRtvRg5JjutyYXMPUS8coUQ==
X-Received: by 2002:a05:6000:1185:: with SMTP id g5mr8968630wrx.42.1604144990803;
        Sat, 31 Oct 2020 04:49:50 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b1sm8529434wmd.43.2020.10.31.04.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 04:49:49 -0700 (PDT)
Date:   Sat, 31 Oct 2020 12:49:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ARM: exynos: clear prefetch bits in default
 l2c_aux_val
Message-ID: <20201031114948.GA6198@kozik-lap>
References: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
 <e44b5226f3ad1551459830c678ed183762d8e458.1597061474.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e44b5226f3ad1551459830c678ed183762d8e458.1597061474.git.guillaume.tucker@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 01:22:08PM +0100, Guillaume Tucker wrote:
> Clear the L310_AUX_CTRL_DATA_PREFETCH and L310_AUX_CTRL_INSTR_PREFETCH
> bits in the l2c_aux_val defaults for Exynos since they can now be set
> using the standard l2c2x0 devicetree bindings.
> 
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
> 
> Notes:
>     v2: split patch to only clear exynos platform register bits
> 
>  arch/arm/mach-exynos/exynos.c | 4 ++--

Thanks, applied.

Best regards,
Krzysztof

