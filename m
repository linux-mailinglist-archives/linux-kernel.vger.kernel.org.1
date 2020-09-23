Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF32276232
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIWUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:33:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37786 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:33:49 -0400
Received: by mail-io1-f68.google.com with SMTP id y13so944751iow.4;
        Wed, 23 Sep 2020 13:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=neWOG4pv89A97ekum6IfY1Bb+Z9Ero6Ah89dyX6YB0Q=;
        b=rV7QQmEaTy+h/weNnTGlnup7A/5JkXQ6FfGCci4+jg50aCXgdDSH6rgNZq5VmA5yvb
         RiMp5o1xh3ouhmc1x29PdSSwsFTYtylvBeccxoMR0cFAm4DzmkV417FqrndPySajDrTV
         wQKx3GJoANHdVkHfXdGeMW6Iepm1x2znv2+9CYO85gW/Gqpl0i6DHjk2ImWPuEC91Del
         4x16ohNhG3qH/Qy+t4Kt1NxEr1LGT6ckMh7Esgkp3tT1id0ZoBG9wAh4X6hJbsp+MD4I
         E2f56RQ4qCqQpwRu+WEbrfKaLO4MPoLKRnskdKWgy69jRhqS/igEot/CwyJpFzwp8AKg
         3pCg==
X-Gm-Message-State: AOAM532jyx4rFjLZN+IQgoo0rKj0ce862Psnt8LtU+p99Zc2BTRmhkhq
        d5L8dWw87jytAEL9XhR0gQ==
X-Google-Smtp-Source: ABdhPJxciS0lhZSweEmVgd9GV/LNqyZ6RFbZsZEupepGGJmBjcBHFqTkDErRe5VEA1djn1ujUVfJ0A==
X-Received: by 2002:a6b:6a18:: with SMTP id x24mr974577iog.92.1600893228173;
        Wed, 23 Sep 2020 13:33:48 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q191sm435138iod.30.2020.09.23.13.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:33:47 -0700 (PDT)
Received: (nullmailer pid 1256862 invoked by uid 1000);
        Wed, 23 Sep 2020 20:33:46 -0000
Date:   Wed, 23 Sep 2020 14:33:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mailbox: fsl,mu: Add missing
 power-domains
Message-ID: <20200923203346.GA1256809@bogus>
References: <20200917194220.6625-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917194220.6625-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 21:42:20 +0200, Krzysztof Kozlowski wrote:
> Add quite common property - power-domains - to fix dtbs_check warnings
> like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml:
>     mailbox@5d280000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Set maxItems to power domains to 1
> 
> Changes since v1:
> 1. Add missing properties instead of unevaluatedProperties
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
