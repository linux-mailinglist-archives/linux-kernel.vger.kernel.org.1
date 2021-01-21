Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE49A2FDF89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436759AbhAUCZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:25:28 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:44260 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393018AbhAUB5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0SG1m
        BGTBN7J7iDBsfJomUMUwZVAJjt/AMZicpcW+DM=; b=JqTv2ln6m/oRKelN3O85k
        lqbKCaFuLGJNO1pwYP8mpwDracg3tcMqfk1a5R/OIBPfKy7GWiz9UzSp1vMA77Xl
        UNBP8BrR4thL2UGZzAYQuo3CdcaAtVT2JnHeHwt6wCESds62403NhTBDzbMmyVzx
        IKRqGRsuuSpgTBf3bwfXbM=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp2 (Coremail) with SMTP id GtxpCgCH29D53ghgtFIlJw--.8411S2;
        Thu, 21 Jan 2021 09:55:12 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
Subject: [PATCH] arch/riscv:fix typo in a comment in arch/riscv/kernel/image-vars.h
Date:   Thu, 21 Jan 2021 09:55:13 +0800
Message-Id: <20210121015513.2258-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgCH29D53ghgtFIlJw--.8411S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4DKw45Jr4rZry5CFyDKFg_yoW3tFcEgw
        n7G3s7WrWfArZ2vryUJ3yS9rnYy348GFyF9r1UZrW8CrykWw4Dt39IqF15Crn8GrnYqFZ3
        Ar9xGrs8ArW7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8Wq2tUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbipQAhUVUMb9PClAAAsm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

"kerne" -> "kernel"

Signed-off-by: WenZhang <zhangwen@yulong.com>
---
 arch/riscv/kernel/image-vars.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/image-vars.h b/arch/riscv/kernel/image-vars.h
index 8c212ef..71a76a6 100644
--- a/arch/riscv/kernel/image-vars.h
+++ b/arch/riscv/kernel/image-vars.h
@@ -3,7 +3,7 @@
  * Copyright (C) 2020 Western Digital Corporation or its affiliates.
  * Linker script variables to be set after section resolution, as
  * ld.lld does not like variables assigned before SECTIONS is processed.
- * Based on arch/arm64/kerne/image-vars.h
+ * Based on arch/arm64/kernel/image-vars.h
  */
 #ifndef __RISCV_KERNEL_IMAGE_VARS_H
 #define __RISCV_KERNEL_IMAGE_VARS_H
-- 
1.9.1

