Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F1F2E2CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 04:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgLZDaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 22:30:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9931 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLZDaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 22:30:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D2q6N1MLCzhxX1;
        Sat, 26 Dec 2020 11:29:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 26 Dec 2020 11:29:26 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <ardb@kernel.org>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <nsaenzjulienne@suse.de>, <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>,
        <huawei.libin@huawei.com>, <xiexiuqi@huawei.com>
Subject: [PATCH 0/2] arm64: mm: fix kdump broken with ZONE_DMA reintroduced
Date:   Sat, 26 Dec 2020 11:35:55 +0800
Message-ID: <20201226033557.116251-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the memory reserved for crash dump kernel falled in ZONE_DMA32,
the devices in crash dump kernel need to use ZONE_DMA will alloc fail.
           
Fix this by reserving low memory in ZONE_DMA if CONFIG_ZONE_DMA is
enabled, otherwise, reserving in ZONE_DMA32.

Patch 1 updates the comments about the ZONE_DMA.
Patch 2 fix kdump broken.

Chen Zhou (2):
  arm64: mm: update the comments about ZONE_DMA
  arm64: mm: fix kdump broken with ZONE_DMA reintroduced

 arch/arm64/mm/init.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.20.1

