Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA11B6443
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 21:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDWTJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDWTJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:09:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE3C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:09:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so4526901ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0h2+HD12jslhQhVTfHXo4XzcR3CkQ35KAkzWejng0I=;
        b=uXmeyzjxovJLmE/4VWvDRDrzLChw9L+6DpVyKT5C+V5TxPbUhch0J89GUxxHyq8oGj
         iyRKDD+wUQ+o72YCH4qEvKrOG7fhU0vN24auW/STeS5rmBCCHcOP6EAQ4JDnsL3a2GwY
         zMpfRM/APtycZNYr7Cb20jpVIyA10ohAE+tTAcVEU7ZtBExsl1kHGI0ZrqlrSj1+9oeQ
         4J5uzfmLNJWHBKTWFl9dWZ74RS/ljfMQ5Gu84gRHTFYVC8jrqFd+KnGmxuT22sKl4i6Y
         JisXvchWTWzCMUgL4RhtsABbhrCKyV93baq1wS3DwIMfywuma003Kik17UemvTp/ajKa
         1LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0h2+HD12jslhQhVTfHXo4XzcR3CkQ35KAkzWejng0I=;
        b=DAWNQHa4tD/04m1SCDc8HWj7w6e+79hIL+rl3VoImtXAODGHogMtUIHMl7fUSCHFw2
         MV+tBC5+l1hK5nhGCns0Gpb5mG7qIF4eSJT8gFqepst6LVr1t+nYolKuqcwFVV9VbyJU
         cF9ekgB4qDZw5y2sqTZLmJ93SiP903Nk0/aCWYyco7GQZpr0ZxxI4UWEiJZSRD1uEImi
         VX/u1eUInovb1E/5jktJ6mdMFU4zIPa9yb/f5e7AXfu3IAflFpKla4E3bM64FF5uKwJw
         QKxeV9dRNqFx4BQ4wnicHpaCI9zAT37imJgnwr3CriSmmtbR7FMWeQplfJMt6K3bgu8F
         N7ug==
X-Gm-Message-State: AGi0PubH/3wnaiac3K3HECUSkE5WaD+ZQO+aa+l7tVhB+pJ4I+UeTGF2
        I3cKcWN1nZGV9q7EafM5WAY=
X-Google-Smtp-Source: APiQypLdzcvy9S6+P/aOFLb3IOw1uyzhQNiRR06kSBTuGUCEX4xAIh73NCRQme1+J/PmbEZrsvSWCw==
X-Received: by 2002:a2e:990f:: with SMTP id v15mr2083262lji.7.1587668992125;
        Thu, 23 Apr 2020 12:09:52 -0700 (PDT)
Received: from alpha (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id z9sm3145981lfd.9.2020.04.23.12.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 12:09:51 -0700 (PDT)
Received: (nullmailer pid 12103 invoked by uid 1000);
        Thu, 23 Apr 2020 19:14:18 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH v2] staging:r8188eu: avoid skb_clone for amsdu to msdu conversion
Date:   Thu, 23 Apr 2020 22:14:04 +0300
Message-Id: <20200423191404.12028-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb clones use same data buffer,
so tail of one skb is corrupted by beginning of next skb.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
Changes in v2:
  - long line in the commit message is divided into two parts.

drivers/staging/rtl8188eu/core/rtw_recv.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index d4278361e002..a036ef104198 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1525,21 +1525,14 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 
 		/* Allocate new skb for releasing to upper layer */
 		sub_skb = dev_alloc_skb(nSubframe_Length + 12);
-		if (sub_skb) {
-			skb_reserve(sub_skb, 12);
-			skb_put_data(sub_skb, pdata, nSubframe_Length);
-		} else {
-			sub_skb = skb_clone(prframe->pkt, GFP_ATOMIC);
-			if (sub_skb) {
-				sub_skb->data = pdata;
-				sub_skb->len = nSubframe_Length;
-				skb_set_tail_pointer(sub_skb, nSubframe_Length);
-			} else {
-				DBG_88E("skb_clone() Fail!!! , nr_subframes=%d\n", nr_subframes);
-				break;
-			}
+		if (!sub_skb) {
+			DBG_88E("dev_alloc_skb() Fail!!! , nr_subframes=%d\n", nr_subframes);
+			break;
 		}
 
+		skb_reserve(sub_skb, 12);
+		skb_put_data(sub_skb, pdata, nSubframe_Length);
+
 		subframes[nr_subframes++] = sub_skb;
 
 		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-- 
2.25.3

