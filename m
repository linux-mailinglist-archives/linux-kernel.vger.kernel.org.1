Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D984323C115
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgHDU6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 16:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgHDU6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE58C22CB3;
        Tue,  4 Aug 2020 20:58:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340k-006HHa-HM; Tue, 04 Aug 2020 16:58:14 -0400
Message-ID: <20200804205814.412245900@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:58:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 17/17] Documentation: bootconfig: Add bootconfig override operator
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a sentence about bootconfig override operator (":=") to
bootconfig.rst.

Link: https://lkml.kernel.org/r/159482884682.126704.7198860675721719878.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index d6b3b77a4129..a22024f9175e 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -71,6 +71,16 @@ For example,::
  foo = bar, baz
  foo = qux  # !ERROR! we can not re-define same key
 
+If you want to update the value, you must use the override operator
+``:=`` explicitly. For example::
+
+ foo = bar, baz
+ foo := qux
+
+then, the ``qux`` is assigned to ``foo`` key. This is useful for
+overriding the default value by adding (partial) custom bootconfigs
+without parsing the default bootconfig.
+
 If you want to append the value to existing key as an array member,
 you can use ``+=`` operator. For example::
 
@@ -84,6 +94,7 @@ For example, following config is NOT allowed.::
 
  foo = value1
  foo.bar = value2 # !ERROR! subkey "bar" and value "value1" can NOT co-exist
+ foo.bar := value2 # !ERROR! even with the override operator, this is NOT allowed.
 
 
 Comments
-- 
2.26.2


