Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41842E213E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgLWUXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbgLWUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608754905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gDO08LPa6Tws75MZC85QHEa5SvLGBYObY/Ryt9z5RDM=;
        b=SKLpk2d7n/Zbg5nskiOAM8GF2TpMp2UUMS4omNrfF/btIhRCAE92STTIloQKifBF1Wf/lT
        kNEFoD0quEgSkTl09VG1zOGWWZOy6bJ2NkdHzLV97iMYsKH+nasWGLu7J3jOe6sXir//pA
        CnwYiVO/5aqeeMr3TREZknZXtqZEtRY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-gXGLfd-1Ogu_8xCoIEYHMw-1; Wed, 23 Dec 2020 15:21:44 -0500
X-MC-Unique: gXGLfd-1Ogu_8xCoIEYHMw-1
Received: by mail-oo1-f69.google.com with SMTP id a3so97666oon.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gDO08LPa6Tws75MZC85QHEa5SvLGBYObY/Ryt9z5RDM=;
        b=X5/ATAlBMSDJju+JzHyRN/F76bwKcud46c0Sjr3Ow+VKMBTCPiJUU3kxzeKxts3shY
         1G/+ITbTe6EZRC8PihHHXJjC5tEbRGy6lcaPwe7Bp6COY+WqPktA2iSXy7usZcns5zXg
         k2AAoNfVH40rHlzpcdN6G7VAFr/5Iq75ROwPFZABa9vZ/HLDQmV5bYiwHuLadgacmjJN
         0EY0+irLitggJUw3IMuTFZOpOjPrLsjeCmdHTgX+KDAsulpbOZkKcQ1Et8O1a7dHuD5a
         8SaQeS6eNVzfejezGIsHuuEcD7ryTW0wkMyuKRoM5xvy183PMXQ9kjR9YMfyjqnD9VIt
         K5tQ==
X-Gm-Message-State: AOAM5338qf6ykyK/3TNZS1uW7HiOptEZfec0hRbM7gFqTMp7QqRP+QBL
        E1/rsPvFW07hvdsJW0f56pzBaCIq9lknmc7EjpEU/OQ3h5ZJubXVIqS4W7fUwxSYuzIdZEPtlhn
        nqDqEnLTcUQqlz+/JeqxF0SQ5
X-Received: by 2002:aca:e0c5:: with SMTP id x188mr1045322oig.20.1608754903267;
        Wed, 23 Dec 2020 12:21:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1bM1H6UwWIKOvvdZGIsYDhSIGtHH1s6hLopv3COSnlvtJgXbU5o2OUVWs65mwuyOKIQpH0A==
X-Received: by 2002:aca:e0c5:: with SMTP id x188mr1045316oig.20.1608754903116;
        Wed, 23 Dec 2020 12:21:43 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e10sm5025985otr.73.2020.12.23.12.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 12:21:42 -0800 (PST)
From:   trix@redhat.com
To:     aelior@marvell.com, davem@davemloft.net, kuba@kernel.org
Cc:     GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] qed: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 12:21:38 -0800
Message-Id: <20201223202138.131563-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c  | 22 +++++++++++-----------
 drivers/net/ethernet/qlogic/qed/qed_main.c |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c  |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index d2f5855b2ea7..feee5535a9e2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -410,7 +410,7 @@ static int qed_llh_alloc(struct qed_dev *cdev)
 			continue;
 
 		p_llh_info->ppfid_array[p_llh_info->num_ppfid] = i;
-		DP_VERBOSE(cdev, QED_MSG_SP, "ppfid_array[%d] = %hhd\n",
+		DP_VERBOSE(cdev, QED_MSG_SP, "ppfid_array[%d] = %d\n",
 			   p_llh_info->num_ppfid, i);
 		p_llh_info->num_ppfid++;
 	}
