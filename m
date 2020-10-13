Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ECF28D2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbgJMQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:57:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33017 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgJMQ5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:57:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id s21so138470oij.0;
        Tue, 13 Oct 2020 09:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ta4GdvuvHmi0S7nFmW+Yiy1nhXEJzHrWRU11UeLVa/g=;
        b=Nu5bf4D8vcb6b0t9tNnp+LYsl+xa1baA6f7K6glAvR4/BwEyycsfcYilXmlWd1j26P
         FBKM8jsVM5rKlz7atlvc8vT3rdHfN36lygJtpdfFiO4TD3a7kwv9lRBnfbSjtZQlnH5f
         Qar5hsazI/E+UhwQP/3c7NzRhYQTf4yS8FU7tb/N6/Vt3CTjO2yXHDVwJniACPIWkwXM
         2UoQgaKVQq0o8TBTNVy/120skGksA/mpets5J4qq56hiF/Avc3/rd2oQIH37xEQAE8m/
         kWD89xxF5t/zrHwpBZxTpYhy+eaXFn31oHHuIttd3V7BZsZfEzRLn3QPOkC09/+MgttS
         DhKg==
X-Gm-Message-State: AOAM531DMIwH1voWhZedY0MOAHtQoydqW94XaEJFQrA9t2p9YSUrhyFJ
        okhtjeBBgRuHP3ss5eU43g==
X-Google-Smtp-Source: ABdhPJyc1iqysH0fM7XE3YiQYs9B9724pxdYSxpfEhRtBijv2YxICdy4kOOGJVrhiD+itYChMQXtwg==
X-Received: by 2002:aca:3145:: with SMTP id x66mr379807oix.41.1602608240433;
        Tue, 13 Oct 2020 09:57:20 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h15sm112140ots.31.2020.10.13.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:57:19 -0700 (PDT)
Received: (nullmailer pid 3686793 invoked by uid 1000);
        Tue, 13 Oct 2020 16:57:18 -0000
Date:   Tue, 13 Oct 2020 11:57:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     srv_heupstream@mediatek.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v6 2/4] mmc: dt-bindings: add support for MT8192 SoC
Message-ID: <20201013165718.GA3686690@bogus>
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
 <20201012124547.16649-3-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012124547.16649-3-wenbin.mei@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 20:45:45 +0800, Wenbin Mei wrote:
> MT8192 mmc host ip is compatible with MT8183.
> Add support for this.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
