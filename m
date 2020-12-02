Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255CE2CB5F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgLBHyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:54:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42113 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726157AbgLBHyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:54:11 -0500
X-UUID: a885dc096bc1489ea0ccbfb7beaf2d2e-20201202
X-UUID: a885dc096bc1489ea0ccbfb7beaf2d2e-20201202
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 775296454; Wed, 02 Dec 2020 15:53:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Dec 2020 15:53:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Dec 2020 15:53:27 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH v3 0/1] Fix object remain in offline per-cpu quarantine
Date:   Wed, 2 Dec 2020 15:53:04 +0800
Message-ID: <1606895585-17382-1-git-send-email-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes object remain in the offline per-cpu quarantine as
describe below.

Free objects will get into per-cpu quarantine if enable generic KASAN.
If a cpu is offline and users use kmem_cache_destroy, kernel will detect
objects still remain in the offline per-cpu quarantine and report error.

Register a cpu hotplug function to remove all objects in the offline
per-cpu quarantine when cpu is going offline. Set a per-cpu variable
to indicate this cpu is offline.

Changes since v3:
 - Add a barrier to ensure the ordering
 - Rename the init function

Changes since v2:
 - Thanks for Dmitry suggestion
 - Remove unnecessary code
 - Put offline variable into cpu_quarantine
 - Use single qlist_free_all call instead of iteration over all slabs
 - Add bug reporter in commit message

Kuan-Ying Lee (1):
  kasan: fix object remain in offline per-cpu quarantine

 mm/kasan/quarantine.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

-- 
2.18.0

