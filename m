Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456232D1E18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgLGXEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:04:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45468 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgLGXEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:04:47 -0500
Received: by mail-oi1-f193.google.com with SMTP id f132so2916472oib.12;
        Mon, 07 Dec 2020 15:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FKVOi81QuTxtmvRA/1QQ/i5ym4BvFRsKDGyyquA2QGo=;
        b=eNBC3eewy9RFGjNbS2oh3m/WrMPSAB2U9aaSe1KIyA0tcsyFsQu6EPjdBPvY015++F
         UpeS5wtzFGePypwV3LBg61X3S3YYUfHakEInzzUsDwAG5LiNirK0PROcL7GJbhd4paGa
         81GTx8Joo5Ycje6Icb0ZdrGw+lWFqkSqXr+L2hu3vWqHxIaYpguB8VbYbA7m95zvAuVP
         qfuuut4CATzgEmEE/V6N6DyQxn507zzmuEjt2Wtuel+Q2k0jG7rbO1mRuHFtQYYTYdHe
         rRSLvvielgaVOYyKPZ5tQocFaOU6O+uwUWFLukp9v267ZtTacqhi/0M0xEFLl3yYndMm
         XP3g==
X-Gm-Message-State: AOAM532mkFbk43pSG1fV4Bg2RFqD3TzzfEd7dYZVznGmh7dhAGptQoj3
        k5tYOmkAxVbjehW2QLaw+KOqAIVZHw==
X-Google-Smtp-Source: ABdhPJwPrbY2Mjm4riXSridU15duWihLNezTrBEYDRujhThLF7Qyb60cdAnrlpGQs50eGq37s+lzoA==
X-Received: by 2002:aca:5548:: with SMTP id j69mr856075oib.32.1607382246438;
        Mon, 07 Dec 2020 15:04:06 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j204sm952836oih.15.2020.12.07.15.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:04:05 -0800 (PST)
Received: (nullmailer pid 1014048 invoked by uid 1000);
        Mon, 07 Dec 2020 23:04:04 -0000
Date:   Mon, 7 Dec 2020 17:04:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: display: eliminate yamllint warnings
Message-ID: <20201207230404.GA1013997@robh.at.kernel.org>
References: <20201207044830.1551-1-thunder.leizhen@huawei.com>
 <20201207044830.1551-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207044830.1551-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 12:48:30 +0800, Zhen Lei wrote:
> Eliminate the following yamllint warnings:
> ./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> :52:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
> 
> ./Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
> :42:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
> :45:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
> 
> ./Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
> :21:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
> 
> ./Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> :25:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml          | 4 ++--
>  .../devicetree/bindings/display/bridge/intel,keembay-dsi.yaml         | 4 ++--
>  Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml   | 4 ++--
>  Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
