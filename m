Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC20D2EFEE6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 11:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhAIKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 05:02:50 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48019 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbhAIKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 05:02:50 -0500
X-UUID: f39892b479ab475689c41d9738a38158-20210109
X-UUID: f39892b479ab475689c41d9738a38158-20210109
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 625812715; Sat, 09 Jan 2021 18:02:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 Jan 2021 18:02:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Jan 2021 18:02:05 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <ardb@kernel.org>
CC:     <akpm@linux-foundation.org>, <andreyknvl@google.com>,
        <aryabinin@virtuozzo.com>, <catalin.marinas@arm.com>,
        <dan.j.williams@intel.com>, <dvyukov@google.com>,
        <glider@google.com>, <kasan-dev@googlegroups.com>,
        <lecopzer.chen@mediatek.com>, <lecopzer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH 0/3] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Sat, 9 Jan 2021 18:02:05 +0800
Message-ID: <20210109100205.11359-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAMj1kXHFOQMV_4pYp9u9u++2jjQbHuLU95KeJTzrWXZWQTe_Tg@mail.gmail.com>
References: <CAMj1kXHFOQMV_4pYp9u9u++2jjQbHuLU95KeJTzrWXZWQTe_Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

> On Fri, 8 Jan 2021 at 19:31, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Sun, Jan 3, 2021 at 6:12 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
> > >
> > > Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > > ("kasan: support backing vmalloc space with real shadow memory")
> > >
> > > Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> > > but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> > > by not to populate the vmalloc area except for kimg address.
> > >
> > > Test environment:
> > >     4G and 8G Qemu virt,
> > >     39-bit VA + 4k PAGE_SIZE with 3-level page table,
> > >     test by lib/test_kasan.ko and lib/test_kasan_module.ko
> > >
> > > It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL,
> > > but not test for HW_TAG(I have no proper device), thus keep
> > > HW_TAG and KASAN_VMALLOC mutual exclusion until confirming
> > > the functionality.
> > >
> > >
> > > [1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")
> > >
> > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> >
> > Hi Lecopzer,
> >
> > Thanks for working on this!
> >
> > Acked-by: Andrey Konovalov <andreyknvl@google.com>
> > Tested-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > for the series along with the other two patches minding the nit in patch #3.
> >
> > Will, Catalin, could you please take a look at the arm changes?
> >
> > Thanks!
> >
> 
> 
> If vmalloc can now be backed with real shadow memory, we no longer
> have to keep the module region in its default location when KASLR and
> KASAN are both enabled.
> 
> So the check on line 164 in arch/arm64/kernel/kaslr.c should probably
> be updated to reflect this change.
> 

I've tested supporting module region randomized and It looks fine
in some easy test(insmod some modules).

I'll add this to patch v2, thanks for your suggestion.

BRs,
Lecopzer
