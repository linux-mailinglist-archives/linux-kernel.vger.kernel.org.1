Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778A72D52BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgLJEUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgLJEUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:20:34 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95706C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 20:19:54 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id bj5so2129065plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 20:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RNggzigDCRW+TTliBArAqf8wbEcRACh4QiPOIXgemU=;
        b=MgDi462j7Yjt6EA9HWr0fO6MGkhPlIkMRb/t6M/oJzZXwLdc/C8tUrD4Q6Qu3jEF/U
         fxEeuCDc/LNS0mfRUL6QM1pJ0EBzUyFJkBUQQsSUwBTqaMTI0QKNTZu6wCIhOg0do43n
         CDmH5ya5st/aOMQk1Ned0AYm6YAYs/1NDtsTJfNhz+JPJxrLIRM0mDOBmK3rFr+LfRHz
         ydh2sucmAa5aEBLPz8yLXLqFHd3YQJpOvChZ7x+/oYxkDKpobyvKfE611LgGQkLM+4SW
         alVW8vQDWRN/1h4FVPcYivgYlAOQQBnxVcX1NSJ78kezMPncz+hrb8FJMcl0ysHQqYTL
         LVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RNggzigDCRW+TTliBArAqf8wbEcRACh4QiPOIXgemU=;
        b=sNwvb/TX9FBrM0LETf5gy/kj5zDqBDmws8niJHByIrr+hF7GtxrhkSE0HVZy+mpUMZ
         iOGMSo75I3sxKq0OxuX1mKq1HXmaNqFPfA9zMMNgFvDk4NRkUnanAaxQKQqV/ndM91jy
         0heqo0Z6zVpdx+jxTWDGgemVB6UftYBaXWYKy6yititwfcgEZcEoNl7fm48oT8vy6pI/
         NX6OaDHxzdiSEu/Tpzm+Jzn4jMO2CepHUsY+npDKJTze6wTADLBiqryNUadX6fq+/Qj9
         4QxV8IV9sx+G3+EZTS1XQ/UZjdxZQmibvir2Skzrx1w9e4loUJkgOAUV1rYrCo1zWGaQ
         qJZw==
X-Gm-Message-State: AOAM532d1iwJ9GzaHD3+LhpKthzyysZTIkMP04FIFwRzfEOIPzsjBGlK
        RjhTtyR8A5DKn6n2APvdNQtczg==
X-Google-Smtp-Source: ABdhPJySyvEsEf3OOyy+CU68val+ivH+Cz6FwJ20NGF+Eobbq1ikbr79pJRckeFTKaOyfH2ajoePtQ==
X-Received: by 2002:a17:902:d38b:b029:db:e003:3ff0 with SMTP id e11-20020a170902d38bb02900dbe0033ff0mr839726pld.7.1607573994104;
        Wed, 09 Dec 2020 20:19:54 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id x4sm4119347pgg.94.2020.12.09.20.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 20:19:53 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, luto@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org,
        Dan Nicholson <nicholson@endlessos.org>,
        Chris Chiu <chiu@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v2] x86/reboot/quirks: Add GIGABYTE BRIX BXBT-2807 reboot quirk
Date:   Thu, 10 Dec 2020 12:19:46 +0800
Message-Id: <20201210041946.8961-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Nicholson <nicholson@endlessos.org>

The GIGABYTE BRIX BXBT-2807 always hangs with the normal acpi
reboot. It works without problem after adding the parameter
reboot=bios.

Signed-off-by: Dan Nicholson <nicholson@endlessos.org>
Signed-off-by: Chris Chiu <chiu@endlessos.org>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---

v2:
  - fix typo in the commit message.

 arch/x86/kernel/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index db115943e8bd..a03344616cd9 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -467,6 +467,16 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 		},
 	},
 
+	/* GIGABYTE */
+	{	/* Workaround hard disk crash on ACPI reboot */
+		.callback = set_bios_reboot,
+		.ident = "GIGABYTE BRIX BXBT-2807",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
+		},
+	},
+
 	/* Hewlett-Packard */
 	{	/* Handle problems with rebooting on HP laptops */
 		.callback = set_bios_reboot,
-- 
2.20.1

