Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9D62A341D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKBTeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBTeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:34:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C078C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:34:11 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id y14so12000162pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zJZ6RJTnErujF0lDgi2VwA7AjjA905AP/3ViCZfttXI=;
        b=di4hLUugm7xL+TP/he0btTeUvJrmVti8iHMyENl31g2iL4BNNIAV+0GJwxCa/0WjqF
         IZt6jGVS/BKUrkKRmmsqnIegGFN2MDvg9WqVFspazwUtrtbtMZf+gi8taGjyH4re5NZr
         ipDmLQaviyI1JyO2gdbeTRj+j/5N1dKGghpwNnHQZlM9yY4JhetlVrsEgj8uniduuZtn
         ELyKQMqkGFjd53hU4v5YcoT+Mo+c/P5g2Fe2fbumGmQUK/zXxMyGFixYOc4SqWH0hlIY
         yZjqUJcgzhT5fluHP5/SGEBr9LnVSiT5VVvdri/ru1BCN+vKi3tSbT2ZehvflAPJOf34
         5SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zJZ6RJTnErujF0lDgi2VwA7AjjA905AP/3ViCZfttXI=;
        b=TFA5NeEYY8VxjjLl7FOMuvu3ARehzofQVLaVscvmwDGBw3d0+xQsmg2mebWTuDuWIQ
         eR3pxSRtQG8GGuO5wppc3nVOF8tq5hOQ6xdnd7MEFMOWAfnt/Jfzf666NTaovn78eP1L
         CUnCXZkYSe1pnVumZixsyxmcRQOIl18joU2mJKYHvv/PL5witOkLm2NeZEw/dVZboHZN
         21lMDMmVoBBh/wLRuFvhaOIfV1ILiqe01TJ9rIT51eeM6lqpG+JKzjNxO1IJ7r2EuX2g
         qq7m5oUyRGBI3WsY89hQ0yW4dGayfkaalXp2IvywEv7Dpyl21i26UiPM7cxQiVDPj+x+
         Zlxg==
X-Gm-Message-State: AOAM531ANjzR5a7sUjQycW6ompCtqBW17UtYbmN+uEXOMF9qPCQqqBVc
        wGMlRexNVGyrRr2ryj47skMJqf+g39Zdo/4=
X-Google-Smtp-Source: ABdhPJz2aIASybo0JHfjTrKlJ/Au7tLUDgP3dPA6SyAkLoYz59E1MddDTm1sXjFQWZgttz2aLJVtLw==
X-Received: by 2002:a62:1991:0:b029:155:f476:2462 with SMTP id 139-20020a6219910000b0290155f4762462mr23426168pfz.43.1604345651018;
        Mon, 02 Nov 2020 11:34:11 -0800 (PST)
Received: from Sleakybeast ([2405:205:c82e:472d:f3dc:c193:6b6:3d7b])
        by smtp.gmail.com with ESMTPSA id e15sm14643816pff.121.2020.11.02.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:34:10 -0800 (PST)
Date:   Tue, 3 Nov 2020 01:04:02 +0530
From:   "siddhant gupta(siddhant1223)" <siddhantgupta416@gmail.com>
To:     matthias.bgg@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        siddhantgupta416@gmail.com, mamatashukla555@gmail.com,
        himadrispandya@gmail.com
Subject: [PATCH] staging: mt7621-dma: Prefer Using BIT Macro instead of left
 shifting on 1.
Message-ID: <20201102193402.GA14965@Sleakybeast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Replace left shifting on 1 by a BIT macro to fix checkpatch warning.

Signed-off-by: Siddhant Gupta <siddhantgupta416@gmail.com>

---
 drivers/staging/mt7621-dma/mtk-hsdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index 354536783e1c..a9e1a1b14035 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -72,7 +72,7 @@
 #define HSDMA_GLO_TX_DMA		BIT(0)
 
 #define HSDMA_BT_SIZE_16BYTES		(0 << HSDMA_GLO_BT_SHIFT)
-#define HSDMA_BT_SIZE_32BYTES		(1 << HSDMA_GLO_BT_SHIFT)
+#define HSDMA_BT_SIZE_32BYTES		BIT(HSDMA_GLO_BT_SHIFT)
 #define HSDMA_BT_SIZE_64BYTES		(2 << HSDMA_GLO_BT_SHIFT)
 #define HSDMA_BT_SIZE_128BYTES		(3 << HSDMA_GLO_BT_SHIFT)
 
-- 
2.25.1

