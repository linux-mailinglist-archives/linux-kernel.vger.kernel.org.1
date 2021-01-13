Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717CC2F4254
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbhAMDVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:21:15 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39143 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhAMDVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:21:14 -0500
Received: by mail-oi1-f174.google.com with SMTP id w124so668274oia.6;
        Tue, 12 Jan 2021 19:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dk16yY6ROEx2ZBdQQaewADnm6C4MWl8oKfBEbYvqAc=;
        b=NyDEC0mGv6Brd4iYAs3pPNNPD0waKMjRRUpDoRfouEVQEwOroUiGoJYgBZwz07DoZi
         AVx4RAdVtNdgUHhHb84WirB5h75mCoX6RMfzYgtPf09/q6BQ8HoBPFtnoi+z6g123kwO
         hafEJyyU97irvcIJ8fMNlugxxfPZ/7pv2uA/CFjbjC6cAZX2l7CkdXAFnEPv71KxY+Cj
         URrcqyQ7z+tig8pGmBiJ9rD4QcXe6pmH53v9KzABzVl4SHhlYvUJ5JZ1ScTlDAQg08ay
         O7gMPeu5Fprcem6BoucUlZnJPcPV0KQRlU+G3znEyAfhtFz2Vog6ja8Kfy5FYJFzX4f9
         Nx7Q==
X-Gm-Message-State: AOAM531CGYow4Aau8sytEPb9OTF0VmuOecqQ5b6ziCPdxKaoRmeP1Y7f
        rcBv/u7wp/ViJgdNcXo4uA==
X-Google-Smtp-Source: ABdhPJyO/aeAqrUrw1G7s5ZPVCcMwNt0fZfQ160zpREu2UZ+0rRFizUvDDwYAZGu/mPgjfV5aMpFZw==
X-Received: by 2002:aca:f15:: with SMTP id 21mr112652oip.109.1610508033749;
        Tue, 12 Jan 2021 19:20:33 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v207sm163066oif.58.2021.01.12.19.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:20:32 -0800 (PST)
Received: (nullmailer pid 1464648 invoked by uid 1000);
        Wed, 13 Jan 2021 03:20:31 -0000
Date:   Tue, 12 Jan 2021 21:20:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: mt8183: Add krane-sku0 board.
Message-ID: <20210113032031.GA1460993@robh.at.kernel.org>
References: <20210107052206.2599844-1-hsinyi@chromium.org>
 <20210107052206.2599844-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107052206.2599844-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:22:06PM +0800, Hsin-Yi Wang wrote:
> Similar to krane-sku176 but using a different panel source.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change:
> v2: move compatible to board dts
> ---
>  .../devicetree/bindings/arm/mediatek.yaml     |  1 +
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../dts/mediatek/mt8183-kukui-krane-sku0.dts  | 23 +++++++++++++++++++
>  3 files changed, 25 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 53f0d4e3ea982..3276f7a2ce672 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -120,6 +120,7 @@ properties:
>            - const: mediatek,mt8183
>        - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
>          items:
> +          - const: google,krane-sku0
>            - const: google,krane-sku176
>            - const: google,krane
>            - const: mediatek,mt8183

This says you must have all 4 compatible strings in the order listed. 
That doesn't match your dts. I assume you want the first 2 under an 
'enum' so there's 3 strings with the first one being sku0 or sku176?

Rob
