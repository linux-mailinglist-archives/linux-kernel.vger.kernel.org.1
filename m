Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4518727AAB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgI1J1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:27:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbgI1J1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:27:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0B0F9CC6B51B16F014DD;
        Mon, 28 Sep 2020 17:26:59 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 17:26:52 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/2] ARM: decompressor: relax the loading restriction of the decompressed kernel
Date:   Mon, 28 Sep 2020 17:26:39 +0800
Message-ID: <20200928092641.2070-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is baseed on Ard Biesheuvel's series:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-p2v-v2


Zhen Lei (2):
  ARM: p2v: fix trivial comments
  ARM: decompressor: relax the loading restriction of the decompressed
    kernel

 arch/arm/boot/compressed/head.S | 33 ++++++++++++++-------------------
 arch/arm/kernel/phys2virt.S     |  4 ++--
 2 files changed, 16 insertions(+), 21 deletions(-)

-- 
1.8.3


