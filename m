Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA36254759
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgH0OtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:49:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7066 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgH0N6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598536701; x=1630072701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nWNzwf2i2SDo3KX81OQU8foELgzT/Y15wKfMoigYVUQ=;
  b=J2YzrWW5b6LmkPPsCOGa4Z0WT3Nkdpos9gp7MT910Dz91YB0IR0hkzPo
   jcbDyjv8MEoqtnHlh8XlXjJAS69ciZ/Z47WP9ei7G/sN36qt0VHnY7yCm
   tTcNQ4NCns00zTJzF65YG0hVPVW4ETLvqho0NL42gnFWUIfLTUtzHOhlw
   BZB+Sm0HeZ7zC7QVuV0B7ML268wxuJahN8UIdt0egVaVZ5mtXyiCprDxH
   cqELjIOiDx+K0frO3GwxVlc/xq3dELqoUCB+X09xiKRDxn4FLB905NqST
   vL03S/PDUI8jUV9tlEzONaUCFuDClIPRk6H+McvyGYaGEjHZzE+yUTOI9
   A==;
IronPort-SDR: L7pdeNwDTYbyK/aOPdyBDvdYlst0HNnWNXmI8xJ6oNUCUkXnsReg19D5ukJ2oAf19rLvvYO96o
 IiBImlEkrC3WgsX2J1ufR40aTUVGHIwV0jDMAFi7ff1eW2Z/Unpqi2PVJMv6RNtEFxjHQKwaaP
 LnR0nOvYghDOUyH5Yw4NGca1Z26tSdqFOEXweAM0efK+a0wDwen1fxh/TOIMO91OlImcqUAdcj
 oEH60u1b7vakpBWhwCZAPOJP6waedKzxeBwPfcH4zhU2SNUsw2dYB0yZpjAaQJXZ/HWw4/VlLz
 vcA=
X-IronPort-AV: E=Sophos;i="5.76,359,1592841600"; 
   d="scan'208";a="150304894"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2020 21:50:30 +0800
IronPort-SDR: 6fOHYBZtzH2WC42EWOL3qqcmBdPGJkFdmNEoor+Gpdnej51ISo9+h/D9hGNJBFTPd7bwYVBmHQ
 gGND1Znswh/w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 06:38:02 -0700
IronPort-SDR: 09OnLdp1tSe9GhMerQJBYbslIlTFD2/YYCuexs09hrpgfMXfwhzyRR1PKy9kr56ykL+UwCFgkv
 hzO1nwtsqSqw==
WDCIronportException: Internal
Received: from us23v6sf2.ad.shared (HELO localhost.hgst.com) ([10.86.59.168])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Aug 2020 06:50:26 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     damien.lemoal@wdc.com, johannes.thumshirn@wdc.com,
        Niklas Cassel <niklas.cassel@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] null_blk: add support for max open/active zone limit for zoned devices
Date:   Thu, 27 Aug 2020 15:50:18 +0200
Message-Id: <20200827135018.63644-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for user space to set a max open zone and a max active zone
limit via configfs. By default, the default values are 0 == no limit.

Call the block layer API functions used for exposing the configured
limits to sysfs.

Add accounting in null_blk_zoned so that these new limits are respected.
Performing an operating that would exceed these limits results in a
standard I/O error.

A max open zone limit exists in the ZBC standard.
While null_blk_zoned is used to test the Zoned Block Device model in
Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
mostly follows ZBC.

