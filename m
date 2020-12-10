Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4812D5161
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgLJD2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:28:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34079 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbgLJD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:28:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id s75so4256468oih.1;
        Wed, 09 Dec 2020 19:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VsFgwAlbOj5WSzj8d8eKnjYyws8ulCoX8NrIvbo902E=;
        b=rkPibgT06f+Ow39Xwh5s1T/E5sMjFscdiRKiL1KPTT+nHck5n3h6lUXgdCWpKJNrUV
         fTWkyuKehOC8HgjK9XQAD9zp4/tcAx9ASH4T0BPA1fEuvEAEsknNlgfF/79Nn7zrf50f
         IMOss0nnQLiXwHcdueJ31JxHUlerXjJlxoQmYpNOeTM0oF+hfG4EGeNXgxDa1gIoQrqY
         2jsIKe8ksicreeA2+VtSb7a+FCKKEGyMitTSw+P5blojpzfYJwXmPzRG0nU0CED40xEY
         8uJfI/cfvOC5FKwUssUKUTQiE2bIrxzhMBVCDwNGvBhe17sAzQE4XPyMyepTz42XX/cF
         fGfQ==
X-Gm-Message-State: AOAM530NmiwNc6ka1H58qlgldboNB6hNFaLPIcueNGPxWMLKCPzPhH4k
        7vwH0Y6jwYLNDruuBZbbAg==
X-Google-Smtp-Source: ABdhPJzIYJcMNqkzFHWlXQQe0wA8CLXvVPMlv4wo8VSFWydNWiyuaAIaFMUHku0a5ruylWjVJmHbjw==
X-Received: by 2002:aca:809:: with SMTP id 9mr4148182oii.13.1607570894130;
        Wed, 09 Dec 2020 19:28:14 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v92sm820519otb.75.2020.12.09.19.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:28:13 -0800 (PST)
Received: (nullmailer pid 1596034 invoked by uid 1000);
        Thu, 10 Dec 2020 03:28:12 -0000
Date:   Wed, 9 Dec 2020 21:28:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: pwm-gpio: Add DT bindings
Message-ID: <20201210032812.GA1595986@robh.at.kernel.org>
References: <20201205214616.e4one25o3oz5dhrp@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205214616.e4one25o3oz5dhrp@einstein.dilieto.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Dec 2020 22:46:16 +0100, Nicola Di Lieto wrote:
> Added Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> 
> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-gpio.yaml          | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
