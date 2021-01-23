Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5AD3016F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbhAWQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 11:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAWQmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 11:42:23 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB0CC06174A;
        Sat, 23 Jan 2021 08:41:43 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d18so460656oic.3;
        Sat, 23 Jan 2021 08:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vueSC+/iHxlD6BCp8DMctqHGkQDoKDsYupUMZWpfOxw=;
        b=YdtZKfuMUumnnm3nh8YqG8Kx1zv5QLrvU8r5dLdidK11ZMXe0WHwS8bg0nQIOmjo5e
         MTBp+Un1gp9HksJx5B0b7u5+xVjtvKVqrzyOGOPzrLu678GrZp0bYAZNfp6PCuVO/af/
         CrS1qeMehLKTNLxxsYfCpL2KYcEw1o8XdiR+QMrIIgoPucUGB4h0SxLg2E5dGoPGSxCB
         +1Y/rd1gUzAOQkfKS/vpo3HRxbFsNel918SKC9WC17bytxkAk4AtJ2hkkGWh+Jsb4FY8
         xVnRgZOAkMnqM7nqltBP1ixAcvvE2+bnNQjWwMtdBevijstOIs9ohi2iriezhu5O2enr
         lSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vueSC+/iHxlD6BCp8DMctqHGkQDoKDsYupUMZWpfOxw=;
        b=mjb8Fxy4gxlhc/cYHw+VG+QRZIDWUv/VTJlQwW9sIBcVtlauQlqeh6iTy0mshbuGHy
         PnIdxXQYeimYGy/xWTXaEQyVnVL2HnmAg+ra+uMdzk2kfdkXU6Y95oibbgtjdwTFOwpf
         RDawgLW1TQg2GCLpRPlWf5DI8OrjOV61T+WZVcAkmd7TmvHdsZ0+vYnNiv/LNsN6EI74
         9J+2YYdxfnNwHZgi2WhFZ4fJ/QLhL4oiQmJRW/JTfYEDNIY8vEcAt+DVZUi00c68YR2R
         nhsNC1nlYbn+Iviomj3W2fRloZzHIpKLcMdDC6xXbejCfs1JR03aUQE2OoSlijXpG0R8
         LaHg==
X-Gm-Message-State: AOAM532I99WVZW2cyBXVf5a98B63PpXhEmYBntG18HyWnmIeiORM54Qd
        IU54Uo2p2gPo1iWtzHNVrP0=
X-Google-Smtp-Source: ABdhPJwlVfNoXpd6ANDrs4XJC9IkSAc/vChvrYla/9UjkjZtnWb9baX38ln06abRl3rP+aUua+zO+w==
X-Received: by 2002:aca:3f07:: with SMTP id m7mr6395738oia.104.1611420102663;
        Sat, 23 Jan 2021 08:41:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24sm2422836oij.20.2021.01.23.08.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jan 2021 08:41:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Jan 2021 08:41:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v5 3/3] MAINTAINERS: Add entry for Texas Instruments
 TPS23861 PoE PSE
Message-ID: <20210123164140.GA53781@roeck-us.net>
References: <20210121134434.2782405-1-robert.marko@sartura.hr>
 <20210121134434.2782405-3-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121134434.2782405-3-robert.marko@sartura.hr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:44:34PM +0100, Robert Marko wrote:
> Add maintainers entry for the Texas Instruments TPS23861 PoE PSE driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> Changes in v4:
> * Add documentation file
> 
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f95e887e5d76..2a7f22587774 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17602,6 +17602,15 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
>  F:	include/linux/soc/ti/ti_sci_inta_msi.h
>  F:	include/linux/soc/ti/ti_sci_protocol.h
>  
> +TEXAS INSTRUMENTS TPS23861 PoE PSE DRIVER
> +M:	Robert Marko <robert.marko@sartura.hr>
> +M:	Luka Perkov <luka.perkov@sartura.hr>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> +F:	Documentation/hwmon/tps23861.rst
> +F:	drivers/hwmon/tps23861.c
> +
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
