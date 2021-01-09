Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457B12EFE4C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbhAIHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:35:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41129 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbhAIHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:35:22 -0500
X-UUID: 8283239f5cd546f49b0c3acee954c681-20210109
X-UUID: 8283239f5cd546f49b0c3acee954c681-20210109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1161108416; Sat, 09 Jan 2021 15:34:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 Jan 2021 15:34:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Jan 2021 15:34:23 +0800
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
Subject: Re: [PATCH 0/3] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Sat, 9 Jan 2021 15:34:23 +0800
Message-ID: <20210109073423.7304-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAAeHK+xaVvvMfd8LhPssYi+mjS-3OVsDaiNq2Li+J7JLF6k3Gg@mail.gmail.com>
References: <CAAeHK+xaVvvMfd8LhPssYi+mjS-3OVsDaiNq2Li+J7JLF6k3Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7E68C651933D07E578D2C654DCA4A58D67A68FF833FFF0EAAD1CDFA66580C7002000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,
>  
> On Sun, Jan 3, 2021 at 6:12 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
> >
> > Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > ("kasan: support backing vmalloc space with real shadow memory")
> >
> > Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> > but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> > by not to populate the vmalloc area except for kimg address.
> >
> > Test environment:
> >     4G and 8G Qemu virt,
> >     39-bit VA + 4k PAGE_SIZE with 3-level page table,
> >     test by lib/test_kasan.ko and lib/test_kasan_module.ko
> >
> > It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL,
> > but not test for HW_TAG(I have no proper device), thus keep
> > HW_TAG and KASAN_VMALLOC mutual exclusion until confirming
> > the functionality.
> 
> Re this: it makes sense to introduce vmalloc support one step a time
> and add SW_TAGS support before taking on HW_TAGS. SW_TAGS doesn't
> require any special hardware. Working on SW_TAGS first will also allow
> dealing with potential conflicts between vmalloc and tags without
> having MTE in the picture as well. Just FYI, no need to include that
> in this change.

Thanks for the information and suggestion, so this serise I'll keep 
only for KASAN_GENERIC support :)



BRs,
Lecopzer

