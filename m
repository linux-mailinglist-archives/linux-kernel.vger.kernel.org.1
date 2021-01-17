Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA12F95BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 23:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbhAQWHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 17:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbhAQWG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 17:06:58 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5867C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 14:06:17 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so16220110ljo.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sk03eSAe1i1kiZvLpOKZi/f9KCnWeoSdMZIHeuRne8o=;
        b=BEcTSurdW1C9IcPJmU/H4Yyd8N0FyjZsyy++4GyY6yl9Qdmqc9fD0XuYgtdcCPZZ+k
         106b++bz6AV+mzCIKhFfER6CUpYTh+7FuZQgIWvaEhnZlXZiXHftlu6iyK5Zj4+650ci
         FuWFpKd4Skn/E0lK+4wQjuWK/dJNgoXG5mq9mDKGM7kIueJeDYhuAV70Wx5s8vGx+Yru
         v17WYvGYi8HHjNV1bN21dMBX+SE+l5SD5ka546kbMsIWA9t3d272jYwxcKGeUoJ3IP1J
         TrlWQC4UNWWD8fXVygqbfBlgb/Z3cfrovX+l9F7/lmx3Oiz0wYi5yUeSswaNR0I7IkOc
         +CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sk03eSAe1i1kiZvLpOKZi/f9KCnWeoSdMZIHeuRne8o=;
        b=rZ4i80jvRBMRN4FvJRThps0wR05yXi8ByXIks7ctoO2WgGLYPvdQadkFFAlvMD1Vyh
         bq9+El6byN/RmLu5b+DyQIQyWKrONyVutgzHMxXtNapyWZGURrd/uek8AEZUnWgwIZRS
         UsUvr1hxx2ElT9AOjBj/S1Cv1AnN1gSbzb6XxQzwbT3vIjms0+UK9Sepz2+xc/AgtRYi
         zLpcG/GqWGhTARFnLwUZOjcDw1tCliPHsP4LHA+VzRh3fj89xun+8DsNh34tR5eViC+n
         pLsJBK/iwNtyVGGrsMjNdhZ3BwCeaxQxlmDFab/8WpKNpXwFAk9go/EQQqQmZGt59jiS
         ZvoQ==
X-Gm-Message-State: AOAM531Asn9selSSvx8yEbwFv1Cv/xemdH+y1AsFY7mSQUphfsbnunEH
        9XY0qu+py78gRuggXT3FicaO8UNOnz3DgA==
X-Google-Smtp-Source: ABdhPJxolJh0Z5JiF5XnwRcEQtK7maKetm1vKt92O8mYmYp6DZA/emjaKA/NuUfE4qUgLFTX7n0gKQ==
X-Received: by 2002:a2e:9ad3:: with SMTP id p19mr9246210ljj.286.1610921176342;
        Sun, 17 Jan 2021 14:06:16 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id b141sm1684647lfd.148.2021.01.17.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 14:06:15 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] soundwire: sysfs: Constiyf static struct attribute_group
Date:   Sun, 17 Jan 2021 23:06:11 +0100
Message-Id: <20210117220611.30921-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only place sdw_slave_dev_attr_group is used is when its address is
passed to devm_device_add_group() which takes a pointer to const struct
attribute_group. Make it const to allow the compiler to put it in
read-only memory. This makes all attribute_group structs in the file
const. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/soundwire/sysfs_slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index b48b6617a396..3210359cd944 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -130,7 +130,7 @@ static struct attribute *slave_dev_attrs[] = {
  * we don't use ATTRIBUTES_GROUP here since we want to add a subdirectory
  * for device-level properties
  */
-static struct attribute_group sdw_slave_dev_attr_group = {
+static const struct attribute_group sdw_slave_dev_attr_group = {
 	.attrs	= slave_dev_attrs,
 	.name = "dev-properties",
 };
-- 
2.30.0

