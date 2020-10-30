Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382642A0E70
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgJ3TSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:18:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45317 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgJ3TRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:17:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id f37so6516645otf.12;
        Fri, 30 Oct 2020 12:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EdL9baVv630hTUqWo6OvHJipP30+abrcAYUdSdJVn1o=;
        b=bpgtVckDZm2lc4Eu6RQjS236OucI6bofw0SiyhSgsDi/4GB0q8ASuIjtrAq0mza7Bq
         zJlLQhyEO21Mb8ZEajBRi9QzZRJk/zK/MHr1GIp9CdUvHys8jCwuC1IORKBt+YVy1pLs
         GLPERE9PaIiXQxu+PMNFsnTTv9gi+dz4IhuebI1bjGqciratyWsFGNdO/h44RAIZbUs4
         ldPlHhynhvNxbxoPwoh18rLgy8grjFatwss3qpt4DRLx11ErqlGnr8+S2CFcb7ZocPHu
         psEPzE8VXgdMrcVAHf3SsiLoO60P57wyR/yUCuClcwANwJWp8OxS6E590/1V3/sGML0l
         xEXQ==
X-Gm-Message-State: AOAM533FAbOThkj61cvFWFpRzZUTWM4GCKaUnIIsrQgzlAmzmEHkL+2l
        g9yRScKrZaogGhx6+YBURg==
X-Google-Smtp-Source: ABdhPJygR1SjnNx0pgftEfYieev15JjQRggZxKmOPg0emitnERRGW8bHgSTq1z6YGe70Flv8U3k20g==
X-Received: by 2002:a9d:3e54:: with SMTP id h20mr2776914otg.236.1604085455157;
        Fri, 30 Oct 2020 12:17:35 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q8sm1461462otf.7.2020.10.30.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 12:17:34 -0700 (PDT)
Received: (nullmailer pid 4172199 invoked by uid 1000);
        Fri, 30 Oct 2020 19:17:33 -0000
Date:   Fri, 30 Oct 2020 14:17:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm64: dts: mediatek: Add
 mt8167-pumpkin board
Message-ID: <20201030191733.GA4172169@bogus>
References: <20201027194816.1227654-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027194816.1227654-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 20:48:13 +0100, Fabien Parent wrote:
> Add binding documentation for the MT8167 Pumpkin board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
