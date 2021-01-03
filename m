Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6292E8E1E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbhACUg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbhACUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:36:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD50C061573
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 12:36:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y17so29390566wrr.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhKo070S3yvS1O4IAxpoIdM4ZCiBBkI7BtlipKFuXsM=;
        b=mlKvaVJ3tTBtrYK8XXhxp//frf9n62e7Yrt3huT+Dx9EbdFyukx66EcRsR9BWObPmc
         IYYlg7bLgqoPj+w84fGiG0E4HngZipOl8GZHsK+XICXMqwdGO72jnP7r6Bba5UT26fFB
         BZr4GuECi8gx6fbDxXmYWuUx9o4gR7nj2K8S90hq981BT+q6LXURN6juFFIVKArhLcen
         zVFL3xoCjHWByDGv/0EALVsPBmKN2AhoEH5XfHPTgK16nBByD/eDV2yrgtlGOi/P/ZDg
         Cvf+8O0z43GTXui+Ez8b48LtbfBhWKXT7dAMTqKbsxHt/xInBs+SJ4cIyaO9/WGD5ONP
         4rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhKo070S3yvS1O4IAxpoIdM4ZCiBBkI7BtlipKFuXsM=;
        b=LbgKtXcbV6PVGGX3ZWtE5VXLKjMAGOgaSPSZVBUf0e6UFnMrVnP0sjSKIbcSg+zXDv
         WEIiIiB8QdSWgJa3arAHeXqBkTDMyI8jx+Bwa8RMIzEImdVdj5FTW1ut0bGa6RwbxETe
         Y/2cHYBvdOW9HUGVfA9nWy4PUc/mGpgG0KRXgbrZabJl2yKaq6iQd0JEsIlD7AKEezrL
         bV2bTq8UGe1di1o+i8CthRxQPGoU9xY+H+NKmzsvVTOC3zIkoMZoWblIZAUSlqo1ysym
         u2qkhkvRQkjVAU7dK046Cb/lZ7WvyH6BaT8NbVRMQeHE9qM1HzRmeO6f9cdIIZpp4uK7
         xl/Q==
X-Gm-Message-State: AOAM53150XQMaX3RdLJAJWpsLxm6Fp2CSgkWubB0nFZPO8+7D6EuEy+q
        3CvgErxRAdtq+fFpnKfbc0ZQueBpR3qE/g==
X-Google-Smtp-Source: ABdhPJwhAuNDGU/9yBLFR/VRElynZKPwZsmnqDLFFCIlCzRjO1L+TbvMOZsGDYcMBoXk2JMdfk9KpA==
X-Received: by 2002:adf:ce82:: with SMTP id r2mr76890574wrn.181.1609706177361;
        Sun, 03 Jan 2021 12:36:17 -0800 (PST)
Received: from localhost.localdomain ([195.213.153.250])
        by smtp.gmail.com with ESMTPSA id m8sm27957526wmc.27.2021.01.03.12.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 12:36:16 -0800 (PST)
From:   Joe Pater <02joepater06@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Joe Pater <02joepater06@gmail.com>
Subject: [PATCH] drivers: base: remove unused function find_bus()
Date:   Sun,  3 Jan 2021 20:32:39 +0000
Message-Id: <20210103203238.111565-1-02joepater06@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_bus() isn't doing anyone any good sitting in a '#if 0' (as it's
been doing since 2006!).

Signed-off-by: Joe Pater <02joepater06@gmail.com>
---
 drivers/base/bus.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index a9c23ecebc7c..b48ad519c34e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -729,23 +729,6 @@ int device_reprobe(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_reprobe);
 
-/**
- * find_bus - locate bus by name.
- * @name: name of bus.
- *
- * Call kset_find_obj() to iterate over list of buses to
- * find a bus by name. Return bus if found.
- *
- * Note that kset_find_obj increments bus' reference count.
- */
-#if 0
-struct bus_type *find_bus(char *name)
-{
-	struct kobject *k = kset_find_obj(bus_kset, name);
-	return k ? to_bus(k) : NULL;
-}
-#endif  /*  0  */
-
 static int bus_add_groups(struct bus_type *bus,
 			  const struct attribute_group **groups)
 {

base-commit: 3516bd729358a2a9b090c1905bd2a3fa926e24c6
prerequisite-patch-id: 87366344c3e939f5a7942e66e16851e56e5cca38
-- 
2.29.2

