Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612652A7624
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbgKEDsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgKEDsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:48:11 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:48:10 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n129so393220iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 19:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MDM15LnnSX3Z+Y7SqJ0tweYp8PHcS6rg13I3l1FWRSM=;
        b=Dnjrj5QCsMNXCkVds3V26fcOQyps/DlT2ddrrHn4eczQsChoQdwxz6LzA0ky/O8XdR
         Zkaf4QJrO4++LQNa9tiArCb9yfk6jz1aNtjQE8qQnPEGSXjWNaFBWEfrtGIbgUcp9AQh
         V9MIX0aQsSxIGfH0HbFNP4/Ry1dAI+4tXxAhrWghWU5OMOHMitBo2Ao2tR/VgY+z9YGj
         tra1XAY3b43zXBBlznYNyMJ6UgNChOiBZ5A2FXO31E0pCDqlrVa4Ov8gahTqyLjy1gMC
         qIbZ7EIeYcBYcg1hJKSB5cRnGewkpyI8ffTi6g+x2ovEgVeP0fMmPbel/a8MHsYs50X6
         F4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDM15LnnSX3Z+Y7SqJ0tweYp8PHcS6rg13I3l1FWRSM=;
        b=SMhW9Ti1FNIt83fAGBhisgNCDu+7WM+Mw2/WAuiQmGGS2Ij6+1cihiQFMUn3rj7GiO
         O1AnYboVHbMP0sZOS1TPfWvrPMhx0EWpparPDSrnCTgoFEtwzYu/uv4EIRPhJNAHVdKN
         Rlcy4sVJvc/qqkeZAh86W7bicFDop+B+YMDUmIFw3AC3JbKAY862UM9NYFsNm5T1j/4K
         VG+NjvCd+MBpSPocoSfZw3AqMqEHgDRv/V+bAM7e8dWNqjqbbRBCMITxzLEM9XrZTySc
         VKRJu1tVoS4WFKKG0hw9T7XzuScJ4qtfVjSKLUX8WBrKOubCvh/eNUKeE2JonySfjMyR
         B1OA==
X-Gm-Message-State: AOAM531AhPm9hnNpXcvMdHMDp8yNsacfHhibexYy1I+nnxoLPypoIi49
        SFy22NL6ZPc2UL5yEXL978s=
X-Google-Smtp-Source: ABdhPJwJjLtDxztFb31Snf1hMBwfhLGl47wF1KsAayqf9LfKnKdN0PhnBD72XvP+Of7zGABoAd/9cw==
X-Received: by 2002:a02:6a25:: with SMTP id l37mr590563jac.70.1604548090247;
        Wed, 04 Nov 2020 19:48:10 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id p6sm172877ilc.26.2020.11.04.19.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 19:48:09 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 3/9] staging: rtl8723bs: remove IP_FMT macro
Date:   Wed,  4 Nov 2020 21:47:48 -0600
Message-Id: <20201105034754.12383-3-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105034754.12383-1-ross.schm.dev@gmail.com>
References: <20201105034754.12383-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary macro for %pI4 and call it directly.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 4 ++--
 drivers/staging/rtl8723bs/include/ieee80211.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index a6d870d663a4..93c93cdaadaf 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -416,7 +416,7 @@ static void ConstructARPResponse(
 		SET_ARP_PKT_TARGET_MAC_ADDR(pARPRspPkt, get_my_bssid(&(pmlmeinfo->network)));
 		SET_ARP_PKT_TARGET_IP_ADDR(pARPRspPkt, pIPAddress);
 		DBG_871X("%s Target Mac Addr:%pM\n", __func__, MAC_ARG(get_my_bssid(&(pmlmeinfo->network))));
-		DBG_871X("%s Target IP Addr" IP_FMT "\n", __func__, IP_ARG(pIPAddress));
+		DBG_871X("%s Target IP Addr:%pI4\n", __func__, IP_ARG(pIPAddress));
 	}
 
 	*pLength += 28;
@@ -738,7 +738,7 @@ static void ConstructProbeRsp(struct adapter *padapter, u8 *pframe, u32 *pLength
 	memcpy(pwlanhdr->addr3, bssid, ETH_ALEN);
 
 	DBG_871X("%s FW Mac Addr:%pM\n", __func__, MAC_ARG(mac));
-	DBG_871X("%s FW IP Addr" IP_FMT "\n", __func__, IP_ARG(StaAddr));
+	DBG_871X("%s FW IP Addr:%pI4\n", __func__, IP_ARG(StaAddr));
 
 	SetSeqNum(pwlanhdr, 0);
 	SetFrameSubType(fctrl, WIFI_PROBERSP);
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 902c710c1155..5cd307cb48a5 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -845,7 +845,6 @@ enum ieee80211_state {
 #define DEFAULT_MAX_SCAN_AGE (15 * HZ)
 #define DEFAULT_FTS 2346
 #define MAC_ARG(x) (x)
-#define IP_FMT "%pI4"
 #define IP_ARG(x) (x)
 
 static inline int is_multicast_mac_addr(const u8 *addr)
-- 
2.25.1

