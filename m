Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8242D52A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgLJELq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgLJELS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:11:18 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F401C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 20:10:38 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id o4so3010310pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 20:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNwDCAmEHJ6GVCJ8LV7P/G32+guy4Z4G/q7aB900dIM=;
        b=qaDhzNnv7QoAkDyAHHSqiI0AAuSjG0o8kPTxvInwKtWvNx9CPfI7OjmWzrK2vSorAg
         rNt9yAfmygyXEau64uWv4YVbz9nMwtn0Jp4wH6sMIqvIeD8KlKqs8qs2ToKjOowVN+D/
         NRocQIQAIpD0V+uunZGbch6QtD123AH9fIgow6ZcT9rn5o/eSQQNvODHqhknouEZQjX/
         oDjdPgYb1mAW2bTN6DhlqIrjhdZmUF/tItyn1/vEs2G3A+/tSwlBoZAwBL5T0Vpizf6g
         yk0P43KbWF4mb07PcPUAiazm+nb0BVxCijfrcENeRYwqboZ0mfUJoNWz+TYB99U4FWY5
         YDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eNwDCAmEHJ6GVCJ8LV7P/G32+guy4Z4G/q7aB900dIM=;
        b=p2a800D5UWlyr2zuRBtL2yATm6WGnW2X3sXW99RiVlWBr2fnLqsJCu2+ERB49CHHfb
         J9OpN6GDWYtJyuZ+urea+b2UifVQK7Cc85a0qyz2HWx5/gMi4UJ9TLZ0paPuNGtShPRS
         NEHF2YLN51/qhT9rdJCsLL1beKF+6Y3BtT/XlYJ7Y5YBlbQR0s5iYnitxzUic3At14R7
         navXRWccWvOSv1pYNp2qdE1HEo5za1a/gx+blQyY4aAOx1dfSI5MceW7L2qvlvBPTedl
         TKI/56zQc+TAYOl7UNbzcjtE7pU1yin2vyCm7ttAoVu3A0xJenyEqStYjYmKy+9DRMNC
         V86w==
X-Gm-Message-State: AOAM533OmvI+srRtnuHczph6u/LJNHyhIzo1JvV6+io1qWb7hK2G+GnR
        Pp8aVebcoP2td3RkQMDUFO4vjA==
X-Google-Smtp-Source: ABdhPJzhFDOpOQsfNNnOSbzK6+F6GkwsYucA1C04k5FqDblEQKLXG9SDWL0JSvsgZZzn7SEZsxIliw==
X-Received: by 2002:a05:6a00:1683:b029:19d:917a:616b with SMTP id k3-20020a056a001683b029019d917a616bmr5141294pfc.15.1607573437656;
        Wed, 09 Dec 2020 20:10:37 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id h20sm4051518pgv.23.2020.12.09.20.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 20:10:37 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        peterz@infradead.org, luto@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org,
        Dan Nicholson <nicholson@endlessos.org>,
        Chris Chiu <chiu@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] x86/reboot/quirks: Add GIGABYTE BRIX BXBT-2807 reboot quirk
Date:   Thu, 10 Dec 2020 12:10:30 +0800
Message-Id: <20201210041030.8458-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Nicholson <nicholson@endlessos.org>

The GIGABYTE BRIX BXBT-2807 always hangs with the normal acpi
reboot. It works withour problem after adding the parameter
reboot=bios.

Signed-off-by: Dan Nicholson <nicholson@endlessos.org>
Signed-off-by: Chris Chiu <chiu@endlessos.org>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
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

