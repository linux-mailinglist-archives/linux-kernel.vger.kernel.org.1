Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2657A28EE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgJOIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgJOIMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:12:18 -0400
Received: from mail.kernel.org (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80BDB2224A;
        Thu, 15 Oct 2020 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602749537;
        bh=XWcvmaBJsNdx4pEkNGAT9OQ81e8rghcsnajzjBknoUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0pDwZ7pxMH44f/Fdqph9pHjgPiKVtdxHFWrRS57BMJjkGZ6028TA/af9IivKaIhO
         f8X9aCkwCaEL9Yp6t7EIxRs2zs2WWy7scA/Dru9wYHfBav4mYLJA+st7j5LvybBdto
         G20S8RXAt/Al2PkREPdktdEWR0osgbX7HryjJsx4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSyMw-000MSl-Ud; Thu, 15 Oct 2020 10:12:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts: kernel-doc: use :c:union when needed
Date:   Thu, 15 Oct 2020 10:12:11 +0200
Message-Id: <20da8fce9bb610dc0ea9ec4865d071e14e2abb1d.1602749214.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602749214.git.mchehab+huawei@kernel.org>
References: <cover.1602749214.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx C domain code after 3.2.1 will start complaning if :c:struct
would be used for an union type:

	.../Documentation/gpu/drm-kms-helpers:352: ../drivers/video/hdmi.c:851: WARNING: C 'identifier' cross-reference uses wrong tag: reference name is 'union hdmi_infoframe' but found name is 'struct hdmi_infoframe'. Full reference name is 'union hdmi_infoframe'. Full found name is 'struct hdmi_infoframe'.

So, let's address this issue too in advance, in order to
avoid future issues.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c8f6b11d5da1..99cd8418ff8a 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1092,7 +1092,11 @@ sub output_struct_rst(%) {
 	print "\n\n.. c:type:: " . $name . "\n\n";
     } else {
 	my $name = $args{'struct'};
-	print "\n\n.. c:struct:: " . $name . "\n\n";
+	if ($args{'type'} eq 'union') {
+	    print "\n\n.. c:union:: " . $name . "\n\n";
+	} else {
+	    print "\n\n.. c:struct:: " . $name . "\n\n";
+	}
     }
     print_lineno($declaration_start_line);
     $lineprefix = "   ";
-- 
2.26.2

