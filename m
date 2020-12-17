Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821EC2DD531
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgLQQ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgLQQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:28:37 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A1C061794;
        Thu, 17 Dec 2020 08:27:56 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id n9so15378355ili.0;
        Thu, 17 Dec 2020 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqaDdh80Jc1X6em3g1sQbEFqj9BR18AP205Qoq6HnvQ=;
        b=tIiDpTuJUZPZzRuoSNxcEPMns83IKTVDMFVatIG6cEzvgpI9TGROx8mKgey/PdLUvF
         q9ySr5AgJKnk2ePIfS9NC1Wbci3eqxUW34HmeQrCEd+bb6T48DMLxizg1Tq+sDP/G/7I
         rNRqTFi/0iW797CYfh4tw5wIwIuvmIrBOQjZJe8WkiGYJLRJDHBseC8LkqvRX+zx/Miq
         hi1g8aDu6ikI7ehLZa1esCx+scEfjz/WE8AOKgkK+L+lSBDXK17HQcbzAp1mfDnvuT3Y
         p995VwDnMUXD7H3aVEdtcDPqIziy6Cd2C1AXa2xRgXH37JkjjRGpwqrvBDFp5ewboE1W
         X6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqaDdh80Jc1X6em3g1sQbEFqj9BR18AP205Qoq6HnvQ=;
        b=jNeihY5knspIbUaRC5/8ZTdC0c6YUdmISwkE9nWDfKKM/VmkZIB9FU248eiGfUbkzI
         zdytqZhbirs6vDQ5i3zqoLrHqr00crZ7TI4dhKJNfNJcIMuSdTqQzdOFRSIyJJmhkoHv
         Xu+v9P9daPkAv4As+O8wDeT1PnAdivFha9dtWv8//WUL54njdNZiJTx6yEfb7TRdF8tq
         nsD0SJFh7Oq4DzY9nw2A+nMBlBmHSRF8gHaEzRVJjLNfSfWspqgLi/Z+GiCrS0GajSwl
         aSYhcCAVXxN9mvCUmChW7Sut7HTkcGCQjSZ/cjmTYIZPk5E3jasmK9iQKWuC85Tqr+uF
         mJgA==
X-Gm-Message-State: AOAM532Zqtohs5y1LxSKSkLx9Lau+rwp5Wv+Y8vjsDQV0Tfr5rs3IB2O
        /vwhpMwdC51LoDH+jGZ2Ksk=
X-Google-Smtp-Source: ABdhPJx4ygJHmJS4lU4rhhfgBUhLOTH4vOjx/1K+DgCxR3OuwVOeTbo1edMUcENQmcdfJeqDcYgd2A==
X-Received: by 2002:a05:6e02:4ae:: with SMTP id e14mr48619070ils.132.1608222475876;
        Thu, 17 Dec 2020 08:27:55 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id y14sm3416240ilb.66.2020.12.17.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 08:27:55 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
Date:   Thu, 17 Dec 2020 10:27:40 -0600
Message-Id: <20201217162740.1452000-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can request an optional clock for mclk.
Update the txt file to reflect this.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/sound/wm8962.txt b/Documentation/devicetree/bindings/sound/wm8962.txt
index dcfa9a3369fd..c36c649ddfd0 100644
--- a/Documentation/devicetree/bindings/sound/wm8962.txt
+++ b/Documentation/devicetree/bindings/sound/wm8962.txt
@@ -9,6 +9,9 @@ Required properties:
   - reg : the I2C address of the device.
 
 Optional properties:
+
+  - clocks : The clock source of the mclk
+
   - spk-mono: This is a boolean property. If present, the SPK_MONO bit
     of R51 (Class D Control 2) gets set, indicating that the speaker is
     in mono mode.
@@ -27,6 +30,7 @@ Example:
 wm8962: codec@1a {
 	compatible = "wlf,wm8962";
 	reg = <0x1a>;
+	clocks = <&clks IMX6QDL_CLK_CKO>;
 
 	gpio-cfg = <
 		0x0000 /* 0:Default */
-- 
2.25.1

