Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60DF2CBD85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbgLBMyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388857AbgLBMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:54:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B30C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 04:53:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so3816273wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 04:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9TQjlh3NMRcZHz6b1uTR/cG4dRf1nJyQ/l3ay6DiFs8=;
        b=dr1C2/7Kqchl/2FxV+J8kTGPYnfDkxxATwJG12LygGRuUzSJKL9OX9vCODkT3aO6Yp
         8wdrSXNwURqiGP0Zk5/34w9ogd/WdlA/wEiV6XQVurMJ5KCuTFtvQ3uHTwWRmzjApplw
         XX4u+AJSFuPyeg5c0s1y2YhHzJ25LH/wF8Dqt5LEgn+iUzKGaBPG0IWV/pWwtOdsWEs2
         1yYUqQm+30jn9/+Fbx8tJ37952pDAZYMtH8HN6/NDOnGHnurDu6JE4JZYI9WcaOXAx8g
         vboKC+YCJVcgeMjVb17+2US5zOgJ0m57dncYtLHh2M6rKx0VSovdrekaFrYqKaPUqMjg
         S4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9TQjlh3NMRcZHz6b1uTR/cG4dRf1nJyQ/l3ay6DiFs8=;
        b=iD51BtWDWu+m8GYnY6kqAN5jkqKTtYrYJ2/03+ZP/KO6+2GU6sn/N/2gUeLVW4NOaB
         MEB/Jl4NfF28Z4AMHSBhh7hyYWNSPhLeHHNcufAKeR4z6L8iv4zFioo53OvxxK8gqLdC
         onzELfU2H0ZVmVWPDzAhkXrW1B/anRFy90sxjUoxia3vC7AElYQqNfh+atmeHCJLY01X
         nfcbYyFuiAB1JNe9DOOvc7Gm3z5gQHq1lsvhBvzDvy3IJDsUEW+pR/SIJw20ErsRM5jJ
         Y8kPuOdDn8G9cej+NV2+womdl6U1zSkkl92hq4NyHBROBBW0n6GhAt8vqUycHheRCEKs
         8nRA==
X-Gm-Message-State: AOAM531pJNQC/IAMvKW63iv7pWbtgfrcQmLp0GtUdnq2qeKsFTgxVHrf
        +4w/z46kBRIgkyPPxLFAIFnoHQ==
X-Google-Smtp-Source: ABdhPJxngByEUMZ3YGTcSgn95mtkUTZdpk6lnDTmV5jM92WJIVhESwQATXk1hfGWMQUEmRyG/6qDyw==
X-Received: by 2002:a5d:688a:: with SMTP id h10mr3361955wru.68.1606913628304;
        Wed, 02 Dec 2020 04:53:48 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id c187sm2104937wmd.23.2020.12.02.04.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:53:47 -0800 (PST)
Date:   Wed, 2 Dec 2020 12:53:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: kempld-core: Add support for additional devices
Message-ID: <20201202125345.GJ4801@dell>
References: <0474e39790ab7351b1b11b565b995b94d49fb87c.camel@kontron.com>
 <76458fc9615cf2fb805ccd4196e3e9824ad18523.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76458fc9615cf2fb805ccd4196e3e9824ad18523.camel@kontron.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020, Michael Brunner wrote:

> This update includes DMI IDs for the following Kontron modules and
> systems:
> COMe-bDV7, COMe-cDV7, COMe-m4AL, COMe-mCT10, SMARC-sXAL, SMARC-sXA4,
> Qseven-Q7AL, mITX-APL, pITX-APL and KBox A-203
> 
> Furthermore the ACPI HID KEM0000 is added, as it is also reserved for
> kempld devices.
> 
> Instead of also adding the newly supported devices to the Kconfig
> description this patch removes the lengthy list. With future usage of
> the ACPI HIDs it will not be necessary to explicitly add support for
> each individual device to the driver and therefore the list would
> become incomplete anyway.
> 
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> ---
> 
>  v2: Corrected a board name, only use 4 digits for IDs
> 
>  drivers/mfd/Kconfig       | 30 ++--------------
>  drivers/mfd/kempld-core.c | 76 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 29 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
