Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0062EFE47
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhAIH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:27:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57484 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725847AbhAIH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:27:17 -0500
X-UUID: 2bf8f8f83d444d7cb12be7145ef8876b-20210109
X-UUID: 2bf8f8f83d444d7cb12be7145ef8876b-20210109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1367188255; Sat, 09 Jan 2021 15:26:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 Jan 2021 15:26:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Jan 2021 15:26:33 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <andreyknvl@google.com>
CC:     <akpm@linux-foundation.org>, <aryabinin@virtuozzo.com>,
        <catalin.marinas@arm.com>, <dan.j.williams@intel.com>,
        <dvyukov@google.com>, <glider@google.com>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <lecopzer@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH 3/3] arm64: Kconfig: support CONFIG_KASAN_VMALLOC
Date:   Sat, 9 Jan 2021 15:26:33 +0800
Message-ID: <20210109072633.7234-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAAeHK+wc-DU2pUma43JtomOSy0Z6smGKwQoG_R+uKzByu3oZ9w@mail.gmail.com>
References: <CAAeHK+wc-DU2pUma43JtomOSy0Z6smGKwQoG_R+uKzByu3oZ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,
 
> On Sun, Jan 3, 2021 at 6:13 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
> >
> > Now I have no device to test for HW_TAG, so keep it not selected
> > until someone can test this.
> >
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  arch/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 05e17351e4f3..29ab35aab59e 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -136,6 +136,7 @@ config ARM64
> >         select HAVE_ARCH_JUMP_LABEL
> >         select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > +       select HAVE_ARCH_KASAN_VMALLOC if (HAVE_ARCH_KASAN && !KASAN_HW_TAGS)
> 
> KASAN_VMALLOC currently "depends on" KASAN_GENERIC. I think we should
> either do "HAVE_ARCH_KASAN && KASAN_GENERIC" here as well, or just do
> "if HAVE_ARCH_KASAN".

Thanks for the correctness, I'll change to the following in V2 patch.
	"select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN"

Let KASAN_VMALLOC depend on the mode it supports to avoid modifying
two places if KASAN_VMALLOC can support other than GENERIC in the future.
