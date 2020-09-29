Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0527D7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgI2URp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:17:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43479 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2URp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:17:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id i17so6894566oig.10;
        Tue, 29 Sep 2020 13:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t59aWAhpZ67eszyLSCndlt/OHfuA01Ub+RG0vyS1B2E=;
        b=X3KRllpqRl49EGS9rag8lXncSvTmsoQy94nTlh/AryV8LCyYDGQupKIN5Q83sp3lRR
         7IdnjlHJoKeRqYLGL6IhJ6m8MHu3hoVrrTJ86YOGsEEYuQpsDnPxDOlQUS7gX7JpnEXA
         mtTWiYnYJWMHA4BZH4Oh8UBhNDfXlxpOjsxhfJzlOSwmCxBIU1wrdH3DKA24MkrSv4hr
         Nnadx5OkBBuk2D70ekCKQpBLrD7AKPn5geaRl0ENnF/3/w8y8XcP2BBuRoU6x0NVB7Kz
         AbSGSaoiysnxhiUBZPCD2gsuMJpyf6mChqpxQY7/cN84gH5oMyVyIK6lj3MUfTPvLvV9
         IHMQ==
X-Gm-Message-State: AOAM5315aCkfgawzE8X5LGVoTsgh4Y78q/iXmcPnwLaGvLEi/7thxrXT
        zrNtE03HY2ZJjos+L421TRlyt9fiL1korXs=
X-Google-Smtp-Source: ABdhPJw8oXYd5dk/F9BkkLRFREqhVnH4h9vwagRk0zBQyF0ATX6mu/B6LtNXUtj9G+uoPk7GzUntfw==
X-Received: by 2002:aca:8cb:: with SMTP id 194mr3505368oii.37.1601410664200;
        Tue, 29 Sep 2020 13:17:44 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m20sm3144986oof.23.2020.09.29.13.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:17:43 -0700 (PDT)
Received: (nullmailer pid 1093221 invoked by uid 1000);
        Tue, 29 Sep 2020 20:17:42 -0000
Date:   Tue, 29 Sep 2020 15:17:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 2/2] dt-bindings: display: sii902x: Add supply bindings
Message-ID: <20200929201742.GA1093186@bogus>
References: <20200924200507.1175888-1-mr.nuke.me@gmail.com>
 <20200928173056.1674274-1-mr.nuke.me@gmail.com>
 <20200928173056.1674274-2-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928173056.1674274-2-mr.nuke.me@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 12:30:54 -0500, Alexandru Gagniuc wrote:
> The sii902x chip family requires IO and core voltages to reach the
> correct voltage before chip initialization. Add binding for describing
> the two supplies.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> Changes since v1:
>   * Nothing. version incremented to stay in sync with sii902x regulator patch
> 
>  Documentation/devicetree/bindings/display/bridge/sii902x.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
