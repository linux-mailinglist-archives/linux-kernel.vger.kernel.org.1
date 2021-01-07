Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCE2ECD0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAGJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:45:01 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:50332 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbhAGJpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:45:00 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210107094417epoutp031ebad17057d17fd1c7f00508e42bcdb4~X6ftpvfZh1845718457epoutp030
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:44:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210107094417epoutp031ebad17057d17fd1c7f00508e42bcdb4~X6ftpvfZh1845718457epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610012657;
        bh=r/0HIMuAWDGl4sC40IJqtgoGCRFGMy3zgCudWco9GyE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dorORJ43Zsopye2Be4EDIljj/hxB4+earfK1BIM0+NqunZRi47+KuMDOdH/uqPJlD
         wiPjdVjCos45r+MQ328pZt8AyXkyIojTrybAesdiZWxbUbQYCacO0gL1OenP0i3Pi0
         ib9VgQUbD7Q4dBZSkWe27jEk0RaFKVYMSRa6wA1M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210107094417epcas1p2e0d3cc35c3ffd68b877d258dc84977a5~X6ftLHunV1299612996epcas1p2E;
        Thu,  7 Jan 2021 09:44:17 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DBLsp1VVGz4x9Q9; Thu,  7 Jan
        2021 09:44:14 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.0F.09577.DE7D6FF5; Thu,  7 Jan 2021 18:44:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210107094413epcas1p1dbbcbbea7ba9a3c4a50e7dc3ae5a5314~X6fpvSCkZ3204532045epcas1p1X;
        Thu,  7 Jan 2021 09:44:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210107094413epsmtrp198b3834b45a048670b141e0cc31b4697~X6fpubEUX3170531705epsmtrp1j;
        Thu,  7 Jan 2021 09:44:13 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-a8-5ff6d7ed9e67
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.0F.13470.DE7D6FF5; Thu,  7 Jan 2021 18:44:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.222]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210107094413epsmtip18cf77905d0aadbd158c22add26992e38~X6fpci6RU0611206112epsmtip1s;
        Thu,  7 Jan 2021 09:44:13 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, ardb@kernel.org, jcmvbkbc@gmail.com,
        olof@lixom.net, sw0312.kim@samsung.com, jh80.chung@samsung.com
