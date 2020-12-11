Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA12D6E58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404992AbgLKDJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:09:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33605 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733046AbgLKDJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:09:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id d27so8318885oic.0;
        Thu, 10 Dec 2020 19:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kzi4C+7lbCELmX5Fwm3nDaczRxcqLIwFpq+sCs/l4qM=;
        b=qInERl4Q3xuxw2AgGu3R5QfNwIsd2VIImr71GCabPnbJL6GfZKj0Xz+FT+vFHwfWaS
         dfid7Lmd2iypCglcAXIw2jVJXXLX0KphE7PUJrWdcF8or9a/ZaLV6pN26PYZP3VQMw2F
         tjn9Q9uBC4hsMy9sef4UvJo+nGBMngxu0bs263OBD/D/n662HpYUpDI0HWJQD5RsiVge
         hwrVwwgYNejjxBYpkZjd7TAhHAegwFQ+WkXt+EPjFzRL4dxY4ua5eBT9VUqKdBhoS0PW
         fFfEpRkSUgXCWBApn0g1mCOcxGOWzCIpeUFvGVdvfu6U7i8Pdr8XZew9WNhyVl/ke4Hx
         CGbw==
X-Gm-Message-State: AOAM533OXVVdNW2FSzEMH7a1tjUGQxm8xmHmzAIBtM7cPpHWwKOn6DCA
        1GK+hASU9n1UeodvHkGHb+QbMPdyCA==
X-Google-Smtp-Source: ABdhPJypoInSvEeWtGXMHGezQP39HxETrQ5TYmDAug3sm72ZjaPzLKAyDG/UAn0XJVLKeKyjpZhKMA==
X-Received: by 2002:aca:418b:: with SMTP id o133mr7531930oia.67.1607656101281;
        Thu, 10 Dec 2020 19:08:21 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z14sm1559328otk.70.2020.12.10.19.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:08:20 -0800 (PST)
Received: (nullmailer pid 3548617 invoked by uid 1000);
        Fri, 11 Dec 2020 03:08:19 -0000
Date:   Thu, 10 Dec 2020 21:08:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: arm: fsl: add Kverneland UT1, UT1Q
 and UI1P boards
Message-ID: <20201211030819.GA3548287@robh.at.kernel.org>
References: <20201201072449.28600-1-o.rempel@pengutronix.de>
 <20201201072449.28600-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201072449.28600-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Dec 2020 08:24:45 +0100, Oleksij Rempel wrote:
> Add Kverneland UT1 (imx6dl), UT1Q (imx6q) and UT1P (imx6dp) based boards
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
