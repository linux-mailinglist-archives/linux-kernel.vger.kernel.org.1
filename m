Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B98251A3D35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 02:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgDJAJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 20:09:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45757 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgDJAJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:09:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id w11so239804pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x++4E99WYTdFMlT838smwcLrJF+YLOsMRV1sYigqI0s=;
        b=N5O+CiPMZNXhxPaAqFK66FSI66B24y4Jqa+3BFkQIyl7h4NQWxTPIikryW4UP5e4uF
         u4zqvX09ik5rXMYTQaSptadQ7Pyjtm3b0d99LI0BfoBO0GqY5DFgxBbKHVCG4KJCXMew
         cLfV3T9ZFNEgmwv495/l7hsVlUPnYwo8xdAZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x++4E99WYTdFMlT838smwcLrJF+YLOsMRV1sYigqI0s=;
        b=cpwlucHJLzCB3rsdHGiEA6IIU1v7/BMjHbNOnsNeXQbla2Ij+Cgor6JOFVyNihdglh
         a7cBKslJaJAoHaM8C/TEmR/kujbzFdxAdUetFvjiMO7InPyFRLBjXa51vs4jlTms9evg
         yinMb2KF5COf+7BdDUjpLjgZMlP3OLwgPJ7vXpIYpL6g4rcmyYkLURDB6DmGNYu91Fzw
         zZ5ZLBjsj0aFHZhyYnztli71am0n4JTRlz0C8O+Ei2Ud0lsbS+JBANlCqcc5d547ZdJX
         iTkYMA+E905H4C7QkyIHY9ok7CjRCnlCJu5wvtz/vwzN8EScFeG0MetV68sA8AdIpZ5x
         +ouQ==
X-Gm-Message-State: AGi0PuYx8McIP4DZujHtsVHsITbXbpB2NUT38cW//muF1eU6Jibvih4R
        QrLPW93dv05apu48HfCpVarp8QvsPBI=
X-Google-Smtp-Source: APiQypID6RxdtekYzsjFAMA1AWPtePg/4Ulj1chxAIoQiV102ZCyPjrdWbsow+41rIc92SIb2W6WQA==
X-Received: by 2002:a62:686:: with SMTP id 128mr2229885pfg.152.1586477341476;
        Thu, 09 Apr 2020 17:09:01 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 6sm216421pgm.51.2020.04.09.17.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:09:01 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 1/3] platform/chrome: typec: Use notifier for updates
Date:   Thu,  9 Apr 2020 17:08:19 -0700
Message-Id: <20200410000819.198668-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410000819.198668-1-pmalani@chromium.org>
References: <20200410000819.198668-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a listener for the cros-usbpd-notifier, and update port state
when a notification comes in.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Added Kconfig dependency to CROS_USBPD_NOTIFY.
- Fixed spacing error.
- Removed superfluous devm_warn() call.

 drivers/platform/chrome/Kconfig         |  1 +
 drivers/platform/chrome/cros_ec_typec.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 03ea5129ed0c3..67fc9c567ae6c 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -218,6 +218,7 @@ config CROS_EC_TYPEC
 	tristate "ChromeOS EC Type-C Connector Control"
 	depends on MFD_CROS_EC_DEV && TYPEC
 	default MFD_CROS_EC_DEV
+	depends on CROS_USBPD_NOTIFY
 	help
 	  If you say Y here, you get support for accessing Type C connector
 	  information from the Chrome OS EC.
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 874269c070739..d444dd7422a2a 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
 #include <linux/usb/typec.h>
 
@@ -26,6 +27,7 @@ struct cros_typec_data {
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 	/* Initial capabilities for each port. */
 	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
+	struct notifier_block nb;
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
@@ -272,6 +274,22 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	return 0;
 }
 
+static int cros_ec_typec_event(struct notifier_block *nb,
+			       unsigned long host_event, void *_notify)
+{
+	struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
+						     nb);
+	int ret, i;
+
+	for (i = 0; i < typec->num_ports; i++) {
+		ret = cros_typec_port_update(typec, i);
+		if (ret < 0)
+			dev_warn(typec->dev, "Update failed for port: %d\n", i);
+	}
+
+	return NOTIFY_OK;
+}
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_typec_acpi_id[] = {
 	{ "GOOG0014", 0 },
@@ -332,6 +350,11 @@ static int cros_typec_probe(struct platform_device *pdev)
 			goto unregister_ports;
 	}
 
+	typec->nb.notifier_call = cros_ec_typec_event;
+	ret = cros_usbpd_register_notify(&typec->nb);
+	if (ret < 0)
+		goto unregister_ports;
+
 	return 0;
 
 unregister_ports:
-- 
2.26.0.110.g2183baf09c-goog

