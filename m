Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5269C2AFF9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKLGY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:24:58 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39561 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726020AbgKLGYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:24:54 -0500
X-UUID: 0fca04583e6f4935af9d2e5f172a45c4-20201112
X-UUID: 0fca04583e6f4935af9d2e5f172a45c4-20201112
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 542004095; Thu, 12 Nov 2020 14:24:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Nov 2020 14:24:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 14:24:47 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <miles.chen@mediatek.com>, <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: [PATCH 0/1] Fix objects remain in the offline per-cpu quarantine
Date:   Thu, 12 Nov 2020 14:24:11 +0800
Message-ID: <1605162252-23886-1-git-send-email-Kuan-Ying.Lee@mediatek.com>
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

Kuan-Ying Lee (1):
  kasan: fix object remain in offline per-cpu quarantine

 mm/kasan/quarantine.c | 59 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

-- 
2.18.0

