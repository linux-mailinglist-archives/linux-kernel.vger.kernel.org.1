Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B952DEAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgLRVSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:18:31 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45986 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLRVS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:18:28 -0500
Received: by mail-ot1-f51.google.com with SMTP id h18so3219524otq.12;
        Fri, 18 Dec 2020 13:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bA/q6/lytXqC0BX2MijAP++B2hrmWNlRg8ooSs4RlPM=;
        b=eO6OgGMoKm2UkQR16ELTe3lQ/+T3d1othbXDn/iUc9OUl1QY5YMKfWqVlvKCVHPyLo
         C1PMAhVOVqY0JvBs7fLIWfQuNSM8Wyr36fSJZx2BPjpJsLHsIt0p4rhUk5xdMwTHq8Gv
         Myqwr0tPimam1N8qdI6DBBIVmocZA2003dqJLNW21suk5nn/E1MTKwfLTsqIzHQUTKRr
         OhCstLSVRF+/gpZDB4o2s1UUrCyTTDEfpRirhcSL9yLTu82EDefOFbtWdiksORN2Oact
         AvhPquBhZ8aU8Kpm4QADdb1MfGS75nwFX6n/vwcfgKzBcoz5ljGn3Of8hyObNbQqhtm7
         nGXA==
X-Gm-Message-State: AOAM530XnnKch9ms2BZCA7GP0epJ7avfTDcbeuS2quO3i9a0mvtTJN2p
        Z/GJ2NMBC1VeqbU6/Y5k2A==
X-Google-Smtp-Source: ABdhPJyoVoLPTGEg/kKZLNBOodRCvkYyVXk5xQ8/x/+uz2Fa5dCMz/ybCZ4YZTqaCGylNMN389z9+A==
X-Received: by 2002:a05:6830:114e:: with SMTP id x14mr4208264otq.253.1608326267166;
        Fri, 18 Dec 2020 13:17:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n11sm461314oij.37.2020.12.18.13.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:17:46 -0800 (PST)
Received: (nullmailer pid 2191479 invoked by uid 1000);
        Fri, 18 Dec 2020 21:17:45 -0000
Date:   Fri, 18 Dec 2020 15:17:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] dt-bindings/display: abt,y030xx067a: Fix binding
Message-ID: <20201218211745.GC2190633@robh.at.kernel.org>
References: <20201101093150.8071-1-paul@crapouillou.net>
 <20201217005945.335111-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217005945.335111-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 00:59:45 +0000, Paul Cercueil wrote:
> The binding should use "unevaluatedProperties" instead of
> "additionalProperties", since it is a SPI device and may have
> SPI-related Device Tree properties, for instance the "spi-max-frequency"
> property that is present in the example.
> 
> Fixes: e366a644c69d ("dt-bindings: display: Add ABT Y030XX067A panel bindings")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/display/panel/abt,y030xx067a.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
