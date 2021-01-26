Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D88304EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405096AbhA0BcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbhAZShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:37:42 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568CC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:35:24 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx1so2758617pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Y7EVk9xYB/OdcSWrB6K91mdtgcHZiUbhRZDgI757no=;
        b=loJlDC4p9JweZZqCuFnQHXvp24/jhCq23uCDUxOfX866ObxCwzlgUnxiTWOj4x1Q6Y
         E0esAO/5WfYT9UHPYjUSaa3nSykMa0kdOuCpV0PttF2GwXDf2DQnWVvZTuDKZ6s7g8Bs
         ARbNqBxGOvVAu3+mv+mOwo3EE6KazgLWARJlCq+QA0zpgCPqF1nJ//VgRJ0zPMVOmwrt
         wCoJ0zF9nzIEa//znUUUPQlQk8yUZSB3RFMzgw0hMIiFyWK5Dr5cXrE7zBxWbobNw+VE
         GP/uBEZqmYuj75hv0sSdfVDtNzOSTPAZS7D40JupQ7X5RXtclA/RYloHcZX+DblAfNsr
         fw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Y7EVk9xYB/OdcSWrB6K91mdtgcHZiUbhRZDgI757no=;
        b=uZTaEcHvw0hVvP1u57l0uCMPK6O9bWVm0cfVpxVgPnLgqjSLIdOO3maLCWen0kB9e2
         9LDUdJZxTGLasn6VOWfTc2lw+Q0rM8Bs80jehggJZxXS+94bVx0upPcZkEBnPT6ryOS2
         mpy8cXi2rJyNTZ6WIahbD8XDAA10MEeeSmeXRNHmToJnSaLR1bB+rtr9bMVtjzmqGQ5E
         O3ZGLCTElb/z4S36ok7dpAGwcyimXCimTILKxQtJEY/UgP3fOJrz6r3+sN7l2PZ6eXE1
         qWX8saUbGMHJXsGMemC/i9v5qSWSaJB5Nk77QmytiItspnfFoeZd9SCk/0zEvRX3kfTm
         w2Yw==
X-Gm-Message-State: AOAM5335b0hULYgYNFseGq2VjSKPVK4TxUKouPNBsg//+A6ta7UQoLjy
        v5Hf5GEwP46dvCF4WJRhrvM=
X-Google-Smtp-Source: ABdhPJw+QQd+ToaoRPeZQLXsE2/9vveXqjDQuQBEb1zUy5nJZF+o5ycl7pZ69Zm9KscNSZLE6q3d8g==
X-Received: by 2002:a17:902:f54e:b029:de:19f9:c45f with SMTP id h14-20020a170902f54eb02900de19f9c45fmr7448437plf.48.1611686124314;
        Tue, 26 Jan 2021 10:35:24 -0800 (PST)
Received: from localhost.localdomain ([49.37.2.129])
        by smtp.gmail.com with ESMTPSA id a31sm19713654pgb.93.2021.01.26.10.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:35:23 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH RFC 1/3] checkpatch: add verbose mode
Date:   Wed, 27 Jan 2021 00:05:19 +0530
Message-Id: <20210126183521.26535-2-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126183521.26535-1-dwaipayanray1@gmail.com>
References: <20210126183521.26535-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new verbose mode to checkpatch.pl to emit additional verbose
test descriptions.

The verbose mode is optional and can be enabled by the flag
--verbose.

The test descriptions are itself loaded from the checkpatch
documentation file at Documentation/dev-tools/checkpatch.rst.
The descriptions in the documentation are in a specified format
enclosed within .. CHECKPATCH_START and .. CHECKPATCH_END labels.

This serves a dual purpose as an external documentation to checkpatch
as well as enables flawless integration of the verbose mode.

A subtle example of the format is as follows:

Documentation/dev-tools/checkpatch.rst:

.. CHECKPATCH_START
TYPE_1

  Description line 1
  Description line 2,
  ...

TYPE_2

  Description line 1,
  etc.

.. CHECKPATCH_END

This file is parsed by checkpatch once the --verbose option
is specified. Verbose descriptions are not output when
the --terse option is specified.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7a323ca8a177..48eeb01074d5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -23,6 +23,8 @@ my $V = '0.32';
 use Getopt::Long qw(:config no_auto_abbrev);
 
 my $quiet = 0;
+my $verbose = 0;
+my %verbose_messages = ();
 my $tree = 1;
 my $chk_signoff = 1;
 my $chk_patch = 1;
@@ -61,6 +63,7 @@ my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $conststructsfile = "$D/const_structs.checkpatch";
+my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
 my $typedefsfile;
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
@@ -78,6 +81,7 @@ Version: $V
 
 Options:
   -q, --quiet                quiet
+  -v, --verbose              verbose mode
   --no-tree                  run without a kernel tree
   --no-signoff               do not check for 'Signed-off-by' line
   --patch                    treat FILE as patchfile (default)
@@ -198,6 +202,49 @@ if (-f $conf) {
 	unshift(@ARGV, @conf_args) if @conf_args;
 }
 
+sub load_docs {
+	open(my $docs, '<', "$docsfile")
+	    or warn "$P: Can't read the documentation file $docsfile $!\n";
+
+	my @lines = ();
+	my $incl = 0;
+	while (<$docs>) {
+		my $line = $_;
+
+		if ($line =~ /\Q.. CHECKPATCH_START\E/) {
+			$incl++;
+			next;
+		} elsif ($line =~ /\Q.. CHECKPATCH_END\E/) {
+			$incl--;
+			next;
+		}
+		next if ($incl < 1);
+
+		$line =~ s/\s*\n?$//g;
+		push (@lines, $line);
+	}
+	close($docs);
+
+	my $linenr = 0;
+	my $cnt = scalar @lines;
+	while ($linenr < $cnt) {
+		while ($linenr < $cnt && $lines[$linenr] !~ /^[^\s]+/) {
+			$linenr++;
+		}
+		last if ($linenr >= $cnt);
+
+		my $message = '';
+		my $type = $lines[$linenr++];
+
+		while ($linenr < $cnt && $lines[$linenr] !~ /^[^\s]+/) {
+			$message .= trim($lines[$linenr++]) . "\n";
+		}
+
+		$message = trim($message);
+		$verbose_messages{$type} = $message;
+	}
+}
+
 # Perl's Getopt::Long allows options to take optional arguments after a space.
 # Prevent --color by itself from consuming other arguments
 foreach (@ARGV) {
@@ -208,6 +255,7 @@ foreach (@ARGV) {
 
 GetOptions(
 	'q|quiet+'	=> \$quiet,
+	'v|verbose!'	=> \$verbose,
 	'tree!'		=> \$tree,
 	'signoff!'	=> \$chk_signoff,
 	'patch!'	=> \$chk_patch,
@@ -249,6 +297,8 @@ help(0) if ($help);
 
 list_types(0) if ($list_types);
 
+load_docs() if ($verbose && !$terse);
+
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
 
@@ -2185,6 +2235,11 @@ sub report {
 		splice(@lines, 1, 1);
 		$output = join("\n", @lines);
 	}
+
+	if ($verbose && !$terse &&
+	    exists $verbose_messages{$type}) {
+		$output .= $verbose_messages{$type} . "\n\n";
+	}
 	$output = (split('\n', $output))[0] . "\n" if ($terse);
 
 	push(our @report, $output);
-- 
2.30.0

