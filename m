Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F521B6579
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 22:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDWUeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 16:34:37 -0400
Received: from fieldses.org ([173.255.197.46]:60222 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgDWUeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:34:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 38EE014DC; Thu, 23 Apr 2020 16:34:35 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/2] nfsd4: stid display should preserve on-the-wire byte order
Date:   Thu, 23 Apr 2020 16:34:33 -0400
Message-Id: <1587674073-9551-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587674073-9551-1-git-send-email-bfields@redhat.com>
References: <1587674073-9551-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

When we decode the stateid we byte-swap si_generation.

But for simplicity's sake and ease of comparison with network traces,
it's better to display the whole thing in network order.

Reported-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7537f2f5156e..a6e0a7f77eb0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2422,7 +2422,8 @@ static void nfs4_show_owner(struct seq_file *s, struct nfs4_stateowner *oo)
 
 static void nfs4_show_stateid(struct seq_file *s, stateid_t *stid)
 {
-	seq_printf(s, "0x%16phN", stid);
+	seq_printf(s, "0x%.8x", stid->si_generation);
+	seq_printf(s, "%12phN", &stid->si_opaque);
 }
 
 static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
-- 
2.25.3

