Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9580920733A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 14:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbgFXMWg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Jun 2020 08:22:36 -0400
Received: from mail2.magna.com ([213.150.228.40]:49983 "EHLO mail2.magna.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388696AbgFXMWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:22:35 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2020 08:22:34 EDT
IronPort-SDR: HZa38QNvGkOh/luUEX7kSjfADWrgNVRaDq6RdD1ogzUmTBmu1gS1S82zGkad66bsHxLtpJm2aF
 kAMCbTz+wFvQ==
X-IronPort-AV: E=Sophos;i="5.75,275,1589241600"; 
   d="scan'208";a="1349816866"
From:   Roman Fietze <roman.fietze@magna.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] print_hex_dump: use %px when using DUMP_PREFIX_ADDRESS
Date:   Wed, 24 Jun 2020 14:15:24 +0200
Message-ID: <1946561.0luHp2vXsY@rfietze>
Organization: Telemotive AG
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on MSIFRAHUB01DS/SVR/MSI-HUB(Release 9.0.1FP4|June
  07, 2015) at 24.06.2020 14:15:25,
        Serialize by Router on MSIFRAHUB01DS/SVR/MSI-HUB(Release 9.0.1FP4|June  07, 2015) at
 24.06.2020 14:15:25,
        Serialize complete at 24.06.2020 14:15:25
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is mainly used for debugging. But for that purpose the
hashed memory address of the dumped data provides no useful
information at all.

Note: There are only very few locations in the kernel, where
print_hex_dump is not used with KERN_DEBUG and DUMP_PREFIX_ADDRESS.

Signed-off-by: Roman Fietze <roman.fietze@magna.com>
---
 lib/hexdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hexdump.c b/lib/hexdump.c
index 147133f8eb2f..52dd2fc1c8b4 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -256,7 +256,7 @@ void print_hex_dump(const char *level, const char 
*prefix_str, int prefix_type,
 
                switch (prefix_type) {
                case DUMP_PREFIX_ADDRESS:
-                       printk("%s%s%p: %s\n",
+                       printk("%s%s%px: %s\n",
                               level, prefix_str, ptr + i, linebuf);
                        break;
                case DUMP_PREFIX_OFFSET:
-- 
2.26.2


-- 

Roman Fietze
Entwicklungsingenieur
MAGNA Telemotive GmbH
Breitwiesen
73347 M�hlhausen
Tel.: +49 7335 18493-45



