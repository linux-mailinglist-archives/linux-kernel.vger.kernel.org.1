Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63629FED9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgJ3Hm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgJ3HlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:05 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B3422447;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043663;
        bh=6ZzWvVhM6TiNtqeTrvq9+vr1edorS5bkenDHNR3lcN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTNO96N+uIkHe3btRL+uh/7J+5Yg+ASWSJWdxJbc5RqgBD88zaAsfGvpoy2o0JsYb
         MvOHy3+EkgSeYOGCyAmenB+T5ptgATmU4qpJxH7siZWCzd7FJlAEhhV/nmIeMD9MrF
         CoE8rC02nsDVyrWKxbzefYueQbCMKCXTWxli8Hkk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004OgQ-Bb; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/39] docs: Kconfig/Makefile: add a check for broken ABI files
Date:   Fri, 30 Oct 2020 08:40:45 +0100
Message-Id: <57a38de85cb4b548857207cf1fc1bf1ee08613c9.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files under Documentation/ABI should follow the syntax
as defined at Documentation/ABI/README.

Allow checking if they're following the syntax by running
the ABI parser script on COMPILE_TEST.

With that, when there's a problem with a file under
Documentation/ABI, it would produce a warning like:

	Warning: file ./Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats#14:
		What '/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor' doesn't have a description
	Warning: file ./Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats#21:
		What '/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal' doesn't have a description

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Kconfig  | 10 ++++++++++
 Documentation/Makefile |  5 +++++
 lib/Kconfig.debug      |  2 ++
 scripts/get_abi.pl     | 14 +++++++++++---
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/Kconfig b/Documentation/Kconfig
index 66046fa1c341..e549a61f4d96 100644
--- a/Documentation/Kconfig
+++ b/Documentation/Kconfig
@@ -10,4 +10,14 @@ config WARN_MISSING_DOCUMENTS
 
 	   If unsure, select 'N'.
 
+config WARN_ABI_ERRORS
+	bool "Warn if there are errors at ABI files"
+	depends on COMPILE_TEST
+	help
+	   The files under Documentation/ABI should follow what's
+	   described at Documentation/ABI/README. Yet, as they're manually
+	   written, it would be possible that some of those files would
+	   have errors that would break them for being parsed by
+	   scripts/get_abi.pl. Add a check to verify them.
 
+	   If unsure, select 'N'.
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 4e47dff8b315..61a7310b49e0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -10,6 +10,11 @@ ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
 $(shell $(srctree)/scripts/documentation-file-ref-check --warn)
 endif
 
+# Check for broken ABI files
+ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
+$(shell $(srctree)/scripts/get_abi.pl validate --dir $(srctree)/Documentation/ABI)
+endif
+
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 537cf3c2937d..60f92c14d496 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2449,4 +2449,6 @@ config HYPERV_TESTING
 
 endmenu # "Kernel Testing and Coverage"
 
+source "Documentation/Kconfig"
+
 endmenu # Kernel hacking
diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index ff4f9f82ecad..f6adf4b38a2b 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -50,7 +50,15 @@ my %symbols;
 sub parse_error($$$$) {
 	my ($file, $ln, $msg, $data) = @_;
 
-	print STDERR "file $file#$ln: $msg at\n\t$data";
+	$data =~ s/\s+$/\n/;
+
+	print STDERR "Warning: file $file#$ln:\n\t$msg";
+
+	if ($data ne "") {
+		print STDERR ". Line\n\t\t$data";
+	} else {
+	    print STDERR "\n";
+	}
 }
 
 #
@@ -110,7 +118,7 @@ sub parse_abi {
 
 			# Invalid, but it is a common mistake
 			if ($new_tag eq "where") {
-				parse_error($file, $ln, "tag 'Where' is invalid. Should be 'What:' instead", $_);
+				parse_error($file, $ln, "tag 'Where' is invalid. Should be 'What:' instead", "");
 				$new_tag = "what";
 			}
 
@@ -225,7 +233,7 @@ sub parse_abi {
 		}
 
 		# Everything else is error
-		parse_error($file, $ln, "Unexpected line:", $_);
+		parse_error($file, $ln, "Unexpected content", $_);
 	}
 	$data{$nametag}->{description} =~ s/^\n+// if ($data{$nametag}->{description});
 	if ($what) {
-- 
2.26.2

