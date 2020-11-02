Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F42A285C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgKBKc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgKBKc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:32:27 -0500
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4E2223BE;
        Mon,  2 Nov 2020 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604313146;
        bh=QUaGIBoAWPb8+PT+LW3xf4ASGlV2LfNoMZjtoIDfME8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh8zHrLElk5jGAdQLOhXbDwJ34GKZDZhs2tgIYkspzeyp0AnSLmnSPOCLRULrT4JF
         Pd98UhejS9F8EoKm8LHj6LPilIB4ruys0m4Z+GRWrEL936pYlJGzIkLiy3v8C7veMS
         pZBnI3hBTyVMs5QZfjAMUtqHTGjs+aXdiJdgLNxA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kZX8P-005tug-UJ; Mon, 02 Nov 2020 11:32:21 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Oded Gabbay <oded.gabbay@gmail.com>
Subject: [PATCH 4/5] scripts: get_abi.pl: Don't let ABI files to create subtitles
Date:   Mon,  2 Nov 2020 11:32:15 +0100
Message-Id: <6c62ef5c01d39dee8d891f8390c816d2a889670a.1604312590.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604312590.git.mchehab+huawei@kernel.org>
References: <cover.1604312590.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ReST output should only contain documentation titles
automatically created by the script.

There are two reasons for that:

1) Consistency.

   just a handful ABI docs define titles

2) To avoid critical errors.

   Docutils (which is the basis for Sphinx) allows a free
   assign of documentation title markups. So, one document
   could be doing things like:

	Level 1
	=======

	Level 2
	-------

   While another one could do the reverse:

	Level 1
	-------

	Level 2
	=======

   But the same document can't mix.

   As the output of get_abi.pl will join contents from multiple
   files, if they don't define the levels on a consistent errors,
   errors like this can happen:

	Sphinx parallel build error:
	docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:

	Attributes Common for All RapidIO Devices
	-----------------------------------------

   Which cause some versions of Sphinx to go into an endless
   loop.

   It should be noticed that an alternative to that would
   be to replace all title occurrences by a single markup,
   but that will make the parser more complex, and, due to
   (1) it would generate an inconsistent output.

   So, better to just remove the titles defined at the ABI
   files from the output.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 2cb592f8eba4..459f169f834c 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -352,6 +352,12 @@ sub output_rest {
 
 		if (!($desc =~ /^\s*$/)) {
 			if ($description_is_rst) {
+				# Remove title markups from the description
+				# Having titles inside ABI files will only work if extra
+				# care would be taken in order to strictly follow the same
+				# level order for each markup.
+				$desc =~ s/\n[\-\*\=\^\~]+\n/\n\n/g;
+
 				# Enrich text by creating cross-references
 
 				$desc =~ s,Documentation/(?!devicetree)(\S+)\.rst,:doc:`/$1`,g;
-- 
2.26.2

