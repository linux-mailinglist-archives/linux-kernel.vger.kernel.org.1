Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95FF2A9F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgKFVhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgKFVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:12 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B3C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:12 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h62so2622539wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmRHhQEVdc7j5b8GRJ+bwBPDfCwyz1df7aW7vS1l850=;
        b=MS1eNve1E8TYJUMppy9nxHHsrdiRDKvguLFeY6/UbTGermAOC/Vb1I96lhQjgRO6/W
         6Rn2wf7AObcPo6z0RmdLi4dAuoiTqAP5C488affSmxOrbY1DDvHPl/nQkMwhY7IrEaFJ
         GboA6G3Hdyn3tk6z/PkCmsIJ52vOiwFdu6cfIyYwbY4no/dhxjrUEmOm09OQdn3RVH/8
         EUyztItAe6k/z0PPyI83DtGj2UUoCMjRq9uTZqUK+e4per+Agb1TpY1vzOtaArMiC9xx
         U13oSXvN8bXdgB03T+XJY6PWQRLyKXHDitXSKbUXhD8ubvH/2CMR4+vujko9tu3HL1JZ
         8wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmRHhQEVdc7j5b8GRJ+bwBPDfCwyz1df7aW7vS1l850=;
        b=Xkouxle0Eg1MF5Vzf+s+qbPtna+toikXTOw6YZy2dMnVikp38RFaxVJttWLon1on1W
         R/dJy+TD3JyOtfIAVzvcpFQd0QKlUnGtmEQ3u+bPSvObEjn706b5CMdC6g8il0/d4E+M
         tQ0d74K5OzKaS5RO5ls/RltgZp5vz5FwtjGSYp4jZSMqaeQKh370d5T9SQJHN/fACzQ2
         +IbYS4RFghixp79m/zKjhawKqIanpQ1PuGwLwjAKkIuCNFbUeAQ+xbhuZ4OdbztXVYB4
         eK7/51QZmPqXgJIccxHGz+HR14807B6fC8CbIlXCtKsiZTQ0ajQ5yYZN5rBrPv+QPho1
         zqAQ==
X-Gm-Message-State: AOAM533bOrmidg0na9MvqWfILnI4sN/h07MHg6avoC9aJK7JZYJ5YAd8
        cnJECsi/v/mjLYG1jL7njjZ6cw==
X-Google-Smtp-Source: ABdhPJxpRnHCX/e1gikCJ98PGt1o+NVbAQVxQRNqGnZf43f7ZRErvaYGHfp62meMhtyoLuGEUnqyHg==
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr1567266wmb.39.1604698630851;
        Fri, 06 Nov 2020 13:37:10 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 08/23] mtd: ubi: build: Document 'ubi_num' in struct mtd_dev_param
Date:   Fri,  6 Nov 2020 21:36:40 +0000
Message-Id: <20201106213655.1838861-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
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

