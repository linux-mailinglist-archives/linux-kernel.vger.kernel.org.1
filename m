Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F712D290A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgLHKhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:37:18 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA76C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 02:36:38 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so11819554pge.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czdrjdVlGdWRX0t2911F8kLhf9bUIXthpSCZ3yhB1pM=;
        b=t+O0l4FU8SBaumgvxIysuTFkTBWRDRwJZVnT8cch+PSbrNKzklgyK8A0MVHuOIxzyQ
         S2QruZdyUg+h+50ZFTrKh+Hh2f3gdbz4lLEhmJqTVEW/Uk9pXdnYyFpgQT9eyAlFY2vY
         aXZFWjnlMXpj/CDuKOcOmrVkdwto4ogNFuEvrQ/pozcMewC/P2FxhIe/vMeVJu0rHHH0
         JcoC1yGm1D6MOocUNKgNMPnXwkLGPvS2xTkVuLNQKsnWLmpS9xUnKztG27PJZYJhCgH7
         hhP3mvZz7OXOsoC9Pq0u/Qr2GRemntB3BEnc7O+yxch6k7Dkb9ZUzEBi2Iqd1OK7iBYi
         qvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czdrjdVlGdWRX0t2911F8kLhf9bUIXthpSCZ3yhB1pM=;
        b=hK7eKUGjKrDgoTLPAsy7zzuP4lInoZt220/7a7ER57NwPpxMvDYYm/l1/AD8WIyLp/
         dsvrejBv6NpWxxlzB5HZF4FwAOhZ6rBLHplXWyPm0KvyeBU9K2m5OhIHy2EChmqrLL7r
         vbzBTEfyoolTKuet/x5wz5TOGkDpbQk5vmZ9UlJ7flp9eLQ1LcnOHODz6WcgAGi8oB0g
         1jVErTP1MLUnH6nhr0391d+bGY7FMa+AZYcgJzhHrCjEFegF4Tq+t71h/oovXmWUq8sK
         HgQak5n43n+bLGNfz5NyrUUgteTvqaZU/Ls8mjA5pA4+RZvIomSY11Jy3Ke0Qi7BBycw
         M5zQ==
X-Gm-Message-State: AOAM532nR6p3NKs/p1vCSbejGO6FQ8okjH27xiKcdZ8i31KYfKH0y07F
        YPIWDTtDYYrtq1CvlG+I/lk=
X-Google-Smtp-Source: ABdhPJzDNPE8O/yQXLmwY6V05iz6bfyONekHaRobvHsV3BD2uKOCvgbnF6hMzIiJn57lv8Vna17Paw==
X-Received: by 2002:a17:90a:990f:: with SMTP id b15mr3619423pjp.166.1607423797699;
        Tue, 08 Dec 2020 02:36:37 -0800 (PST)
Received: from cjuniorslaptop.localdomain ([202.164.130.48])
        by smtp.gmail.com with ESMTPSA id dw16sm2466237pjb.35.2020.12.08.02.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 02:36:36 -0800 (PST)
From:   Aswin C <aswinraman2013@gmail.com>
X-Google-Original-From: Aswin C <realc@protonmail.com>
To:     olteanv@gmail.com
Cc:     linux-kernel@vger.kernel.org, Aswin C <realc@protonmail.com>
Subject: [PATCH] net: dsa: sja1105: Remove an unprofessional word from the code comments
Date:   Tue,  8 Dec 2020 16:03:32 +0530
Message-Id: <20201208103332.5095-1-realc@protonmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the word 'retarded' from the code comments with a more professional word
'erroneous' to make it less profane.
---
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index b777d3f37..7a76180f3 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -250,7 +250,7 @@ sja1105pqrs_l2_lookup_cmd_packing(void *buf, struct sja1105_dyn_cmd *cmd,
 			SJA1105PQRS_SIZE_L2_LOOKUP_ENTRY, op);
 }
 
-/* The switch is so retarded that it makes our command/entry abstraction
+/* The switch is so erroneous that it makes our command/entry abstraction
  * crumble apart.
  *
  * On P/Q/R/S, the switch tries to say whether a FDB entry
-- 
2.29.2

