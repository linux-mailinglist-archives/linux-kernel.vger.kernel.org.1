Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05D2CD37C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbgLCK3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgLCK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:29:21 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE7BC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:28:40 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so1333359wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WR5N2RgMXKbZVcZ/NAjb1kgdYhbDz+iPAQbu94t8kvY=;
        b=d2kWMJ2zMZ7Lnc4DdgNhYIjcFmHmlPVQ4XBmctmfpBjPrlFiLQomkxBpT4Ojf5xVVy
         ZmNoGrdHXTBzhQ1pNfnJYg7F/rAcPehbkIi2yo+7LbuN+vA0hWa9YlfDHHKWdG9eN9Nk
         D3Bhsh05m5IEiXJ8BEvFedRya+mjAuT8NXBCP2rjW2d/2LByk2S8yZuDr0cDl9YOD6sw
         /dNT32wGce4VJMvjW0YOnpcNjI+Ysiic4mO+mUJJSl4uU9FmmmNuOAgeKBrer6rhTOuh
         iGMBBYZ2EoXEGGpuSWDgHrvaEDvl2VJz2Nk1xn5Ivs7dMO2XNL0y6E11PvY2th2X65D+
         cbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WR5N2RgMXKbZVcZ/NAjb1kgdYhbDz+iPAQbu94t8kvY=;
        b=Y6bqXwm8oSeN1Tzx95kWnp/k8H0qIHSuCITSA5uE+Vuj3t4AOzNL0TItsbR6v8K98g
         rG7D48uaAHOGXe11yBVrYerR+Xw5040xHO5GsfXn4IbMldnGJJnRbubz1ftXS0UGD5Yh
         NrJ+UwPgiKeI+mdHK7HIeh/d+4bvJHAwwT0puuvBRZn/gOeX1bY8K17438DVBafWSPFA
         mesq6zEv3Y9/xicJ42opNQqWRigbViRC4uTc4Kr1Zt2kUTuU4v39OdBLey0o39jEe7oa
         yeUKBPvd8lUNd9Eno5+sjX32t9EYWQSwvdfB5mywx8xbNYJR7nEZDW3605DVlxK2Iq0x
         ESIg==
X-Gm-Message-State: AOAM533je7pfpOKxlPHnudMKK7P9KyHF/5v9OiJcCbCNPnBvIthZGea0
        7r5x6uv0o6o+zots19uFi4etnnAzZcV+7g==
X-Google-Smtp-Source: ABdhPJzromFGjJKml15S3oOM+NPM3ztFfBiRIIEMEselUcOP28JoglyKgODK5zBdJyamKki8mUUdUA==
X-Received: by 2002:a5d:654c:: with SMTP id z12mr2931042wrv.46.1606991319101;
        Thu, 03 Dec 2020 02:28:39 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id o13sm847589wmc.44.2020.12.03.02.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 02:28:38 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v3 1/3] drm/mipi-dbi: Add support for Type B
Date:   Thu,  3 Dec 2020 20:28:11 +1000
Message-Id: <1606991293-29539-2-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606991293-29539-1-git-send-email-mikhail_durnev@mentor.com>
References: <1606991293-29539-1-git-send-email-mikhail_durnev@mentor.com>
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
 drivers/gpu/drm/drm_mipi_dbi.c | 134 ++++++++++++++++++++++++++++++++++++++---
 include/drm/drm_mipi_dbi.h     |  30 ++++++++-
 2 files changed, 153 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 230c4fd..3edb041 100644
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
@@ -701,6 +701,15 @@ int mipi_dbi_poweron_conditional_reset(struct mipi_dbi_dev *dbidev)
 }
 EXPORT_SYMBOL(mipi_dbi_poweron_conditional_reset);
 
+static bool mipi_dbi_machine_little_endian(void)
+{
+#if defined(__LITTLE_ENDIAN)
+	return true;
+#else
+	return false;
+#endif
+}
+
 #if IS_ENABLED(CONFIG_SPI)
 
 /**
@@ -721,15 +730,6 @@ u32 mipi_dbi_spi_cmd_max_speed(struct spi_device *spi, size_t len)
 }
 EXPORT_SYMBOL(mipi_dbi_spi_cmd_max_speed);
 
-static bool mipi_dbi_machine_little_endian(void)
-{
-#if defined(__LITTLE_ENDIAN)
-	return true;
-#else
-	return false;
-#endif
-}
-
 /*
  * MIPI DBI Type C Option 1
  *
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
+	dbi->spi = NULL; /* Type B uses GPIO lines rather than SPI */
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

