Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DC1AFEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDSWrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 18:47:02 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:47015 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgDSWrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:47:02 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 18:47:02 EDT
Received: from visor (unknown [10.95.89.82])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 6A65040186F;
        Sun, 19 Apr 2020 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1587335813;
        bh=jxHvGKInQk3QYVsXG/uXRFxG6JYrVJcDhgYhQzWLrgY=;
        h=Date:From:To:Cc:Subject:From;
        b=XOHNPhSXSLcLMDl1uoUInQu8yYaUyH+XrQgX3P2c9zo9zi1XKUXgVJVoWvJ05mD4D
         3HQ8eoo6T4WudQbrxcTs82obvhyyxHbjFWJHUeROpcdABDK6BuYK/CQmbn+m9rlkP4
         7YUZXKbeiWHChPz4gPLv75mCvw3JPDY6iRo7x7lhwDzzb1GxSufalDjvWnrQYRX8S1
         vYjNW5XlgPjijixdZ752Ik4swIXHqDu4KzL70jv5d+sg7DhTIzWPjhSS9YMqH0TNK/
         F7wiyB95UTzj4LPpWBX4PDXOKzSBJJKHQoZd7NiS/Fl/Jpoy11zKy5zbGMWPIeKg09
         PaiIn3d5mnWuA==
Date:   Sun, 19 Apr 2020 15:36:53 -0700
From:   Ivan Delalande <colona@arista.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/decodecode: fix trapping instruction formatting
Message-ID: <20200419223653.GA31248@visor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.13.5 (2020-03-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the trapping instruction contains a ':', for a memory access through
segment registers for example, the sed substitution will insert the '*'
marker in the middle of the instruction instead of the line address:

	2b:   65 48 0f c7 0f          cmpxchg16b %gs:*(%rdi)          <-- trapping instruction

I started to think I had forgotten some quirk of the assembly syntax
before noticing that it was actually coming from the script. Fix it to
add the address marker at the right place for these instructions:

	28:   49 8b 06                mov    (%r14),%rax
	2b:*  65 48 0f c7 0f          cmpxchg16b %gs:(%rdi)           <-- trapping instruction
	30:   0f 94 c0                sete   %al

Fixes: 18ff44b189e2 ("scripts/decodecode: make faulting insn ptr more robust")
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 scripts/decodecode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index ba8b8d5834e6..fbdb325cdf4f 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -126,7 +126,7 @@ faultlinenum=$(( $(wc -l $T.oo  | cut -d" " -f1) - \
 faultline=`cat $T.dis | head -1 | cut -d":" -f2-`
 faultline=`echo "$faultline" | sed -e 's/\[/\\\[/g; s/\]/\\\]/g'`
 
-cat $T.oo | sed -e "${faultlinenum}s/^\(.*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
+cat $T.oo | sed -e "${faultlinenum}s/^\([^:]*:\)\(.*\)/\1\*\2\t\t<-- trapping instruction/"
 echo
 cat $T.aa
 cleanup
-- 
Ivan Delalande
Arista Networks
