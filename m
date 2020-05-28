Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828EE1E540E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 04:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE1Ckc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 22:40:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41541 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Ckc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:40:32 -0400
Received: by mail-io1-f67.google.com with SMTP id o5so28341694iow.8;
        Wed, 27 May 2020 19:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAgEV3lXpdTMtJoytrXIsuXAMfljBJ1pwoL+aiV7YTw=;
        b=lZ6WF3CU5MjXsOVgsYaYTfzKkn0c9UAPWEWdLgu0yun/1flvXdpv7VN5mTvGDsQtRQ
         BC6U1Qopet7udyByp9HKcPz+ywCRxUsNAY4pkQOyQV6Nqja39e2ZbXYzcI3o6QgIE6LZ
         2UEUTXX+TSbjiCo+6CMyEAD82I1SfGAanQ2oXl17we+G+JbfWzv8IjfxXzQtaw82nBJ8
         eBt4+QyeAGCndqPrmuL+51hM2vh8YDj9UgE70/ONEpO9hFZu3QDjEgcbCX8+oK+FErzl
         c4n8sntyjkPDjukoRXdT+ziRO4UhQa8T5UObAbfH5ZA0O9nlwYdwB8oxWQTncYFPFBVx
         mgAg==
X-Gm-Message-State: AOAM5303GzOSVtl7ERXtjvSBHF/v1W1IygsWpzF01mG3s3R58P4x+dy4
        KRpEhREqQxVa612un1Sa8g==
X-Google-Smtp-Source: ABdhPJzXkkAhZmxetk8xI59P5Da6u7sTn24AZmqsb6MTJ1H3YqrbiXlZdcB6G5fnNZIqM3YLj2VqEw==
X-Received: by 2002:a6b:fa0b:: with SMTP id p11mr689360ioh.147.1590633631449;
        Wed, 27 May 2020 19:40:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s66sm1938432ilb.25.2020.05.27.19.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:40:30 -0700 (PDT)
Received: (nullmailer pid 3259005 invoked by uid 1000);
        Thu, 28 May 2020 02:40:29 -0000
Date:   Wed, 27 May 2020 20:40:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        Bhushan Shah <bshah@kde.org>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add Xingbangda
Message-ID: <20200528024029.GA3258957@bogus>
References: <20200513212451.1919013-1-megous@megous.com>
 <20200513212451.1919013-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513212451.1919013-2-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 23:24:47 +0200, Ondrej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Shenzhen Xingbangda Display Technology Co., Ltd is a company which
> produces LCD modules. It supplies the LCD panels for the PinePhone.
> 
> Add the vendor prefix of it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
