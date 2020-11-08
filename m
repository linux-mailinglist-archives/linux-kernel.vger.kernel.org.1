Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882F92AA9C7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 07:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgKHGe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 01:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgKHGe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 01:34:56 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86CC0613CF;
        Sat,  7 Nov 2020 22:34:54 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id ei22so733807pjb.2;
        Sat, 07 Nov 2020 22:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Kt6S+JMIQwOJCIw5xl6gOY+bhA3QLddX49Ln4+J/S5E=;
        b=IYY4AP2WouUHHmO3MoOKKOmXZgUzX6Vps9phVlae88j2KW9/Uffo2U6+V/28oF8pMy
         GmQ3E2drQP63zj1qK2KfNjLG3gEkqizxZ8rjZAHF2gC3/ZkZ52pYvP5QeUyUmUfTLHQG
         vehnDICxg1gSWi8C1vV6s9GBk+1gWt7JeTRxrAdWb4qemGNAmgeEp1VSr/wRZmCKKlWB
         QmK2B6c5FaKi4JNB7dJ4vBHxwIV7+cjR8yrSHLiJMGxeVg7gL8gRkPCeY3I5Tsppu+0X
         doZ/x2eBHCCyDhbmlSgyT3ItpsjCw9iJawxuVnhRVOl6oNPywy68k75l7Bk4oIvg+W5O
         FI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kt6S+JMIQwOJCIw5xl6gOY+bhA3QLddX49Ln4+J/S5E=;
        b=Gw/3A5urA4W/uyCLDfG5LD/h+tE+T444aKet0Vuv0BbxQhXpbPYXwtUD9Me852lW0h
         r7wq7mB9+qI/OT8j2QMH5Re3Lh3r+M9tCQ8HvRZhGnDCOke1ci0IFTzpWy1i7470i5/j
         clAVinyGJLMU0bAYbiBKJDIroKI1h0jJNdNdgE6+WuZ3UhAvVpdv3oznMEdqLfmeWFQ8
         Cvff4UAhQLQBCN42W++r5dpNDY3r/ZaTo7naJQoNtARzdWZf9T2P2704DtFg+yBZbA7+
         MDN1hizxYf7phdhntXEMAl37nh2FVULKuyIUHWoxWb1jdcbwljBVllkBFFEvocfhSOpQ
         zoeQ==
X-Gm-Message-State: AOAM530BueHe+JjOumxFDFxvkPUPhDGijnnBjYjA4LCLm5N5/57PDvKS
        tSgZHHIzlDM9FYMcDp8+xQ==
X-Google-Smtp-Source: ABdhPJya6GqzMQ9h6deD8YgY9MQZ6eV1J9l/ifsqnG85LCg45xF2g8TIpRqjhNtlAyq7j4O0K4fjCw==
X-Received: by 2002:a17:90a:4a15:: with SMTP id e21mr6837307pjh.130.1604817294232;
        Sat, 07 Nov 2020 22:34:54 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id n1sm7040745pgl.31.2020.11.07.22.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 22:34:53 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] s390/qeth: remove useless if/else
Date:   Sun,  8 Nov 2020 14:34:47 +0800
Message-Id: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle report:

./drivers/s390/net/qeth_l3_main.c:107:2-4: WARNING: possible condition with no effect (if == else)

Both branches are the same, so remove them.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/s390/net/qeth_l3_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b1c1d2510d55..264b6c782382 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -104,10 +104,7 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
 		qeth_l3_convert_addr_to_bits(ipatoe->addr, ipatoe_bits,
 					  (ipatoe->proto == QETH_PROT_IPV4) ?
 					  4 : 16);
-		if (addr->proto == QETH_PROT_IPV4)
-			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
-		else
-			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
+		rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
 		if (rc)
 			break;
 	}
-- 
2.20.0

