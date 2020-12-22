Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E992E104A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgLVW3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:29:45 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:60561 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728380AbgLVW3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:29:39 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D0rRF2QshzPkWZ;
        Tue, 22 Dec 2020 23:21:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608675705; bh=ZV0QaFU8ufvRRApS5SXrg2UAX2IePfyP7k2p8UslGUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=G7qFnPq7aFHcMuU3sYW6q6jHnIsZsDxcDR1uKPRQm1Nfi4l1FOw5L646tQ+juKjlq
         02x33c4gmqBMPWhega/Lo06kDXCKtClZQiSuAwJ+dQBF3X4eHGx9FzDh2vqGLj8l2A
         IL7MhabPKIXEfipYUn2P6u4MjVDH00zyexmzYhx1akkLtTFyAnRBAmpCa1gjMCNfco
         3LTBJPfW8+kjKALQW7D8G67B/Xb4xEVXWNixhN0ixsAo9iTKdusgvtynNn2cvPtGJA
         23cHz8J50rndzbvU5Q80rYMdBpsiOizd8xr+aYaNnYB9jWz1k12MuEkbdBWg+8ZpGS
         9uj9Eg7hhw8iQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19fa:6f01:10d5:3d50:1797:6266
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19fa:6f01:10d5:3d50:1797:6266])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/QUMw3xDdDVpCGwuRO41Ezgzt47a60bRw=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D0rRB4rnNzPk2t;
        Tue, 22 Dec 2020 23:21:42 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     johannes.czekay@fau.de, nicolai.fischer@fau.de,
        gustavo@embeddedor.com, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@suse.com, adawesomeguy222@gmail.com,
        igormtorrente@gmail.com, sylphrenadin@gmail.com,
        izabela.bakollari@gmail.com, colin.king@canonical.com,
        steff.richards.the.third@gmail.com
Subject: [PATCH 1/6] wlan-ng: clean up line ending
Date:   Tue, 22 Dec 2020 23:20:12 +0100
Message-Id: <20201222222015.20558-2-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222222015.20558-1-johannes.czekay@fau.de>
References: <20201222222015.20558-1-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up all the "Lines should not end with a '('" warnings.

Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 drivers/staging/wlan-ng/cfg80211.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 759e475e303c..eda5b5a4e089 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -324,8 +324,7 @@ static int prism2_scan(struct wiphy *wiphy,
 		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
 		i++)
 		msg1.channellist.data.data[i] =
-			ieee80211_frequency_to_channel(
-				request->channels[i]->center_freq);
+			ieee80211_frequency_to_channel(request->channels[i]->center_freq);
 	msg1.channellist.data.len = request->n_channels;
 
 	msg1.maxchanneltime.data = 250;
@@ -478,8 +477,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 				goto exit;
 
 			/* send key to driver */
-			did = didmib_dot11smt_wepdefaultkeystable_key(
-					sme->key_idx + 1);
+			did = didmib_dot11smt_wepdefaultkeystable_key(sme->key_idx + 1);
 			result = prism2_domibset_pstr32(wlandev,
 							did, sme->key_len,
 							(u8 *)sme->key);
-- 
2.25.1

