Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7802AFA58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgKKVa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:30:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37436 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:30:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id cq7so3868296edb.4;
        Wed, 11 Nov 2020 13:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VXU2Y8um07dYkZOSE2h8yApKemYd1SjZEtR4nU/PGP4=;
        b=Mkk+ynrKEv0xCVDpIjW+u+4nW3H4iclGZuYmD/xwfsmgKM2aYv1fOh2Ut2Gp6f8ytO
         qSYppsFS7aM51lawhm6bfU8vdnl7qB5kFbPG9YZ3F2BVVtBMxcthmvljxAVi5CahosD/
         HPcD672neUDcD9zizKK3mCFVwc8vz+d32INKG3mTG5MEj1DNisFRZdGtaXjI55cBoEiR
         a7L29gg4yBYXVd34eXMkymeDFEN1gExzqYbp4gPQ3wfy4OsCbG670ZJsak/BKOf1wTg1
         MF0vW/lIuMCwX3pl9qdSkCC2ScuVVhvR6CQ6+H3gDrONVSqtv/0eOMAMLpifGU61jbH5
         nNuw==
X-Gm-Message-State: AOAM5335ZZDZdF0jWc1aJJ6yOcBg9Jx3ME2y0ro2mfXFZJWvUxoV8nZe
        nEr+EzLzos0Zgg1XDsDQ/HM=
X-Google-Smtp-Source: ABdhPJwVSGs92SscCBCPBRoMp1HtHTNhBg0G7orwBTU8eK0jeXqo9NPvVCdZIMkZeStonb8IonVcFg==
X-Received: by 2002:a50:b761:: with SMTP id g88mr1638344ede.387.1605130227345;
        Wed, 11 Nov 2020 13:30:27 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k12sm1319337ejz.48.2020.11.11.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:30:26 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:30:24 +0100
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
Subject: Re: [PATCH v4 03/24] dt-bindings: memory: mediatek: Extend
 LARB_NR_MAX to 32
Message-ID: <20201111213024.GB287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-4-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-4-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:38:17PM +0800, Yong Wu wrote:
> Extend the max larb number definition as mt8192 has larb_nr over 16.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 2 +-
>  include/dt-bindings/memory/mtk-smi-larb-port.h              | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
