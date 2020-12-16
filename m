Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B052DC47B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgLPQmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:42:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39529 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725939AbgLPQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:42:35 -0500
X-UUID: 0ba6916b4c4f4c5b93b53f1a393c392c-20201217
X-UUID: 0ba6916b4c4f4c5b93b53f1a393c392c-20201217
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 961995813; Thu, 17 Dec 2020 00:41:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Dec 2020 00:41:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 00:41:45 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <catalin.marinas@arm.com>
CC:     <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <will@kernel.org>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Date:   Thu, 17 Dec 2020 00:41:47 +0800
Message-ID: <20201216164147.9854-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216155820.GH2511@gaia>
References: <20201216155820.GH2511@gaia>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Thanks for your reply.

so there is two points
1. out-of-tree function can't be approved
    I totally agree with this :) so we may have a driver upstream in the future.
2. APM not make sense on arm64
Could you please let me konw the reason why APM on ARM64 doesn't make sense?


thanks!
BRs,
Lecopzer


> On Wed, Nov 25, 2020 at 07:41:30PM +0800, Lecopzer Chen wrote:
> > >> In order to select CONFIG_APM_EMULATION, make SYS_SUPPORTS_APM_EMULATION
> > >> default is y if ACPI isn't configured.
> > >
> > >I'm a bit confused why this should be enabled for !ACPI. Which DT
> > >platforms need this, and how do they use it? Why should this only be
> > >enabled for kernels without ACPI support, and not for kernels that
> > >support both ACPI and DT?
> > 
> > In our internal patch has no !ACPI here,
> > the reason I add here is that in kernel document[1] it mention:
> > > No, sorry, you cannot have both ACPI and APM enabled and running at once.
> > Thus, I try to limit the scope for who don't use the ACPI because I'm not sure
> > they could exist at the same time or not.
> > 
> > But I think it should be fine without !ACPI if APM and APCI
> > config won't conflict with each other.
> > 
> > So if it's better to remove !ACPI I'll send v2 for this.
> > 
> > BTW, The platform is for our internal kernel drivers, they utilize APM interface,
> > /dev/apm_bios to do their works in arm64.
> 
> Sorry, I don't think the APM interface makes sense on an arm64 kernel
> (and it's also used by an out of tree driver).
