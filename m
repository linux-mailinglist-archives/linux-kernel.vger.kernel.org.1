Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD528A7B6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgJKOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbgJKOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 10:14:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7945DC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 07:14:50 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m11so13383195otk.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=muNZenS0Km4uODESvAwS5JDriZubFvXedophlc0fbss=;
        b=A0RUJIwW3Jw6VGrIbIvCBWuwW5gvVIwwQJYWVuawgwMv3dGud3GX5Chla8ZJVapU6w
         Xa+NMOll4AFRj9wwRwB60L7G4B7JTpmWyfmISu7gyFMcpnMAa1DawZS9JA1OhSkvu0DU
         djvRvm68GeZE6//I2X/ozENdB+3Gshe7c6odbn6S8NnW1kwpyjHyXhbGhIB7aqH+h4sg
         6EwpjsBXVG0oowGP8JiqgSH9RgpVYSO2FOB9Gt1d+rK9fMNDVuyG7RfDPUsROJnnkSnE
         UShx0n7O5mOEiBA4Z5A67ybRVI5wdFASYbUIIO3rMZbrdhuKkiWFJwUz47BXMBvnn3Lc
         k3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=muNZenS0Km4uODESvAwS5JDriZubFvXedophlc0fbss=;
        b=A5Zgj5ND34emXRcMjTw+vDP0dIkjO/0Cy+1X8QR7JUD9Xck3z/Uy63TY0sRISwXNiD
         550IsdcWXp5oXqY+usR5o7sG4LanXF0OzTeRaOJRJgPQosXsXK9jnVDiErlgZGxVLa5p
         jU2wGbk/4YnUxj3Oj+NmT8UyZferPqHMfbroQTah6BftL4qJDm3sG8d/sQiuc+uHmvg2
         ca1abFuyvp0qyRcRF+NXFPNLRCzmjOKaEX+BtXgkQvYD+dHVQMFYoyKiq6ONlRfhi1pQ
         +cbb6d3vDbq9GEKenJE/9MRzrsj2YeZvimSKdjsafj9tgWCTQntAHn6AbwUW0nBg3I5e
         fwPw==
X-Gm-Message-State: AOAM530qBi891xhVdurpxEBcw4yH/oq3WTR6sC9cqHf/W2mw9n6sN7TU
        Y58S2WKUfOa1YBVJ+e1L1IA=
X-Google-Smtp-Source: ABdhPJyy8ExgRMDlYsTYkkLhCw077p/PR6MvHl6/JCxGySg6X+QX+Psbr0XLNu2GjHmuxyCOcwjOsw==
X-Received: by 2002:a9d:7085:: with SMTP id l5mr7653164otj.159.1602425689809;
        Sun, 11 Oct 2020 07:14:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm8813278oic.11.2020.10.11.07.14.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 07:14:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 11 Oct 2020 07:14:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: parsers: bcm63xx: Do not make it modular
Message-ID: <20201011141447.GA9215@roeck-us.net>
References: <20200928161617.2a1b2244@xps13>
 <20200929172726.30469-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929172726.30469-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:27:21AM -0700, Florian Fainelli wrote:
> With commit 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE
> detection"), we generate a reference to fw_arg3 which is the fourth
> firmware/command line argument on MIPS platforms. That symbol is not
> exported and would cause a linking failure.
> 
> The parser is typically necessary to boot a BCM63xx-based system anyway
> so having it be part of the kernel image makes sense, therefore make it
> 'bool' instead of 'tristate'.
> 
> Fixes: 91e81150d388 ("mtd: parsers: bcm63xx: simplify CFE detection")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

What happened with this patch ? The build failure is still seen in mainline
and in next-20201009.

Guenter

> ---
>  drivers/mtd/parsers/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
> index f98363c9b363..e72354322f62 100644
> --- a/drivers/mtd/parsers/Kconfig
> +++ b/drivers/mtd/parsers/Kconfig
> @@ -12,7 +12,7 @@ config MTD_BCM47XX_PARTS
>  	  boards.
>  
>  config MTD_BCM63XX_PARTS
> -	tristate "BCM63XX CFE partitioning parser"
> +	bool "BCM63XX CFE partitioning parser"
>  	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
>  	select CRC32
>  	select MTD_PARSER_IMAGETAG
> -- 
> 2.25.1
> 
