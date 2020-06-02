Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9834C1EC33D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 21:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgFBTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 15:53:14 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:29399 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728433AbgFBTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:53:06 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:11 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6E45140BF1;
        Tue,  2 Jun 2020 12:51:11 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 32/32] objtool: mcount: Rename
Date:   Tue, 2 Jun 2020 12:50:25 -0700
Message-ID: <562751373c9fc71b7173bc5604e0eaa91a4fa106.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've converted recordmcount to a subcommand of objtool
rename the .c file in order to follow the convention of the other
objtool subcmds.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/Build                        | 2 +-
 tools/objtool/{recordmcount.c => mcount.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/objtool/{recordmcount.c => mcount.c} (100%)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index f4f0515d4f91..7815a094c991 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -7,7 +7,7 @@ objtool-$(SUBCMD_CHECK) += special.o
 objtool-$(SUBCMD_ORC) += check.o
 objtool-$(SUBCMD_ORC) += orc_gen.o
 objtool-$(SUBCMD_ORC) += orc_dump.o
-objtool-$(SUBCMD_MCOUNT) += recordmcount.o
+objtool-$(SUBCMD_MCOUNT) += mcount.o
 
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
diff --git a/tools/objtool/recordmcount.c b/tools/objtool/mcount.c
similarity index 100%
rename from tools/objtool/recordmcount.c
rename to tools/objtool/mcount.c
-- 
2.20.1