@@ -624,7 +624,7 @@ static int qed_llh_abs_ppfid(struct qed_dev *cdev, u8 ppfid, u8 *p_abs_ppfid)
 
 	if (ppfid >= p_llh_info->num_ppfid) {
 		DP_NOTICE(cdev,
-			  "ppfid %d is not valid, available indices are 0..%hhd\n",
+			  "ppfid %d is not valid, available indices are 0..%d\n",
 			  ppfid, p_llh_info->num_ppfid - 1);
 		*p_abs_ppfid = 0;
 		return -EINVAL;
@@ -988,13 +988,13 @@ int qed_llh_add_mac_filter(struct qed_dev *cdev,
 
 	DP_VERBOSE(cdev,
 		   QED_MSG_SP,
-		   "LLH: Added MAC filter [%pM] to ppfid %hhd [abs %hhd] at idx %hhd [ref_cnt %d]\n",
+		   "LLH: Added MAC filter [%pM] to ppfid %d [abs %d] at idx %d [ref_cnt %d]\n",
 		   mac_addr, ppfid, abs_ppfid, filter_idx, ref_cnt);
 
 	goto out;
 
 err:	DP_NOTICE(cdev,
-		  "LLH: Failed to add MAC filter [%pM] to ppfid %hhd\n",
+		  "LLH: Failed to add MAC filter [%pM] to ppfid %d\n",
 		  mac_addr, ppfid);
 out:
 	qed_ptt_release(p_hwfn, p_ptt);
@@ -1134,13 +1134,13 @@ qed_llh_add_protocol_filter(struct qed_dev *cdev,
 
 	DP_VERBOSE(cdev,
 		   QED_MSG_SP,
-		   "LLH: Added protocol filter [%s] to ppfid %hhd [abs %hhd] at idx %hhd [ref_cnt %d]\n",
+		   "LLH: Added protocol filter [%s] to ppfid %d [abs %d] at idx %d [ref_cnt %d]\n",
 		   str, ppfid, abs_ppfid, filter_idx, ref_cnt);
 
 	goto out;
 
 err:	DP_NOTICE(p_hwfn,
-		  "LLH: Failed to add protocol filter [%s] to ppfid %hhd\n",
+		  "LLH: Failed to add protocol filter [%s] to ppfid %d\n",
 		  str, ppfid);
 out:
 	qed_ptt_release(p_hwfn, p_ptt);
@@ -1184,13 +1184,13 @@ void qed_llh_remove_mac_filter(struct qed_dev *cdev,
 
 	DP_VERBOSE(cdev,
 		   QED_MSG_SP,
-		   "LLH: Removed MAC filter [%pM] from ppfid %hhd [abs %hhd] at idx %hhd [ref_cnt %d]\n",
+		   "LLH: Removed MAC filter [%pM] from ppfid %d [abs %d] at idx %d [ref_cnt %d]\n",
 		   mac_addr, ppfid, abs_ppfid, filter_idx, ref_cnt);
 
 	goto out;
 
 err:	DP_NOTICE(cdev,
-		  "LLH: Failed to remove MAC filter [%pM] from ppfid %hhd\n",
+		  "LLH: Failed to remove MAC filter [%pM] from ppfid %d\n",
 		  mac_addr, ppfid);
 out:
 	qed_ptt_release(p_hwfn, p_ptt);
@@ -1242,13 +1242,13 @@ void qed_llh_remove_protocol_filter(struct qed_dev *cdev,
 
 	DP_VERBOSE(cdev,
 		   QED_MSG_SP,
-		   "LLH: Removed protocol filter [%s] from ppfid %hhd [abs %hhd] at idx %hhd [ref_cnt %d]\n",
+		   "LLH: Removed protocol filter [%s] from ppfid %d [abs %d] at idx %d [ref_cnt %d]\n",
 		   str, ppfid, abs_ppfid, filter_idx, ref_cnt);
 
 	goto out;
 
 err:	DP_NOTICE(cdev,
-		  "LLH: Failed to remove protocol filter [%s] from ppfid %hhd\n",
+		  "LLH: Failed to remove protocol filter [%s] from ppfid %d\n",
 		  str, ppfid);
 out:
 	qed_ptt_release(p_hwfn, p_ptt);
@@ -3865,7 +3865,7 @@ static int qed_hw_get_ppfid_bitmap(struct qed_hwfn *p_hwfn,
 
 	if (!(cdev->ppfid_bitmap & (0x1 << native_ppfid_idx))) {
 		DP_INFO(p_hwfn,
-			"Fix the PPFID bitmap to include the native PPFID [native_ppfid_idx %hhd, orig_bitmap 0x%hhx]\n",
+			"Fix the PPFID bitmap to include the native PPFID [native_ppfid_idx %d, orig_bitmap 0x%x]\n",
 			native_ppfid_idx, cdev->ppfid_bitmap);
 		cdev->ppfid_bitmap = 0x1 << native_ppfid_idx;
 	}
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 5bd58c65e163..a8133764b5cb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -968,7 +968,7 @@ static int qed_slowpath_setup_int(struct qed_dev *cdev,
 
 	if (is_kdump_kernel()) {
 		DP_INFO(cdev,
-			"Kdump kernel: Limit the max number of requested MSI-X vectors to %hd\n",
+			"Kdump kernel: Limit the max number of requested MSI-X vectors to %d\n",
 			cdev->int_params.in.min_msix_cnt);
 		cdev->int_params.in.num_vectors =
 			cdev->int_params.in.min_msix_cnt;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index cd882c453394..1f1791a87fe2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3940,7 +3940,7 @@ int qed_mcp_get_engine_config(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 				      FW_MB_PARAM_ENG_CFG_L2_AFFIN_VALUE);
 
 	DP_INFO(p_hwfn,
-		"Engine affinity config: FIR={valid %hhd, value %hhd}, L2_hint={valid %hhd, value %hhd}\n",
+		"Engine affinity config: FIR={valid %d, value %d}, L2_hint={valid %d, value %d}\n",
 		fir_valid, cdev->fir_affin, l2_valid, cdev->l2_affin_hint);
 
 	return 0;
@@ -3966,7 +3966,7 @@ int qed_mcp_get_ppfid_bitmap(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 	cdev->ppfid_bitmap = QED_MFW_GET_FIELD(mb_params.mcp_param,
 					       FW_MB_PARAM_PPFID_BITMAP);
 
-	DP_VERBOSE(p_hwfn, QED_MSG_SP, "PPFID bitmap 0x%hhx\n",
+	DP_VERBOSE(p_hwfn, QED_MSG_SP, "PPFID bitmap 0x%x\n",
 		   cdev->ppfid_bitmap);
 
 	return 0;
-- 
2.27.0

