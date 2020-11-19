Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A72A2B96D5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgKSPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:48:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:52700 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgKSPsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:48:52 -0500
IronPort-SDR: DESW6EuCMi0qi3LgtR3KJBXlqnU1VIRBQvn6ZwCMUYsgrN4PRLIk+E+u8PG2IPW84qOWEJpzir
 6Ib1tio/nZGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="168735896"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="168735896"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:48:52 -0800
IronPort-SDR: 7nyJA55w6VuCGIhdXrOWeTOsyorzZkAKSMwBzgtUfEPEOZwDmspLMi05fvJnwDG1WU28n/4ECb
 pU6P+E54kgOA==
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="326012096"
Received: from johnsa1-desk.jf.intel.com ([10.54.75.131])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:48:51 -0800
Date:   Thu, 19 Nov 2020 07:52:17 -0800
From:   "Andersen, John" <john.s.andersen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: [RFC] checkpatch.pl Is "does MAINTAINERS need updating" check broken?
Message-ID: <20201119155217.GA631033@johnsa1-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed that patches which have "added, moved or deleted file(s)" and
updated MAINTAINERS still trigger the following warning:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?


Here's two examples using existing patches

$ git show --format=email a7305e684fcfb33029fe3d0af6b7d8dc4c8ca7a1 | ./scripts/checkpatch.pl
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#103:
rename from drivers/power/avs/qcom-cpr.c

total: 0 errors, 1 warnings, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] PM: AVS: qcom-cpr: Move the driver to the qcom specific" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

$ git show --format=email bca815d620544c27288abf4841e39922d694425c | ./scripts/checkpatch.pl
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#89:
rename from drivers/power/avs/smartreflex.c

total: 0 errors, 1 warnings, 44 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] PM: AVS: smartreflex Move driver to soc specific drivers" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


After applying the patch below it seems that checkpatch now picks up the change
to MAINTAINERS correctly.


$ git show --format=email a7305e684fcfb33029fe3d0af6b7d8dc4c8ca7a1 | ./scripts/checkpatch.pl
total: 0 errors, 0 warnings, 39 lines checked

"[PATCH] PM: AVS: qcom-cpr: Move the driver to the qcom specific" has no obvious style problems and is ready for submission.

$ git show --format=email bca815d620544c27288abf4841e39922d694425c | ./scripts/checkpatch.pl
total: 0 errors, 0 warnings, 44 lines checked

"[PATCH] PM: AVS: smartreflex Move driver to soc specific drivers" has no obvious style problems and is ready for submission.


I am not sure if this is a "doesn't work on my machine" situation or if there is
really an issue here. Please let me know your thoughts.

I didn't do much digging into this but found that simply changing the regex
wasn't enough. I had to put a separate loop above the main loop. I've never
touched pearl so that's they this is such a dumb fix.

Thanks,
John


diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..74e27cd64c58 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2510,6 +2510,14 @@ sub process {
 
 	$prefix = '';
 
+# Check if MAINTAINERS is being updated.  If so, there's probably no need to
+# emit the "does MAINTAINERS need updating?" message on file add/move/delete
+	foreach my $line (@lines) {
+		if ($line =~ /\+\+\+ b\/MAINTAINERS$/) {
+			$reported_maintainer_file = 1;
+		}
+	}
+
 	$realcnt = 0;
 	$linenr = 0;
 	$fixlinenr = -1;
@@ -2744,12 +2752,6 @@ sub process {
 			$in_commit_log = 0;
 		}
 
-# Check if MAINTAINERS is being updated.  If so, there's probably no need to
-# emit the "does MAINTAINERS need updating?" message on file add/move/delete
-		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
-			$reported_maintainer_file = 1;
-		}
-
 # Check signature styles
 		if (!$in_header_lines &&
 		    $line =~ /^(\s*)([a-z0-9_-]+by:|$signature_tags)(\s*)(.*)/i) {
