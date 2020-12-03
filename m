Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8472CD840
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgLCNxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgLCNxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:53:08 -0500
From:   Jessica Yu <jeyu@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, systemd-devel@lists.freedesktop.org
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Franck Bui <fbui@suse.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH RFC 1/1] module: delay kobject uevent until after module init call
Date:   Thu,  3 Dec 2020 14:51:24 +0100
Message-Id: <20201203135124.16695-2-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201203135124.16695-1-jeyu@kernel.org>
References: <20201203135124.16695-1-jeyu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently there has been a longstanding race between udev/systemd and
the module loader. Currently, the module loader sends a uevent right
after sysfs initialization, but before the module calls its init
function. However, some udev rules expect that the module has
initialized already upon receiving the uevent.

This race has been triggered recently (see link in references) in some
systemd mount unit files. For instance, the configfs module creates the
/sys/kernel/config mount point in its init function, however the module
loader issues the uevent before this happens. sys-kernel-config.mount
expects to be able to mount /sys/kernel/config upon receipt of the
module loading uevent, but if the configfs module has not called its
init function yet, then this directory will not exist and the mount unit
fails. A similar situation exists for sys-fs-fuse-connections.mount, as
the fuse sysfs mount point is created during the fuse module's init
function. If udev is faster than module initialization then the mount
unit would fail in a similar fashion.

To fix this race, delay the module KOBJ_ADD uevent until after the
module has finished calling its init routine.

References: https://github.com/systemd/systemd/issues/17586
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index a40ec708f8f2..e1dd0df57244 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1897,7 +1897,6 @@ static int mod_sysfs_init(struct module *mod)
 	if (err)
 		mod_kobject_put(mod);
 
-	/* delay uevent until full sysfs population */
 out:
 	return err;
 }
@@ -1934,7 +1933,6 @@ static int mod_sysfs_setup(struct module *mod,
 	add_sect_attrs(mod, info);
 	add_notes_attrs(mod, info);
 
-	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
 	return 0;
 
 out_unreg_modinfo_attrs:
@@ -3656,6 +3654,9 @@ static noinline int do_init_module(struct module *mod)
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_LIVE, mod);
 
+	/* Delay uevent until module has finished its init routine */
+	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
+
 	/*
 	 * We need to finish all async code before the module init sequence
 	 * is done.  This has potential to deadlock.  For example, a newly
-- 
2.16.4

