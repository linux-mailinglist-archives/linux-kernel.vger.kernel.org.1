Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E451DA320
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgESUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:55:58 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4149 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725998AbgESUz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:55:56 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 May 2020 13:55:53 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 32BC4404B7;
        Tue, 19 May 2020 13:55:55 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH 1/3] objtool: Exit successfully when requesting help
Date:   Tue, 19 May 2020 13:55:31 -0700
Message-ID: <26346796590ccf07ffe7b9d2b230435c9e787357.1589913349.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589913349.git.mhelsley@vmware.com>
References: <cover.1589913349.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user requests help it's not an error so do not exit with
a non-zero exit code. This is not especially useful for a user but
any script that might wish to check that objtool --help is at least
available can't rely on the exit code to crudely check that, for
example, building an objtool executable succeeds.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/objtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 0b3528f05053..58fdda510653 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -58,7 +58,9 @@ static void cmd_usage(void)
 
 	printf("\n");
 
-	exit(129);
+	if (!help)
+		exit(129);
+	exit(0);
 }
 
 static void handle_options(int *argc, const char ***argv)
-- 
2.20.1

