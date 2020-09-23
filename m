Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF3C2761C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgIWUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:15:20 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41579 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:15:20 -0400
Received: by mail-il1-f193.google.com with SMTP id f82so845953ilh.8;
        Wed, 23 Sep 2020 13:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=deoXjiCPJcgqhdsTvaj4st28nR1WxDgki8dvwLYWvok=;
        b=ZJNWYrXtiUa9RTsnn3p81NyBtaOJ3l/73/oiQoMs8a5zshDM0aUXTPeQBjFdY8bqN1
         G+S/3HNWQmb4JpCsdrJLEhowbDa20S/1GuqLil9tPZVoYMTOKDX4aniNMJGz8oN8ONwA
         wZoRwmWvBRyPtxn+k4aZ/z9Fsvgdhr9yFLdXJrJXHDoKrBrHz7tN4/sqzXZA/yMSdJrG
         LDMPZX/hRPeoz1Q+qGPxzDFgjNFIToZsIJVL3hXcQflSkRHP3RmluU/SdW/uGtILxdP1
         i7x/2/XNr1qmynDkskZZQcLnUNITcQKybNMF1dPcLjIZHPiDInSv3Zz4EjGISsNE05rK
         Zw5w==
X-Gm-Message-State: AOAM531V4+QRYnMNNLAkWrwTy4F3tQrBqt4+TXQBOR9eG4B4NPpP9bxK
        3fXyarmsdyjEOgGgvRd5Rg==
X-Google-Smtp-Source: ABdhPJwaDK+zaodGN8kVQe2lXZuX+7m1JOY8bAoUaOFpvDMwzBbr0i3tjfuCtDUP871BlwHOy+AaKQ==
X-Received: by 2002:a92:bb0c:: with SMTP id w12mr1270941ili.199.1600892119215;
        Wed, 23 Sep 2020 13:15:19 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t14sm361989ilj.45.2020.09.23.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:15:18 -0700 (PDT)
Received: (nullmailer pid 1227032 invoked by uid 1000);
        Wed, 23 Sep 2020 20:15:17 -0000
Date:   Wed, 23 Sep 2020 14:15:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     yingjoe.chen@mediatek.com, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        eddie.huang@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, huijuan.xie@mediatek.com,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, stonea168@163.com,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        linux-mediatek@lists.infradead.org, cawa.cheng@mediatek.com,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [v2 PATCH] dt-bindings: display: mediatek: convert the dpi
 bindings to yaml
Message-ID: <20200923201517.GA1226945@bogus>
References: <20200917073305.25738-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917073305.25738-1-jitao.shi@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 15:33:05 +0800, Jitao Shi wrote:
> Convert display/mediatek/mediatek,dpi.txt to display/mediatek/mediatek,dpi.yaml
> and remove the old text bindings.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.txt     | 42 ----------
>  .../bindings/display/mediatek/mediatek,dpi.yaml    | 97 ++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
