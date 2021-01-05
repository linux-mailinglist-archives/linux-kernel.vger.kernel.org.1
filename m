Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9A2EAA99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbhAEMZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbhAEMZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:25:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18D6C061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:24:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r3so36018311wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+hdtHCSFxGXzmG9zcdLMtsA9CM+yy9a1rXrTwefd0k4=;
        b=czVOdt7W25XBtu4im5qKxLy9uOjEtYROQxi0G7IXxemfd7dlNi9S35QZcJf2tkmzdm
         ResxHLmFnKh1QtSXPwmKM5mprpO8AT0NeBYgA/sQar9rXKIZwLQRF6uEU19GeqhkFo4f
         pW48YkmqsciB3RfhC9mG8yCEc2yJnPdOVe6T6GqU8Uh2NCHPrBbTGgr+XgK/2N3DJlwB
         Y+IhLUnm7FyJR1pgeRJ+6b9r8J5FO169CvmeQAQQDC+Z6zgP89caedG64fNz0m+v4qXa
         MdUN8hhjoVbG5KelW4SdwbaLvy2V2nvVCqwi2FHF4P6cPcxARN1N62fSjW2q0FjS/dUB
         XvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+hdtHCSFxGXzmG9zcdLMtsA9CM+yy9a1rXrTwefd0k4=;
        b=Idg3BAvv7Olvc+yJ1IKGUbnKTUXVQhkaLCV5drElSv0fEzEYCD0H6KyZoYljE9FlF7
         wvp/K6B2/eMSF6pXxexWc6B3KaVD2Rhmz/J3BFk4SB5aXFGFzhMmcePDFuYbtqLy7fsf
         bvxkxWLXSOycSgTb6pSbvFanBwHmz6uuUOPF0IdDsjcfISIKy6cZhDJc1NFsab96CBy/
         SD+gNvS58ALCxzhebxzZ0Jo197B2xG5PcyOkX54EbPWEqqnBhFsNpgvjPLGEIJgoapmz
         pBLxaN7SCRzugDqTs/J6TEx9vmX/cFiViaEct5kRny7cIKPYL1GmEtLfxc3bgy1OVtZO
         O8BA==
X-Gm-Message-State: AOAM532YcVbSxVKxIpRCd2o2HG64PG91ovEd62lpwzWxEaSKMxzq8nwY
        2pSGCoHVB7m0Wk/1IraBr8KIqg==
X-Google-Smtp-Source: ABdhPJzn5Pn25J8kQp408XDwJKVIyaot6NazKqEsQTBFCbc7itvHuBDfoCtbHIJ2SYdpVDK0NCdS3Q==
X-Received: by 2002:a05:6000:368:: with SMTP id f8mr84261273wrf.150.1609849468767;
        Tue, 05 Jan 2021 04:24:28 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id 138sm4242281wma.41.2021.01.05.04.24.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 04:24:28 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
Cc:     yan@daynix.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] skbuff: define field for hash report type
Date:   Tue,  5 Jan 2021 14:24:10 +0200
Message-Id: <20210105122416.16492-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105122416.16492-1-yuri.benditovich@daynix.com>
References: <20210105122416.16492-1-yuri.benditovich@daynix.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used by virtio-net receive side scaling

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/linux/skbuff.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 416bf95cd5f2..36cf40ec0259 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -510,7 +510,7 @@ int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
  * the end of the header data, ie. at skb->end.
  */
 struct skb_shared_info {
-	__u8		__unused;
+	__u8		hash_report_type; /* virtio-net rss */
 	__u8		meta_len;
 	__u8		nr_frags;
 	__u8		tx_flags;
@@ -1430,6 +1430,11 @@ static inline struct skb_shared_hwtstamps *skb_hwtstamps(struct sk_buff *skb)
 	return &skb_shinfo(skb)->hwtstamps;
 }
 
+static inline __u8 *skb_hash_report_type(struct sk_buff *skb)
+{
+	return &skb_shinfo(skb)->hash_report_type;
+}
+
 static inline struct ubuf_info *skb_zcopy(struct sk_buff *skb)
 {
 	bool is_zcopy = skb && skb_shinfo(skb)->tx_flags & SKBTX_DEV_ZEROCOPY;
-- 
2.17.1

