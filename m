Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F65F1A2613
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgDHPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9D920787;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=BTPcRwxL5Vi5wneFHtqBCwfk8BpgcAIHfCgs53kcGM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=De3KAj7YfDooui6IYeglxOGipSe8n8+l6o1vwAcpVxrXMs1mtr8dOlfJdnJOH13sW
         PCEpEZt5GEdmOqrfNglH61kJMhT1F/S81Dcv1iRZs/vbz3PHqtgTNYY4wHXE7P4c0Y
         0Pv4rQ5BNzG3GfdGZjzr/B3ZxqfNpcBTI7Xde/RY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBh-P4; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 18/35] scripts: kernel-doc: accept negation like !@var
Date:   Wed,  8 Apr 2020 17:46:10 +0200
Message-Id: <cf4f785b3b67375680a0a48a23192ea4bd5b5764.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a few places, it sometimes need to indicate a negation of a
parameter, like:

	!@fshared

This pattern happens, for example, at:

	kernel/futex.c

and it is perfectly valid. However, kernel-doc currently
transforms it into:

	!**fshared**

This won't do what it would be expected.

Fortunately, fixing the script is a simple matter of storing
the "!" before "@" and adding it after the bold markup, like:

	**!fshared**

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d15c8ea95d93..b019d8db6502 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -213,6 +213,7 @@ my $type_constant = '\b``([^\`]+)``\b';
 my $type_constant2 = '\%([-_\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
+my $type_param_ref = '([\!]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
 my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
 my $type_env = '(\$\w+)';
@@ -237,6 +238,7 @@ my @highlights_man = (
                       [$type_typedef, "\\\\fI\$1\\\\fP"],
                       [$type_union, "\\\\fI\$1\\\\fP"],
                       [$type_param, "\\\\fI\$1\\\\fP"],
+                      [$type_param_ref, "\\\\fI\$1\$2\\\\fP"],
                       [$type_member, "\\\\fI\$1\$2\$3\\\\fP"],
                       [$type_fallback, "\\\\fI\$1\\\\fP"]
 		     );
@@ -258,7 +260,7 @@ my @highlights_rst = (
                        [$type_union, "\\:c\\:type\\:`\$1 <\$2>`"],
                        # in rst this can refer to any type
                        [$type_fallback, "\\:c\\:type\\:`\$1`"],
-                       [$type_param, "**\$1**"]
+                       [$type_param_ref, "**\$1\$2**"]
 		      );
 my $blankline_rst = "\n";
 
-- 
2.25.2

