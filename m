Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A182448EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgHNLkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgHNLkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6291C06135A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so7661701wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uoJdiMFnGqJL36MQX9//RZPgySw6yuwW0/4q6pcbpxI=;
        b=Z5jKBlju35T6oTj3hxsY8oXDyw2EjocH3+UWqQor/nEHI1TLpiYZFG/+OYyJeEB2kQ
         2T5fLfadZrwb1sv21VtNhRA340P+/omrcCtPRqMpkQYgK4yadwVCp0445v5cPAmh763H
         j5YBLXYXRAOCNNmh64LfTsD2uOriUrw6vnviTLGpxiEOrpG1ekLXmi8AgQI8prR2Aqxs
         s7lW4M9jtPTxSs+kyOc8G8e6dbJBjn4xy8MdKdarBpiuEyH8UCJ0XvLsIPuENKIWvugP
         AbxHOK8zN/OsOw+q2PC0O4sBNQWbtzl8r9pkEujXbg7bIIAQAuK+f3CjhEZ+4kPsaieI
         nIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoJdiMFnGqJL36MQX9//RZPgySw6yuwW0/4q6pcbpxI=;
        b=gDzjy+Qkfk7z7IPAZR5mloqapGuKXYzuUP+9BnqfpklQJ5UGJTBaYrANQa75q4Snk+
         oSuoLxFOTiu+lIWk2xTt/xcb6l/VVzNjCtITE+SYH7fkZbSqB8R2VV9azyYCxVal6oSi
         CYKzDNeIg8RL3PV/qI1TMgBkID0ej8TE+G3aGGcYGBO/QCMFACrVUjflT4PWRoo8ydzw
         R9vFKlnOcZY6SbirucZSWp3Ptek1DPCVvXP7dpy7P5Hz+fCMK1+QW0axvhUZ++zgkBPg
         bxfS1yOJ9yFblzxvV/2EFUqncFfCDfzF+AUfBws9fq5eDuNaVVAiSliPU1LuCiTRJUWc
         /7TA==
X-Gm-Message-State: AOAM531jXmOR6Mif3YDJzMgMBicOPqIJ+LwES9qtsoz1858GEVttoxmo
        lolGK0N25ATv3/3YSCGqIdF/1w==
X-Google-Smtp-Source: ABdhPJyNHmgfSG7oqJDg2SQorjhZpluNZk69ZMxYqm+xYL0qSq3eatKOxTcA4ERuh7Joh5ya2/azlA==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr2262670wmi.34.1597405214622;
        Fri, 14 Aug 2020 04:40:14 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Subject: [PATCH 22/30] net: wireless: broadcom: brcm80211: brcmfmac: fweh: Remove set but unused variable 'err'
Date:   Fri, 14 Aug 2020 12:39:25 +0100
Message-Id: <20200814113933.1903438-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c: In function ‘brcmf_fweh_handle_if_event’:
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:131:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index a5cced2c89ac6..6f74567c7bd72 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -128,7 +128,6 @@ static void brcmf_fweh_handle_if_event(struct brcmf_pub *drvr,
 	struct brcmf_if_event *ifevent = data;
 	struct brcmf_if *ifp;
 	bool is_p2pdev;
-	int err = 0;
 
 	brcmf_dbg(EVENT, "action: %u ifidx: %u bsscfgidx: %u flags: %u role: %u\n",
 		  ifevent->action, ifevent->ifidx, ifevent->bsscfgidx,
@@ -171,8 +170,8 @@ static void brcmf_fweh_handle_if_event(struct brcmf_pub *drvr,
 	if (ifp && ifevent->action == BRCMF_E_IF_CHANGE)
 		brcmf_proto_reset_if(drvr, ifp);
 
-	err = brcmf_fweh_call_event_handler(drvr, ifp, emsg->event_code, emsg,
-					    data);
+	brcmf_fweh_call_event_handler(drvr, ifp, emsg->event_code, emsg,
+				      data);
 
 	if (ifp && ifevent->action == BRCMF_E_IF_DEL) {
 		bool armed = brcmf_cfg80211_vif_event_armed(drvr->config);
-- 
2.25.1

