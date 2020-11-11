Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A522AFA56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgKKVaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:30:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44969 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:30:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id l5so3831598edq.11;
        Wed, 11 Nov 2020 13:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HXTmIvGpS6O2JN7ZP+tV8NA98uj/d24NOFx2y9hbQXo=;
        b=kFCcATSMMI30L/6AqQemPqdFapvA4rAqq/3vBsBsQyxNyvb7qwOlwb3meVpoAirHh6
         IopkaqCQBa31QqQdI0epiRpVM5MMyhFviFaxZEnsVnxWHm7dCW8xLR8YkgdfY8sj5s1Z
         /snhoh8MqNn47DeeqmzIe/oVk5hMc7192SVlKRxFDujsmiQ5Pgzer3kVV327sBP+hPqt
         3ibuE7wyjMHszkLJ1aw+vEEH9IPp5z7hPAneMexxFVP7lzyrWa7Edvtf2niYVGtCGm1t
         cpU4155bL4AQ8R+bD+vOfy0rCcNuZDbACR/6QcUkOp5VxEMLV+XYL0mpKXto3Mj40kRI
         tc5A==
X-Gm-Message-State: AOAM53322CQezCSnkkdHTxH0TjaH684MSxOzKCXSg15fMBpKh13Ig4/p
        VyK0Js8KzrvOpyqU2oNDUQg=
X-Google-Smtp-Source: ABdhPJzZenTK1Rz6VyR60TpP7GxdbeoRs2AcpvlAu6VCtNPuHEDus85c+Hal/IVl6aOsp2lRL06b2Q==
X-Received: by 2002:a50:fe14:: with SMTP id f20mr1601079edt.61.1605130210735;
        Wed, 11 Nov 2020 13:30:10 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z2sm1433060edr.47.2020.11.11.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:30:09 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:30:07 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 02/24] dt-bindings: memory: mediatek: Add a common
 larb-port header file
Message-ID: <20201111213007.GA287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:38:16PM +0800, Yong Wu wrote:
> Put all the macros about smi larb/port togethers, this is a preparing
> patch for extending LARB_NR and adding new dom-id support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8167-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
>  6 files changed, 20 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> 
> diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
