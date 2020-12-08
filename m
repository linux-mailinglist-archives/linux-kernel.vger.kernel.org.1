Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6312D33A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgLHUWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40152 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgLHUWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id j12so16995525ota.7;
        Tue, 08 Dec 2020 12:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IemDVxzYa7kmtRFbPpD/3Ro3fB+xQRwobtjllZYqVA8=;
        b=unSCZt9Hbeh0O2m4owjBV4lPjxUraDAHazMVSecCmawk73OrUh3yr1aYRFcPu7DiOx
         ++xDPsmlI9os+vsDSRiK3GV9TU2pb63n4KxQBHkV5Jd19pMA2rsThK1MHkVPnpj7VTFy
         PQbDpAdJZisa2ecfnIUOuKjZQiT60vE/aEIjjEBfyXgvV3gZ4XRJQrvTlTF+4wil/qkD
         tGEwUJVBhg1NvAU5uB9p2NYrnZhgWQlujhv3fkbo+fk5ycw5vHthi6JMK/a7NOuspJdr
         mxb/WzA977plbbSvJNnp4wKI4H/mbVP0AL1tZfayUO2yLL9cziUdqoA7j/JmF7Iqyk8r
         lE5A==
X-Gm-Message-State: AOAM530ShR48g+q1x3Y4MS9Fib0W8fAbdVblgH+tRx72u9YloBY/jsBi
        KidjyL8kAxgsOVapJrwf3KJ00iQQpQ==
X-Google-Smtp-Source: ABdhPJyBmFzeTk1FwCgWYJjznHH0+Nf+LhDGfslxgPCcIMQp8Ecc+U415pK0risvZR47J6iVFCavaA==
X-Received: by 2002:a9d:7ac8:: with SMTP id m8mr17674643otn.86.1607457071031;
        Tue, 08 Dec 2020 11:51:11 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t5sm3628330oth.16.2020.12.08.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:51:09 -0800 (PST)
Received: (nullmailer pid 2970461 invoked by uid 1000);
        Tue, 08 Dec 2020 19:51:08 -0000
Date:   Tue, 8 Dec 2020 13:51:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     konrad.dybcio@somainline.org, linux-media@vger.kernel.org,
        sakari.ailus@iki.fi, andrey.konovalov@linaro.org,
        martin.botka@somainline.org, devicetree@vger.kernel.org,
        mchehab@kernel.org, marijn.suijten@somainline.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org, robh+dt@kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] media: dt-bindings: media: i2c: Add IMX300 CMOS
 sensor binding
Message-ID: <20201208195108.GA2970383@robh.at.kernel.org>
References: <20201127223047.2764643-1-kholk11@gmail.com>
 <20201127223047.2764643-3-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127223047.2764643-3-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 23:30:47 +0100, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add YAML device tree binding for IMX300 CMOS image sensor, and
> the relevant MAINTAINERS entries.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/media/i2c/sony,imx300.yaml       | 112 ++++++++++++++++++
>  MAINTAINERS                                   |   7 ++
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx300.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
