Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EBD2B7706
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKRHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:36:47 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856BC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:36:46 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id b6so1162878wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AzWf6h3xVwzZJjUxTOdI521zAz9/mIr5bpxTeRbBHos=;
        b=okKRT/66ZNoR1Kytz5qof7fWmapN98V2MvKBCwlIdOBEsWznRDIC2T7TNyO8aphrXf
         QfgcD+TKqcPHHCBCFKDxUPi9GJQO2Gn9uVTKhrAAi0NLC6NHz0c9Q6zhvvRCgxrGsQLK
         0lsGhM/hlIgLtuI71VAurS3gwVMnym1yc2GheTDGnKJ102zcwCJd8G0stZcoLCZusisg
         klCty1H5GKR0uUh4IZVMu1iz9zNDIymwl0morZVR9IY+xUqU8PKm8OP5dp45SVrgMEyp
         o6y/3fCWjjlZMnH8D8b/CRBv1dB9hp/+ka2MHcygkepP1DV++t/gvyGIQ0jPhSV8VeQo
         az0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AzWf6h3xVwzZJjUxTOdI521zAz9/mIr5bpxTeRbBHos=;
        b=GZFx0n9N/e+EJzI9t55sb1zg/ItJbw4nC0PDO6T4oSNWlHz6fpWXoPjiaL3hj7/vLC
         jFck7gLniqUONbwr/Sb1/leYu0YFgktAnBhi7pvo5HX37r9wzsxG24jK+BCfRUjizy1v
         euyqKgVgloHjPcpXAizc6rvyml7TCfW+FpiOzQlkttpyS0Dc1I40VZF1918URFL0qtYf
         8Q1P+89y4Cio8FN81ZMCR/Ic4p3OfpP/vhPlkJlnx1dIDWceINkLNRu9Iw2BUq6eR2Qk
         bGwKI36UdV4N7yFJecBt9yoaxsJr/HgfPNVA+f6xQZLOl5lHnKnzzMu6aYx7btZ5A8Bo
         Ne5Q==
X-Gm-Message-State: AOAM532sKMi4k8uRFbkklGnERAq0YieFaTwlWMHk4+IU9TlrFdJ5tLKg
        e5Ughu4WPOGIhBLJNZozr5uoilv4JvA=
X-Google-Smtp-Source: ABdhPJxOJNevHugY2xd7xWucXT73AfukKzHisAGVzzM1gS7HJkZiBxEnSZbzhKqUzdTIBCKez1dqcw==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr3262838wrv.355.1605685005078;
        Tue, 17 Nov 2020 23:36:45 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id b14sm30188632wrq.47.2020.11.17.23.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 23:36:44 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org
Cc:     mikhail_durnev@mentor.com, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Subject: [PATCH 1/3] drm/mipi-dbi: Add support for Type B
Date:   Wed, 18 Nov 2020 17:35:43 +1000
Message-Id: <1605684945-29727-2-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605684945-29727-1-git-send-email-mikhail_durnev@mentor.com>
References: <1605684945-29727-1-git-send-email-mikhail_durnev@mentor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Durnev <mikhail_durnev@mentor.com>

Intel 8080 type (Type B) parallel bus over GPIO.

The parallel bus is implemented partially. It supports only write
operations from the host to the display. Read operations would
require switching GPIO mode between input and output back and
forth. But this implementation is very simple, and GPIO mode can
be set for all used pins to output once at initialization.

It is enough to support only write operations to initialize displays
and output video data. The bus driver returns EOPNOTSUPP for all read
operations requested through a display driver.

Bit banging is used to transmit data over the parallel bus from host
to display. There are two numbers that contol timings: wr_up_delay
and wr_down_delay. They should be provided by the display driver.
The first number is related to the write control pulse duration, and
the second number is related to the write cycle duration that can
be found in the specification of the display.

Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 116 ++++++++++++++++++++++++++++++++++++++++-
 include/drm/drm_mipi_dbi.h     |  30 ++++++++++-
 2 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 230c4fd..4d2e108 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -61,7 +61,7 @@
  *    3. 8-bit with the Data/Command signal as a separate D/CX pin
  *
  * Currently mipi_dbi only supports Type C options 1 and 3 with
- * mipi_dbi_spi_init().
+ * mipi_dbi_spi_init() and Type B with mipi_dbi_gpio_init().
  */
 
 #define MIPI_DBI_DEBUG_COMMAND(cmd, data, len) \
@@ -1158,6 +1158,120 @@ EXPORT_SYMBOL(mipi_dbi_spi_transfer);
 
 #endif /* CONFIG_SPI */
 
