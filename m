Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450B02B4E46
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgKPRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:43:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38803 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387838AbgKPRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:43:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so16826957otf.5;
        Mon, 16 Nov 2020 09:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bFSVgx8WStUFGQnq+FjDm6HcOkdzT+U43PMkQHH3/Aw=;
        b=f+zA9+YfM1DBc57sD7QCS3/qSNilBdRrcXhyQWnqa9u+gOyaYb2crmrCdF4ocJdfNG
         eKcNQT4m3xQP6UZJMIfdIqJzjDchocjaCdX8ytgegHE5c/G3SPQGK3eIQwzDGx1o71O3
         7CTrDDh7mBQs71nIVrpQndzEhAuBCsRQWok3+igchF7EvOpNoseF823Lv+6nWrrLZMME
         YIaDRZzVs63uaqtLC1KyqNGQ/CRoe6IHg7p5lx5VWibCunSbvPKM7kr7YXo0QmdvDEo/
         tPjOx7vPShw7qycXvHHhcwocz9xIjrMX9wWPcoNnWvecYPPawz56gvW8z4j86JH2f71b
         KPkw==
X-Gm-Message-State: AOAM531X7c4HzLnUKL3RCFWKQynxlLXXHc8/yPiR6j0xKhQpWaYFNvgG
        CX5UxjuEqHicaKeUwMmLig==
X-Google-Smtp-Source: ABdhPJwh1KaqZEZLdQqP4EWjEctBZTixLBC9FyUTW+gl0aAyhKJKwMO7/5rESwI4HpgWTlAqXMMXlg==
X-Received: by 2002:a05:6830:1259:: with SMTP id s25mr332017otp.66.1605548617729;
        Mon, 16 Nov 2020 09:43:37 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t5sm4921770oth.16.2020.11.16.09.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:43:37 -0800 (PST)
Received: (nullmailer pid 1861365 invoked by uid 1000);
        Mon, 16 Nov 2020 17:43:35 -0000
Date:   Mon, 16 Nov 2020 11:43:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        kernel-team@android.com, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, youlin.pei@mediatek.com,
        Joerg Roedel <joro@8bytes.org>, srv_heupstream@mediatek.com,
        Tomasz Figa <tfiga@google.com>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, chao.hao@mediatek.com
Subject: Re: [PATCH v4 01/24] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
Message-ID: <20201116174335.GA1861314@bogus>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 20:38:15 +0800, Yong Wu wrote:
> Convert MediaTek IOMMU to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.txt         | 105 -----------
>  .../bindings/iommu/mediatek,iommu.yaml        | 167 ++++++++++++++++++
>  2 files changed, 167 insertions(+), 105 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
