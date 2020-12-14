Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5AD2D9543
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393102AbgLNJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:29:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44593 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726289AbgLNJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:29:40 -0500
X-UUID: 6a9b6ff6c833496cabda8d49bc852a5c-20201214
X-UUID: 6a9b6ff6c833496cabda8d49bc852a5c-20201214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1082158233; Mon, 14 Dec 2020 17:28:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Dec 2020 17:28:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Dec 2020 17:28:50 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Date:   Mon, 14 Dec 2020 17:28:51 +0800
Message-ID: <20201214092851.16741-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201125103637.GC70906@C02TD0UTHF1T.local>
References: <20201125103637.GC70906@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could any maintainer help review this?

Thanks a lot for your help,

BRs,
Lecopzer


> Although most of modern devices use ACPI, there still has combination
> of APM + ARM64.
> 
> In order to select CONFIG_APM_EMULATION, make SYS_SUPPORTS_APM_EMULATION
> default is y if ACPI isn't configured.
> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Suggested-by: YJ Chiang <yj.chiang@mediatek.com>
> ---
>  arch/arm64/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..5e9e3694015a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -260,6 +260,9 @@ config NO_IOPORT_MAP
>  config STACKTRACE_SUPPORT
>  	def_bool y
>  
> +config SYS_SUPPORTS_APM_EMULATION
> +	def_bool y if !ACPI
> +
>  config ILLEGAL_POINTER_VALUE
>  	hex
>  	default 0xdead000000000000



