Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D02C882B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgK3Ph1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgK3PhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:37:25 -0500
Received: from mail.kernel.org (ip5f5ad5b3.dynamic.kabel-deutschland.de [95.90.213.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC55F2076E;
        Mon, 30 Nov 2020 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750604;
        bh=V3i/kBBknOLk7wkOW3+WAsf7k8n9Au+dQuF5LLUipl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOv68oulKw5ZaRuQ8N5afo6Ubsc9hgvYVr7ETGH6DsQPwlobRmjOkTkqRChR9JJTh
         EMcGWTVjfzO1MLVnaPeFV1lOlhzht0oB5kgQRvRFiKkU0hd4vHjV+DPdq8UbtpcOZv
         C0H4AnVETTetjIYG5KRs8xofzzzSy4KG1JUma4XE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kjlEI-00CjvN-EP; Mon, 30 Nov 2020 16:36:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] scripts: get_feat.pl: use its implementation for list-arch.sh
Date:   Mon, 30 Nov 2020 16:36:32 +0100
Message-Id: <a97f49677805ad4e6b982d02c0db8c9dfbbd20a6.1606748711.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606748711.git.mchehab+huawei@kernel.org>
References: <cover.1606748711.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the same output format as the bash script,
and use its implementation instead of the previous one.

I opted to do such patch in order to have a single script
responsible for parsing Documentation/features and
produce different outputs.

As someone may rely on the past format, which is easy
to parse it, get_feat.pl now gains a new command with
the same output format as the previous script.

As a side effect, the perl script is a lot faster, as it reads
each file only once, instead of parsing files several times
via a for command and grep commands inside it.

This patch also changes the features list order to be
case-insensitive, in order to better match the output of
the existing script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/features/list-arch.sh | 17 +------
 scripts/get_feat.pl                 | 77 ++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
index 1ec47c3bb5fa..e73aa35848f0 100755
--- a/Documentation/features/list-arch.sh
+++ b/Documentation/features/list-arch.sh
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Small script that visualizes the kernel feature support status
 # of an architecture.
@@ -7,18 +8,4 @@
 
 ARCH=${1:-$(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/')}
 
-cd $(dirname $0)
-echo "#"
-echo "# Kernel feature support matrix of the '$ARCH' architecture:"
-echo "#"
-
-for F in */*/arch-support.txt; do
-  SUBSYS=$(echo $F | cut -d/ -f1)
-  N=$(grep -h "^# Feature name:"        $F | cut -c25-)
-  C=$(grep -h "^#         Kconfig:"     $F | cut -c25-)
-  D=$(grep -h "^#         description:" $F | cut -c25-)
-  S=$(grep -hv "^#" $F | grep -w $ARCH | cut -d\| -f3)
-
-  printf "%10s/%-22s:%s| %35s # %s\n" "$SUBSYS" "$N" "$S" "$C" "$D"
-done
-
+$(dirname $0)/../../scripts/get_feat.pl list --arch $ARCH
diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 7b92ebab7ddd..81d1b78d65c9 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -6,13 +6,18 @@ use Pod::Usage;
 use Getopt::Long;
 use File::Find;
 use Fcntl ':mode';
+use Cwd 'abs_path';
 
 my $help;
 my $man;
 my $debug;
 my $arch;
 my $feat;
-my $prefix="Documentation/features";
+
+my $basename = abs_path($0);
+$basename =~ s,/[^/]+$,/,;
+
+my $prefix=$basename . "../Documentation/features";
 
 GetOptions(
 	"debug|d+" => \$debug,
@@ -20,17 +25,19 @@ GetOptions(
 	'help|?' => \$help,
 	'arch=s' => \$arch,
 	'feat=s' => \$feat,
+	'feature=s' => \$feat,
 	man => \$man
 ) or pod2usage(2);
 
 pod2usage(1) if $help;
 pod2usage(-exitstatus => 0, -verbose => 2) if $man;
 
-pod2usage(2) if (scalar @ARGV < 1 || @ARGV > 2);
+pod2usage(1) if (scalar @ARGV < 1 || @ARGV > 2);
 
 my ($cmd, $arg) = @ARGV;
 
-pod2usage(2) if ($cmd ne "current" && $cmd ne "rest" && $cmd ne "validate");
+pod2usage(2) if ($cmd ne "current" && $cmd ne "rest" && $cmd ne "validate"
+		&& $cmd ne "ls" && $cmd ne "list");
 
 require Data::Dumper if ($debug);
 
@@ -213,7 +220,7 @@ sub output_arch_table {
 
 	foreach my $name (sort {
 				($data{$a}->{subsys} cmp $data{$b}->{subsys}) ||
-				($data{$a}->{name} cmp $data{$b}->{name})
+				("\L$a" cmp "\L$b")
 			       } keys %data) {
 		next if ($feat && $name ne $feat);
 
@@ -222,7 +229,7 @@ sub output_arch_table {
 		printf "%-${max_size_name}s  ", $name;
 		printf "%-${max_size_kconfig}s  ", $data{$name}->{kconfig};
 		printf "%-${max_size_status}s  ", $arch_table{$arch};
-		printf "%-${max_size_description}s\n", $data{$name}->{description};
+		printf "%-s\n", $data{$name}->{description};
 	}
 
 	print "=" x $max_size_subsys;
@@ -237,6 +244,31 @@ sub output_arch_table {
 	print "\n";
 }
 
+#
+# list feature(s) for a given architecture
+#
+sub list_arch_features {
+	print "#\n# Kernel feature support matrix of the '$arch' architecture:\n#\n";
+
+	foreach my $name (sort {
+				($data{$a}->{subsys} cmp $data{$b}->{subsys}) ||
+				("\L$a" cmp "\L$b")
+			       } keys %data) {
+		next if ($feat && $name ne $feat);
+
+		my %arch_table = %{$data{$name}->{table}};
+
+		my $status = $arch_table{$arch};
+		$status = " " x ((4 - length($status)) / 2) . $status;
+
+		printf " %${max_size_subsys}s/ ", $data{$name}->{subsys};
+		printf "%-${max_size_name}s: ", $name;
+		printf "%-5s|   ", $status;
+		printf "%${max_size_kconfig}s # ", $data{$name}->{kconfig};
+		printf " %s\n", $data{$name}->{description};
+	}
+}
+
 #
 # Output a feature on all architectures
 #
@@ -337,7 +369,7 @@ sub output_matrix {
 	my $cur_subsys = "";
 	foreach my $name (sort {
 				($data{$a}->{subsys} cmp $data{$b}->{subsys}) or
-				($a cmp $b)
+				("\L$a" cmp "\L$b")
 			       } keys %data) {
 
 		if ($cur_subsys ne $data{$name}->{subsys}) {
@@ -400,6 +432,17 @@ if ($cmd eq "current") {
 	$arch =~s/\s+$//;
 }
 
+if ($cmd eq "ls" or $cmd eq "list") {
+	if (!$arch) {
+		$arch = qx(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/');
+		$arch =~s/\s+$//;
+	}
+
+	list_arch_features;
+
+	exit;
+}
+
 if ($cmd ne "validate") {
 	if ($arch) {
 		output_arch_table;
@@ -418,18 +461,26 @@ get_feat.pl - parse the Linux Feature files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<get_feat.pl> [--debug] [--man] [--help] [--dir=<dir>]
-	       [--arch=<arch>] [--feat=<feature>] <COMAND> [<ARGUMENT>]
+B<get_feat.pl> [--debug] [--man] [--help] [--dir=<dir>] [--arch=<arch>]
+	       [--feature=<feature>|--feat=<feature>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
 =over 8
 
-B<current>               - output features for this machine's architecture
+B<current>               - output table in ReST compatible ASCII format
+			   with features for this machine's architecture
 
-B<rest>                  - output features in ReST markup language
+B<rest>                  - output table(s)  in ReST compatible ASCII format
+			   with features in ReST markup language. The output
+			   is affected by --arch or --feat/--feature flags.
 
-B<validate>              - validate the feature contents
+B<validate>              - validate the contents of the files under
+			   Documentation/features.
+
+B<ls> or B<list>         - list features for this machine's architecture,
+			   using an easier to parse format.
+			   The output is affected by --arch flag.
 
 =back
 
@@ -442,9 +493,9 @@ B<validate>              - validate the feature contents
 Output features for an specific architecture, optionally filtering for
 a single specific feature.
 
-=item B<--feat>
+=item B<--feat> or B<--feature>
 
-Output features for a single specific architecture.
+Output features for a single specific feature.
 
 =item B<--dir>
 
-- 
2.28.0

