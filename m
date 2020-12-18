Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A912DDDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 06:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgLRFDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 00:03:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46387 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgLRFDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 00:03:05 -0500
X-UUID: 0d42aa00950e441a81b5dd2f734e05ac-20201218
X-UUID: 0d42aa00950e441a81b5dd2f734e05ac-20201218
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 261668821; Fri, 18 Dec 2020 13:02:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Dec 2020 13:02:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 13:02:19 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <catalin.marinas@arm.com>
CC:     <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Date:   Fri, 18 Dec 2020 13:02:20 +0800
Message-ID: <20201218050220.25803-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201217164911.GB20278@gaia>
References: <20201217164911.GB20278@gaia>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,
 
Thanks for your explanation.
 
> > so there is two points
> > 1. out-of-tree function can't be approved
> >     I totally agree with this :) so we may have a driver upstream in the future.
> 
> It may not be upstreamable if it relies on the old APM interface ;).
> 
> > 2. APM not make sense on arm64
> > Could you please let me konw the reason why APM on ARM64 doesn't make sense?
> 
> It's a very old interface, even on x86 it is disabled in the distro
> kernels. There are more modern alternatives and you should update your
> driver and user space to use them (e.g. /sys/power/).

Got it! I will disscuss with our internal team to update their drivers.

thanks a lot!

BRs,
Lecopzer