Subject: [PATCH] ARM: mm: Free memblock from free_initrd_mem()
Date:   Thu,  7 Jan 2021 18:47:02 +0900
Message-Id: <1610012822-20291-1-git-send-email-sw0312.kim@samsung.com>
X-Mailer: git-send-email 1.7.4.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmnu6769/iDRZtZbKYs34Nm8XPL+8Z
        Lb49XMhoceNXG6vFpsfXWC0u75rDZnFo6l5Gi1PXP7NZHFm/nclixuSXbA5cHpevXWT22Dnr
        LrvHplWdbB4nZvxm8di8pN7jyokmVo++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnXFq0iTGgg3sFRtOLGdqYJzL1sXI
        ySEhYCKx8UoPYxcjF4eQwA5Gic6DM5ghnE+MEjvaH0FlvjFKXDn+hh2m5dq62awQib2MEn++
        vWKCcL4wSvz7sZMFpIpNQEdi/5LfrCC2iIC9xLXHs8DmMgtsZZRoaf8PlhAWsJNYvmkn2FgW
        AVWJk12tTCA2r4CbxP5dr5gg1ilILLj3lg2kWULgEbvEj/YfjBAJF4mZm1dCFQlLvDq+Beo+
        KYmX/W1QdrXE9gk/2SGaOxgletobWSASxhL7l04GauYAOklTYv0ufYiwosTO33PB5jML8Em8
        +9rDClIiIcAr0dEmBFGiIrHz6CQ2iLCUxKwNwRBhD4kfjx+AVQsJxEq8fCc4gVF2FsL4BYyM
        qxjFUguKc9NTiw0LTJFjaRMjON1pWe5gnP72g94hRiYOxkOMEhzMSiK8Fse+xAvxpiRWVqUW
        5ccXleakFh9iNAUG10RmKdHkfGDCzSuJNzQ1MjY2tjAxNDM1NFQS500yeBAvJJCeWJKanZpa
        kFoE08fEwSnVwLS/U/RnVq2ImkzPwWyPZhbHT9aN3T+nS/ZP7VZRd9s1n8n49LeSylvPAzU1
        9IO/rxBw+bXm6L22aR7LNPeXR3SUrp6XtvXIjtrMh6sZVPyX7t15u3nWDLNkNelzSyt860sC
        9xs3RueLr9+muyjEQvfvvMJA93jhikVFbx0F+rIE/SR8Ui5aaFww2Mm+cILVwS+aNov4jT7+
        LRITVnr+iq3Uy8xvr2rZ/IMn454XlWpcmKg3/9JPn4Jqzb3XTq5xFXgx+X+bN+9OZdEropmf
        Pz/I09TSkhI7HVf8/tzfE6Ufvk6zLRLuXel5+nPsEc+P35vKaoIfhrUnhT9xqvozc/fCnwwB
        InMcQuedW2c/W4mlOCPRUIu5qDgRAJIKkb0ABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnO7b69/iDc6uEreYs34Nm8XPL+8Z
        Lb49XMhoceNXG6vFpsfXWC0u75rDZnFo6l5Gi1PXP7NZHFm/nclixuSXbA5cHpevXWT22Dnr
        LrvHplWdbB4nZvxm8di8pN7jyokmVo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKODVpEmPB
        BvaKDSeWMzUwzmXrYuTkkBAwkbi2bjZrFyMXh5DAbkaJ/hfrmCASUhJzv21n7GLkALKFJQ4f
        LgYJCwl8YpToXcIIYrMJ6EjsX/KbFcQWEXCUOLKvkwVkDrPAfkaJ84032UESwgJ2Ess37QSz
        WQRUJU52tYLN5xVwk9i/6xXULgWJBffesk1g5FnAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0
        L10vOT93EyM4/LQ0dzBuX/VB7xAjEwfjIUYJDmYlEV6LY1/ihXhTEiurUovy44tKc1KLDzFK
        c7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamA63t7z7RCP4dWZh915E3g4rszcUn/P6YLv
        jBipf1WBh2eeX3N/05+b16xPG2nuWfChxUVpo/wefe1pJtu+NKyez3XWe03UQqHTgWku7AfP
        73ho9moN9zqj7FOyz1R91mozuNnvfcbq98onbfaFjT8us53geG4ftOBzwYGzFluWCO7S+2K+
        umf73rTEOTWn9ZiPnJ6il/Lt38ajV3TVq283m8kzpe2frvht+RPVQMaJRx9pnD4R2JT37Ehw
        68vEdae9dJ99cL9xcOOe6Yx3uSsXvAvQCUqV+blMj222YNHTyRpRbnsvb0y4kX+78RjL+wTN
        Ten5GroLNjQVLe1J8lppbPxKN1Gu4ugc34mnT13wW6PEUpyRaKjFXFScCACRl+hOrgIAAA==
X-CMS-MailID: 20210107094413epcas1p1dbbcbbea7ba9a3c4a50e7dc3ae5a5314
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210107094413epcas1p1dbbcbbea7ba9a3c4a50e7dc3ae5a5314
References: <CGME20210107094413epcas1p1dbbcbbea7ba9a3c4a50e7dc3ae5a5314@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even after free_initrd_mem(), memblock for initrd remains. Free
memblock for initrd from free_initrd_mem().

Reported-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 arch/arm/mm/init.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a256..f7db023 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -530,6 +530,13 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
+	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
+
+	memblock_free(__pa(aligned_start), aligned_end - aligned_start);
+#endif
+
 	if (start == initrd_start)
 		start = round_down(start, PAGE_SIZE);
 	if (end == initrd_end)
-- 
1.7.4.1

