Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958641CE1D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 19:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgEKRfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 13:35:44 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:26405 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731040AbgEKRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:35:39 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 May 2020 10:35:37 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id C3FE7401CD;
        Mon, 11 May 2020 10:35:37 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 5/5] objtool: Report missing support for subcommands
Date:   Mon, 11 May 2020 10:35:13 -0700
Message-ID: <38a0c7a1ec8d98238379a322866c0432befc259b.1588888003.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1588888003.git.mhelsley@vmware.com>
References: <cover.1588888003.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check and orc-related subcommands for objtool are x86-specific.
To make this clear to anyone using the tool return a non-zero exit
code and indicate in the help and usage output which commands are
(and are not) available.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/Build                   |  1 +
 tools/objtool/arch/missing/check.c    |  4 +++-
 tools/objtool/arch/missing/orc_dump.c |  4 +++-
 tools/objtool/builtin-check.c         |  5 ++++
 tools/objtool/builtin-orc.c           |  7 ++++++
 tools/objtool/builtin.h               |  2 ++
 tools/objtool/check.h                 |  1 +
 tools/objtool/objtool.c               | 34 +++++++++++++++++++++++----
 tools/objtool/orc.h                   |  1 +
 9 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index fb6e6faf6f10..8e5ad5c238ba 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -1,3 +1,4 @@
+objtool-y += arch/missing/
 objtool-y += arch/$(SRCARCH)/
 
 objtool-$(SUBCMD_CHECK) += check.o
diff --git a/tools/objtool/arch/missing/check.c b/tools/objtool/arch/missing/check.c
index 5eac14c8c6a5..7f9deb0451bb 100644
--- a/tools/objtool/arch/missing/check.c
+++ b/tools/objtool/arch/missing/check.c
@@ -8,7 +8,9 @@
 
 const char *objname;
 
-int __attribute__ ((weak)) check(const char *_objname, bool orc)
+int missing_check(const char *_objname, bool orc)
 {
 	return 127;
 }
+
+int __attribute__ ((weak, alias("missing_check"))) check(const char *_objname, bool orc);
diff --git a/tools/objtool/arch/missing/orc_dump.c b/tools/objtool/arch/missing/orc_dump.c
index f7ebb3a2ce9e..45367ddd08a4 100644
--- a/tools/objtool/arch/missing/orc_dump.c
+++ b/tools/objtool/arch/missing/orc_dump.c
@@ -5,7 +5,9 @@
 
 #include "../../orc.h"
 
-int __attribute__ ((weak)) orc_dump(const char *_objname)
+int missing_orc_dump(const char *_objname)
 {
 	return 127;
 }
+
+int __attribute__ ((weak, alias("missing_orc_dump"))) orc_dump(const char *_objname);
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 10fbe75ab43d..7e7ad576ebc0 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -35,6 +35,11 @@ const struct option check_options[] = {
 	OPT_END(),
 };
 
+bool is_cmd_check_available(void)
+{
+	return check != missing_check;
+}
+
 int cmd_check(int argc, const char **argv)
 {
 	const char *objname;
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index e6e54ae4ab75..043b93f68e83 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -23,6 +23,13 @@ static const char *orc_usage[] = {
 	NULL,
 };
 
+bool is_cmd_orc_available(void)
+{
+	if (check == missing_check)
+		return false;
+	return orc_dump != missing_orc_dump;
+}
+
 int cmd_orc(int argc, const char **argv)
 {
 	const char *objname;
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 0b907902ee79..478558d38007 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -10,7 +10,9 @@
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
 
+extern bool is_cmd_check_available(void);
 extern int cmd_check(int argc, const char **argv);
+extern bool is_cmd_orc_available(void);
 extern int cmd_orc(int argc, const char **argv);
 
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 4d34bfc84dc7..c54fb9f5c8e6 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -9,6 +9,7 @@
 #include <stdbool.h>
 #include "objtool.h"
 
+int missing_check(const char *objname, bool orc);
 int check(const char *objname, bool orc);
 
 struct instruction *find_insn(struct objtool_file *file,
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 593ec85915a9..e901c40c76ef 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -27,21 +27,22 @@ struct cmd_struct {
 	const char *name;
 	int (*fn)(int, const char **);
 	const char *help;
+	bool (*is_available)(void);
 };
 
 static const char objtool_usage_string[] =
 	"objtool COMMAND [ARGS]";
 
 static struct cmd_struct objtool_cmds[] = {
-	{"check",	cmd_check,	"Perform stack metadata validation on an object file" },
-	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file" },
+	{"check",	cmd_check,	"Perform stack metadata validation on an object file", is_cmd_check_available },
+	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file", is_cmd_orc_available },
 };
 
 bool help;
 
 static void cmd_usage(void)
 {
-	unsigned int i, longest = 0;
+	unsigned int i, longest = 0, num_unavail = 0;
 
 	printf("\n usage: %s\n\n", objtool_usage_string);
 
@@ -52,8 +53,26 @@ static void cmd_usage(void)
 
 	puts(" Commands:");
 	for (i = 0; i < ARRAY_SIZE(objtool_cmds); i++) {
-		printf("   %-*s   ", longest, objtool_cmds[i].name);
-		puts(objtool_cmds[i].help);
+		struct cmd_struct *p = objtool_cmds+i;
+
+		if (!p->is_available()) {
+			num_unavail++;
+			continue;
+		}
+		printf("   %-*s   ", longest, p->name);
+		puts(p->help);
+	}
+
+	if (num_unavail > 0) {
+		puts("\n Unavailable commands on this architecture:");
+		for (i = 0; i < ARRAY_SIZE(objtool_cmds); i++) {
+			struct cmd_struct *p = objtool_cmds+i;
+
+			if (p->is_available())
+				continue;
+			printf("   %-*s   ", longest, p->name);
+			puts(p->help);
+		}
 	}
 
 	printf("\n");
@@ -96,6 +115,11 @@ static void handle_internal_command(int argc, const char **argv)
 		if (strcmp(p->name, cmd))
 			continue;
 
+		if (!p->is_available()) {
+			fprintf(stderr, "command %s is not available on this architecture\n", cmd);
+			exit(127);
+		}
+
 		ret = p->fn(argc, argv);
 
 		exit(ret);
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
index c67f451d7610..9174356ba0fa 100644
--- a/tools/objtool/orc.h
+++ b/tools/objtool/orc.h
@@ -11,6 +11,7 @@ struct objtool_file;
 int create_orc(struct objtool_file *file);
 int create_orc_sections(struct objtool_file *file);
 
+int missing_orc_dump(const char *objname);
 int orc_dump(const char *objname);
 
 #endif /* _ORC_H */
-- 
2.20.1

