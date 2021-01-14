Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39DD2F6356
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbhANOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:41:08 -0500
Received: from ms.lwn.net ([45.79.88.28]:58396 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbhANOlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:41:07 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C5F106139;
        Thu, 14 Jan 2021 14:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C5F106139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610635227; bh=qRURchjLTP1weg90nrfIXrzmaVl3oLNx+1rbmhDEPaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HXuN4/253F0cmvtyKg2ri1O3gYGZsIA701UezYuLGaeoW3abk/V5QNB/DwAq1sqJa
         Rsk89g+5eed750UTMB8r8QJ2Szgh0TwHWvxi4RCKA+4NY5bbS592440c75jdHslYJk
         pcsyeD+tbMUMHCCPlDd8HWJaPhG8r3zylKPRFaexu8Jy1M+JcgGe3TWSd0uhYUM47B
         Koj0ysm0Rd0QKV0PbNPIWjkEpYTOy5wlCiVYA2BStEjoAzm5fe2rbbin060I5t5Cgd
         HAyc4xu4tibayPlcTArxjIQ2LrYlv7oQszYaNqTf5DzFTNEP7JHfb8ja50kX19SAUi
         9MUPhr23ZNf/Q==
Date:   Thu, 14 Jan 2021 07:40:25 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] doc/zh_CN: fix Sphinx errors
Message-ID: <20210114074025.44b29891@lwn.net>
In-Reply-To: <ad0badc92b4cda71384951e1e501e1babb6d8d4f.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
        <ad0badc92b4cda71384951e1e501e1babb6d8d4f.1610610444.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 08:53:36 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The whitespacing with some translations are weird,
> which causes errors like this one:
> 
> 	devel/v4l/docs/Documentation/translations/zh_CN/mips/ingenic-tcu.rst:61: WARNING: Malformed table.
> 	Text in column margin in table line 6.
> 
> 	===========         =====
> 	时钟                drivers/clk/ingenic/tcu.c
> 	中断                drivers/irqchip/irq-ingenic-tcu.c
> 	定时器              drivers/clocksource/ingenic-timer.c
> 	OST                 drivers/clocksource/ingenic-ost.c
> 	脉冲宽度调制器      drivers/pwm/pwm-jz4740.c
> 	看门狗              drivers/watchdog/jz4740_wdt.c
> 	===========         =====
> 
> Fix it.

This one has already been taken care of.

Thanks,

jon
