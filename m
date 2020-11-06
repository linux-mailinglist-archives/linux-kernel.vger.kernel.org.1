Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B841D2A9842
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgKFPMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:12:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44819 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgKFPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:12:45 -0500
Received: by mail-ed1-f66.google.com with SMTP id y15so1451015ede.11;
        Fri, 06 Nov 2020 07:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PJzdMlFHlOQC8rc2PlAdZu6jaGDwCnPncsKPu/65M9g=;
        b=ezdRDTN69EQb81l8VrXhUN7H89HodX65XK/Vl9rMxTwAXiOwBEcj9cfUWOokV/vBdp
         ioJ674S9R9kVpEBwyoD3jp7JnILSqHLMwbeCAxUqI1jfSot/Rx3nlm6AYoUI6fe90V13
         h2SLgwRi3gcX7ONsujfpqdumi+r6sHU9P3lOBL3vIuh5dURMJyngmbsu6CDqoFki39k9
         rGnGVQ3vdw66DMdCUZjSUToHh02oWajoVxpWspGqW82nfElsQTHcBTxqH4JeqCvQQwtJ
         QUOLkBlBMLHokPSf5pRKU12FNMt9Zv0lDkxKS/REerevCAtGUi2I3zcjSRDFcEJ05WaW
         x96w==
X-Gm-Message-State: AOAM532dpUNcTf/kRi9iMWt/ZDnIPPB5IYzRFqN7MoXfGM8hAtdYmehI
        tcgsa/5o5hthyIHo/EcJG8A=
X-Google-Smtp-Source: ABdhPJzdNcJvw/o/8KLivmPRL33EKUz+RXxYlWNaLQALdg+B2zMBZQdLbqmbL2NHQsvpCptTpCL3Ig==
X-Received: by 2002:a05:6402:154b:: with SMTP id p11mr2506869edx.217.1604675563355;
        Fri, 06 Nov 2020 07:12:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id pk25sm1152652ejb.16.2020.11.06.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 07:12:42 -0800 (PST)
Date:   Fri, 6 Nov 2020 16:12:40 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: fix typo Makefile
Message-ID: <20201106151240.GA45829@kozik-lap>
References: <20201105111823.1613337-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201105111823.1613337-1-anders.roxell@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:18:23PM +0100, Anders Roxell wrote:
> While trying to do 'make dtbs_install' the following error shows up
> 
> make[3]: *** No rule to make target
>   '/srv/src/kernel/next/out/obj-arm64-next-20201105/dtbsinstall/freescale/imx8mm-kontron-n801x-s.dts',
>   needed by '__dtbs_install'.
> make[3]: Target '__dtbs_install' not remade because of errors.
> make[2]: *** [/srv/src/kernel/bisecting/scripts/Makefile.dtbinst:34:
>   arch/arm64/boot/dts/freescale] Error 2
> make[2]: Target '__dtbs_install' not remade because of errors.
> make[1]: *** [/srv/src/kernel/bisecting/Makefile:1344: dtbs_install]
>   Error 2
> make: *** [Makefile:185: __sub-make] Error 2
> make: Target 'dtbs_install' not remade because of errors.

Don't paste unrelated messages and don't wrap too early ("Error 2"
should not be after new line). This blob is not useful at all.

Keep only first two lines, all rest is meaningless.

> 
> Fix typo in imx8mm-kontron-n801x-s.dts change file ending to *.dtb
> 
> Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

You need to CC the maintainers of platform. Unfortunately Makefile is
not included, so point to the DTS file to get the proper folks and
mailing lists.

Best regards,
Krzysztof
