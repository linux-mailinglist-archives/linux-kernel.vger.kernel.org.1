Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB626A041
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIOHzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgIOHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600156418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xaVYOONGn86Op+Uk66CUX8g6kureEuzSw+KqiLGosLM=;
        b=WI1yERLNRPpiIajyRwVdksoySWY7EdbLkbCC8PTbN8MVeOkeVkLVJ5rRKedg2WdaNZNJcD
        kEKMr7PpwjH4QMPWylAVzh+IsiIQ5ouzMLHLB0bfgxFaCQ4HKGwELBEXdmMO87M375j6Ul
        LMWwUIPqw6dG8fGQV0DkYNKZju9tLRs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-aL45qYZfPAONyaqeuN2Y3g-1; Tue, 15 Sep 2020 03:53:36 -0400
X-MC-Unique: aL45qYZfPAONyaqeuN2Y3g-1
Received: by mail-wm1-f70.google.com with SMTP id s19so870658wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaVYOONGn86Op+Uk66CUX8g6kureEuzSw+KqiLGosLM=;
        b=m6jPoTan++IC+zW8OZn5mPBSm+C0ksJkt0GsEqEqntoZByeRl+yXIoX6WRoA1MEtkY
         slRwSvYBgZY8SGUYrabYu1WbSNOq8WmczQCIHGuohgP2KNkbuZouw8c1EYr5Y26Wt03o
         1RLpa0xIy7P7+eetigYVrta4Q9cksoNgMLTn673shbzxEJqrANYLGruwiZJ6ZwEoEE+C
         RxNg1sHEb1xfIAalnYbXE12DrK74q1cO42AW203xO9IS+zABSrbkz4ePkarYW7e84RJj
         1mfvUxB91bEIMNI49Stb/M9WHKZs2+TZhIENgt/JqzaWdMfXB+PP6C4KRYnqSkIh8yhq
         +gwg==
X-Gm-Message-State: AOAM530U+X3xwVVD5aoJtFe+ZzWWuw7VUM0dkj9z7ebXSDJa9LcpNzP/
        DZ9IuyrvVhdyrHEqIJDQ534Mn8b0GqvksoV6Fl4IyzWKl5r15KXqftHJdB0IXrXGujrmNrDpSHm
        aJ6HyJFhopuQ77tbQipwvKhjL
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr3229486wmb.71.1600156414950;
        Tue, 15 Sep 2020 00:53:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6lcuxkFPATJ4JINqyvYrFZYmYOA0QcZx2HAnsXDkbY/1WlvX6DbC9eNph1YGUA6efv1NcRw==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr3229474wmb.71.1600156414785;
        Tue, 15 Sep 2020 00:53:34 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id t16sm25301572wrm.57.2020.09.15.00.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:53:34 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 3/3] objtool: check: Handle calling non-function symbols in other sections
Date:   Tue, 15 Sep 2020 08:53:18 +0100
Message-Id: <20200915075318.7336-4-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915075318.7336-1-jthierry@redhat.com>
References: <20200915075318.7336-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocation for a call destination could point to a symbol that has
type STT_NOTYPE.

Lookup such a symbol when no function is available.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cd7c6698d316..500f63b3dcff 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -815,6 +815,17 @@ static void remove_insn_ops(struct instruction *insn)
 	}
 }
 
+static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
+{
+	struct symbol *call_dest;
+
+	call_dest = find_func_by_offset(sec, offset);
+	if (!call_dest)
+		call_dest = find_symbol_by_offset(sec, offset);
+
+	return call_dest;
+}
+
 /*
  * Find the destination instructions for all calls.
  */
@@ -832,9 +843,7 @@ static int add_call_destinations(struct objtool_file *file)
 					       insn->offset, insn->len);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
-			if (!insn->call_dest)
-				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
+			insn->call_dest = find_call_destination(insn->sec, dest_off);
 
 			if (insn->ignore)
 				continue;
@@ -852,8 +861,9 @@ static int add_call_destinations(struct objtool_file *file)
 
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-			insn->call_dest = find_func_by_offset(reloc->sym->sec,
-							      dest_off);
+			insn->call_dest = find_call_destination(reloc->sym->sec,
+								dest_off);
+
 			if (!insn->call_dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
-- 
2.21.3

