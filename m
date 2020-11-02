Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF12A31A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKBReo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgKBReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:34:44 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D65C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:34:43 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x7so13686233ili.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxMzrdZcjEL0JJ6yvBsXBlKvsrYvjjyVf7t7mWyl/QY=;
        b=YN7mW/nri9xNNNunEygc4Y8mTJ8WA86uI2PVrndkO42SUdcyGK1LXt3X4Cq8Z5b5/l
         WcswdaiGtCdwVGH17HdZ8DnfpncVzstYpufEte4YHQluwisYrXkWgVMZiUqS79VdgZi+
         LPgRYrRgc/MNKT7p/T/Iy/PXFvMih9vQTMCHl7wSZwJnLkLFLuuyqFzZOk75FcF2Jcdl
         70Re9u2Rw5prU5BqFAbw6+63L7GuuXP52zq4B4DdXU0gjPN4BJ7ZgrsYpKFuorsyzXNM
         7VU/V5ZqEzVMb5l1gACbrTHHbJ50qxbmIwdOE0kRUng27N7XbRp6FzEj1LuI+i0DPsix
         ow6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxMzrdZcjEL0JJ6yvBsXBlKvsrYvjjyVf7t7mWyl/QY=;
        b=nRkJ0ywJkdi5ta2wzApsIdZqrl1bh+n/IJOAD7z1kMnkrspGhemJStEMqxUPiCt1aj
         RKifbmA9pl2i4UIcviq9NEpZORtfsVYTNFgRcX0pApeQzbJpCyaATSO6YygTZ1+WNeLZ
         6JoFskMDnxQ3kUUYceoqe7zQJpQViVU4RTJt1lZZ2gm7hNNUHqMRwbSwUTgvdLwURJWT
         qySh4SHvkIiTPQgqyLKHEg51zWZYcG0soixP+1P4emOd3EnBJt6RA+s/HhOGWV6m4GbE
         bUUsiiXcMdW9JSTmTMoqnhXN5BpkcITAUEKlLLvOeapL8KDFvqgahtpOk38PDVLW4m+a
         IyLQ==
X-Gm-Message-State: AOAM532hAGZc1UICpBVQ1cBn4HC78CvGUXsU/xIqZ9F11aGCaf/OrQOa
        gfDuzSehzCOWZl0fAVm66BGwww==
X-Google-Smtp-Source: ABdhPJxFLCublLFiKxPcBrsz/nOyGqz3ZlA28rV+BeouRxTKfd5HoWCHLqmRDZm4LFIV91ZObX6fIg==
X-Received: by 2002:a92:6810:: with SMTP id d16mr5010881ilc.153.1604338483325;
        Mon, 02 Nov 2020 09:34:43 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u8sm10963432ilm.36.2020.11.02.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:34:42 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ipa: restrict special reset to IPA v3.5.1
Date:   Mon,  2 Nov 2020 11:34:35 -0600
Message-Id: <20201102173435.5987-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With IPA v3.5.1, if IPA aggregation is active at the time an
underlying GSI channel reset is performed, some special handling
is required.

There is logic in ipa_endpoint_reset() that arranges for that
special handling, but it's done for all hardware versions, not
just IPA v3.5.1.

Fix the logic to properly restrict the special behavior.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 7386e10615d99..6f79028910e3c 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1314,7 +1314,7 @@ static void ipa_endpoint_reset(struct ipa_endpoint *endpoint)
 	 */
 	legacy = ipa->version == IPA_VERSION_3_5_1;
 	special = !endpoint->toward_ipa && endpoint->data->aggregation;
-	if (special && ipa_endpoint_aggr_active(endpoint))
+	if (legacy && special && ipa_endpoint_aggr_active(endpoint))
 		ret = ipa_endpoint_reset_rx_aggr(endpoint);
 	else
 		gsi_channel_reset(&ipa->gsi, channel_id, legacy);
-- 
2.20.1

