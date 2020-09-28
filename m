Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415BA27B42C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgI1SNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:13:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53516 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgI1SNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:13:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08SIDCT1062317;
        Mon, 28 Sep 2020 13:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601316792;
        bh=CasjrgzHVyLc+ilz105hi1BU9h5XrolkxMvRLUdH7S0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hD4HzWDHo2CM/ea2yBk3FSe2Vho5ClX/l8KHZ/Mt/3bVQPdDZS0KBuTHTotqkjwpE
         PkcG29QQBntPmL1SI+Gud+hAt8dCDFNnfihqWWxykr35w0R59T3lMHT4ZV30hDT7Wn
         53dkvz8/GOxXznQyJhHUbVFxJOCug4DgTKNQKtTQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08SIDCAm034050
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 13:13:12 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 13:13:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 13:13:11 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08SID9VQ074015;
        Mon, 28 Sep 2020 13:13:09 -0500
Subject: Re: [PATCH] ARM: davinci: fix kconfig dependency warning when
 !GPIOLIB
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
CC:     <geert+renesas@glider.be>, <bgolaszewski@baylibre.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <paul@pgazz.com>,
        <jeho@cs.utexas.edu>
References: <20200914141954.337859-1-fazilyildiran@gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a04c933d-9642-c211-1e49-7f564019d6ab@ti.com>
Date:   Mon, 28 Sep 2020 23:43:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200914141954.337859-1-fazilyildiran@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/20 7:49 PM, Necip Fazil Yildiran wrote:
> When MACH_DAVINCI_DA830_EVM is enabled and GPIOLIB is disabled, it results
> in the following Kbuild warning:
> 
> WARNING: unmet direct dependencies detected for GPIO_PCF857X
>   Depends on [n]: GPIOLIB [=n] && I2C [=y]
>   Selected by [y]:
>   - MACH_DAVINCI_DA830_EVM [=y] && ARCH_DAVINCI [=y] && ARCH_DAVINCI_DA830 [=y] && I2C [=y]
> 
> The reason is that MACH_DAVINCI_DA830_EVM selects GPIO_PCF857X without
> depending on or selecting GPIOLIB while GPIO_PCF857X is subordinate to
> GPIOLIB.
> 
> Honor the kconfig menu hierarchy to remove kconfig dependency warnings.
> 
> Fixes: 77316f057526 ("davinci: DA830/OMAP-L137 EVM: use runtime detection for UI card")
> Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>

Here too, I think changing to "imply GPIO_PCF857X if I2C" is better.

Thanks,
Sekhar
