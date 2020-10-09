Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30427288961
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbgJIMz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbgJIMzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:55:25 -0400
Received: from mail.kernel.org (unknown [95.90.213.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8E6222BA;
        Fri,  9 Oct 2020 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602248124;
        bh=qfJg059R+ulFXS2MriZQjy1jkWjepa6QmsXYhZ2egvc=;
        h=From:To:Cc:Subject:Date:From;
        b=BK8XHONMdI5ZjBzCvZJ38g0z43/WAYiR1yZghmghPBIWE9/IjY9cA+Pk6qailuzIJ
         Fmsu9Zcj/9LYAWszg+gbaHd9tu3gGwmO51iFYfhRJAdjkQQmdxM13Z4Sme7EW6Wj94
         iXSYL5CsQtll0gBpDR3+ldmyseCqWSORHoDPaE5U=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kQrve-003m4S-Ga; Fri, 09 Oct 2020 14:55:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] scripts: kernel-doc: allow printing the documented symbols
Date:   Fri,  9 Oct 2020 14:55:18 +0200
Message-Id: <179c640b7d54512742c9864f0ed364bb7599e1e0.1602247918.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to know what symbols are documented, as
scripts could use this in order to check for documentation
issues. This comes almost for free from kernel-doc parsing.

So, add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

While checking what's documented on some media files, I found
the lack of a feature that would report it on an easy way.

Well, it turns that it is very easy to make kernel-doc report it.
With that, it is easy to check, for example, what are the external
symbols that are documented with:

$ ./scripts/kernel-doc --export --symbols drivers/media/dvb-core/dvb_ca_en50221.c
dvb_ca_en50221_camchange_irq()
dvb_ca_en50221_camready_irq()
dvb_ca_en50221_frda_irq()
dvb_ca_en50221_init()
dvb_ca_en50221_release()

And the internal ones with:

$ ./scripts/kernel-doc --internal --symbols drivers/media/dvb-core/dvb_ca_en50221.c
findstr()
dvb_ca_en50221_wait_if_status()
dvb_ca_en50221_link_init()
dvb_ca_en50221_read_tuple()
dvb_ca_en50221_parse_attributes()
dvb_ca_en50221_set_configoption()
dvb_ca_en50221_read_data()
dvb_ca_en50221_write_data()
dvb_ca_en50221_slot_shutdown()
dvb_ca_en50221_thread_wakeup()
dvb_ca_en50221_thread_update_delay()
dvb_ca_en50221_poll_cam_gone()
dvb_ca_en50221_thread_state_machine()
dvb_ca_en50221_io_do_ioctl()
dvb_ca_en50221_io_ioctl()
dvb_ca_en50221_io_write()
dvb_ca_en50221_io_read()
dvb_ca_en50221_io_open()
dvb_ca_en50221_io_release()
dvb_ca_en50221_io_poll()


 scripts/kernel-doc | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 297312824d26..9168a783efd1 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -55,6 +55,7 @@ Output format selection (mutually exclusive):
   -man			Output troff manual page format. This is the default.
   -rst			Output reStructuredText format.
   -none			Do not output documentation, only warnings.
+  -symbols		Output just the documented symbol names.
 
 Output format selection modifier (affects only ReST output):
 
@@ -434,6 +435,8 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	$blankline = $blankline_rst;
     } elsif ($cmd eq "none") {
 	$output_mode = "none";
+    } elsif ($cmd eq "symbols") {
+	$output_mode = "symbols";
     } elsif ($cmd eq "module") { # not needed for XML, inherits from calling document
 	$modulename = shift @ARGV;
     } elsif ($cmd eq "function") { # to only output specific functions
@@ -1139,6 +1142,35 @@ sub output_struct_none(%) {
 sub output_blockhead_none(%) {
 }
 
+## symbols mode output functions
+
+sub output_function_symbols(%) {
+        my %args = %{$_[0]};
+
+	print "$args{'function'}()\n";
+}
+
+sub output_enum_symbols(%) {
+        my %args = %{$_[0]};
+
+	print "enum $args{'enum'}\n";
+}
+
+sub output_typedef_symbols(%) {
+        my %args = %{$_[0]};
+
+	print "typedef $args{'typedef'}\n";
+}
+
+sub output_struct_symbols(%) {
+        my %args = %{$_[0]};
+
+	print "struct $args{'struct'}\n";
+}
+
+sub output_blockhead_symbols(%) {
+}
+
 ##
 # generic output function for all types (function, struct/union, typedef, enum);
 # calls the generated, variable output_ function name based on
-- 
2.26.2


