Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F331E5415
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 04:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgE1ClO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 22:41:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34791 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1ClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:41:13 -0400
Received: by mail-io1-f67.google.com with SMTP id f3so28428247ioj.1;
        Wed, 27 May 2020 19:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJSvdBSUP8hCC8+rgsz4EB7YLn+fmauMUvtrBMNRvO0=;
        b=GaeHl0BcAvbEWtrGEiGCzqzxiFy3QvXT+9AYBiy7kkIN7AsOM2IDUovCG3Hqu9XQpT
         J5KSO3VVJhMnPjkG43twskPeAzHrWK6wTe8TWghXRHWpLAL5T3sOB0qlQq1M3QXnPCwH
         KoWlRVfYWjxP5IC3yZFbrfahL759FtY6Jpxnm2Bd+XKObKcvre6EwbfuZRQ9Cs+tDR6L
         FJ2axtZnm4JRaNzzFbFoFe1rYl0p/gnJgoyd36sRMsYJnBg4TxQXIaIX2wDgbYkwbfee
         UV8d1gUlWTM4+NzexE9mB94ZeOkzdCCtCv+u0lsaLlVC71ed+2dOXJ/feHhPrSey3pUp
         cLcg==
X-Gm-Message-State: AOAM533Z5dyZmfLCSJxKiaZO30ACaMx78pFmWX2IH3dyoaVWQUtYxRmx
        EltlNeTaOcTR6bXePGlIvA==
X-Google-Smtp-Source: ABdhPJwSqz8Y/sFww2/trT6sggJFiwuWfVKWn54mRv6JFqUdmLygooXIQDu0sxeliOzsjWUfS6ELdw==
X-Received: by 2002:a5d:9e51:: with SMTP id i17mr691242ioi.8.1590633672645;
        Wed, 27 May 2020 19:41:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u2sm1917979ion.50.2020.05.27.19.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:41:12 -0700 (PDT)
Received: (nullmailer pid 3259982 invoked by uid 1000);
        Thu, 28 May 2020 02:41:10 -0000
Date:   Wed, 27 May 2020 20:41:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Luca Weiss <luca@z3ntu.xyz>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@googlegroups.com,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bhushan Shah <bshah@kde.org>, linux-kernel@vger.kernel.org,
        Martijn Braam <martijn@brixit.nl>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] dt-bindings: panel: Add binding for Xingbangda
 XBD599 panel
Message-ID: <20200528024110.GA3259935@bogus>
References: <20200513212451.1919013-1-megous@megous.com>
 <20200513212451.1919013-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513212451.1919013-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 23:24:48 +0200, Ondrej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel. It is based on
> Sitronix ST7703 LCD controller.
> 
> Add its device tree binding.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../display/panel/sitronix,st7703.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7703.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
