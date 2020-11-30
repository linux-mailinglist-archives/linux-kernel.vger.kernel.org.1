Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83B2C840F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgK3MXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:23:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37741 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgK3MXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:23:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id h21so24874084wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 04:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVCfLnDhqxnCaRnqSvXv1QBwbVLxk4XJomN3aTRMb7U=;
        b=kJ2OAd1MyM9orIyUv13m2lv+dkAhm2PxAstEtHU9SNoK4GMN0aNK7Gbjn/lVPe8Epp
         S8VqB5o7C4ccDt8eyLO67AyA16n0c1lH0mIQb6CWlO2ij3iErC/6K5grBikUREKeW8wQ
         GroC2GinqbLevqmgFxK6hEDSbhVSUvjmRBADRrkZvaGLY2asDPT4wxDhQyZW7lkfWV0E
         kXCAOybzN0E0sY2Kafqn3EBSwZm/C2HsDq9pN9UeE/eBC16r0twtYKGfdmOU/1L9pGKJ
         zDP6ZekBM3lbKUMfgnBUFqoemV0IUmqW0GffjMCZQJx0gpbHa4z2Z0Y69+L63s4+NDTe
         ds5g==
X-Gm-Message-State: AOAM530JhQlFihvyMoj58ZYy0av9tHhzrX8fiEymeLUn7mD2IGGt1FdI
        x5nW2ao3FQQomyOVzLd1IqQ=
X-Google-Smtp-Source: ABdhPJx1kXDADddKTYym4xvkUo0QeZzXeP3j39wHQpZ1UMr5RBDu97WAIalP5pxhEG49pVI+dZoemQ==
X-Received: by 2002:a1c:3d4:: with SMTP id 203mr23490666wmd.52.1606738968773;
        Mon, 30 Nov 2020 04:22:48 -0800 (PST)
Received: from pi3 (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r1sm26967671wra.97.2020.11.30.04.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 04:22:47 -0800 (PST)
Date:   Mon, 30 Nov 2020 13:22:45 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, vkoul@kernel.org, geert+renesas@glider.be,
        Anson.Huang@nxp.com, michael@walle.cc, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: drop unused POWER_AVS option
Message-ID: <20201130122245.GB22590@pi3>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
 <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:27:31AM +0000, Andrey Zhizhikin wrote:
> Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
> corresponding Kconfig") moved AVS code to SOC-specific folders, and
> removed corresponding Kconfig from drivers/power, leaving original
> POWER_AVS config option enabled in multi_v7_defconfig file.
> 
> Remove the option, which has no references in the tree anymore.
> 
> Fixes: 785b5bb41b0a ("PM: AVS: Drop the avs directory and the corresponding Kconfig")
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>

Thanks for the patch. You should also remove it from the omap2plus config.

Best regards,
Krzysztof
