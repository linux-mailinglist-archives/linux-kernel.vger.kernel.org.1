Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0F1B8F71
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgDZLaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:30:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E314C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 04:30:12 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n24so5750281plp.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AbWCLOe80NPNu65Z49+UFJ6874bj3AHlyRV8+H/41c8=;
        b=KLokaSMn2GXvBJBDgi761i/7wOWdpCzqM+awFSmMqevuWFaXuUgRlw+SSFSGs/BjHT
         AJkqETJ49Q7HzWdNajIYkaV0ORedi22jFEy3GkT0ZOqlBnHKyeyJn6dTY5Aa4Po5N/+J
         S7YqK6DUou55SQWmx2Db/yADrgaTtCyTa3rDG+RRzMhc66fhqOCgZKzUj8W/BzVlbAHn
         JTdEVXWiwZ2vJDtgjvlGkeLUXR4VR/55/r8HTZKJVq9nx3sNZVTE+hjVt7pPa99dFOWb
         U5St96DnLt6rnU4150yGdmEe/MBIUMMA9ufdsTmco7hTOSwp2ZjghwVzdsB0gv7/jn2D
         FJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AbWCLOe80NPNu65Z49+UFJ6874bj3AHlyRV8+H/41c8=;
        b=lRvYSiATOE+nVoawI96JQGfdJ7BumTf7jFOPYMnBPdcrvVryic0Mi3KXg1iQamlS8H
         ng7wGLwi91QIz0ntLPAUppdHfcBiRq5UUi1PjriwtMuGO4VgwUsxNwd++zCAYUF2g9Is
         wRoh/vfTaiqaGpL+EBDAQNTWIYzMsdL693k91iO2iBRRPQSM1DAMm1gBCpeIKB3/qirt
         2M5WhnkWMZEHJ/IDRGzA8VOCI/E/VNo16f6bzAZB3XiEz79rbsqO2K77fsbhKgGMCLFu
         apty4+0pcF9ogqdDhk1yMU9QrlABuzNBZMTN1WiihJuKYMnEDeQhkjmcvuJOe0nXTDM+
         xTkA==
X-Gm-Message-State: AGi0PuaaeqxBSOyR2OhHk9Eo8nbHFHbYxzuuyanPNFUXSPLt/2xQBypa
        lKKYwRaB8O4KAhnSx+ds4eYY0XA=
X-Google-Smtp-Source: APiQypK95U/MBSpUx4EqnDglJmuYAs3AAeHg8TQN/QISrQNIh6r4TTzmBqa9xnVfSIM19NfJu9Zxow==
X-Received: by 2002:a17:90a:5d02:: with SMTP id s2mr17153242pji.148.1587900611325;
        Sun, 26 Apr 2020 04:30:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:5018:92b5:cd87:e9c9:9a3b:3ddd])
        by smtp.gmail.com with ESMTPSA id p19sm9625492pfn.19.2020.04.26.04.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 04:30:10 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     mporter@kernel.crashing.org, alex.bou9@gmail.com,
        akpm@linux-foundation.org, dan.carpenter@oracle.com,
        hubcap@omnibond.com, tglx@linutronix.de, ira.weiny@intel.com,
        allison@lohutok.net
Cc:     linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] rapidio: Avoid data race between file operation callbacks and mport_cdev_add().
Date:   Sun, 26 Apr 2020 16:59:50 +0530
Message-Id: <20200426112950.1803-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Fields of md(mport_dev) are set after cdev_device_add().
However, the file operation callbacks can be called after
cdev_device_add() and therefore accesses to fields of md in the
callbacks can race with the rest of the mport_cdev_add() function.

One such example is INIT_LIST_HEAD(&md->portwrites) in
mport_cdev_add(), the list is initialised after cdev_device_add().
This can race with list_add_tail(&pw_filter->md_node,&md->portwrites)
in rio_mport_add_pw_filter() which is called by unlocked_ioctl.

To avoid such data races use cdev_device_add() after initializing md.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 8155f59ece38..40296378e5ee 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -2379,13 +2379,6 @@ static struct mport_dev *mport_cdev_add(struct rio_mport *mport)
 	cdev_init(&md->cdev, &mport_fops);
 	md->cdev.owner = THIS_MODULE;
 
-	ret = cdev_device_add(&md->cdev, &md->dev);
-	if (ret) {
-		rmcd_error("Failed to register mport %d (err=%d)",
-		       mport->id, ret);
-		goto err_cdev;
-	}
-
 	INIT_LIST_HEAD(&md->doorbells);
 	spin_lock_init(&md->db_lock);
 	INIT_LIST_HEAD(&md->portwrites);
@@ -2405,6 +2398,13 @@ static struct mport_dev *mport_cdev_add(struct rio_mport *mport)
 #else
 	md->properties.transfer_mode |= RIO_TRANSFER_MODE_TRANSFER;
 #endif
+
+	ret = cdev_device_add(&md->cdev, &md->dev);
+	if (ret) {
+		rmcd_error("Failed to register mport %d (err=%d)",
+		       mport->id, ret);
+		goto err_cdev;
+	}
 	ret = rio_query_mport(mport, &attr);
 	if (!ret) {
 		md->properties.flags = attr.flags;
-- 
2.17.1

