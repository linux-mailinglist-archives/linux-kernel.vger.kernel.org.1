Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2D227230
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 00:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGTWXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 18:23:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44123 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTWXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:23:10 -0400
Received: by mail-io1-f67.google.com with SMTP id i4so19261594iov.11;
        Mon, 20 Jul 2020 15:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+CUr9tHT5PVLHwGkmwIOpkcnunWXimE18rjDQkGp1Yk=;
        b=FZU6XCNWbEcG/HIhv2DPTYvx0269GDOvkwpSoOqVyOjrLjUN3BAf3B4t6XuVp2HQ0B
         7Aj6WUcQ+VvJuDSYFkKrU52PivVPpv4zunuq8fW+xNVwx/lxU1Trp0v+GUyaRHDxsUQ5
         ysFzUmjLWQMs1yU5cdn5Cc9EeusDUlsSE52yRCbeN0qrsUU7XDa3FoRHgXnEvNLa2bWk
         /HmTt5YdXDmcFc9goXt2f8BNctsz751pwj7EC4cNh28dmV5eRqrx3qZNFlL8Z8zyObdx
         Uxetsg/eN3W5Wld5xtbV2ql780GhupbnGCzayEKF1tDknh//PSuK0fwmdjB16W6LJixu
         eKvQ==
X-Gm-Message-State: AOAM532z21eTdnlrtQ2kZIjUZtcrpzpSJBt/4zlGfbhLxK9/fyPFdaEK
        NYwh/SgvaF4O8ylPZ4m758sQYJOExQ==
X-Google-Smtp-Source: ABdhPJwllR6kKvpNlj5U5ToaaUpZ/6dIW7JrJ1q8wXwbwU6yDnrnrQ4MzKOwoZKQo+WbuWg/9TAoaw==
X-Received: by 2002:a05:6638:1495:: with SMTP id j21mr3018281jak.136.1595283790071;
        Mon, 20 Jul 2020 15:23:10 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b14sm9767511ilg.86.2020.07.20.15.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:23:09 -0700 (PDT)
Received: (nullmailer pid 3057835 invoked by uid 1000);
        Mon, 20 Jul 2020 22:23:07 -0000
Date:   Mon, 20 Jul 2020 16:23:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Culhane <conor.culhane@silvaco.com>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add vendor prefix for Silvaco
Message-ID: <20200720222307.GA3056749@bogus>
References: <20200709080159.2178-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709080159.2178-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 10:01:56AM +0200, Miquel Raynal wrote:
> Silvaco, Inc. is an EDA provider of software tools used for process
> and device development and for analog/mixed-signal, power IC and
> memory design [1].
> 
> [1] https://www.silvaco.com/company/profile/profile.html
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9aeab66be85f..5933966db783 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1004,6 +1004,8 @@ patternProperties:
>      description: Shenzhen Sunchip Technology Co., Ltd
>    "^SUNW,.*":
>      description: Sun Microsystems, Inc
> +  "^svc,.*":

Why not 'silvaco'?

> +    description: Silvaco, Inc.
>    "^swir,.*":
>      description: Sierra Wireless
>    "^syna,.*":
> -- 
> 2.20.1
> 