Therefore, implement the manage open zone resources function from ZBC,
but additionally add support for max active zones.
This enables user space not only to test against a device with an open
zone limit, but also to test against a device with an active zone limit.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
Changes since v1:
-Fixed review comments by Damien Le Moal.

 drivers/block/null_blk.h       |   5 +
 drivers/block/null_blk_main.c  |  16 +-
 drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------
 3 files changed, 282 insertions(+), 58 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index daed4a9c34367..d2e7db43a52a7 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -42,6 +42,9 @@ struct nullb_device {
 	struct badblocks badblocks;
 
 	unsigned int nr_zones;
+	unsigned int nr_zones_imp_open;
+	unsigned int nr_zones_exp_open;
+	unsigned int nr_zones_closed;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
 
@@ -51,6 +54,8 @@ struct nullb_device {
 	unsigned long zone_size; /* zone size in MB if device is zoned */
 	unsigned long zone_capacity; /* zone capacity in MB if device is zoned */
 	unsigned int zone_nr_conv; /* number of conventional zones */
+	unsigned int zone_max_open; /* max number of open zones */
+	unsigned int zone_max_active; /* max number of active zones */
 	unsigned int submit_queues; /* number of submission queues */
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index d74443a9c8fa2..53161a418611b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -208,6 +208,14 @@ static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
 MODULE_PARM_DESC(zone_nr_conv, "Number of conventional zones when block device is zoned. Default: 0");
 
+static unsigned int g_zone_max_open;
+module_param_named(zone_max_open, g_zone_max_open, uint, 0444);
+MODULE_PARM_DESC(zone_max_open, "Maximum number of open zones when block device is zoned. Default: 0 (no limit)");
+
+static unsigned int g_zone_max_active;
+module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
+MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -347,6 +355,8 @@ NULLB_DEVICE_ATTR(zoned, bool, NULL);
 NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
+NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
+NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -464,6 +474,8 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_size,
 	&nullb_device_attr_zone_capacity,
 	&nullb_device_attr_zone_nr_conv,
+	&nullb_device_attr_zone_max_open,
+	&nullb_device_attr_zone_max_active,
 	NULL,
 };
 
@@ -517,7 +529,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
+			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -580,6 +592,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_size = g_zone_size;
 	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
+	dev->zone_max_open = g_zone_max_open;
+	dev->zone_max_active = g_zone_max_active;
 	return dev;
 }
 
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 3d25c9ad23831..e7e341e811fbf 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -51,6 +51,22 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 			dev->zone_nr_conv);
 	}
 
+	/* Max active zones has to be < nbr of seq zones in order to be enforceable */
+	if (dev->zone_max_active >= dev->nr_zones - dev->zone_nr_conv) {
+		dev->zone_max_active = 0;
+		pr_info("zone_max_active limit disabled, limit >= zone count\n");
+	}
+
+	/* Max open zones has to be <= max active zones */
+	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) {
+		dev->zone_max_open = dev->zone_max_active;
+		pr_info("changed the maximum number of open zones to %u\n",
+			dev->nr_zones);
+	} else if (dev->zone_max_open >= dev->nr_zones - dev->zone_nr_conv) {
+		dev->zone_max_open = 0;
+		pr_info("zone_max_open limit disabled, limit >= zone count\n");
+	}
+
 	for (i = 0; i <  dev->zone_nr_conv; i++) {
 		struct blk_zone *zone = &dev->zones[i];
 
@@ -99,6 +115,8 @@ int null_register_zoned_dev(struct nullb *nullb)
 	}
 
 	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
+	blk_queue_max_open_zones(q, dev->zone_max_open);
+	blk_queue_max_active_zones(q, dev->zone_max_active);
 
 	return 0;
 }
@@ -159,6 +177,103 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 	return (zone->wp - sector) << SECTOR_SHIFT;
 }
 
