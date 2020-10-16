Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11F2290A48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436538AbgJPRHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:07:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37279 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410150AbgJPRHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:07:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id m22so3049993ots.4;
        Fri, 16 Oct 2020 10:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VOnUBlYCol3UnYmGYrGOQTrAlxbpurYNGe8gXF8RHnk=;
        b=uUyXuMcq1lppSmj9ZlVrx/bzSsiBVEAfaVn5dGvz1wwA49L7qY4khgccy9NLN+oVM3
         TwVowGsm+MY9y7grdGrXpqUQFnzgnZgJvpqcXIgehMfXOUSE6j2CM9EFIXr/wvhxVVve
         xesj2Evep/k4hYON7pyb5h9jGwySJIssaBYFJbz+ULDw28pfgcwzJIARRKTa9P5uXv4s
         +Pf51iy8RoDFm721LONS/1K68FUf7PZpqRBUhiz8OmXcV8UsO1jzVfEjRrwTpnx0ZYZE
         UmFNlyLOu8rStWRDJPjDgYDSCOmSOs1WddPHiiQkYLN9j3c2LLL0NGTDyNhmoJISByVW
         aHjw==
X-Gm-Message-State: AOAM530NNCC/BVanJpauZ/wQ6CGbxGOmhCOdnWtzqIFRSqNJqinh6kdH
        pFRGlCg0UtXqHal98ijnag==
X-Google-Smtp-Source: ABdhPJwg/aSdvLT6liD1DFywqtQD2ulJ09DrXmWwEbznkeBnRsDigukv0B1qfRnTkjDHe2MLKQ2teA==
X-Received: by 2002:a9d:bee:: with SMTP id 101mr3169477oth.257.1602868052731;
        Fri, 16 Oct 2020 10:07:32 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o14sm1149734ota.63.2020.10.16.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:07:32 -0700 (PDT)
Received: (nullmailer pid 1583848 invoked by uid 1000);
        Fri, 16 Oct 2020 17:07:30 -0000
Date:   Fri, 16 Oct 2020 12:07:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Min Guo <min.guo@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: phy: convert HDMI PHY binding to
 YAML schema
Message-ID: <20201016170730.GA1583813@bogus>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
 <20201013085207.17749-4-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013085207.17749-4-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 16:52:03 +0800, Chunfeng Yun wrote:
> Convert HDMI PHY binding to YAML schema mediatek,ufs-phy.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: fix binding check warning of reg in example
> ---
>  .../display/mediatek/mediatek,hdmi.txt        | 17 +---
>  .../bindings/phy/mediatek,hdmi-phy.yaml       | 90 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,hdmi-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
