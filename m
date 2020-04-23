Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B771B657B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 22:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDWUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 16:34:36 -0400
Received: from fieldses.org ([173.255.197.46]:60220 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgDWUeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:34:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 308AE1BE2; Thu, 23 Apr 2020 16:34:35 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/2] nfsd4: common stateid-printing code
Date:   Thu, 23 Apr 2020 16:34:32 -0400
Message-Id: <1587674073-9551-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

There's a problem with how I'm formatting stateids.  Before I fix it,
I'd like to move the stateid formatting into a common helper.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e32ecedece0f..7537f2f5156e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2420,6 +2420,11 @@ static void nfs4_show_owner(struct seq_file *s, struct nfs4_stateowner *oo)
 	seq_quote_mem(s, oo->so_owner.data, oo->so_owner.len);
 }
 
+static void nfs4_show_stateid(struct seq_file *s, stateid_t *stid)
+{
+	seq_printf(s, "0x%16phN", stid);
+}
+
 static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 {
 	struct nfs4_ol_stateid *ols;
@@ -2435,7 +2440,9 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	nf = st->sc_file;
 	file = find_any_file(nf);
 
-	seq_printf(s, "- 0x%16phN: { type: open, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: open, ");
 
 	access = bmap_to_share_mode(ols->st_access_bmap);
 	deny   = bmap_to_share_mode(ols->st_deny_bmap);
@@ -2468,7 +2475,9 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	nf = st->sc_file;
 	file = find_any_file(nf);
 
-	seq_printf(s, "- 0x%16phN: { type: lock, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: lock, ");
 
 	/*
 	 * Note: a lock stateid isn't really the same thing as a lock,
@@ -2497,7 +2506,9 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 	nf = st->sc_file;
 	file = nf->fi_deleg_file;
 
-	seq_printf(s, "- 0x%16phN: { type: deleg, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: deleg, ");
 
 	/* Kinda dead code as long as we only support read delegs: */
 	seq_printf(s, "access: %s, ",
@@ -2519,7 +2530,9 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
 	file = ls->ls_file;
 
-	seq_printf(s, "- 0x%16phN: { type: layout, ", &st->sc_stateid);
+	seq_printf(s, "- ");
+	nfs4_show_stateid(s, &st->sc_stateid);
+	seq_printf(s, ": { type: layout, ");
 
 	/* XXX: What else would be useful? */
 
-- 
2.25.3