+static blk_status_t null_close_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
+
+	switch (zone->cond) {
+	case BLK_ZONE_COND_CLOSED:
+		/* close operation on closed is not an error */
+		return BLK_STS_OK;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_FULL:
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	if (zone->wp == zone->start) {
+		zone->cond = BLK_ZONE_COND_EMPTY;
+	} else {
+		zone->cond = BLK_ZONE_COND_CLOSED;
+		dev->nr_zones_closed++;
+	}
+
+	return BLK_STS_OK;
+}
+
+static void null_close_first_imp_zone(struct nullb_device *dev)
+{
+	unsigned int i;
+
+	for (i = dev->zone_nr_conv; i < dev->nr_zones; i++) {
+		if (dev->zones[i].cond == BLK_ZONE_COND_IMP_OPEN) {
+			null_close_zone(dev, &dev->zones[i]);
+			return;
+		}
+	}
+}
+
+static bool null_can_set_active(struct nullb_device *dev)
+{
+	if (!dev->zone_max_active)
+		return true;
+
+	return dev->nr_zones_exp_open + dev->nr_zones_imp_open +
+	       dev->nr_zones_closed < dev->zone_max_active;
+}
+
+static bool null_can_open(struct nullb_device *dev)
+{
+	if (!dev->zone_max_open)
+		return true;
+
+	if (dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max_open)
+		return true;
+
+	if (dev->nr_zones_imp_open && null_can_set_active(dev)) {
+		null_close_first_imp_zone(dev);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * This function matches the manage open zone resources function in the ZBC standard,
+ * with the addition of max active zones support (added in the ZNS standard).
+ *
+ * The function determines if a zone can transition to implicit open or explicit open,
+ * while maintaining the max open zone (and max active zone) limit(s). It may close an
+ * implicit open zone in order to make additional zone resources available.
+ *
+ * ZBC states that an implicit open zone shall be closed only if there is not
+ * room within the open limit. However, with the addition of an active limit,
+ * it is not certain that closing an implicit open zone will allow a new zone
+ * to be opened, since we might already be at the active limit capacity.
+ */
+static bool null_manage_zone_resources(struct nullb_device *dev, struct blk_zone *zone)
+{
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EMPTY:
+		if (!null_can_set_active(dev))
+			return false;
+		fallthrough;
+	case BLK_ZONE_COND_CLOSED:
+		return null_can_open(dev);
+	default:
+		/* Should never be called for other states */
+		WARN_ON(1);
+		return false;
+	}
+}
+
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 				    unsigned int nr_sectors, bool append)
 {
@@ -177,43 +292,155 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		/* Cannot write to a full zone */
 		return BLK_STS_IOERR;
 	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_CLOSED:
+		if (!null_manage_zone_resources(dev, zone))
+			return BLK_STS_IOERR;
+		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
+		break;
+	default:
+		/* Invalid zone condition */
+		return BLK_STS_IOERR;
+	}
+
+	/*
+	 * Regular writes must be at the write pointer position.
+	 * Zone append writes are automatically issued at the write
+	 * pointer and the position returned using the request or BIO
+	 * sector.
+	 */
+	if (append) {
+		sector = zone->wp;
+		if (cmd->bio)
+			cmd->bio->bi_iter.bi_sector = sector;
+		else
+			cmd->rq->__sector = sector;
+	} else if (sector != zone->wp) {
+		return BLK_STS_IOERR;
+	}
+
+	if (zone->wp + nr_sectors > zone->start + zone->capacity)
+		return BLK_STS_IOERR;
+
+	if (zone->cond == BLK_ZONE_COND_CLOSED) {
+		dev->nr_zones_closed--;
+		dev->nr_zones_imp_open++;
+	} else if (zone->cond == BLK_ZONE_COND_EMPTY) {
+		dev->nr_zones_imp_open++;
+	}
+	if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
+
+	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
+	if (ret != BLK_STS_OK)
+		return ret;
+
+	zone->wp += nr_sectors;
+	if (zone->wp == zone->start + zone->capacity) {
+		if (zone->cond == BLK_ZONE_COND_EXP_OPEN)
+			dev->nr_zones_exp_open--;
+		else if (zone->cond == BLK_ZONE_COND_IMP_OPEN)
+			dev->nr_zones_imp_open--;
+		zone->cond = BLK_ZONE_COND_FULL;
+	}
+	return BLK_STS_OK;
+}
+
+static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
+
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EXP_OPEN:
+		/* open operation on exp open is not an error */
+		return BLK_STS_OK;
+	case BLK_ZONE_COND_EMPTY:
+		if (!null_manage_zone_resources(dev, zone))
+			return BLK_STS_IOERR;
+		break;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
 	case BLK_ZONE_COND_CLOSED:
-		/*
-		 * Regular writes must be at the write pointer position.
-		 * Zone append writes are automatically issued at the write
-		 * pointer and the position returned using the request or BIO
-		 * sector.
-		 */
-		if (append) {
-			sector = zone->wp;
-			if (cmd->bio)
-				cmd->bio->bi_iter.bi_sector = sector;
-			else
-				cmd->rq->__sector = sector;
-		} else if (sector != zone->wp) {
+		if (!null_manage_zone_resources(dev, zone))
 			return BLK_STS_IOERR;
-		}
+		dev->nr_zones_closed--;
+		break;
+	case BLK_ZONE_COND_FULL:
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	zone->cond = BLK_ZONE_COND_EXP_OPEN;
+	dev->nr_zones_exp_open++;
 
