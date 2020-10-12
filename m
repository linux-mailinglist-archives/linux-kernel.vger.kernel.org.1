Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0F28ADDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgJLFt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgJLFt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:49:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B16C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 22:49:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c20so1914047pfr.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNSSFlxS0Jw+cQsOnsPziRX11XM/7DkrUT0mheiLgeg=;
        b=UxO+H5vxXv1UTXIGMrvzkl02w0Yb9KAHirjKDjdQknMbKG6FU+5YpsIBI1L8mr53yV
         M/U0pBQSB6qQeSLE+GndEwyb96NpSd4soS+upP7eNqZ6A3xpaTVDlZC0DxOzNsfSZENT
         p5C4iTZYMqyXbswhyx0bDo2Xw7adm5takwZkveJZjs9cpAqiD01UHaoyQQeBRQfhn1NJ
         BxPy5WDymd0oovB4QiVNYQ7M0yk2Q1caxt9FkulD1VcDGwNpLp75uGSk8udkeK8xY5C8
         aLtHt23bkwjcINHazDK/tjoJEs/RVQR+Feymy2NMTEgnHWy3CVcp9TIwlBM1p8qdOJ/T
         5rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNSSFlxS0Jw+cQsOnsPziRX11XM/7DkrUT0mheiLgeg=;
        b=b3yYKxnlp1uu5qldiYB0fsjrOvoO379kL4OIub5sGH6scrMDvcY4xbCqH9YVuDg1aU
         MaAYUtTjcAut44pzGPKplz1EkEKAJhPvGBQHm19sCNBdePY1D/k4S0TXK+pN/PGAgVXT
         Rd45407xsLsuQwfYVvoDyhtr+e5GEUmoH4EpvFfCdkqEuoj20cOYQy9h3r3fBlxxRDEm
         +7H8k9O4HbbpPq5FLUqLBEdy6c8L/2+SDA/dcCAC/fJtpm6KfwIR7CwrVCGzaaXBjXrb
         4EQJvEx+YjEzSEzYe/+rJzgM6bRljcMrANC87YTRoUIUAQTkArJIQWZh+oKa99lOjBEu
         eU8A==
X-Gm-Message-State: AOAM530l+lUsWAgM863KfJKqqhBDYyv2qbcLToDEeSMo3CFFWZRyMoCS
        1sHk/B+oZVNcR962Id7gN8w=
X-Google-Smtp-Source: ABdhPJxVNBvAUs35rhIwBsJ1BkwyFph/YswmvpDEQ2quvwdYDVU55XDcPtHih9eoLL/wxaU2HtPudw==
X-Received: by 2002:a17:90b:3103:: with SMTP id gc3mr18423521pjb.158.1602481794088;
        Sun, 11 Oct 2020 22:49:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a404:280a:90bd:7a49:dcda:1fb1])
        by smtp.gmail.com with ESMTPSA id ck21sm21759040pjb.56.2020.10.11.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 22:49:52 -0700 (PDT)
From:   Ujjwal Kumar <ujjwalkumar0501@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Subject: [RFC PATCH] checkpatch: add shebang check to EXECUTE_PERMISSIONS
Date:   Mon, 12 Oct 2020 11:19:43 +0530
Message-Id: <20201012054943.1196031-1-ujjwalkumar0501@gmail.com>
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
which is a false-positive.

Adding a shebang check along with current conditions will make
the check more generalised and improve checkpatch reports.
To do so, without breaking the core design decision of checkpatch,
we can fetch the first line from the patch itself and match it for
a shebang pattern.

There can be cases where the first line is not part of the patch.
In that case there may be a false-positive report but in the end we
will have less false-positives as we will be handling some of the
unhandled cases.

Signed-off-by: Ujjwal Kumar <ujjwalkumar0501@gmail.com>
---
Apologies, I forgot to include linux-kernel@vger.kernel.org so I'm
now resending.

 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..e596d30794bf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1795,6 +1795,23 @@ sub get_stat_here {
 	return $herectx;
 }

+sub get_shebang {
+	my ($linenr, $realfile) = @_;
+	my $rawline = "";
+	my $shebang = "";
+
+	$rawline = raw_line($linenr, 3);
+	if (defined $rawline &&
+		$rawline =~ /^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
+		if (defined $1 && $1 == 1) {
+			$shebang = raw_line($linenr, 4);
+			$shebang = substr $shebang, 1;
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
+			my $shebang = get_shebang($linenr, $realfile);
 			if ($realfile !~ m@scripts/@ &&
+			    $shebang !~ /^#!\s*(\/\w)+.*/ &&
 			    $realfile !~ /\.(py|pl|awk|sh)$/) {
 				ERROR("EXECUTE_PERMISSIONS",
 				      "do not set execute permissions for source files\n" . $permhere);

base-commit: d67bc7812221606e1886620a357b13f906814af7
--
2.26.2

