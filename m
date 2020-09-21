Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC58271F23
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIUJo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:32798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgIUJo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:44:56 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D94F21789;
        Mon, 21 Sep 2020 09:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600681496;
        bh=TqO1qs6ahGcj9j2h8tQUCtcOZ16IAV6b4/EB1nVuINU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDHd8VaC+V2Loq1c6ozP9tG9AvU7vLnzDx6/JHXIntEPtJPHelCXhL3HlP7ez/gss
         mZ9yZMfLNCJCPAiLCnZE2GZHIVfT2L3ZO7yJSBi6txMJBn3cZxmhTlZgYlO2fef3VU
         z+cqKI8gAcey7IkYfJkn6xj8YRPleV1FZUjXwRrU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/4] lib/bootconfig: Fix to remove tailing spaces after value
Date:   Mon, 21 Sep 2020 18:44:51 +0900
Message-Id: <160068149134.1088739.8868306567670058853.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160068147328.1088739.7282405187565509762.stgit@devnote2>
References: <160068147328.1088739.7282405187565509762.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to remove tailing spaces after value. If there is a space
after value, the bootconfig failed to remove it because it
applies strim() before replacing the delimiter with null.

For example,

foo = var    # comment

was parsed as below.

foo="var    "

but user will expect

foo="var"

This fixes it by applying strim() after removing the delimiter.

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b44bba0f1583..649ed44f199c 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -494,8 +494,8 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 			break;
 		}
 		if (strchr(",;\n#}", c)) {
-			v = strim(v);
 			*p++ = '\0';
+			v = strim(v);
 			break;
 		}
 	}

