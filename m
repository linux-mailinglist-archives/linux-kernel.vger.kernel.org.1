Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB92A2A08
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgKBLyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgKBLyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:25 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B82CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:25 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n15so14288131wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmRHhQEVdc7j5b8GRJ+bwBPDfCwyz1df7aW7vS1l850=;
        b=w4+biPUE2uMMqM1NCNVRw/lhr1t2nDaFpT8nyyjQsKMPQSxZh9JlQm19v4OWojmS9M
         LRH4zJVB3i3J9Vl9CTf89o78Tvv8KSyYixWNURyMWKqfCiJ9VUR8pWhs7PDZ8ATkyKg/
         0k/geNcihJaIVBPlDvNci4aNTroRuJV8VR8CNUM4Px7f+ZxHlUV96B/d5p8gRPftyyzO
         y5dnNHGT48kE5ka9kn3j7mMVPhZenI8Kv7/Y5/fnCSFObccpgGkMU4TF0iGGCLyeTK2F
         Qo88KXtk/m0M8OZCFCqFGzSDBI7xXaMPF5dho5lBPiFxC9kACwTTx9JfGQBVyHOw1YA0
         LSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmRHhQEVdc7j5b8GRJ+bwBPDfCwyz1df7aW7vS1l850=;
        b=V2+bg0ZlQ/rvFb1FscGAvgiJUs6X0tY9J4AY+teNuFDcNDl9aQAnp9yi9U6Apbghws
         /91uqn40qrTCAgBxsVkZ7rf0ifunT6jSB9Qbv8u0DAFkwlQZ4fpcMC6p0M12D6k9ppUh
         zJEx3sik/D3mi3wBZPHZ4CxHMv5520aTPofnEbnoVoD6ANDg6Ej4cUipn5G0OfmYmTEr
         QU/iLIRkyMkltvxg6z2W/B1D6hqIIuP4dXs3pD0SSIZk70K7pt9ZHldl84Kbs73LkV9E
         kODXLyJ4lAPbNS/DiSup0T2ATvV1vfXf+f/Tsbr0nXsn1afSglfhVo8iKgOj3oicskCV
         XFcg==
X-Gm-Message-State: AOAM533p23kF/qAw/5eP+QHGXVVPK8yqFpN+g8eDnrJzyvYJtlV0jXWl
        OJQYISb6wdpDhGVzDJtnLjj5xw==
X-Google-Smtp-Source: ABdhPJyJf4YYacMOMRGDnSM6ll4hRK/WVoFumKmKugMzoiLcuyHlURGIkMffq81yrt4xhF/tTH+JCA==
X-Received: by 2002:a05:6000:1084:: with SMTP id y4mr18846233wrw.138.1604318063774;
        Mon, 02 Nov 2020 03:54:23 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 08/23] mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
Date:   Mon,  2 Nov 2020 11:53:51 +0000
Message-Id: <20201102115406.1074327-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/build.c:61: warning: Function parameter or member 'ubi_num' not described in 'mtd_dev_param'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index e85b04e9716b2..40fa994ad6a8f 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -50,6 +50,7 @@
  * struct mtd_dev_param - MTD device parameter description data structure.
  * @name: MTD character device node path, MTD device name, or MTD device number
  *        string
+ * @ubi_num: UBI number
  * @vid_hdr_offs: VID header offset
  * @max_beb_per1024: maximum expected number of bad PEBs per 1024 PEBs
  */
-- 
2.25.1

