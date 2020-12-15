Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA32DB149
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgLOQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:23:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37580 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgLOQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:23:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id o11so19906913ote.4;
        Tue, 15 Dec 2020 08:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZISEQ6HaMntdpVz1WaDdYPo6C8kVf283YLFSzfriUM=;
        b=GoCGIrBLgTUgLpymx4TebU4uoeG6wCOewJrYgVKPLcb+/qwTHSCMeVVhBwJY7AxwZ9
         KjV10DOphgJdpUxU9e6qbizzNsQWvR8ShI8QAOxyW2Rwc3J3e6A8hr6E3Y8ZOcwmzPcj
         DAOuDOc9xDm19xdeVJoR3JIGPz1rogAX3cVPWYfHqrDQI4kaun1iezShB8n0+zKpNTiC
         jwDRxKv1MNhqU/MwP2/xkwCi4QH2QkHfq+KPfxn7cbP2nouifeVZZ26cqSfpmwOErV80
         APR5W8zzsXurZ8RJrJ6egaoTC8vNMuja8eanj3Rz4sau9kAQkWnlgjz5zsEYey82TT57
         K2cw==
X-Gm-Message-State: AOAM533VRI5Vgl4sLi+89VZwCp7mkcehDxprPJGRD4wga48n6OzyA+eB
        1WHyXUPuUhBf0Fwnj+H+BQ==
X-Google-Smtp-Source: ABdhPJycVMPcM/R+xT7/BKd+G6ZNUDi5ob1ruwngO2yqWJBZtYqftnv/DChHiD2lRHcGRL6DK+aT7g==
X-Received: by 2002:a05:6830:1501:: with SMTP id k1mr24289010otp.12.1608049384744;
        Tue, 15 Dec 2020 08:23:04 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s23sm105865oot.0.2020.12.15.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:23:03 -0800 (PST)
Received: (nullmailer pid 3965708 invoked by uid 1000);
        Tue, 15 Dec 2020 16:23:02 -0000
Date:   Tue, 15 Dec 2020 10:23:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2, 03/17] dt-bindings: mediatek: add description for
 mt8192 display
Message-ID: <20201215162302.GA3965660@robh.at.kernel.org>
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
 <1607746317-4696-4-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607746317-4696-4-git-send-email-yongqiang.niu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Dec 2020 12:11:43 +0800, Yongqiang Niu wrote:
> add description for mt8192 display
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
