Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB540302C02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbhAYTw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:52:26 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33979 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbhAYThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:37:15 -0500
Received: by mail-ot1-f47.google.com with SMTP id a109so13937399otc.1;
        Mon, 25 Jan 2021 11:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BqRRksk+3G/r1SIptHOITJUnap9kkWd8tCAejk57+/w=;
        b=OwDDLGBJC02p/vvd2mM+hSDHhk3Ez96B/97S5tAG3a7vN/2KRlQuhOpB2/nJ/NIri4
         cEDkrm0wkyYLo7XmVVIed6GErHzOzWzmV4tQcQqZxmKvysz6NDqeoP6Bd3MdWYC9w6yx
         sUJWFNVGSXtI4RG2/pPtBbzAp5vQha7glDGm4bPlvxdDZfCgNIvzuV9NzARAz1tJtESo
         klG55b822artdGoIq6+nBgqJJBVnZ1ZZuxBmQT/pzMwd60lH26NjOSVq8HGahoHQziX7
         en9KTBFriJPv1jU8qPbsw7RAnDUiusx2vEjxWjTNjCelgYeaIKuJ93KxxppY4uggS6fj
         DX3A==
X-Gm-Message-State: AOAM533EpgavPz5L9Hf7reE+UMfBuDDjOQnb3EYGmB9JXDIHcWaW9Rce
        ex0oWeliaFJt+fgR7QZ0jw==
X-Google-Smtp-Source: ABdhPJzlEW0dIRUFPrRvLWdmFeuR1WWHyjf3aQ+xypxGsQfZC/kKhBP3Saz9yuCGB7AFW3Nx6YZPOg==
X-Received: by 2002:a05:6830:13d3:: with SMTP id e19mr1527569otq.157.1611603394687;
        Mon, 25 Jan 2021 11:36:34 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l110sm2623884otc.25.2021.01.25.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:36:33 -0800 (PST)
Received: (nullmailer pid 830912 invoked by uid 1000);
        Mon, 25 Jan 2021 19:36:32 -0000
Date:   Mon, 25 Jan 2021 13:36:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: arm64: dts: mediatek: Add krane sku0
Message-ID: <20210125193632.GA830825@robh.at.kernel.org>
References: <20210113110400.616319-1-hsinyi@chromium.org>
 <20210113110400.616319-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113110400.616319-3-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 19:04:03 +0800, Hsin-Yi Wang wrote:
> Krane-sku0 is similar to krane-sku176 but using a different panel
> source.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
