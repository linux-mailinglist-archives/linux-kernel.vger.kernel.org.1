Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFB2AD497
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgKJLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJLTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:19:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC97C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 03:19:36 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id cp9so2878926plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 03:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X4dag7xcL4vnMx5NVKJB+5vVrgE6HapSQew213si/Dw=;
        b=SNfNLhZ/dpxXrMy4/FK9AWMcOQdw9k1kOpHCwRyMv2hM6sYX8QjWLwUCV9HLXiSs++
         GzibrEaqkpoMEgwqdu5Dq5S5Ii3qhaZxmsALEQm6+0GtcPf6H1n1DazRzzvyiQdPQ8dD
         /lpLwXQWAUXch6mzTUfFXNJLuDO1A+ej5zdvWteJ0tqmUsNjlZa9/i+9IxH/WTnTa8aN
         bbYO8NiBxEDs2CEsj9s+3s4IrYjWGWSaCh3mffIompyLQFiSr0PsclBbak+tP2WWFE7K
         M6iU8cKDzeZp70OyVeaJ0pu+hHm5pY+dnzjCF8o3FIWCvdHDgcva1P3WNa+94NdEqF9b
         NB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X4dag7xcL4vnMx5NVKJB+5vVrgE6HapSQew213si/Dw=;
        b=hcsB0ztTaOBgYLIk61FSlJdNZ2ZNyCfCTVijASFeKgzhaSoojWY12xA0HE9WtBYwgK
         gcOaKzET1YTX+1EbycL2GbZiDVMFICvJc1+4etwVbSFeN7eqbyoKFrIclMD97cRggY7r
         UgGj46W/Wn/qSaDLch67PsBHMEfmBABtJrKcMF+0puhYPqic84u7ppcmlqggFkfN+LA8
         K87DEyL/uE+Asny4ijsphta4SysHzP+oIVkprpWWGzl2GTCfI+RcKHu8MypNp3b88fhB
         OXmvGTQHlT+tAgIKNysGJNb84URdaKKyB8/ceddOUY628pqUGyxFXr4Ptv59pAIXaWbH
         z5Aw==
X-Gm-Message-State: AOAM533G/twGYX04w4odswdlTsLnjW0WcaHKeu4h2XdDz9VnvYi1R+Hg
        ILNcur1C8ZkpA4H353XAgzQH8OPDo55x
X-Google-Smtp-Source: ABdhPJyiAwT7goe3svaAUM2ZncwpSApH4A+jbOGzmSqdTK1fW3Iex6KPIHHdoE2c8DF2NZx0tD5CYQ==
X-Received: by 2002:a17:902:c154:b029:d6:efa5:4ce7 with SMTP id 20-20020a170902c154b02900d6efa54ce7mr16096487plj.73.1605007176212;
        Tue, 10 Nov 2020 03:19:36 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id s145sm14224197pfs.187.2020.11.10.03.19.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 03:19:35 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] powerpc/powernv/sriov: fix unsigned int win compared to less than zero
Date:   Tue, 10 Nov 2020 19:19:30 +0800
Message-Id: <1605007170-22171-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix coccicheck warning:

./arch/powerpc/platforms/powernv/pci-sriov.c:443:7-10: WARNING: Unsigned expression compared with zero: win < 0
./arch/powerpc/platforms/powernv/pci-sriov.c:462:7-10: WARNING: Unsigned expression compared with zero: win < 0

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 arch/powerpc/platforms/powernv/pci-sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index c4434f20f42f..92fc861c528f 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -422,7 +422,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 {
 	struct pnv_iov_data   *iov;
 	struct pnv_phb        *phb;
-	unsigned int           win;
+	int		       win;
 	struct resource       *res;
 	int                    i, j;
 	int64_t                rc;
-- 
2.20.0

