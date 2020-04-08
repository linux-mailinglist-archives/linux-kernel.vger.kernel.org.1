Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2961A25D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgDHPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE4220BED;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=djdizYUF8P2UkZPkY2sLJI5bKLZqZSwRhGddHALE768=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6mJnpirWd768ymAkegEDrM0PTsqOd1rHesjskcNjn19PhahQWlauN0fUK3NlLoyg
         KXKpGhjmquO0nRglgQIjNEYlaUM18FcykFS+IYHWiEWT8RU1RpIWTrMdrl/Jv0NZ8h
         sbx/AmLD8xT1HLv9NXwmo4dgwkvgXnK9z4XHtV9U=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cB6-Fp; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 11/35] scripts: kernel-doc: proper handle @foo->bar()
Date:   Wed,  8 Apr 2020 17:46:03 +0200
Message-Id: <a388c88a1eebd4e0fb6147adb666289ef769aa51.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern @foo->bar() is valid, as it can be used by a
function pointer inside a struct passed as a parameter.

Right now, it causes a warning:

	./drivers/firewire/core-transaction.c:606: WARNING: Inline strong start-string without end-string.

In this specific case, the kernel-doc markup is:

	/**
	 * fw_core_remove_address_handler() - unregister an address handler
	 * @handler: callback
	 *
	 * To be called in process context.
	 *
	 * When fw_core_remove_address_handler() returns, @handler->callback() is
	 * guaranteed to not run on any CPU anymore.
	 */

With seems valid on my eyes. So, instead of trying to hack
the kernel-doc markup, let's teach it about how to handle
such things. This should likely remove lots of other similar
warnings as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f2d73f04e71d..d15c8ea95d93 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -214,6 +214,7 @@ my $type_constant2 = '\%([-_\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
+my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
 my $type_env = '(\$\w+)';
 my $type_enum = '\&(enum\s*([_\w]+))';
 my $type_struct = '\&(struct\s*([_\w]+))';
@@ -249,6 +250,7 @@ my @highlights_rst = (
                        [$type_member_func, "\\:c\\:type\\:`\$1\$2\$3\\\\(\\\\) <\$1>`"],
                        [$type_member, "\\:c\\:type\\:`\$1\$2\$3 <\$1>`"],
 		       [$type_fp_param, "**\$1\\\\(\\\\)**"],
+		       [$type_fp_param2, "**\$1\\\\(\\\\)**"],
                        [$type_func, "\$1()"],
                        [$type_enum, "\\:c\\:type\\:`\$1 <\$2>`"],
                        [$type_struct, "\\:c\\:type\\:`\$1 <\$2>`"],
-- 
2.25.2

