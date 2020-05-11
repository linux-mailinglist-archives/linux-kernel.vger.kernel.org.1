Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E967C1CE1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgEKRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 13:35:36 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:26398 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbgEKRff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:35:35 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 11 May 2020 10:35:34 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D681E40193;
        Mon, 11 May 2020 10:35:34 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 1/5] objtool: Exit successfully when requesting help
Date:   Mon, 11 May 2020 10:35:09 -0700
Message-ID: <10618c5e40b34a6af62c183feb5cd474c95e06fa.1588888003.git.mhelsley@vmware.com>
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

When the user requests help it's not an error so do not exit with
a non-zero exit code. This is not especially useful for a user but
any script that might wish to check that objtool --help is at least
available can't rely on the exit code to crudely check that, for
example building an objtool executable succeeds.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/objtool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 0b3528f05053..593ec85915a9 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -58,7 +58,10 @@ static void cmd_usage(void)
 
 	printf("\n");
 
-	exit(129);
+	if (!help)
+		exit(129);
+	else
+		exit(0);
 }
 
 static void handle_options(int *argc, const char ***argv)
-- 
2.20.1

