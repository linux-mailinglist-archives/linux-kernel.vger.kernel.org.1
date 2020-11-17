Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C852B6841
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgKQPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:08:58 -0500
Received: from mail.hallyn.com ([178.63.66.53]:58964 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgKQPI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:08:57 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id D03AC1105; Tue, 17 Nov 2020 09:08:56 -0600 (CST)
Date:   Tue, 17 Nov 2020 09:08:56 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Herv=E9?= Guillemet <herve@guillemet.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
Message-ID: <20201117150856.GA12240@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namespaced file capabilities were introduced in 8db6c34f1dbc .
When userspace reads an xattr for a namespaced capability, a
virtualized representation of it is returned if the caller is
in a user namespace owned by the capability's owning rootid.
The function which performs this virtualization was not hooked
up if CONFIG_SECURITY=n.  Therefore in that case the original
xattr was shown instead of the virtualized one.

To test this using libcap-bin (*1),

$ v=$(mktemp)
$ unshare -Ur setcap cap_sys_admin-eip $v
$ unshare -Ur setcap -v cap_sys_admin-eip $v
/tmp/tmp.lSiIFRvt8Y: OK

"setcap -v" verifies the values instead of setting them, and
will check whether the rootid value is set.  Therefore, with
this bug un-fixed, and with CONFIG_SECURITY=n, setcap -v will
fail:

$ v=$(mktemp)
$ unshare -Ur setcap cap_sys_admin=eip $v
$ unshare -Ur setcap -v cap_sys_admin=eip $v
nsowner[got=1000, want=0],/tmp/tmp.HHDiOOl9fY differs in []

Fix this bug by calling cap_inode_getsecurity() in
security_inode_getsecurity() instead of returning
-EOPNOTSUPP, when CONFIG_SECURITY=n.

*1 - note, if libcap is too old for getcap to have the '-n'
option, then use verify-caps instead.

Signed-off-by: Serge Hallyn <serge@hallyn.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1593431
Cc: Hervé Guillemet <herve@guillemet.org>
Cc: Andrew G. Morgan <morgan@kernel.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index bc2725491560..39642626a707 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -869,7 +869,7 @@ static inline int security_inode_killpriv(struct dentry *dentry)
 
 static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
 {
-	return -EOPNOTSUPP;
+	return cap_inode_getsecurity(inode, name, buffer, alloc);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
-- 
2.25.1

