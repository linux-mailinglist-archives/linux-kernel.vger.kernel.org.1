Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19332DEEAA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgLSMTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 07:19:14 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35940 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgLSMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 07:19:13 -0500
Received: by mail-ed1-f43.google.com with SMTP id b2so5112380edm.3;
        Sat, 19 Dec 2020 04:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qi+cHJsutD0v/2D158E61pxGnRmCY1Auxgmi47GVOeE=;
        b=QVwgiHdGYh7btqH/Sf+ZZRcxYwkglhRK+Ut6IZNTaCRdqPp6tdz+J2qmrGzqTmSgZo
         WIYNl05OTctNSJACtbwkTejT7CTle9svWI3FizKoVohvRk2VYO+PWYXu22F1cDI5vVLA
         54Ya4PssvHHEUYFxyqT5ue9izgptx+tIm+sXaKQ9x1/7D+SftQSSasdt5uBgmrwwBKVT
         OB0kS00qQjE4UHEaGL1QPL1tMlNKoz/696tHSCzfLMUwFOp+KmuP/it1SiM4sjqDMcdV
         ANJvV0YaVYzLxdYRbl4z4lL2pqnXBelueebYt7S5BS8zFIBcvUjmzvpm2sjkiAsN/fud
         Xhbg==
X-Gm-Message-State: AOAM533BuT7RcgAtqyMiUWDby6l69TbVMJcR2U/k11tUxZEdWEwshErI
        dr8ehKQmhbXC9b+EeCnuXiM=
X-Google-Smtp-Source: ABdhPJz3AF5UZHZA83wBIxOoi/qH0ktPREnG1PVUi4nAA1FyeEy8mQkPeLg7YijpfFupqZA6Pq/vAw==
X-Received: by 2002:aa7:da8f:: with SMTP id q15mr8534914eds.239.1608380311889;
        Sat, 19 Dec 2020 04:18:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d14sm28331645edn.31.2020.12.19.04.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:18:30 -0800 (PST)
Date:   Sat, 19 Dec 2020 13:18:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v8 4/4] soc: imx8m: change to use platform driver
Message-ID: <20201219121829.GB13886@kozik-lap>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218083726.16427-4-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201218083726.16427-4-alice.guo@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 04:37:26PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Directly reading ocotp register depends on that bootloader enables ocotp
> clk, which is not always effective, so change to use nvmem API. Using
> nvmem API requires to support driver defer probe and thus change
> soc-imx8m.c to use platform driver.
> 
> The other reason is that directly reading ocotp register causes kexec
> kernel hang because the 1st kernel running will disable unused clks
> after kernel boots up, and then ocotp clk will be disabled even if
> bootloader enables it. When kexec kernel, ocotp clk needs to be enabled
> before reading ocotp registers, and nvmem API with platform driver
> supported can accomplish this.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> Changes for v8:
>  - none
> Changes for v7:
>  - solve the problem "drivers/soc/imx/soc-imx8m.c:174:34: warning:
>    unused variable"

There was a reviewed-by part of changelog. The tag was in your commit.
I am now confused, as changes for v8 say "none"... but shall I trust it?

Best regards,
Krzysztof
