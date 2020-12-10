Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AC62D601A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391349AbgLJPk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391312AbgLJOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:40:30 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e3f23ce40269a4c9053a@syzkaller.appspotmail.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5.9 61/75] gfs2: check for empty rgrp tree in gfs2_ri_update
Date:   Thu, 10 Dec 2020 15:27:26 +0100
Message-Id: <20201210142609.048472872@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210142606.074509102@linuxfoundation.org>
References: <20201210142606.074509102@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

commit 778721510e84209f78e31e2ccb296ae36d623f5e upstream.

If gfs2 tries to mount a (corrupt) file system that has no resource
groups it still tries to set preferences on the first one, which causes
a kernel null pointer dereference. This patch adds a check to function
gfs2_ri_update so this condition is detected and reported back as an
error.

Reported-by: syzbot+e3f23ce40269a4c9053a@syzkaller.appspotmail.com
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/rgrp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -989,6 +989,10 @@ static int gfs2_ri_update(struct gfs2_in
 	if (error < 0)
 		return error;
 
+	if (RB_EMPTY_ROOT(&sdp->sd_rindex_tree)) {
+		fs_err(sdp, "no resource groups found in the file system.\n");
+		return -ENOENT;
+	}
 	set_rgrp_preferences(sdp);
 
 	sdp->sd_rindex_uptodate = 1;


