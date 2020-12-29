Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA942E6EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgL2H3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:29:22 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:8230 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbgL2H3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:29:21 -0500
X-AuditID: 0a650161-e51ff70000001043-69-5feadaa254bc
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 39.E9.04163.2AADAEF5; Tue, 29 Dec 2020 15:28:34 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1609226914; h=from:subject:to:date:message-id;
        bh=ckqbPj/qgcwYf2JKOHD5zfKi40VVFJ1/9rVVvWK529Q=;
        b=M/tKvKPljuhMK63yu2wyBO8glLHjEbauMCQ6goTwic/y6r7iDF5IqB13uit0boXAequoB0eA0Ws
        ok113xkh+uddtdOoKqp8p/ySOV4peGmymTymgcnaBrXE88om8k5GCjbOYzRLoM1DKmP2/XFFTnyBV
        CIpbTdFR0xaDbwLB4sA=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.252) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Tue, 29 Dec 2020 15:28:33 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] sizes.h: Add SZ_8G/SZ_16G/SZ_32G macros
Date:   Tue, 29 Dec 2020 15:28:19 +0800
Message-ID: <20201229072819.11183-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.252]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add these macros, since we can use them in drivers.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 include/linux/sizes.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index 9874f6f67537..1ac79bcee2bb 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -44,6 +44,9 @@
 #define SZ_2G				0x80000000
 
 #define SZ_4G				_AC(0x100000000, ULL)
+#define SZ_8G				_AC(0x200000000, ULL)
+#define SZ_16G				_AC(0x400000000, ULL)
+#define SZ_32G				_AC(0x800000000, ULL)
 #define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.17.1

