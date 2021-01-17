Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9D2F95D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 23:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbhAQWRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 17:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbhAQWRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 17:17:08 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E5C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 14:16:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v67so21315991lfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 14:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEQwHSt5wB+FY+WFucfVyvvqOmezqvFu6e0JdF0f7rc=;
        b=QhTPvho9EhN/5rHBWXQzenGdub9EnpcDaE6RWo4t0LK41xIzVZhRFpwJPcUt9X2fqq
         r5RpK07cl2eXDH6XdsmiuSvPI9b1B/vnCZew3lDSGEfgygbhBHBFwa3LJj9fzgnbQUU0
         Oga24U13FJOHncLCNfQB34RoscPVWOS8LEGcj8ibWQMTdxUMMVbVIj0Z14qgDXjolEcI
         Kv1LomVjVTtd9C9W1nlLL7Y0PZFIAx0nZ37yp+jlSiiOGsSHESBt9gFCkk7Emdf0lrdq
         JTEV90dO6ow3ocYT15rsxK+Y6SXiWldFEjRnMpPyhsiLKBblU+rONNz9zsPwP204cXl3
         2I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEQwHSt5wB+FY+WFucfVyvvqOmezqvFu6e0JdF0f7rc=;
        b=Pf+pi7v4PqpWuIZ459QCJJP+0W9rkmi6ddpHWtXP/wc/2molFdFZNgbsuskGspULPA
         hlt8w9jledAXACT8IqshE8s6TgmiHsFu/uPBV62clE8XxaipC3NM6NFlV/9q2gM+U8HO
         xPvx+OYOCU7TFJxZzgNW3C0GJJY5I5JTkUAw5IIWsK5pDQ6hCzjdH31k3x7V3o1ljxlv
         yVqYbCMMKyxA7RG7mT5Y0jkkviqCabsvz+uop31OxlZ0KtqlaetpiM4ArhEfoHtL85yN
         tlPlZLiHUV4rrtMWhxz9kjOmXu6cFwZhE23GvLEQ2vmwy+kxcYcFfMG5gnzvHwk7EyEe
         fFFg==
X-Gm-Message-State: AOAM531bZiPte0Pv/J3WjMj0a6SFKRwjBrWIcr1pk65g6SaRfulKN+ap
        sXueYs6Ok8R/oxonXdl1TJ8=
X-Google-Smtp-Source: ABdhPJyvz9B2O1hXQosSgiboAyYNtVk1MFwHdbeuvC85sZ1pEGYSwwRJ5W3s0MbOlSySvMjuew+mpQ==
X-Received: by 2002:a19:890b:: with SMTP id l11mr10194400lfd.66.1610921785919;
        Sun, 17 Jan 2021 14:16:25 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id j20sm1510262ljc.47.2021.01.17.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 14:16:25 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH V2] soundwire: sysfs: Constify static struct attribute_group
Date:   Sun, 17 Jan 2021 23:16:22 +0100
Message-Id: <20210117221622.34315-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117220611.30921-1-rikard.falkeborn@gmail.com>
References: <20210117220611.30921-1-rikard.falkeborn@gmail.com>
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
Changes since v 1: Fix spelling in commit message title (sorry for the noise...)

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

