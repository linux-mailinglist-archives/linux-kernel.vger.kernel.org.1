Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953262A25CA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKBIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:05:12 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D3C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:05:11 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 133so10394899pfx.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 00:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcdv4aKrlxLT+L8OMCxLupfQoFPx0rrIAPSpJAAsrOA=;
        b=eVwiEveNUcb/KZSTY2IfTZycLYQPTXOci4ywat0pjd/QQMWqBwh7yAMXmJCFS3Utb8
         W+vIZl999fSnpjptA90W3kvVtLSoGn/ZFrLCT+lIIwLmaOKRYBDWHEEIP5tXdtoTd34t
         zTIbfRJidtX57/Pge5wsjZ00+JaFBAetbqLT+ksCBYVhtIEAP/Z+GSl/FbbacTLr6TGt
         ckvchRmg9mGvDQwAaqXj+znHuctQQgMq5ijn7SADORzQC21fpK5FanYJxIy5kDQCE3NM
         Hn6cp9Ho2+kKA1x4pr8T3yXGKuaNtj4j+rehG2sKkUxFl9gpSIdpSJ4cCa3znoL0xacI
         +TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gcdv4aKrlxLT+L8OMCxLupfQoFPx0rrIAPSpJAAsrOA=;
        b=eGLxu9hkuwH2ixyQsWjpwNqWWDIZCogmfsrn3gI5LXDjqKUCVZc4G7Pvsjr0qBsOdx
         8/xpfAoUiBXLvy5rdqaFbFioJc/ZHUGRttwCahpi7X+ZfnaqZQJG3yt/vfs6yxYtCMfj
         M6pVjsL9HA0Av1NYIZtXDg/LdQgGZ9Gz1f8R/Gt1/hbrKsoNB42am5YUFLacVtiDEGV0
         M2WV+ofhcT97NjI33LthBB26k6ZoUcG+/3nfBZtadfG/dCd/X8LLzj2TwVHtFfbkReko
         WhLtsjwKOCV0Gn2KAc3y0AHASLvE+zECPeOMI10rbY37gHmJa+OQeDLlokq8awPhSNoA
         qiPQ==
X-Gm-Message-State: AOAM5335w06FaLlRQ+Cgxg29swLFYxT3Hvq6z56yubiWpAWIeCkHM1Nw
        z/RQjBzwNkM0dvPZtSyZ5znCnuIh4gQ=
X-Google-Smtp-Source: ABdhPJwdMAUMs6F8ZuP3W5ZcoeQIi27+FU6GEAq549igBZNDHm/Xg0QSf0tXNfhEbuSM0Bl/he6JkQ==
X-Received: by 2002:aa7:9607:0:b029:155:2b85:93f5 with SMTP id q7-20020aa796070000b02901552b8593f5mr20768001pfg.36.1604304310585;
        Mon, 02 Nov 2020 00:05:10 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id p17sm11811164pgn.28.2020.11.02.00.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:05:09 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        konrad.wilk@oracle.com, Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] x86/iommu: fix a typo in printk
Date:   Mon,  2 Nov 2020 16:04:37 +0800
Message-Id: <20201102080437.929-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In check_iommu_entries(), p->detect depends on q->detect, so q->detect
should be called before p->detect.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 arch/x86/kernel/pci-iommu_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pci-iommu_table.c b/arch/x86/kernel/pci-iommu_table.c
index 2e9006c1e240..c69b55436f7d 100644
--- a/arch/x86/kernel/pci-iommu_table.c
+++ b/arch/x86/kernel/pci-iommu_table.c
@@ -68,7 +68,7 @@ void __init check_iommu_entries(struct iommu_table_entry *start,
 		q = find_dependents_of(p, finish, p);
 		if (q && q > p) {
 			printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
-			       p->detect, q->detect);
+			       q->detect, p->detect);
 		}
 	}
 }
-- 
2.25.1

