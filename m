Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8182C8FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbgK3VQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:16:00 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36000 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgK3VQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:16:00 -0500
Received: by mail-io1-f65.google.com with SMTP id z136so13364259iof.3;
        Mon, 30 Nov 2020 13:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jwht71OxD5GRnfrTVHlZAHOwqpu6pUHtWSfdxPAhhe4=;
        b=BNg4/OGGnTrwL1nW5Wtgce8tl4ZzC/gC3xbK2iJaM/lOGDOe+dFxPEr8lHXIZrLIQy
         ULRl8bxMGxOXIjgtE8VTG5CCFaMjH0H4R8kukYI6RS8vyQE9mzlShJcOHtcQ6pxyykUv
         oJvXdzYbKqCSxWWNqK12EpUI8L2SWKYxtTIz7gD2VJyGB0rE3VJUrmFl6VV9lG4Y7kM1
         +oQmIePUScvudfqJniWnrHF5HUbU2qi6YaRLwuhWwODmg8Hc6wrM0Ru5RAv1IFvyr/WO
         tfiV8tGFIWuemHoVEsVHZeIj4xTNZKs4oq4FzeyRIOSwrLedbWpxaMg2E1OSAQyKXr/i
         c/qg==
X-Gm-Message-State: AOAM533cmS8QUMUaDlZ/Qglx07BYxXNu2dCaEIUV6bllSfYxK8KLY2je
        xbJVanSEG2ErgZiWNH//Rg==
X-Google-Smtp-Source: ABdhPJxBxVUopJfyw4u+TG/AMxEzVixJJSObpTwD2wlDLL8a3YdNWFt17IuDYm5BToKWs/WtjrQ0/A==
X-Received: by 2002:a5d:8042:: with SMTP id b2mr17558393ior.4.1606770919062;
        Mon, 30 Nov 2020 13:15:19 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v23sm2272237iol.21.2020.11.30.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:15:18 -0800 (PST)
Received: (nullmailer pid 3035408 invoked by uid 1000);
        Mon, 30 Nov 2020 21:15:16 -0000
Date:   Mon, 30 Nov 2020 14:15:16 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     vkoul@kernel.org, kishon@ti.com, mturquette@baylibre.com,
        robh+dt@kernel.org, rick.tyliu@ingenic.com, zhenwenjin@gmail.com,
        paul@crapouillou.net, aric.pzqi@ingenic.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-usb@vger.kernel.org,
        sernia.zhou@foxmail.com, balbi@kernel.org
Subject: Re: [PATCH v9 2/3] dt-bindings: USB: Add bindings for Ingenic JZ4775
 and X2000.
Message-ID: <20201130211516.GA3035356@robh.at.kernel.org>
References: <20201116141906.11758-1-zhouyanjie@wanyeetech.com>
 <20201116141906.11758-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116141906.11758-3-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 22:19:05 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Move Ingenic USB PHY bindings from Documentation/devicetree/bindings/usb
> to Documentation/devicetree/bindings/phy, and add bindings for JZ4775 SoC
> and X2000 SoC.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v8:
>     New patch.
> 
>     v8->v9:
>     Correct the path errors in "ingenic,phy-usb.yaml" and "ingenic,cgu.yaml".
> 
>  Documentation/devicetree/bindings/clock/ingenic,cgu.yaml              | 2 +-
>  .../{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml}         | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{usb/ingenic,jz4770-phy.yaml => phy/ingenic,phy-usb.yaml} (89%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