-		if (zone->wp + nr_sectors > zone->start + zone->capacity)
+	return BLK_STS_OK;
+}
+
+static blk_status_t null_finish_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
+
+	switch (zone->cond) {
+	case BLK_ZONE_COND_FULL:
+		/* finish operation on full is not an error */
+		return BLK_STS_OK;
+	case BLK_ZONE_COND_EMPTY:
+		if (!null_manage_zone_resources(dev, zone))
 			return BLK_STS_IOERR;
+		break;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_CLOSED:
+		if (!null_manage_zone_resources(dev, zone))
+			return BLK_STS_IOERR;
+		dev->nr_zones_closed--;
+		break;
+	default:
+		return BLK_STS_IOERR;
+	}
 
-		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
-			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+	zone->cond = BLK_ZONE_COND_FULL;
+	zone->wp = zone->start + zone->len;
 
-		ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
-		if (ret != BLK_STS_OK)
-			return ret;
+	return BLK_STS_OK;
+}
+
+static blk_status_t null_reset_zone(struct nullb_device *dev, struct blk_zone *zone)
+{
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return BLK_STS_IOERR;
 
-		zone->wp += nr_sectors;
-		if (zone->wp == zone->start + zone->capacity)
-			zone->cond = BLK_ZONE_COND_FULL;
+	switch (zone->cond) {
+	case BLK_ZONE_COND_EMPTY:
+		/* reset operation on empty is not an error */
 		return BLK_STS_OK;
+	case BLK_ZONE_COND_IMP_OPEN:
+		dev->nr_zones_imp_open--;
+		break;
+	case BLK_ZONE_COND_EXP_OPEN:
+		dev->nr_zones_exp_open--;
+		break;
+	case BLK_ZONE_COND_CLOSED:
+		dev->nr_zones_closed--;
+		break;
+	case BLK_ZONE_COND_FULL:
+		break;
 	default:
-		/* Invalid zone condition */
 		return BLK_STS_IOERR;
 	}
+
+	zone->cond = BLK_ZONE_COND_EMPTY;
+	zone->wp = zone->start;
+
+	return BLK_STS_OK;
 }
 
 static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
@@ -222,56 +449,34 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zone_no = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zone_no];
+	blk_status_t ret = BLK_STS_OK;
 	size_t i;
 
 	switch (op) {
 	case REQ_OP_ZONE_RESET_ALL:
-		for (i = 0; i < dev->nr_zones; i++) {
-			if (zone[i].type == BLK_ZONE_TYPE_CONVENTIONAL)
-				continue;
-			zone[i].cond = BLK_ZONE_COND_EMPTY;
-			zone[i].wp = zone[i].start;
-		}
+		for (i = dev->zone_nr_conv; i < dev->nr_zones; i++)
+			null_reset_zone(dev, &dev->zones[i]);
 		break;
 	case REQ_OP_ZONE_RESET:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-
-		zone->cond = BLK_ZONE_COND_EMPTY;
-		zone->wp = zone->start;
+		ret = null_reset_zone(dev, zone);
 		break;
 	case REQ_OP_ZONE_OPEN:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			return BLK_STS_IOERR;
-
-		zone->cond = BLK_ZONE_COND_EXP_OPEN;
+		ret = null_open_zone(dev, zone);
 		break;
 	case REQ_OP_ZONE_CLOSE:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			return BLK_STS_IOERR;
-
-		if (zone->wp == zone->start)
-			zone->cond = BLK_ZONE_COND_EMPTY;
-		else
-			zone->cond = BLK_ZONE_COND_CLOSED;
+		ret = null_close_zone(dev, zone);
 		break;
 	case REQ_OP_ZONE_FINISH:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-
-		zone->cond = BLK_ZONE_COND_FULL;
-		zone->wp = zone->start + zone->len;
+		ret = null_finish_zone(dev, zone);
 		break;
 	default:
 		return BLK_STS_NOTSUPP;
 	}
 
-	trace_nullb_zone_op(cmd, zone_no, zone->cond);
-	return BLK_STS_OK;
+	if (ret == BLK_STS_OK)
+		trace_nullb_zone_op(cmd, zone_no, zone->cond);
+
+	return ret;
 }
 
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
-- 
2.26.2

