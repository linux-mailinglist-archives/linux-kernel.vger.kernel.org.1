Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21BC2F80BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbhAOQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAOQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:27:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:26:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a12so9846675wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHREG6C5P/XayT82CqAsPtVld3xr9E3ouKBjbBy5N5U=;
        b=GTtpLXxLg7ZP+rWkWH1nnfl757C7Cm4v0/Jt6aV6jvw9XwfZi52A/yeBra3MBCMGuk
         cyMt+90LMpCKvHAfyGiSOZ+QwExsvVzhZwlBdmQalqI/70EHGMuVezc25RIl2scofx5B
         aBmGzJYlQ+d9ER1aRvM8vxhiCXAqN/ghqA6kwl+9eajHuheIM/P9SeNTgWkg8GcYchgN
         98FsGb2NzY2t8CQtEXXBtk70lCy+7TmG8wXOZp/iUkcGLnN1Lymhb3TOSoiokCbopUTX
         LMBAkcQnw6snXQOYX/RD0hCU8RsVl5YkAAHOV9Ekzz1LgyBT0Se+L/QVpt8BHzvzmz5V
         RfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHREG6C5P/XayT82CqAsPtVld3xr9E3ouKBjbBy5N5U=;
        b=Zf6gjpi3ZHULwOgDUKEFFXYb6dpi9+6EngsCNH27GxRCtCe1EodLdn7pUkklcRIzAE
         Ahuk7aB9VZwOVJTTKICH0jxpAKwsDge8OLzVD5xpbrYckMxxdtKS1YZZCPqNXMNq6xnA
         MFZAz2p7QEj6fI0CSCTMcK5JALI7pfi+LC1yWXTGZpLNRNcC+evLT/XWS27D4SWKDtP/
         TKcbV+0si3Tz+85bbU/DKN9d/ZvTps9yQzCKy6l+Asj/h4ZDAv5vQc4Kb2+15WMLJuIN
         khcgAYWpo4Vkh0UoIo0kdNE2fdUrOtfXMG5bqE2rRaO/TVcWl5wEgtn/GL+G0AANL8Vv
         dd9g==
X-Gm-Message-State: AOAM532To2XGGbiOSlQAh5pC5+elQCarRh08XKbdwm1D+xiLDs5uUhH3
        oxfqteS8s2cNULW5JyRnuEssiQ==
X-Google-Smtp-Source: ABdhPJwwmUh8LEZ25b7vcsLVQpggunQJl2xR+DgnmFwAyT195XuhOmnHA6CxELYlWhGFS8FQj2kinA==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr14198635wro.292.1610727996473;
        Fri, 15 Jan 2021 08:26:36 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id v4sm16079764wrw.42.2021.01.15.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 08:26:35 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: debugfs: use controller id instead of link_id
Date:   Fri, 15 Jan 2021 16:25:59 +0000
Message-Id: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

link_id can be zero and if we have multiple controller instances
in a system like Qualcomm debugfs will end-up with duplicate namespace
resulting in incorrect debugfs entries.

Using id should give a unique debugfs directory entry and should fix below
warning too.
"debugfs: Directory 'master-0' with parent 'soundwire' already present!"

Fixes: bf03473d5bcc ("soundwire: add debugfs support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index b6cad0d59b7b..5f9efa42bb25 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -19,7 +19,7 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
 		return;
 
 	/* create the debugfs master-N */
-	snprintf(name, sizeof(name), "master-%d", bus->link_id);
+	snprintf(name, sizeof(name), "master-%d", bus->id);
 	bus->debugfs = debugfs_create_dir(name, sdw_debugfs_root);
 }
 
-- 
2.21.0

