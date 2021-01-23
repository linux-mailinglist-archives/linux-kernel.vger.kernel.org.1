Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3359301870
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 21:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbhAWU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 15:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 15:56:11 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E64C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 12:55:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id f63so6049399pfa.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 12:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EercHppS5zHvJ9u8mw3fHts1+fEonJt2IKsH9vxwzUg=;
        b=l7RvQfcAvkPWnA2EIyfLN7tmz5FA2jDxnOCCFC2126eDKUKMotx3R7zDvP1remC0jK
         DsUKo82DJvLEY8eXb0vsrdqa21x6m5UKNBgGPGs5emZP1xVx33dBUOhiFfP+ms7RSkH+
         61Nq8wekxxM1QtCJ8JxZERDS52zbKhJ6TAVeVG+Y4GWm02xyD1RD/BWX9o0AYZ2o2yci
         tBXbtqsFEDD/iiag++EJGW5PxTY3lFUK5dDSnaLfw1gAi8vDk9iIS+kObLXAzQAXLpKu
         p0aIb0nqVlTWu7t/AF4BIZ5fWCAZuIvXy7X9l0rLZypdB6U2QFLjFyeeJiHGRI+vecgK
         aD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EercHppS5zHvJ9u8mw3fHts1+fEonJt2IKsH9vxwzUg=;
        b=OaTn3qHrbvoeP91AszFsh5OMVODpDGF0T3px2z3k8wuyLWGg/GE5PDQ7whnlR8hkPv
         SXL6x4MQubuLPNVNbNSqg0u7TGuJUZgQZj3j4J+QmyXZVCYhggM/1g8VdIMb5IBS3EPa
         781new4TEtBRYsZKc4rHoW3K5eQ6tFHdO5TKcF4SaybYMONKt43OF9h3unGQeUSqKFAA
         0r7XF8ERsoznq1IIcYvx7nU2D/ScOkcONPfEuUKwlY1Xpb0RvjMcqj1wfgOQvLUMnszY
         tMRMfxGNvzyXKPQkGkYzD0GOOIovey3+yrNA+OhfrmvEi0NWJgpQXeU5OejHzi6JcBt1
         dOJQ==
X-Gm-Message-State: AOAM5321HxmFkgVgp0d4nNJeZygPtXi8fN+vWWfzsLys74UtgW3mBHQz
        0siabl74cicqPQn2NWj93fk=
X-Google-Smtp-Source: ABdhPJy44TayQvk83Yyp/BQjI9bDurKloc2MUThsIj+eYamYA3Uczg1eQ92pu/GXntKGgK70XxH6ZQ==
X-Received: by 2002:a62:3886:0:b029:1b9:4214:68e3 with SMTP id f128-20020a6238860000b02901b9421468e3mr680884pfa.3.1611435330478;
        Sat, 23 Jan 2021 12:55:30 -0800 (PST)
Received: from athina.mtv.corp.google.com ([2620:15c:211:0:d48d:d27:239a:ec22])
        by smtp.gmail.com with ESMTPSA id gx21sm14030815pjb.31.2021.01.23.12.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 12:55:29 -0800 (PST)
From:   =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
To:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] configfs: make directories inherit uid/gid from creator
Date:   Sat, 23 Jan 2021 12:55:16 -0800
Message-Id: <20210123205516.2738060-1-zenczykowski@gmail.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

Currently a non-root process can create directories, but cannot
create stuff in the directories it creates.

Example (before this patch):
  phone:/ $ id
  uid=1000(system) gid=1000(system) groups=1000(system),... context=u:r:su:s0

  phone:/ $ cd /config/usb_gadget/g1/configs/

  phone:/config/usb_gadget/g1/configs $ ls -lZ
  drwxr-xr-x 3 system system u:object_r:configfs:s0  0 2020-12-28 06:03 b.1

  phone:/config/usb_gadget/g1/configs $ mkdir b.2

  phone:/config/usb_gadget/g1/configs $ ls -lZ
  drwxr-xr-x 3 system system u:object_r:configfs:s0  0 2020-12-28 06:03 b.1
  drwxr-xr-x 3 root   root   u:object_r:configfs:s0  0 2020-12-28 06:51 b.2

  phone:/config/usb_gadget/g1/configs $ chown system:system b.2
  chown: 'b.2' to 'system:system': Operation not permitted

  phone:/config/usb_gadget/g1/configs $ ls -lZ b.1
  -rw-r--r-- 1 system system u:object_r:configfs:s0  4096 2020-12-28 05:23 MaxPower
  -rw-r--r-- 1 system system u:object_r:configfs:s0  4096 2020-12-28 05:23 bmAttributes
  lrwxrwxrwx 1 root   root   u:object_r:configfs:s0     0 2020-12-28 05:23 function0 -> ../../../../usb_gadget/g1/functions/ffs.adb
  drwxr-xr-x 2 system system u:object_r:configfs:s0     0 2020-12-28 05:23 strings

  phone:/config/usb_gadget/g1/configs $ ln -s ../../../../usb_gadget/g1/functions/ffs.adb b.2/function0
  ln: cannot create symbolic link from '../../../../usb_gadget/g1/functions/ffs.adb' to 'b.2/function0': Permission denied

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Change-Id: Ia907b2def940197b44aa87b337d37c5dde9c5b91
---
 fs/configfs/dir.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b839dd1b459f..04f18402ef7c 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1410,6 +1410,21 @@ static int configfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	else
 		ret = configfs_attach_item(parent_item, item, dentry, frag);
 
+	/* inherit uid/gid from process creating the directory */
+	if (!uid_eq(current_fsuid(), GLOBAL_ROOT_UID) ||
+	    !gid_eq(current_fsgid(), GLOBAL_ROOT_GID)) {
+		struct inode * inode = d_inode(dentry);
+		struct iattr ia = {
+			.ia_uid = current_fsuid(),
+			.ia_gid = current_fsgid(),
+			.ia_valid = ATTR_UID | ATTR_GID,
+		};
+		inode->i_uid = ia.ia_uid;
+		inode->i_gid = ia.ia_gid;
+		/* (note: the above manual assignments skip the permission checks) */
+		(void)configfs_setattr(dentry, &ia);
+	}
+
 	spin_lock(&configfs_dirent_lock);
 	sd->s_type &= ~CONFIGFS_USET_IN_MKDIR;
 	if (!ret)
-- 
2.30.0.280.ga3ce27912f-goog

