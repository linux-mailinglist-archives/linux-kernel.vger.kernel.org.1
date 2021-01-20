Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CCB2FC548
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbhATACb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbhATABx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:01:53 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860E2C0613C1;
        Tue, 19 Jan 2021 16:01:03 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1BFAA52BF;
        Wed, 20 Jan 2021 00:01:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1BFAA52BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611100863; bh=tn1wINqlscY/vHOgWAz1D25iKzRtrck2nKofvI8A/kI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rFkD2YRmFgwXGihwHj/BER7Fu/rLxWwvkv8IhGNmeGl+RnJ7IDlBes0LuLupMvty5
         fjZxFjosFKRJ+8MHMf5mvhfUWqf/xmFEmESej2UMtHDefHvuSXeLoGPsNM2GUNtlRM
         ZXU6HmCMyjAqBfsww8Jcp/ck5L8alpGbOVaOERr7ZEkIoEZmQVBYWboB37eAaIUw+Z
         tnrlwJeWmHUZRe688oByBJVuhS9tziMQerzBblnnALqR6G9bgLQR5LtGRB2NUtT2W0
         QmYNSgJiiqnZECmt9VX+buUv/CmxFR4+BksuqcccCOCBYkxelqELZWTQKNN6XJhE9b
         tdKN/XQchDuSA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Milan Lakhani <milan.lakhani@codethink.co.uk>,
        lukas.bulwahn@gmail.com, sudip.mukherjee@codethink.co.uk,
        linux-safety@lists.elisa.tech, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, harryxiyou@gmail.com,
        alex.shi@linux.alibaba.com
Cc:     Milan Lakhani <milan.lakhani@codethink.co.uk>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] docs: Change reference that was to removed file
In-Reply-To: <1611051980-3834-1-git-send-email-milan.lakhani@codethink.co.uk>
References: <1611051980-3834-1-git-send-email-milan.lakhani@codethink.co.uk>
Date:   Tue, 19 Jan 2021 17:01:02 -0700
Message-ID: <87y2gopjcx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milan Lakhani <milan.lakhani@codethink.co.uk> writes:

[CC += Rob]

> There were two references to
> Documentation/devicetree/booting-without-of.rst for dtb format
> information. This file has been removed, so I have changed the links to
> Documentation/devicetree/usage-model.rst for this information, which
> itself points to https://elinux.org/Device_Tree_Usage for an overview of
> the device tree data format.
>
> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> ---
>  Documentation/arm/booting.rst                | 2 +-
>  Documentation/translations/zh_CN/arm/Booting | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/arm/booting.rst b/Documentation/arm/booting.rst
> index a226345..5392d01 100644
> --- a/Documentation/arm/booting.rst
> +++ b/Documentation/arm/booting.rst
> @@ -128,7 +128,7 @@ it.  The recommended placement is in the first 16KiB of RAM.
>  
>  The boot loader must load a device tree image (dtb) into system ram
>  at a 64bit aligned address and initialize it with the boot data.  The
> -dtb format is documented in Documentation/devicetree/booting-without-of.rst.
> +dtb format is documented in Documentation/devicetree/usage-model.rst.

Except that ... usage-model.rst doesn't actually document the DTB
format.  Perhaps we should instead substitute a link that does what's
promised here?

Thanks,

jon
