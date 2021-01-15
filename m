Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA382F7260
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbhAOFli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:41:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11015 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbhAOFlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:41:35 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DH9431Yw0zj7nk;
        Fri, 15 Jan 2021 13:39:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 13:40:40 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/4] initrd: Use unified initrd reserve function in ARM/RISCV
Date:   Fri, 15 Jan 2021 13:46:02 +0800
Message-ID: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same implementation of initrd reserve to avoid duplication.

v3:
- split into four patches, suggested-by Palmer Dabbelt
v2:
- fix build error found by kernel test robot

Kefeng Wang (4):
  initrd: Add the preprocessor guard in initrd.h
  initramfs: Provide a common initrd reserve function
  ARM: Covert to reserve_initrd_mem()
  riscv: Covert to reserve_initrd_mem()

 arch/arm/mm/init.c     | 43 +--------------------------------
 arch/riscv/mm/init.c   | 54 +-----------------------------------------
 include/linux/initrd.h | 11 +++++++++
 init/initramfs.c       | 45 +++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 95 deletions(-)

-- 
2.26.2

