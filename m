Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5B2E224A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 22:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgLWV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 16:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 16:57:28 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A476C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 13:56:48 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id e14so179445qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jCG+pP5B/ha4zc4aANM/eXYqzTZqfBuYgIBq10srGgc=;
        b=nYnwax4SRVuQGeooRFDyFNIzMBuAzj2r78Z9tDwBEIoUniS/GEnKWslTLzZnz1Nj66
         ROa3/HZfcX02fZCFHI3djGAdq4s+6dSMOjYaJqnBFasdx5ivJpisntJAeyn2mvX/40R5
         RCGezh0HlnVam7sPVVjsZRtt5XA3MGpmBxuW9HhKmOznHKuVq7IA4BEmHIZbGIPfam9T
         8VC/NgTHTCuVE/+P+/HJWHFlHgczn3NQRq9Ce1pr1/NIhhClMv4LLbmdE00o1e98N2to
         SXdi+NPV2axecTksd43+iolSehqV269OvtqJkuo1eFjml13ZZP1c7w6q19xRH0C1PZC0
         iopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jCG+pP5B/ha4zc4aANM/eXYqzTZqfBuYgIBq10srGgc=;
        b=NnsvQoAHzlfH1egwwQRQrip5uAWc1XNl8M9sPGWoS4hoENvs17KlLvPgdVs9kL49pp
         EPIAPxkozYAuvlFubzA595hYm6kEyavK9iFu/cK/Q2tDey8JviJlqtWB8F+hC8Q900tg
         l/uagohIj++XjB3Isxa3pnWqIg7BMfSknmgqR/Lcpsb30JdwhVurlHUb2u26DbmetHnP
         3RK9qqMn77NZMp1CHnbuM9LoP3rteKA7MC//A1fldiZwTjKU0qEiA5884Y3AJMFaDqGQ
         CU6q74C8vm0AF0q0jaX7p1y7SttRBGvMRGOMa8goN23eCuHG4buMmiS8dgSLzCWq8FRH
         4pbw==
X-Gm-Message-State: AOAM531oTyqK62wr33o6INeg7i1+p/cs+ZpDfItEtAGeAJFKVOrIe2ka
        3KFz+viq62v+Vb/WgnSznZuY+dAGlGIHrAs=
X-Google-Smtp-Source: ABdhPJzcdwpbleDWDWlKof2to9y4p0GOiPNS6G4j2LvnBlWfhcsRwwRXXcgSu5YAX4np3ypNVVy68a+po87tukw=
Sender: "goegebuer via sendgmr" <goegebuer@overmind.svl.corp.google.com>
X-Received: from overmind.svl.corp.google.com ([2620:15c:2c5:3:1ea0:b8ff:fe77:e712])
 (user=goegebuer job=sendgmr) by 2002:a05:6214:533:: with SMTP id
 x19mr29179737qvw.20.1608760607341; Wed, 23 Dec 2020 13:56:47 -0800 (PST)
Date:   Wed, 23 Dec 2020 13:56:30 -0800
In-Reply-To: <1887c783-7a80-a71c-949f-c07c83c2d0fe@ti.com>
Message-Id: <20201223215630.1917891-1-goegebuer@google.com>
Mime-Version: 1.0
References: <1887c783-7a80-a71c-949f-c07c83c2d0fe@ti.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] mtd: parser: cmdline: Support MTD names containing one or
 more colons
From:   Ian Goegebuer <goegebuer@google.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     "Ronald G . Minnich" <rminnich@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ian Goegebuer <goegebuer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel platforms, the usable SPI area is located several
MiB in from the start, to leave room for descriptors and
the Management Engine binary. Further, not all the remaining
space can be used, as the last 16 MiB contains firmware.

To make the SPI usable for mtdblock and other devices,
it is necessary to enable command line partitions so the
middle usable region can be specified.

Add a part_probes array which includes only "cmdelineparts",
and change to mtd_device_parse_register to use this part_probes.

Signed-off-by: "Ronald G. Minnich" <rminnich@google.com>
Signed-off-by: Ian Goegebuer <goegebuer@google.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index b54a56a68100..9de38851c411 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -903,6 +903,8 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 	.erase = intel_spi_erase,
 };
 
+static const char * const part_probes[] = { "cmdlinepart", NULL };
+
 struct intel_spi *intel_spi_probe(struct device *dev,
 	struct resource *mem, const struct intel_spi_boardinfo *info)
 {
@@ -950,7 +952,8 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	if (!ispi->writeable || !writeable)
 		ispi->nor.mtd.flags &= ~MTD_WRITEABLE;
 
-	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
+	ret = mtd_device_parse_register(&ispi->nor.mtd, part_probes,
+					NULL, &part, 1);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.29.2.729.g45daf8777d-goog

