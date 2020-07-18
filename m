Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAED82249A1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgGRHUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 03:20:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46035 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbgGRHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595056808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RRfV+030OZkI3mkNTShBE54pKgPBKNhenrspYRndL2o=;
        b=TtkM157+FNS1ZhfUyXh0tvs2oY/i0piDjoGCQDBBZzBX15U9X+y6B/qPIXugiBOURAeVOY
        VmYFDdoBsmlqteQ8P2jBJ5/7mtPFPE0Rv/YC9a0mlr9y8x0wu6PeQGiawiD7xl4BdXV42W
        b/HqP/Q2it65C3Q9evvNeu0wR1pkVvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-tlUefK-ENLeSOEMpVYwcQg-1; Sat, 18 Jul 2020 03:20:06 -0400
X-MC-Unique: tlUefK-ENLeSOEMpVYwcQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E27A107ACCA;
        Sat, 18 Jul 2020 07:20:05 +0000 (UTC)
Received: from f32-m1.lan (ovpn-112-21.phx2.redhat.com [10.3.112.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1938C6FEF7;
        Sat, 18 Jul 2020 07:20:04 +0000 (UTC)
Date:   Sat, 18 Jul 2020 00:20:03 -0700
From:   Kevin Buettner <kevinb@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] copy_xstate_to_kernel: Fix typo which caused GDB regression
Message-ID: <20200718002003.6e0a2aef@f32-m1.lan>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a regression encountered while running the
gdb.base/corefile.exp test in GDB's test suite.

In my testing, the typo prevented the sw_reserved field of struct
fxregs_state from being output to the kernel XSAVES area.  Thus the
correct mask corresponding to XCR0 was not present in the core file
for GDB to interrogate, resulting in the following behavior:

[kev@f32-1 gdb]$ ./gdb -q testsuite/outputs/gdb.base/corefile/corefile testsuite/outputs/gdb.base/corefile/corefile.core
Reading symbols from testsuite/outputs/gdb.base/corefile/corefile...
[New LWP 232880]

warning: Unexpected size of section `.reg-xstate/232880' in core file.

With the typo fixed, the test works again as expected.

Signed-off-by: Kevin Buettner <kevinb@redhat.com>
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6a54e83d5589..9cf40a7ff7ae 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1022,7 +1022,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 		copy_part(offsetof(struct fxregs_state, st_space), 128,
 			  &xsave->i387.st_space, &kbuf, &offset_start, &count);
 	if (header.xfeatures & XFEATURE_MASK_SSE)
-		copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
+		copy_part(xstate_offsets[XFEATURE_SSE], 256,
 			  &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
 	/*
 	 * Fill xsave->i387.sw_reserved value for ptrace frame:
-- 
2.26.2