+/*
+ * This function implements data transfer only from host to display.
+ */
+static void mipi_dbi_gpio_transfer(struct mipi_dbi *dbi, u16 data)
+{
+	unsigned long ldata = data;
+
+	/*
+	 * Set W/R to low to start transfer.
+	 * Set DB bits with provided data when W/R is low.
+	 */
+	gpiod_set_value_cansleep(dbi->wr, 0);
+	gpiod_set_array_value_cansleep(dbi->db->ndescs, dbi->db->desc,
+				       dbi->db->info, &ldata);
+
+	/*
+	 * The bus usually needs additional delay.
+	 */
+	ndelay(dbi->wr_up_delay);
+
+	/*
+	 * Set W/R to high to indicate that DB lines are set.
+	 */
+	gpiod_set_value_cansleep(dbi->wr, 1);
+
+	/*
+	 * The connected display needs some time to read the data.
+	 */
+	ndelay(dbi->wr_down_delay);
+}
+
+static int mipi_dbi_gpio_command(struct mipi_dbi *dbi, u8 *cmd,
+				u8 *par, size_t num)
+{
+	int i;
+
+	/*
+	 * Read commands are not currently supported.
+	 */
+	if (mipi_dbi_command_is_read(dbi, *cmd))
+		return -EOPNOTSUPP;
+
+	MIPI_DBI_DEBUG_COMMAND(*cmd, par, num);
+
+	gpiod_set_value_cansleep(dbi->dc, 0);
+	mipi_dbi_gpio_transfer(dbi, (u16)*cmd);
+	gpiod_set_value_cansleep(dbi->dc, 1);
+
+	if (dbi->db->ndescs == 16 &&
+	    (*cmd == MIPI_DCS_WRITE_MEMORY_START ||
+	     *cmd == MIPI_DCS_WRITE_MEMORY_CONTINUE)) {
+		/*
+		 * Only a couple of commands supports 16-bit transfer.
+		 */
+		for (i = 0; i < num; i += 2) {
+			u16 data = *(u16 *)&par[i];
+
+			if (dbi->swap_bytes)
+				data = (data >> 8) | (data << 8);
+
+			mipi_dbi_gpio_transfer(dbi, data);
+		}
+	} else {
+		for (i = 0; i < num; i++) {
+			/*
+			 * Other commands ignore most significant bits.
+			 */
+			mipi_dbi_gpio_transfer(dbi, (u16)par[i]);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * mipi_dbi_gpio_init - Initialize MIPI DBI Type B interface implemented via GPIO
+ * @dbi: MIPI DBI structure to initialize
+ * @dc: D/C gpio
+ * @wr: W/R gpio
+ * @db: DB gpios
+ * @wr_up_delay: Delay after setting DB and before changing W/R from low to high
+ * @wr_down_delay: Delay after changing W/R from low to high
+ *
+ * This function sets &mipi_dbi->command, enables &mipi_dbi->read_commands for the
+ * usual read commands. It should be followed by a call to mipi_dbi_dev_init() or
+ * a driver-specific init.
+ *
+ * Returns:
+ * Zero on success, negative error code on failure.
+ */
+int mipi_dbi_gpio_init(struct mipi_dbi *dbi, struct gpio_desc *dc,
+		      struct gpio_desc *wr, struct gpio_descs *db,
+		      unsigned long wr_up_delay, unsigned long wr_down_delay)
+{
+	dbi->spi = 0; /* Type B uses GPIO lines rather than SPI */
+
+	dbi->read_commands = mipi_dbi_dcs_read_commands;
+	dbi->command = mipi_dbi_gpio_command;
+
+	dbi->dc = dc;
+	dbi->wr = wr;
+	dbi->db = db;
+	dbi->wr_up_delay = wr_up_delay;
+	dbi->wr_down_delay = wr_down_delay;
+
+	if (mipi_dbi_machine_little_endian())
+		dbi->swap_bytes = true;
+
+	mutex_init(&dbi->cmdlock);
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dbi_gpio_init);
+
 #ifdef CONFIG_DEBUG_FS
 
 static ssize_t mipi_dbi_debugfs_command_write(struct file *file,
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index c2827ce..c4be5ca 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -55,7 +55,7 @@ struct mipi_dbi {
 	struct spi_device *spi;
 
 	/**
-	 * @dc: Optional D/C gpio.
+	 * @dc: D/C gpio, optional for Type C and mandatory for Type B.
 	 */
 	struct gpio_desc *dc;
 
@@ -68,6 +68,31 @@ struct mipi_dbi {
 	 * @tx_buf9_len: Size of tx_buf9.
 	 */
 	size_t tx_buf9_len;
+
+	/* Type B specific */
+
+	/**
+	 * @wr: W/R gpio.
+	 */
+	struct gpio_desc *wr;
+
+	/**
+	 * @db: Data Bus gpios (usually 8 or 16).
+	 */
+	struct gpio_descs *db;
+
+	/**
+	 * @wr_up_delay: Delay after setting all db lines and before changing
+	 * wr from low to high.
+	 */
+	unsigned long wr_up_delay;
+
+	/**
+	 * @wr_down_delay: Delay after changing wr from low to high and
+	 * before wr can be changed again from hight to low to start a new
+	 * write operation.
+	 */
+	unsigned long wr_down_delay;
 };
 
 /**
@@ -139,6 +164,9 @@ static inline struct mipi_dbi_dev *drm_to_mipi_dbi_dev(struct drm_device *drm)
 
 int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *dbi,
 		      struct gpio_desc *dc);
+int mipi_dbi_gpio_init(struct mipi_dbi *dbi, struct gpio_desc *dc,
+		      struct gpio_desc *wr, struct gpio_descs *db,
+		      unsigned long wr_up_delay, unsigned long wr_down_delay);
 int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
 				   const struct drm_simple_display_pipe_funcs *funcs,
 				   const uint32_t *formats, unsigned int format_count,
-- 
2.7.4

