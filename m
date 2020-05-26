Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C414B1A87BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 19:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440500AbgDNRlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 13:41:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39608 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgDNRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:41:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id 8so917211oiy.6;
        Tue, 14 Apr 2020 10:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oy5Pa2pThiwkYu8G4GkTHJjme1DMBn7sY2MflS7Zuig=;
        b=qOacL+1yiiU3D1dvAGnDear7Q4j/mFwaYsyB6Yfax93e5m7QfWYnZghKZP3FaiTo+q
         jpJ7kixQOc1OD/2k1pwKmm4VpCQrmKJ8uYviGrhNgvHFUa5JXyTZDP6FU/iVQtC62KKw
         mHFoD/JgMO7F+OZGinDbPwwznZ5BgG2JGlxw+xk3SCyZullR76jAeKkTabgljqDShMVs
         IOKrujU68Vc/WCWAorM6TVRYwEJxt70guJ4+wskWDBEWU3ofbsMC8f645zGtn4E1FgFI
         QfXdx7mIb9YeUvgP/SgYHYfyc5KHIQxY8z1hyS2L1sMNfHMdDZ90E7A2BpDDbbRR7TRE
         KgGA==
X-Gm-Message-State: AGi0PubZkdiyUkyGPMVUrAO6KraT+05wQs1hcLN/I6oIpqyyTALgVaJG
        ud0zWi7dG40dp9uFI3kIzA==
X-Google-Smtp-Source: APiQypKD41PgBlcTSotaK7Yjth1ocx/nKnHfnnEGSNYS9OULrLgLODfCIhLnCRAsdGgLQ4hyeSvY7w==
X-Received: by 2002:aca:ef82:: with SMTP id n124mr15636268oih.73.1586886069014;
        Tue, 14 Apr 2020 10:41:09 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm3984048otk.59.2020.04.14.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:41:08 -0700 (PDT)
Received: (nullmailer pid 6218 invoked by uid 1000);
        Tue, 14 Apr 2020 17:41:07 -0000
Date:   Tue, 14 Apr 2020 12:41:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v14 1/3] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
Message-ID: <20200414174107.GA6165@bogus>
References: <20200403080350.95826-1-jitao.shi@mediatek.com>
 <20200403080350.95826-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403080350.95826-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 16:03:48 +0800, Jitao Shi wrote:
> Add property "pinctrl-names" to swap pin mode between gpio and dpi mode. Set
> the dpi pins to gpio mode and output-low to avoid leakage current when dpi
> disabled.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt   | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
