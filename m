Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61002FE31E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAUGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:43:48 -0500
Received: from m12-18.163.com ([220.181.12.18]:55791 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbhAUGnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xdab7
        uurP4KG1QJtVUzCo6bsWMRYXE0ma24Vt/kVsPI=; b=izkAtZ1yss3owuBEmTLaH
        C4NluMfU/0EfihjbFwDstlgqNvnXA2y8Iyi3gGOCW8m9SNht5ScgnA5dmxEgnexF
        DOEDYU3GvbuCvgjvV5MZ57j9IlTwgeuTnRvXe4oYwGkvJ6dtTZXjNmMmtD0MTRJY
        jOPzcUflTLxnHKKz82Qt/k=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAA3SRCJ6whg9R_eQA--.30496S2;
        Thu, 21 Jan 2021 10:48:47 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
Subject: [PATCH v2] arch/alpha:fix typo in a comment
Date:   Thu, 21 Jan 2021 10:48:34 +0800
Message-Id: <20210121024834.2389-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAA3SRCJ6whg9R_eQA--.30496S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWUGr1fZFW7WFy5ur1DAwb_yoW3AwcEvF
        13Xa12g3yfJrZIvr18ArZxCr9Yyan8Cr18trn7XryUXFnxZrn8JFs7Jr1avr17WrW0gan3
        Wr4Dtr17Ww18KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8X4S5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/xtbBRQ8hUVPAJp-KIAAAs6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

Fix typo in a comment in arch/alpha/boot/bootpz.c

"cvan" -> ", it can"

Signed-off-by: tangchunyou <tangchunyou@yulong.com>
---
 arch/alpha/boot/bootpz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
index 61b61be..90a2b34 100644
--- a/arch/alpha/boot/bootpz.c
+++ b/arch/alpha/boot/bootpz.c
@@ -200,7 +200,7 @@ extern int decompress_kernel(void* destination, void *source,
 	START_ADDR	KSEG address of the entry point of kernel code.
 
 	ZERO_PGE	KSEG address of page full of zeroes, but 
-			upon entry to kernel cvan be expected
+			upon entry to kernel, it can be expected
 			to hold the parameter list and possible
 			INTRD information.
 
-- 
1.9.1


