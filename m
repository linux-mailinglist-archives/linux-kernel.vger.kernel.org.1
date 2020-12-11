Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB22D6EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395148AbgLKDec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:34:32 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:42748 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395130AbgLKDeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:34:01 -0500
Received: by mail-oo1-f66.google.com with SMTP id x203so1831595ooa.9;
        Thu, 10 Dec 2020 19:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GnJS91mExiBzt28XQgbgmRTyU/KP5iwnHySnsJrR+g=;
        b=W9tDr4aDMdj1t3B2NZPCy3IpBQyt7oY+pFLivGp6qO0+LJ958nfLQ8/jjyzYDphg6Z
         erPrtnSY3EtPA4q1MUYMEH3WsQKImRUB1nGE5Kv/V2nirzQXMJAnBOZBU6/0HC7Nm5OO
         nFxm1pPGNWow6KlMTDMj3+To1LNhNSQwS+0jq/M1yozwPK+PtENK453ZZCzl/d906UbP
         A1WhjcXJscoPALA7o3WhfTemoSzN5NFUW5kBGN45eVMLBIcMev2qf7+eM9Ijv0Y9JlGj
         1nWW2mYY5nadl6qdn/C1k2eKoS+LvMXUzZe0DbiZ+k1yAHI1FUBWqZG1ByQwtAVY9Oui
         5CqQ==
X-Gm-Message-State: AOAM531rEOqiRdjuIvIFxcnuF11nxb5DbO8tLBSVtmnJAXE4Ho70FiaO
        3D3Cy1G28b1XWUyywH+EOl3uiNvY4g==
X-Google-Smtp-Source: ABdhPJyv+HjIJIG6vQ0mqx8wcxKerll2vL+hFq43z5m9733QezRGM9e/Qwbq1lN4LMs4idy5AaXIWQ==
X-Received: by 2002:a4a:e687:: with SMTP id u7mr8551739oot.20.1607657600097;
        Thu, 10 Dec 2020 19:33:20 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n16sm187964oop.9.2020.12.10.19.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:33:19 -0800 (PST)
Received: (nullmailer pid 3584435 invoked by uid 1000);
        Fri, 11 Dec 2020 03:33:18 -0000
Date:   Thu, 10 Dec 2020 21:33:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH RFC 1/2] Documentation: devicetree: Add property for
 ignoring the dummy bits sent before read transfer
Message-ID: <20201211033301.GA3581630@robh.at.kernel.org>
References: <20201209175708.16252-1-a-govindraju@ti.com>
 <20201209175708.16252-2-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209175708.16252-2-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:27:07PM +0530, Aswath Govindraju wrote:
> Dummy zero bits are sent before data during a read transfer. This causes
> the data read to be shifted to the right. To fix this send zero bits after
> the address during a read transfer.
> 
> Add property to send zero bits after the address during a read transfer.

When is this necessary? Why can't it be implied by the compatible 
string which should be specific to the chip model?

> 
> Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/misc/eeprom-93xx46.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> index a8ebb4621f79..09fb1cec54f0 100644
> --- a/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> +++ b/Documentation/devicetree/bindings/misc/eeprom-93xx46.txt
> @@ -10,7 +10,9 @@ Optional properties:
>  - read-only : parameter-less property which disables writes to the EEPROM
>  - select-gpios : if present, specifies the GPIO that will be asserted prior to
>    each access to the EEPROM (e.g. for SPI bus multiplexing)
> -
> +- read-op-dummy-cycles: If present specifies the number of dummy zero-bits to
> +  be sent after the address during a read transfer to ignore any bits sent
> +  preceding the data.
>  Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
>  apply.  In particular, "reg" and "spi-max-frequency" properties must be given.
>  
> -- 
> 2.17.1
> 
