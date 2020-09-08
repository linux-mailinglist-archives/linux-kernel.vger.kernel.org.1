Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD729260771
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 02:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIHAOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 20:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgIHAON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 20:14:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B01C061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 17:14:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so4136777pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 17:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRTGbzGQzZxelHLRMFsoYAaIr8NVu1Ffq0lGmgbn8Bg=;
        b=IMNx0wtMrdyV3/etrml49CIwu5atFIrDvNOZHDKx5rc53PIZNuEYpCD9N/CFVAoDor
         1uw1FYlumUufiWBK0YpuvkNR5RmL/MfJ6ZW3UBAJLM1PwVqNWqWnzdGLHTXtFhE7AnVg
         +qwjqMsBeNyrfgqFcq89LDebeLgaLAGMFvfZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRTGbzGQzZxelHLRMFsoYAaIr8NVu1Ffq0lGmgbn8Bg=;
        b=k6wKD3q3WuaPPpy9sfFyhGWcg+CY5Sf9F10n+J/tj7WxNmECMJGLy3e2L1/mClyYKE
         /9r868rTYvuA4B0R2RLAj8DKnLb/VFAEiH2C1EPhHxXZ3JdvDVrFhwmljU+ObkepSdkn
         SE33iL2y1nn7PE7CHrSBVYuDJqpLVSD9c1JVr9kefXbKuWhK+ZhAZPczSs3doGA5frCP
         kEVaUIfB+kCGFWPMtDDR3DyeBxMwteGGebhpvZAN9ITqA060RgxTC8xf5TJY7VCb/DvY
         wXpCBUG3VuYViFIAAzr8QWhpIQe2FdOnjQ6dNeGbCRJX9lcd+hPd58MXzSdjEoNNCz2K
         Jq6g==
X-Gm-Message-State: AOAM530W5RR+bcdJwQpiQWdCCafO7tQXVHr6aknG4JhpiX8n8T99RWEN
        NI5LfFlo4jqKSEHMg3Jr8YrVDA==
X-Google-Smtp-Source: ABdhPJxrF04N6GdVqxWymt+vGNud5cGZ0pp4iZxQVFekGQj4k8u8s9ZdiIs7Dxw9q4PtBezxdi0PiQ==
X-Received: by 2002:a17:90a:eb06:: with SMTP id j6mr1506448pjz.46.1599524048600;
        Mon, 07 Sep 2020 17:14:08 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id d8sm4788515pjs.47.2020.09.07.17.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 17:14:07 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list@cypress.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] brcmsmac: fix memory leak in wlc_phy_attach_lcnphy
Date:   Tue,  8 Sep 2020 00:13:21 +0000
Message-Id: <20200908001324.8215-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
References: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wlc_phy_txpwr_srom_read_lcnphy fails in wlc_phy_attach_lcnphy,
the allocated pi->u.pi_lcnphy is leaked, since struct brcms_phy will be
freed in the caller function.

Fix this by calling wlc_phy_detach_lcnphy in the error handler of
wlc_phy_txpwr_srom_read_lcnphy before returning.

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 7ef36234a25d..66797dc5e90d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -5065,8 +5065,10 @@ bool wlc_phy_attach_lcnphy(struct brcms_phy *pi)
 	pi->pi_fptr.radioloftget = wlc_lcnphy_get_radio_loft;
 	pi->pi_fptr.detach = wlc_phy_detach_lcnphy;
 
-	if (!wlc_phy_txpwr_srom_read_lcnphy(pi))
+	if (!wlc_phy_txpwr_srom_read_lcnphy(pi)) {
+		kfree(pi->u.pi_lcnphy);
 		return false;
+	}
 
 	if (LCNREV_IS(pi->pubpi.phy_rev, 1)) {
 		if (pi_lcn->lcnphy_tempsense_option == 3) {
-- 
2.17.1

