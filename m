Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A33039FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbhAZKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:15:45 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45500 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbhAYT1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:27:52 -0500
Received: by mail-oi1-f174.google.com with SMTP id g69so15194835oib.12;
        Mon, 25 Jan 2021 11:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4pMzj4F5sGyiw0Npjv+oCcMmAv4Qz6Br4C1Wz04rzwo=;
        b=LnghEX2IE8W1iTTSFZXSEitjRpfmDE43B9p+tl6WeL/jqc/nRcMUCFQe6p9Isi1rmW
         sUVGiiCQsum2/pz5xj8Gly4xUdB8BgqyhM3gEOCMoHV1EG8Cux/p6qVVK8trK7OXpYhz
         1GLN/FWHmkePWY4cgXlkyABZSLscqwEcm9Feubr/p5pds2/58G2qmSPFUUSkFjociux0
         TDqSWcJiu49hCaxSyN2ZfNtePmE5mNG25ccI5AVlzitkRVsilUtjR/d7OrM5YUTgcLEG
         ZmRiM4l4udwx4VjlarO1/tEnyotfkAv804P7QVzs5Zs4h2ONEcClBk+mzRLwLikWyLtv
         Z2Mw==
X-Gm-Message-State: AOAM5305vJ2psmCyF/w7io1FG04fD3TOdvVcbj1avTH+96f6j0I4727N
        CEJcnHpLwdOF+vsXby/S0A==
X-Google-Smtp-Source: ABdhPJxAzJx2x6+i0A4uT7fsLRy+H8EdaY+p15TtbYRd+1pf2Vnetwij66uSg6hpWaWh7MJzjj8eTw==
X-Received: by 2002:a05:6808:213:: with SMTP id l19mr1038857oie.83.1611602830875;
        Mon, 25 Jan 2021 11:27:10 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm1177551ooi.45.2021.01.25.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:27:09 -0800 (PST)
Received: (nullmailer pid 813043 invoked by uid 1000);
        Mon, 25 Jan 2021 19:27:07 -0000
Date:   Mon, 25 Jan 2021 13:27:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Steven Price <steven.price@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        boris.brezillon@collabora.com, hoegsberg@chromium.org,
        hsinyi@chromium.org, linux-mediatek@lists.infradead.org,
        David Airlie <airlied@linux.ie>, fshao@chromium.org
Subject: Re: [PATCH v10 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek
 MT8183
Message-ID: <20210125192707.GA813009@robh.at.kernel.org>
References: <20210113060703.3122661-1-drinkcat@chromium.org>
 <20210113140546.v10.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113140546.v10.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 14:07:00 +0800, Nicolas Boichat wrote:
> Define a compatible string for the Mali Bifrost GPU found in
> Mediatek's MT8183 SoCs.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> Changes in v10:
>  - Fix the binding to make sure sram-supply property can be provided.
> 
> Changes in v6:
>  - Rebased, actually tested with recent mesa driver.
>  - No change
> 
> Changes in v5:
>  - Rename "2d" power domain to "core2"
> 
> Changes in v4:
>  - Add power-domain-names description
>    (kept Alyssa's reviewed-by as the change is minor)
> 
> Changes in v3:
>  - No change
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
