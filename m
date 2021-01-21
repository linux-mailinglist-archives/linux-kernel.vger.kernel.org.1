Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5C22FE775
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhAUKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:22:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33242 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729210AbhAUKUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:20:15 -0500
X-UUID: 36e76576b9b3487e96b940ddce5c09d2-20210121
X-UUID: 36e76576b9b3487e96b940ddce5c09d2-20210121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 415781448; Thu, 21 Jan 2021 18:19:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Jan 2021 18:19:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 18:19:28 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <lecopzer@gmail.com>
CC:     <akpm@linux-foundation.org>, <andreyknvl@google.com>,
        <ardb@kernel.org>, <aryabinin@virtuozzo.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <dan.j.williams@intel.com>,
        <dvyukov@google.com>, <glider@google.com>, <gustavoars@kernel.org>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux@roeck-us.net>, <robin.murphy@arm.com>, <rppt@kernel.org>,
        <tyhicks@linux.microsoft.com>, <vincenzo.frascino@arm.com>,
        <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
Date:   Thu, 21 Jan 2021 18:19:18 +0800
Message-ID: <20210121101918.11423-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
References: <20210109103252.812517-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear reviewers and maintainers,


Could we have chance to upstream this in 5.12-rc?

So if these patches have any problem I can fix as soon as possible before
next -rc comming.


thanks!

BRs,
Lecopzer
