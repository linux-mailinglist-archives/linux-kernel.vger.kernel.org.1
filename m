Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888642E1858
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 06:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgLWFUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 00:20:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727282AbgLWFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 00:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608700753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FLECD3fszJkQ0foq9Jee/a0IqJ4VTmTS/l3JtWjF48=;
        b=eNkefJ911Q4fUFcNcqI+1a5o6/V9cpRLi9s+cx1eE6Rdopfa3GC5ArL20C6hjjp3IAo3na
        j+dLJ26yy1PL5WW2frqb+9DMnpU6sqs8UJQGSL8Yy7Irj7JWN7e7GK3zS2Pj/TVtpXjc4V
        cIUpnu2OKMdRr1JQ8C4aNPnlsQTcoGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Y_oG4oo9O1GqqGNZNmnjhw-1; Wed, 23 Dec 2020 00:19:09 -0500
X-MC-Unique: Y_oG4oo9O1GqqGNZNmnjhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 700571015C82;
        Wed, 23 Dec 2020 05:19:08 +0000 (UTC)
Received: from treble.redhat.com (ovpn-117-91.rdu2.redhat.com [10.10.117.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2D3D19D9C;
        Wed, 23 Dec 2020 05:19:07 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 2/3] objtool: Add 'alt_group' struct
Date:   Tue, 22 Dec 2020 23:18:09 -0600
Message-Id: <f092bae6365f5a4c476b0189b9e3001283117fa2.1608700338.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1608700338.git.jpoimboe@redhat.com>
References: <cover.1608700338.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new struct associated with each group of alternatives
instructions.  This will help with the removal of fake jumps, and more
importantly with adding support for stack layout changes in
alternatives.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 29 +++++++++++++++++++++++------
 tools/objtool/check.h | 13 ++++++++++++-
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..67f39b57c6f7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -984,20 +984,28 @@ static int handle_group_alt(struct objtool_file *file,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
-	unsigned int alt_group = alt_group_next_index++;
+	struct alt_group *orig_alt_group, *new_alt_group;
 	unsigned long dest_off;
 
+
+	orig_alt_group = malloc(sizeof(*orig_alt_group));
+	if (!orig_alt_group) {
+		WARN("malloc failed");
+		return -1;
+	}
 	last_orig_insn = NULL;
 	insn = orig_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = alt_group;
+		insn->alt_group = orig_alt_group;
 		last_orig_insn = insn;
 	}
+	orig_alt_group->orig_group = NULL;
+	orig_alt_group->first_insn = orig_insn;
+	orig_alt_group->last_insn = last_orig_insn;
 
 	if (next_insn_same_sec(file, last_orig_insn)) {
 		fake_jump = malloc(sizeof(*fake_jump));
@@ -1028,8 +1036,13 @@ static int handle_group_alt(struct objtool_file *file,
 		return 0;
 	}
 
+	new_alt_group = malloc(sizeof(*new_alt_group));
+	if (!new_alt_group) {
+		WARN("malloc failed");
+		return -1;
+	}
+
 	last_new_insn = NULL;
-	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		struct reloc *alt_reloc;
@@ -1041,7 +1054,7 @@ static int handle_group_alt(struct objtool_file *file,
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
-		insn->alt_group = alt_group;
+		insn->alt_group = new_alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
@@ -1090,6 +1103,10 @@ static int handle_group_alt(struct objtool_file *file,
 		return -1;
 	}
 
+	new_alt_group->orig_group = orig_alt_group;
+	new_alt_group->first_insn = *new_insn;
+	new_alt_group->last_insn = last_new_insn;
+
 	if (fake_jump)
 		list_add(&fake_jump->list, &last_new_insn->list);
 
@@ -2405,7 +2422,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 static void fill_alternative_cfi(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *first_insn = insn;
-	int alt_group = insn->alt_group;
+	struct alt_group *alt_group = insn->alt_group;
 
 	sec_for_each_insn_continue(file, insn) {
 		if (insn->alt_group != alt_group)
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 4c10916ff1cf..b74c383c2d83 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -19,6 +19,17 @@ struct insn_state {
 	s8 instr;
 };
 
+struct alt_group {
+	/*
+	 * Pointer from a replacement group to the original group.  NULL if it
+	 * *is* the original group.
+	 */
+	struct alt_group *orig_group;
+
+	/* First and last instructions in the group */
+	struct instruction *first_insn, *last_insn;
+};
+
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
@@ -34,7 +45,7 @@ struct instruction {
 	s8 instr;
 	u8 visited;
 	u8 ret_offset;
-	int alt_group;
+	struct alt_group *alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
-- 
2.29.2

