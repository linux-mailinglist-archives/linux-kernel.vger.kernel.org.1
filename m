Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB19B3039FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391871AbhAZKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:16:56 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:37660 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbhAYT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:28:43 -0500
Received: by mail-oo1-f42.google.com with SMTP id q3so3545005oog.4;
        Mon, 25 Jan 2021 11:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1ql3qmKtKUBcfggl4PtEkcGo/McfdbzrD7ix9pM9ug=;
        b=qpuCO1dY01Lb7NR/FWgjnvnM7gTLTYVa5VanaYEeKuFNbPnkDkQayB/PGElU2aXkhT
         qsoOYKTrLqklGygL6Vl700gymwXQiXnQAFmOkKcaq4RKRgH4SJcXbZnyj2dubIhHshCF
         iOIv1Gso7SD0TE+WfwfqD091NZo1UdBzVLNB1DwkQPo81nq05tmxeEar+uTbrmFkrwtx
         sSVhvOtN1uNQrnjNLCryphGLXta3pjQStUXhbCZFrV4HGjuy45rOlEdLCDNlGnQ1NmVp
         puRf99vaNXZhv3j+NJ3JByEPqFpnajDw1WPlK97QSUto75Z3XngZaTDThYU+cGsYahtg
         CoRQ==
X-Gm-Message-State: AOAM531ac2zihuw+bi//o/QDqQyr1q4Bs9bBYXQ4ELeX3iyX4/NbmS3J
        Sutd797xwnCFbQRUKCCiCw==
X-Google-Smtp-Source: ABdhPJykXn0r+tDnB/aHlhNQIwDwGzPDmNconZtOosNygiHPN68ntf/2aHOEGq2/Y9aFF+5Jofq2ww==
X-Received: by 2002:a4a:3150:: with SMTP id v16mr1455948oog.71.1611602882417;
        Mon, 25 Jan 2021 11:28:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 66sm2761860otw.75.2021.01.25.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:28:01 -0800 (PST)
Received: (nullmailer pid 814724 invoked by uid 1000);
        Mon, 25 Jan 2021 19:28:00 -0000
Date:   Mon, 25 Jan 2021 13:28:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: mt8183: Add krane-sku0 board.
Message-ID: <20210125192800.GA814682@robh.at.kernel.org>
References: <20210113062834.4043956-1-hsinyi@chromium.org>
 <20210113062834.4043956-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113062834.4043956-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 14:28:35 +0800, Hsin-Yi Wang wrote:
> Similar to krane-sku176 but using a different panel source.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> change:
> v3: fix yaml
> ---
>  .../devicetree/bindings/arm/mediatek.yaml     |  4 +++-
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../dts/mediatek/mt8183-kukui-krane-sku0.dts  | 23 +++++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
