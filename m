Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A271D28CDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgJMMC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgJMMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:02:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D69C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:02:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g16so586728pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EojIG9gMRrD09GYxDSxcMWENzlGRCeBng0hCNmqUT0=;
        b=ZYyl5we4afO+NSu2i1cSmMcG2RkdqSys1eDO1I3BTbzJue7bBgVvyj/CCWgR1U2uWq
         lxYYf/Qfw5F1qENOeuyPq1yG9rfXs6GWECXcDp5DbIjKVAlJCztu6ngdBEF6WX7b3DUc
         ALWDYP6sVAQ6b61grY1danDR5OEiNJeoqFa8elJcHS9iBVeItPmFZZO7oHxwE8feuUlE
         NpVEGZqXnuQifbJvcwAshQAnY6NIvrsGAIZMzbeFZeNWmeo0+dEHaKElpyrlECGNPuTX
         gtAGO75bpqZReL+v5CMBTL3CWNdPiImBk2g/5PI4ziWjSkpU6IBrSXEKKlRXaEKwgSL2
         k/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EojIG9gMRrD09GYxDSxcMWENzlGRCeBng0hCNmqUT0=;
        b=i4KOLhZPjsJIvJvVf5lNFHF6pkxru60DjarUHFr4uaiGQq+aQX6+WymVCQCIZUYC2y
         3EitGHv+vQD42Sfd4Z/7XH306HZqXn7VI1BSpdq+rgeZQCwxKiO0Bqr+DnE4GgvYJjUo
         u0X6pc86d781oQB3pYuj4NahuMiPPltJh5NOb0wCW2mMPufYa0bjOXTPuJTl2E60wyJd
         uiNquNQFtOTy5gGV0m4Q0OU7xaglZWiJYCLmqBwR2i0vNz/4j9NVbEmxw1fJU4pQHXpQ
         je4DDtgt5pnQB4QN54xzdAlsRULvAO03GxctjzCUhaGizD3bXe3bpXDoVlyC/ANbDRaw
         I96g==
X-Gm-Message-State: AOAM533C1K0yThowWA0I55yPrX24qMH6K0gdSG0aLiFFR2w6R/dhbN4r
        UW6pu81ix2rAuuqiIpaH5BQ=
X-Google-Smtp-Source: ABdhPJz3XuxodNTHuko3fm97FIbgyRnO0U0lueAT9LunyZLDwi5sNv7q0svOGJavAWwTX5GUPZ+7fg==
X-Received: by 2002:a17:90a:73cb:: with SMTP id n11mr12200354pjk.213.1602590576411;
        Tue, 13 Oct 2020 05:02:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a404:280a:90bd:7a49:dcda:1fb1])
        by smtp.gmail.com with ESMTPSA id y4sm7176074pgs.0.2020.10.13.05.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 05:02:55 -0700 (PDT)
From:   Ujjwal Kumar <ujjwalkumar0501@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Subject: [RFC PATCH v2] checkpatch: add shebang check to EXECUTE_PERMISSIONS
Date:   Tue, 13 Oct 2020 17:31:30 +0530
Message-Id: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
files. The script leverages filename extensions and its path in
the repository to decide whether to allow execute permissions on
the file or not.

Based on current check conditions, a perl script file having
execute permissions, without '.pl' extension in its filename
and not belonging to 'scripts/' directory is reported as ERROR
which is a false positive.

Adding a shebang check along with current conditions will make
the check more generalised and improve checkpatch reports.
To do so, without breaking the core design decision of checkpatch,
we can fetch the first line from the patch itself and match it for
a shebang pattern.

There can be cases where the first line is not part of the patch.
For instance: a patch that only changes permissions without
changing any of the file content.
In that case there may be a false positive report but in the end we
will have less false positives as we will be handling some of the
unhandled cases.

Signed-off-by: Ujjwal Kumar <ujjwalkumar0501@gmail.com>
---
Changes in v2:
  - Spelling correction and add example to commit
    message
  - Code style changes
  - Remove unncessary function argument
  - Use non-capturing group in regexp

 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..7ebbee9c3672 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1795,6 +1795,23 @@ sub get_stat_here {
 	return $herectx;
 }

+sub get_shebang {
+	my ($linenr) = @_;
+	my $rawline = "";
+	my $shebang = "";
+
+	$rawline = raw_line($linenr, 3);
+	if (defined($rawline) &&
+	    $rawline =~ /^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
+		if (defined($1) && $1 == 1) {
+			$shebang = raw_line($linenr, 4);
+			$shebang = substr($shebang, 1);
+		}
+	}
+
+	return $shebang;
+}
+
 sub cat_vet {
 	my ($vet) = @_;
 	my ($res, $coded);
@@ -2680,7 +2697,9 @@ sub process {
 # Check for incorrect file permissions
 		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
 			my $permhere = $here . "FILE: $realfile\n";
+			my $shebang = get_shebang($linenr);
 			if ($realfile !~ m@scripts/@ &&
+			    $shebang !~ /^#!\s*(?:\/\w)+.*/ &&
 			    $realfile !~ /\.(py|pl|awk|sh)$/) {
 				ERROR("EXECUTE_PERMISSIONS",
 				      "do not set execute permissions for source files\n" . $permhere);

base-commit: 148fdf990dee4efd23c1114811b205de9c966680
--
2.26.2

