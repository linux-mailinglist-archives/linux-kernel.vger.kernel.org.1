Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8526949E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINSQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:16:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42820 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:16:27 -0400
Received: by mail-io1-f65.google.com with SMTP id u6so1108000iow.9;
        Mon, 14 Sep 2020 11:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gkgh20bzSMEzQBjaR/yXNkvt2d9QAmenQ6iuJ6sWbhQ=;
        b=R0g/mKZWKD4fp75F7SXh/u4VWkMhyJzgiTQZlD9Ppn/u+Fs0xUfjr9WEEMz++QVlYv
         +P3wSpNeVjNiTKCiu0ADGDBJ1jd954Uc5KQ0GGhDDxQH4H84KVHUGtUQufkv37emWoMA
         5f5+g0d01wfGICN2vYP2JBRiUMHzIV839F73R2tn92M24cRhfPRQFiucWATOAVd8r+oM
         dqZinkgwniEd4AJw95YjgeP4+XlPGZUeTptWU/7nQPC+gDtSpff0umOVfBefwOuCxbG2
         iDbCLUaRQZRJeZrgOGKdzgM4IxtGaGiaB+6Y4nLejE1Y+2weAEFqvYqetyYo3iIUi+yC
         zD5A==
X-Gm-Message-State: AOAM531JqDspnUgPj23y0oUez36REtSgI8AAZoitQ8i9OVT8s7QCJwgk
        OWo/4rFzGF1h/uzBgXaX0Q==
X-Google-Smtp-Source: ABdhPJysQTS83/P0m/NWQcM+Si2V+AT/0soNX7Yd+tqoN1X+CxgOiIkfng9Eqf/6+mv48oGeuJ5e0w==
X-Received: by 2002:a5d:96ce:: with SMTP id r14mr12026983iol.146.1600107386676;
        Mon, 14 Sep 2020 11:16:26 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y10sm6300353ioy.25.2020.09.14.11.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:16:26 -0700 (PDT)
Received: (nullmailer pid 4172155 invoked by uid 1000);
        Mon, 14 Sep 2020 18:16:22 -0000
Date:   Mon, 14 Sep 2020 12:16:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display: samsung, amoled-mipi-dsi: Do
 not require enable-gpios on samsung, s6e63j0x03
Message-ID: <20200914181622.GA4172076@bogus>
References: <20200829172532.29358-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829172532.29358-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 19:25:29 +0200, Krzysztof Kozlowski wrote:
> The samsung,s6e63j0x03 does not have enable GPIO, so do not require it.
> This fixes dtbs_check warning:
> 
>   arch/arm/boot/dts/exynos3250-rinato.dt.yaml: panel@0: 'enable-gpios' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../display/panel/samsung,amoled-mipi-dsi.yaml       | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Applied, thanks!
