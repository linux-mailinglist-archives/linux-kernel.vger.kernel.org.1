Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2861B277516
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgIXPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:20:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44374 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgIXPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:20:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08OFKbmD053626;
        Thu, 24 Sep 2020 10:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600960837;
        bh=As0LBQrlo7GbhKXw66VgAuUH9w1aj9X87IwzCpW+vT4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xjIa4C5kIQgkKD1o5cTbyDD+vxUvBx6vLaaIGcyQ6gTYb5XP3wCA/WEvZ0GIxuVuT
         rixW574qS4cClFNGK9UbcbGgj/Kwv3nhtMGNYB3cQNPLZXFG6QdifxMBRW4cRNGA/8
         sacQw/Pua6Fru4oym/MkROOvGSAEtuomvOCL62QI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08OFKbDt054494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 10:20:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 10:20:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 10:20:37 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08OFKYtn005534;
        Thu, 24 Sep 2020 10:20:35 -0500
Subject: Re: [PATCH] ARM: davinci: fix kconfig dependency warning when
 !PINCTRL
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
CC:     <bgolaszewski@baylibre.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <paul@pgazz.com>,
        <jeho@cs.utexas.edu>
References: <20200914123848.307406-1-fazilyildiran@gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <fa237200-7555-9fda-04be-994151637bf7@ti.com>
Date:   Thu, 24 Sep 2020 20:50:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200914123848.307406-1-fazilyildiran@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Necip,

On 14/09/20 6:08 PM, Necip Fazil Yildiran wrote:
> When ARCH_DAVINCI is enabled and PINCTRL is disabled, it results
> in the following Kbuild warning:
> 
> WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
>   Depends on [n]: PINCTRL [=n] && OF [=y] && HAS_IOMEM [=y]
>   Selected by [y]:
>   - ARCH_DAVINCI [=y] && ARCH_MULTI_V5 [=y]
> 
> The reason is that ARCH_DAVINCI selects PINCTRL_SINGLE without depending on
> or selecting PINCTRL while PINCTRL_SINGLE is subordinate to PINCTRL.
> 
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings.
> 
> Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v5")
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>

I think its better to fix this by changing the "select PINCTRL_SINGLE"
to "imply PINCTRL_SINGLE". It should be valid to build a DaVinci kernel
without pinctrl support if bootloader is taking care of the pin muxing.

I would not recommend it, but its not illegal either.

While at it, I would drop the other "select PINCTRL" line under "config
MACH_DA8XX_DT". It should not be needed since ARCH_DAVINCI will imply
PINCTRL_SINGLE

Thanks,
Sekhar
