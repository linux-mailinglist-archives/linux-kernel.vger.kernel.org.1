Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC622E18E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgLWGZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgLWGZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:25:04 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0C5C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:24:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f14so2494887pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QiwH8ao3HelKgvVCUMgmqCqlcpNzwtvsd407+B9/1NY=;
        b=eYnQiqzkc8vzQwlMvfZzfj7syy7MJ1XFHJjiVNkeZHNg3jyRjKCiR+TPpvalS6M2Pc
         2xsl6Gln5wx027ZKiQpWimcwigEU0tvBHl2sdCYyWupq0P/uHegXExkviWowQ6WYJqbc
         HnZDPjn7+nTnvg4racg/ahs7PvAhDet12LBwQ5S9DljuYWzxzbdmOKP8UpBlZb2ZMB/2
         czxBL0Ow4GAsTFSR4f4WsKJ1dRYlZJ1FVLB4U/Nv/PrzefztSxTNI6TggEQHGmF65uX6
         AXqzmq5KeNYX1Zp0T8TVIwXBpJX6aMmhAU1R2AC5h6DKxrEFY+HrcLFTxiDkOGEPcWCW
         S0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QiwH8ao3HelKgvVCUMgmqCqlcpNzwtvsd407+B9/1NY=;
        b=Q7bJshPB8bLyEVf8KVLcK/49zFZcbv8klnODyxkkBsXhb8ddX5N4zDKiFvsUMOU4JD
         qkQhI3L3mX6zUKEEjXHkf3XgG5OE5yGCp9q15/smdDo9y6bh2zdcqZyMv4XjjaLi12MU
         tE8Y+dJzjPeUAMgAIX5s8mqY6E7E866o6O8W4nsg9s+xzOLXtVnRWlGUiYDdHqHbCJRb
         OQZObFWOOo+PYrnvwh1CtgyQGZ8tqqD5TLbHneMtCpjF7scDiCLWasK0z6MKQUaokJxm
         rsM1ymcXd6YFc9/PasVXn08SzUqR373OrATB6Lo8KzrzIFB4z8Z0lFwY3rRauNGhZwlZ
         K1UQ==
X-Gm-Message-State: AOAM531slkbc0X0gJNM6TyfA9lvy6Wiqlfdsy+B3Bi8s74ZNpcktsr2d
        wYzWywUB9sRb58SpuolKPeQggtYEZuI=
X-Google-Smtp-Source: ABdhPJyxNF52FuyNuoJelGOrJq7YmmPv7+afCqw0vLDy2cmpXqIywzuQsCNT2fBLXqgRv5G1GviOnA==
X-Received: by 2002:a17:90a:12c4:: with SMTP id b4mr25060313pjg.234.1608704663193;
        Tue, 22 Dec 2020 22:24:23 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id y6sm1480667pjl.0.2020.12.22.22.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 22:24:22 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     zhongjiang@huawei.com, joe@perches.com, konrad.wilk@oracle.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] x86/iommu: Fix two minimal issues in check_iommu_entries()
Date:   Wed, 23 Dec 2020 14:24:12 +0800
Message-Id: <20201223062412.343-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_iommu_entries() checks for cyclic dependency in iommu entries
and fixes the cyclic dependency by setting x->depend to NULL. But
this repairing isn't correct if q is in front of p, there will be
"EXECUTION ORDER INVALID!" report following. Fix it by NULLing
whichever in the front.

The second issue is about the report of exectuion order reverse,
the order is reversed incorrectly in the report, fix it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 arch/x86/kernel/pci-iommu_table.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/pci-iommu_table.c b/arch/x86/kernel/pci-iommu_table.c
index 2e9006c..40c8249 100644
--- a/arch/x86/kernel/pci-iommu_table.c
+++ b/arch/x86/kernel/pci-iommu_table.c
@@ -60,7 +60,10 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
 			printk(KERN_ERR "CYCLIC DEPENDENCY FOUND! %pS depends on %pS and vice-versa. BREAKING IT.\n",
 			       p->detect, q->detect);
 			/* Heavy handed way..*/
-			x->depend = NULL;
+			if (p > q)
+				q->depend = NULL;
+			else
+				p->depend = NULL;
 		}
 	}
 
@@ -68,7 +71,7 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
 		q = find_dependents_of(p, finish, p);
 		if (q && q > p) {
 			printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
-			       p->detect, q->detect);
+			       q->detect, p->detect);
 		}
 	}
 }
-- 
1.8.3.1

