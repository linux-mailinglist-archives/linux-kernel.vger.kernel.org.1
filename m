Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201E32FD531
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbhATQO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:14:27 -0500
Received: from m12-16.163.com ([220.181.12.16]:50664 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391344AbhATQN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=D4mdl
        yQB1pXTj9GqLmepuC+vdfy4ZaH+ugJ/Ulh//J4=; b=TMPeezjfmQrHY3pQEhJOP
        1n72vr2n57TIa5TLyfdJNWaATjQepDy+rGanRsi3Icn2x74geH3hZDTJzOPpcLBI
        FbXfOR6MJr4KZ8043bBy7FwJomODGaSupSvN1pTeSZfBbDzD30O9Ldg7Nd+fV25r
        JK48GMbjN+Dk/bjFuJvs1g=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowADXykRJMQhgPnUmYA--.25667S2;
        Wed, 20 Jan 2021 21:34:09 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        akpm@linux-foundation.org, rppt@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@yulong.com, tangchunyou@yulong.com
Subject: [PATCH] arch/alpha: fix typo in a comment in arch/alpha/boot/bootpz.c
Date:   Wed, 20 Jan 2021 21:34:10 +0800
Message-Id: <20210120133410.2182-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADXykRJMQhgPnUmYA--.25667S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw13Ar4fuFWxCFy5XF1fZwb_yoW3JFbEvF
        1aqw42g3yfXFZIvr1kA3yfur9Yyan5Cr1rtrn7Xry7ZFnxZrn8JFZrJr4avr47WrWvqana
        grs2qrn7uw18KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU06VbDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiHhEgUVSIsZKXIgAAs0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

"kerne" -> "kernel"

Signed-off-by: tangchunyou <tangchunyou@yulong.com>
---
 arch/alpha/boot/bootpz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
index 43af718..61b61be 100644
--- a/arch/alpha/boot/bootpz.c
+++ b/arch/alpha/boot/bootpz.c
@@ -200,7 +200,7 @@ extern int decompress_kernel(void* destination, void *source,
 	START_ADDR	KSEG address of the entry point of kernel code.
 
 	ZERO_PGE	KSEG address of page full of zeroes, but 
-			upon entry to kerne cvan be expected
+			upon entry to kernel cvan be expected
 			to hold the parameter list and possible
 			INTRD information.
 
-- 
1.9.1


