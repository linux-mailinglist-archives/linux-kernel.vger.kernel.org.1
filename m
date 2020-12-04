Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD32CF57E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgLDUUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388072AbgLDUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:20:18 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56063C09424E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:18:26 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id u18so9354446lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6TvCy/F7eRWtUNo/MxFFiMZO9h7izN6lekg9c6lpkc=;
        b=zTJIsspapB64C5r5loN0+0GDKLFNDnEMlGm5RHOQgShnFOeXFexxBihVypXTdPf1n1
         TcoPsxiTRkIZlexfVgyIdhu1JYBbMGlycaL3NBzLTldpom6UA6jl7BF02ALHZXNgg3/V
         2zfG9moKzOBr5l3ppCWUh6kTsw9UhqC1tM2m6bQTJRq0x7DO1YgfPLSswbgpNr4KpgpI
         miSL76z/9e4UCkjK/0H+g8awm2BPHn+Hf+zfm+k+ezxb8OQ5CMfwI9TGc+TizhmPD6wq
         Tmkvwz3zxxWbVeoKvQfuly+EJ4XK9Ak+kSMTpa/NU7eIlmpLay2xmx5Qadj7s37igAAZ
         2jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6TvCy/F7eRWtUNo/MxFFiMZO9h7izN6lekg9c6lpkc=;
        b=jbU/74cJj6swbU5PX56EJxbINpxpGj2y66BQgOYnWkxyACCmsr65AtFAnjchxsmx5X
         J7vsGuCqr2Mw7mLUutEO1K6WjQdRmT5oj+IuL6cgtDFuQB7m1YJamlRFvaJ3f/Y6J36Q
         jM1H9e9CBVN3hmilbWzunujRG8kE6Br59O6upOQGqw6vMkqQ+1sj3/7V7nzGtcbyndAG
         v6NLuNejn+h2b/UZkqVgaF46CDta/rpity21FwKoy6wTgjAG8seQddB5HdbWcnMFHxPf
         o4HwKOrXUCtK0/cP54+CLF+FBbc88InT2XovgTRv8cfF4FhlCSBO86dPcxy1N2B/QBOS
         QTVQ==
X-Gm-Message-State: AOAM532gG38T2VnsB1h/bJlcOYQVf+aZ6xYNruRArG47wt85b0GrcocW
        +ry76RMpygP7MF5EFyLQlA48aDyp6LHtDA==
X-Google-Smtp-Source: ABdhPJx86pDawmjihnBby2Ln8g2zAZeAcXoUgXGJVDzaLglJkBUW+wxsCPzW8TQpxT/Hm4XxtMCeDg==
X-Received: by 2002:ac2:5307:: with SMTP id c7mr3694123lfh.28.1607113104899;
        Fri, 04 Dec 2020 12:18:24 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id w21sm2036918lff.280.2020.12.04.12.18.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:18:24 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, rogerq@ti.com
Subject: [PATCH v3 6/6] remoteproc: pru: Add support for various PRU cores on K3 J721E SoCs
Date:   Fri,  4 Dec 2020 21:18:07 +0100
Message-Id: <20201204201807.14716-7-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201204201807.14716-1-grzegorz.jaszczyk@linaro.org>
References: <20201204201807.14716-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The K3 J721E family of SoCs have a revised version of the AM65x ICSSG IP
and contains two instances of this newer ICSSG IP. Each ICSSG processor
subsystem contains 2 primary PRU cores, 2 auxiliary PRU cores called RTUs,
and 2 new auxiliary cores called Transmit PRUs (Tx_PRUs).

Enhance the existing PRU remoteproc driver to support these new PRU
and RTU cores by using specific compatibles. The cores have the same
memory copying limitations as on AM65x, so reuses the custom memcpy
function within the driver's ELF loader implementation. The initial
names for the firmware images for each PRU core are retrieved from
DT nodes, and can be adjusted through sysfs if required.

Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v2->v3:
- Add Reviewed-by: tag
---
 drivers/remoteproc/pru_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index f76423792acb..e32123c099de 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -849,6 +849,9 @@ static const struct of_device_id pru_rproc_match[] = {
 	{ .compatible = "ti,am654-pru",		.data = &k3_pru_data },
 	{ .compatible = "ti,am654-rtu",		.data = &k3_rtu_data },
 	{ .compatible = "ti,am654-tx-pru",	.data = &k3_tx_pru_data },
+	{ .compatible = "ti,j721e-pru",		.data = &k3_pru_data },
+	{ .compatible = "ti,j721e-rtu",		.data = &k3_rtu_data },
+	{ .compatible = "ti,j721e-tx-pru",	.data = &k3_tx_pru_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pru_rproc_match);
-- 
2.29.0

