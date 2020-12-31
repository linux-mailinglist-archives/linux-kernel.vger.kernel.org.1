Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E682E81CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 20:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgLaTSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 14:18:17 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:43679 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 14:18:17 -0500
Received: by mail-io1-f54.google.com with SMTP id o6so17795886iob.10;
        Thu, 31 Dec 2020 11:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQCkc0Ql/EqRy7WiuSEdF4FuniiceA875LUWTzglt3c=;
        b=lZei7J07KjUzMfsQr1X2L5+xGu9e5XRRvuXzSYcTgXrUrM8TWWxZBaMx3THrvZh6gv
         zYP7dDJA0MYz+h/BG9YTFuCt5luDxse3/8r43AthCUTdsXtZv2IaUlvyZJvH+CNMrbC8
         8sD0A0bTkGmKg58QIZYCVgVXpSyX2n3p5iv+D/LRkW56DafcoUkm4zpgoObzygBeFeDo
         1v6pj/rwQNYu4dGVeTrHYelqJUomd2L36iJ2AMXgT1fricftdU0elRD+qBDQch3REVro
         HhYyg9Mt7Xy5VOPcDKk9TU5d46ek4s3IMvDMu62wEVDK2lpXan1WAbbonbipmyANYRuk
         eWTQ==
X-Gm-Message-State: AOAM531SI35g7w5wUPz7XtoA51xS3uc7X3R6NX47ppS363azYpPUkhns
        BE50wMN/5eJ8V09j5qjUEEtsgjyf3Q==
X-Google-Smtp-Source: ABdhPJz1/jE3nniUnD3RSbyPTD5w6UiEuG/n78Zv2Cpe+QJuOnBb93sIRqws2C02wqgQ4jScOMKI+A==
X-Received: by 2002:a5d:80d2:: with SMTP id h18mr46906176ior.117.1609442256117;
        Thu, 31 Dec 2020 11:17:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n10sm35061686ila.69.2020.12.31.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 11:17:35 -0800 (PST)
Received: (nullmailer pid 2199447 invoked by uid 1000);
        Thu, 31 Dec 2020 19:17:32 -0000
Date:   Thu, 31 Dec 2020 12:17:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: devicetree: Add new compatible string
 for eeprom microchip 93LC46B
Message-ID: <20201231191732.GA2198038@robh.at.kernel.org>
References: <20201218140815.9501-1-a-govindraju@ti.com>
 <20201218140815.9501-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218140815.9501-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 07:38:10PM +0530, Aswath Govindraju wrote:
> Add a new compatible string for eeprom microchip 93LC46B in eeprom-93xx46
> dt-binding file as it belongs to the 93xx46 family of devices.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> index a8ebb4621f79..9f272361f117 100644
> --- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> +++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible : shall be one of:
>      "atmel,at93c46d"
>      "eeprom-93xx46"
> +    "microchip,93LC46B"

Generally, we use lowercase and that's the existing pattern here.

>  - data-size : number of data bits per word (either 8 or 16)
>  
>  Optional properties:
> -- 
> 2.17.1
> 
