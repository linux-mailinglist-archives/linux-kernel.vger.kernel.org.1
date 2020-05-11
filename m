Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23B11CE805
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEKWZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 18:25:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42188 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgEKWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:25:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id i13so16558988oie.9;
        Mon, 11 May 2020 15:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N73zBrwIBmYpG8/mtE42ByaDIOPbOcw7oUrz+Oif3Eo=;
        b=KsHC6pWVhMc3u3KWFX6jvW1WDMh8Z99+WwXbH+nd1H0NwcxlkOGUiAyWfut8HRBgsw
         fnSiDI6tHI6C4iey8wn/5x1xm+cp4WX8hW5QOJ5y60tmADj+E3x4az0M2qwjcZSWRE7k
         DryQVJ2UF2a+41suDkIzRyACs2Iiz2oqAp4u6JzsQV/ewwuDHyuHoRWljaAMnnSQrIGL
         s9DtKpvmykO8Ai952V16B1MS3Wc38U4CJaCZCtHVOSXgY1dqwyTfaOvISWTyZSgspnLV
         RZBC/IpqIw2DQFI1NmmYvo5fSwzKyB1dssmDpf57Sb4F6SqQyHr7MCSh2WiyxQpuSgWK
         4hrQ==
X-Gm-Message-State: AGi0PuYUELogYsDnM0NsPFePybKdj6FD2+izAS7FGsfy3F0UE+SqJgY8
        mI00BkbEthsSOb+Jr8WRql9v0Kc=
X-Google-Smtp-Source: APiQypIdxF+D8MOPQ2d/giDq1zA7n3B31P983KHIrpVlUv9jtqc3f9KpvrzKWtblGovXNsvgE8KCzA==
X-Received: by 2002:a05:6808:24f:: with SMTP id m15mr22304882oie.152.1589235918092;
        Mon, 11 May 2020 15:25:18 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g94sm2982774otg.74.2020.05.11.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:25:17 -0700 (PDT)
Received: (nullmailer pid 25383 invoked by uid 1000);
        Mon, 11 May 2020 22:25:16 -0000
Date:   Mon, 11 May 2020 17:25:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, airlied@linux.ie
Subject: Re: [PATCH] dt-bindings: gpu: add power-domains #cooling-cells to
 arm, mali-bifrost.yaml
Message-ID: <20200511222516.GA25294@bogus>
References: <20200425154037.21083-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425154037.21083-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 17:40:37 +0200, Johan Jonker wrote:
> A test with the command below gives this error:
> 
> arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: gpu@ff400000:
> '#cooling-cells', 'power-domains'
> do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> With the conversion to yaml it also filters things
> in a node that are used by other drivers like
> '#cooling-cells' and 'power-domains'
> for Rockchip px30 gpu nodes,
> so add them to 'arm,mali-bifrost.yaml'.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/gpu/
> arm,mali-bifrost.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Applied, thanks!
