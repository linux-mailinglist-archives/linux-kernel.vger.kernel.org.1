Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609692A2A07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgKBLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgKBLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:20 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09E2C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:19 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so877659wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxY4nsmyRi/nUX3VIHaOzQz5RbwhMjYbYFGyjUQHoHg=;
        b=JCPDuMlnKywnaHCyiFzg8iFhOYqvCd9b1hcgx7kc3+HIlApSIeeTFycUjUor7DSF7k
         eUG04bfHRpuy/7JATrM5WvxmfuSIGeosPpUfsMfAhq/2ixxFcnN8xqoqXTmQRSXQ98QP
         7Ewj2hKytb/TtMIUClOmW/gdVscSc6uM5avkYexLiZk1vO+zrHk/JuI4NBOL+V/ynD6r
         fx6time6q7cDuhXFFyuDOOWskPTRoKW+HTVhw8KeZRYdVytgFGKJ7RT76qgqg/jIxz6h
         UY3U5D/pGF1wAFal+E/r08gZMz0OxwT6WRFziw868b8039yWaWOkyx7JutH1LIyYUrCJ
         0ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxY4nsmyRi/nUX3VIHaOzQz5RbwhMjYbYFGyjUQHoHg=;
        b=gmtw5F+jiJuRkVV2606PoWNSmAgNzBd+ys5O9hRirkV1T9JvNG8xwTKdrAn865w2Z1
         cAiUZatRPym2lxp7Iu19HB08P20D7mVWICTTjDhp+g2lJCcW9imCqfYlw6jx78570EMf
         4uZaRy9Sg+9rpxgN+j/EcnMyw26pA0c/EmbZkamYpGuDC7Zh0BMcj8Qg+IDTGqOF410w
         mPXqPyawbMwGHf130LQKPfZ+1VD0EQRG2ciNccYqTrZcJiORbEzxcVbX2bwsWZwbshBw
         MyQ0HVbpzeDMv65L5RVpSQifrBkqJfWiXnJS/3VFwW0mEDEaoEPwRkU68OjcF/NFsCxg
         taQg==
X-Gm-Message-State: AOAM532DrQtQHrjQYm8yiqu56OdhdAskWRMKdVGwU4lS00jup/d8wOdR
        xyGg+SZbvppgFnyQiRE4DeJDTQ==
X-Google-Smtp-Source: ABdhPJwzgnEGAIiEE8RyNVpM9wHkkyb53IHSIEb5ieMRbI8BZwjKdlvZUyAObOT/4HgF9E5yesqStQ==
X-Received: by 2002:a1c:bd0b:: with SMTP id n11mr17472032wmf.111.1604318058701;
        Mon, 02 Nov 2020 03:54:18 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 04/23] mtd: devices: docg3: Fix kernel-doc 'bad line' and 'excessive doc' issues
Date:   Mon,  2 Nov 2020 11:53:47 +0000
Message-Id: <20201102115406.1074327-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/docg3.c:819: warning: bad line:
 drivers/mtd/devices/docg3.c:1799: warning: Excess function parameter 'base' description in 'doc_probe_device'

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/docg3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index a030792115bc2..5b0ae5ddad745 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -816,7 +816,7 @@ static void doc_read_page_finish(struct docg3 *docg3)
 
 /**
  * calc_block_sector - Calculate blocks, pages and ofs.
-
+ *
  * @from: offset in flash
  * @block0: first plane block index calculated
  * @block1: second plane block index calculated
@@ -1783,10 +1783,9 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
 
 /**
  * doc_probe_device - Check if a device is available
- * @base: the io space where the device is probed
+ * @cascade: the cascade of chips this devices will belong to
  * @floor: the floor of the probed device
  * @dev: the device
- * @cascade: the cascade of chips this devices will belong to
  *
  * Checks whether a device at the specified IO range, and floor is available.
  *
-- 
2.25.1

