Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7992C2209
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgKXJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:48:25 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33333 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgKXJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:48:25 -0500
Received: by mail-ej1-f67.google.com with SMTP id 7so27553154ejm.0;
        Tue, 24 Nov 2020 01:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHg8opE9L5ssa94AdwhJs0rx8rUn9jblcvlXwtbT79s=;
        b=ivCyxUdqckFfsX0FvxUAMEl0RPWa8CQ5d68g2ZjtdcCnrSyPNryJFnmi7jFC5sXxHm
         MB4SR0u4p41l/ZJdndNEtKGP45r5Uac/7RVKymfC9mw0pHzn1c9MRoOTN1Y9padAlt1T
         y7RBilxzoC/CwITV82DbBwLOCwmXEFAW5X5yBrnUhXK+356SY6R/e5mThHfgjWs8Z/HA
         gdFfsQvJpma8DYMQQCVLn6n83qz15tvUZcNz2HpeQs1VQM3ggBevdKpdlvS3jwaCA/vw
         h8BS+ehgbvZgaq1ewRMx6oDXeMkau1OduAXedWuqJDdWx9abt4KAfpvSl9vwRCGcMU0A
         pqqg==
X-Gm-Message-State: AOAM533nxciD5NkuB3aVlWilloBk9V7HYf98Kfji1VYA/MjrX1RBhicb
        g8yG8renyFe3LqdeMwfgqlFvQnbzw88=
X-Google-Smtp-Source: ABdhPJyggbZTD/skqATfplFLBtAYVhwVXtFfpu71G0LRsxRoVgm4xAKt5ANzXDkyYTPMCNWGq2arVA==
X-Received: by 2002:a17:906:eb46:: with SMTP id mc6mr3622300ejb.54.1606211303203;
        Tue, 24 Nov 2020 01:48:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b9sm6509738ejb.0.2020.11.24.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 01:48:22 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:48:20 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/4] soc: imx8m: change to use platform driver
Message-ID: <20201124094820.GC15030@kozik-lap>
References: <20201124015949.29262-1-alice.guo@nxp.com>
 <20201124015949.29262-4-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124015949.29262-4-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 09:59:49AM +0800, Alice Guo wrote:
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

I already reviewed it. You skipped all my review tags from v5.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> ---
> 
> v2: remove the subject prefix "LF-2571-4"
> v3: Keep the original way which uses device_initcall to read soc unique
>     ID, and add the other way which uses module_platform_driver and
>     nvmem API, so that it will not break the old version DTBs.
> v4: delete "__maybe_unused"
>     delete MODULE_DEVICE_TABLE(of, imx8m_soc_match);
>     rename match table, "fsl,imx8mm/n/q/p" is actually a machine
> compabile and "fsl,imx8mm/n/q/p-soc" is a compabile of soc@0
>     delete "flag" and change to determine whether the pointer is NULL
>     ues of_find_matching_node_and_match()
>     delete of_match_ptr()
> v5: add cleanup part "of_node_put"
>     add note to explain that why device_initcall still exists
> v6: none
