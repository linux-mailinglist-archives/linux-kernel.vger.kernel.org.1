Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAA42E8D20
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhACQ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:26:28 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:36435 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbhACQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:26:27 -0500
Received: by mail-il1-f174.google.com with SMTP id u12so23126480ilv.3;
        Sun, 03 Jan 2021 08:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SCk5sLHOYObN1LtflP+npLNY+fu1HwfMPc8N5vmi9Rc=;
        b=EOCc3dqBEtVSG2RkjDaOLOAhhurbiQyltO1oweo8PUES32ylAHrbbIgH3S3zrxcPeP
         xozyoc0stdfX9uWWJqdg0vDQ+3v9hWiPvKKEZndfDOWc7fCyf1z4EvF/drvBscnrMaVf
         M8kyU/QELkTH4l1OyKqIAqWa3HNNyrdQIiG2cHmdr8mHiKE/dCSoGWfsTVKXuizxQ7kz
         U7V8MA2Zv1WOzLH65Zce1idNtWBMnoTUeyw1Wkakfp+LPdDP3/qcTQhSb+We0H79K26P
         V9yAOfBFX9FCofeDdB9jReNadrEGd2smzRs+pa6zQCMskMcr0mIpldW81YkB+tjZ2tIg
         hlyA==
X-Gm-Message-State: AOAM5303jjCTcEUBnyA/9XZFCRB5MPlzYYObeHcIMXaD60LWBcmgt/kD
        PYWNo1Di0vGkz378bBoL4NJprMVHIg==
X-Google-Smtp-Source: ABdhPJyERsS1rlD8orinZwPIQuhBotgG7vJMD8pbQQHrpSYXEEw6RVmHks9o/qRqB9gl+m7ryPkrtQ==
X-Received: by 2002:a05:6e02:160e:: with SMTP id t14mr14633157ilu.148.1609691146243;
        Sun, 03 Jan 2021 08:25:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h70sm40924928iof.31.2021.01.03.08.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:25:45 -0800 (PST)
Received: (nullmailer pid 3986255 invoked by uid 1000);
        Sun, 03 Jan 2021 16:25:40 -0000
Date:   Sun, 3 Jan 2021 09:25:40 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yz.Wu@mediatek.com
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: mediatek: add support for
 MediaTek mt8192 SoC
Message-ID: <20210103162540.GA3983563@robh.at.kernel.org>
References: <20201221061018.18503-1-Yz.Wu@mediatek.com>
 <20201221061018.18503-2-Yz.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221061018.18503-2-Yz.Wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 02:10:19PM +0800, Yz.Wu@mediatek.com wrote:
> From: Ryan Wu <Yz.Wu@mediatek.com>
> 
> This updates dt-binding documentation for MediaTek mt8192
> 
> Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
> ---
> This patch is based on v5.10-rc7.
> ---
>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> index 0668c45a156d..e2f0c0f34d10 100644
> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> @@ -7,6 +7,7 @@ Required properties:
>  	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
>  	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
>  	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
> +	      "mediatek,mt8192-efuse" or "mediatek,efuse": for MT8192

No, "mediatek,efuse" by itself is only for MT8173.

>  - reg: Should contain registers location and length
>  
>  = Data cells =
> -- 
> 2.18.0
> 
