Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419C026960C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgINUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:07:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43294 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgINUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:07:34 -0400
Received: by mail-io1-f65.google.com with SMTP id z25so1478702iol.10;
        Mon, 14 Sep 2020 13:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cQywR9iIPsj0KlHQdnWKI/tnI0oK4QmIBDygSWB11Ss=;
        b=GVbZQApZeQFFYMqFZQzqQHhGgwpnTtE/yCMRV8/7COlTnuTht0xjVH0b1gKjGy7BAZ
         awSy8dajULQSLXSRnsOCQfsqgF/ld8aZCWCATqFrVw4cz9NvrqGSmLoCVZrDTQnDiW6E
         L2Cef2szxh7o7DoIYdYvV9kBoWUppbcfIBgpYiEwCE8BsdvRmmcAmjAylhT+WpwDDLXH
         EVRwwWidFEg2dRaX9VO9us952K+7oHtQ/Ed2Bh6DZrFTX9RL+SKWwNIZZ6Z6niyJiSx5
         gDK67doppbEDMktQghFOQR/xpQdCg4ZN09AUA7XKhqPaHQ+dYs7oC8vGirww+3PwMjgu
         G3Cw==
X-Gm-Message-State: AOAM533K4R3W4RPVtif6cfWWxdYzovzgHY67+kROUrxFuacUHT7szQ1j
        OXKQWlAZaitO9QMV4o/Jug==
X-Google-Smtp-Source: ABdhPJzRM3MEVMxc6A5vZ4yhuQDw2sZG6G+WSd8bJcKEDnFhmbLoAxkJNlAn5dxhAZMjgFtOtP7yVg==
X-Received: by 2002:a05:6602:15c5:: with SMTP id f5mr11611812iow.42.1600114052902;
        Mon, 14 Sep 2020 13:07:32 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a20sm7557962ilq.57.2020.09.14.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:07:32 -0700 (PDT)
Received: (nullmailer pid 152738 invoked by uid 1000);
        Mon, 14 Sep 2020 20:07:29 -0000
Date:   Mon, 14 Sep 2020 14:07:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     jason@lakedaemon.net, daniel@0x0f.com, yj.chiang@mediatek.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, maz@kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        alix.wu@mediatek.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: interrupt-controller: Add MStar
 interrupt controller
Message-ID: <20200914200729.GA152651@bogus>
References: <20200902063344.1852-1-mark-pk.tsai@mediatek.com>
 <20200902063344.1852-3-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902063344.1852-3-mark-pk.tsai@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020 14:33:44 +0800, Mark-PK Tsai wrote:
> Add binding for MStar interrupt controller.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  .../interrupt-controller/mstar,mst-intc.yaml  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
