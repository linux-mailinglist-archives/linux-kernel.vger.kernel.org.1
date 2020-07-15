Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3F1221525
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 21:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGOTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 15:32:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33079 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:32:19 -0400
Received: by mail-il1-f196.google.com with SMTP id a11so3041310ilk.0;
        Wed, 15 Jul 2020 12:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fm0BJxhDtxgCQwxltRyCdPVib98HJFWxC3xrwVYYVeM=;
        b=ACQPraeyMHlltlN/yuvGKhMw479wolUFh9f/MSNhlhI0VhpL4tQtuCcbzQ4x6vkrRt
         7rZArOWNqdI4mNU9UzxmpKl4D6f8cqfgDQg5P6JlLbn2iYwGV59ibejHjtMNNV8dIGjh
         2yCMvU0DP5bqrhnNQVAtq9MQmGiGoCCI+LAZvupk4DM2bYvp5C3g2UqlUBe97NHM+jnI
         jApGulosBMasFtWkL/jUg6uwo7jTCgD8s05E1hoge0KsU85EB4B2DhvJq2oI7Cmao1N0
         tUG0+7UEfTpFxscjYnopm3TkGw8QWXwwdDONMbrQ9SGpaQ33+E21CRuY8C9UUjQR1ZXZ
         AHkA==
X-Gm-Message-State: AOAM531vkATPwOMvAbp4ivoxLImbyjzZzrA8ADVVFtfTuTm/X8+ZpAR3
        odCkm6mAcnOE5uKZGCP/1A==
X-Google-Smtp-Source: ABdhPJxZZ3CA0GjhVDdP1Px9lfAUwoboMTg7JHz3I2tEnQLo4i2chUuvIXIFIKSq20QRzkLi0WuH7w==
X-Received: by 2002:a05:6e02:14c2:: with SMTP id o2mr1093123ilk.54.1594841538920;
        Wed, 15 Jul 2020 12:32:18 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c7sm1556191ilo.85.2020.07.15.12.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:32:18 -0700 (PDT)
Received: (nullmailer pid 689607 invoked by uid 1000);
        Wed, 15 Jul 2020 19:32:17 -0000
Date:   Wed, 15 Jul 2020 13:32:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: Convert UniPhier reset to json-schema
Message-ID: <20200715193217.GA689533@bogus>
References: <20200622114826.450442-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622114826.450442-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 20:48:26 +0900, Masahiro Yamada wrote:
> Convert the UniPhier reset controller binding to DT schema format.
> I excluded the glue resets because their bindings are too different.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../reset/socionext,uniphier-reset.yaml       | 112 ++++++++++++++++
>  .../bindings/reset/uniphier-reset.txt         | 121 +-----------------
>  2 files changed, 113 insertions(+), 120 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
> 

Applied, thanks!
