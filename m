Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04B31A8675
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407537AbgDNQ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440289AbgDNQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:03 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571832076A;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=BTPcRwxL5Vi5wneFHtqBCwfk8BpgcAIHfCgs53kcGM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPA3Uh4kmv1fd3MaAhyaTgykoreSvt2BZMHnp9Hp26+G6y2V1rn45zs38hvTUTcQt
         h/mm2fQW+Fg1v2/8G71BR6hkZWKvGufbL/a51oCnRyqE2jNgSKl27u4Gdj743fJnzm
         BsMAMKFy20n7TNaGZ16JEsW1kT1mUuBMsWLZIkEY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068l2-HS; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 02/33] scripts: kernel-doc: accept negation like !@var
Date:   Tue, 14 Apr 2020 18:48:28 +0200
Message-Id: <0314b47f8c3e1f9db00d5375a73dc3cddd8a21f2.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
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

