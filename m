Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933AE211689
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 01:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGAXR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 19:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgGAXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:17:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D00208C7;
        Wed,  1 Jul 2020 23:17:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jqlzH-0048yY-Ve; Wed, 01 Jul 2020 19:17:55 -0400
Message-ID: <20200701231755.857125951@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 19:17:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 2/8] ktest.pl: Always show log file location if defined even on success
References: <20200701231717.757834010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a log file is defined and the test were to error, a print statement is
made that shows the user where the log file is to examine it further. But
this is not done if the test were to succeed.

I find it annoying that it does not show where the log file is on success,
as I run several different tests that place their log files in various
locations, and even though the test pass, there's things I want to look at
in the log file (like warnings). It is much easier to find where the log
file is, if it is displayed at the end of a test.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 5f6f88911f5c..5d5cf3e1e81a 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4441,6 +4441,10 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 }
 
 
+if (defined($opt{"LOG_FILE"})) {
+    print "\n See $opt{LOG_FILE} for the record of results.\n";
+}
+
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
-- 
2.26.2


