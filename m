Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260072E0A44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgLVNGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLVNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:06:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2204C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 05:06:01 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ef200e29264d90d5dcac8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f200:e292:64d9:d5d:cac8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE0051EC04DA;
        Tue, 22 Dec 2020 14:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608642359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=f29iITGRSMPfX8nwHvyOpLzXPEqaQz/RqOThYU9HB/4=;
        b=aJ38C+B1yaZeCFTx0vFdZCtyDNcU4UW9NuQHzF+oFjQzm1/1S3tu/+O9XzE6VsKitX7ic6
        0i4j4yHQ9aYt4ssZwDv4kRJ9fkTnkma3EQP2D8GQK5er8eYd1HlM/jzfQU5RnqwY33pFtc
        sxhPJ+zN8N84CDcNQ3wELy88ds26oFU=
Date:   Tue, 22 Dec 2020 14:05:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/submitting-patches: Add blurb about backtraces
 in commit messages
Message-ID: <20201222130555.GA13463@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201221095425.6da68163@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 09:54:25AM -0700, Jonathan Corbet wrote:
> Given that there was indeed a lack of bikeshedding, I just went ahead
> and applied this to docs-next; will ship it Linusward in the near
> future.

Cool.

Although I betcha that is because of the impending holiday season. I
think I should just use that moment to sneak in more stuff stealthily
and when everyone awakes from their drunken and food stupor, it'll all
be there! Tadaa!

:-)))

Ok, here's the next one which I think, is also, not really controversial.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Tue, 22 Dec 2020 13:58:22 +0100

Document that backtraces in commit messages should be trimmed down to
the useful information only.

This has been carved out from a tip subsystem handbook patchset by
Thomas Gleixner:

  https://lkml.kernel.org/r/20181107171010.421878737@linutronix.de

and incorporates follow-on comments.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/process/submitting-patches.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 5ba54120bef7..0ffb21366381 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -679,6 +679,26 @@ generates appropriate diffstats by default.)
 See more details on the proper patch format in the following
 references.
 
+Backtraces in commit mesages
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Backtraces help document the call chain leading to a problem. However,
+not all backtraces are helpful. For example, early boot call chains are
+unique and obvious. Copying the full dmesg output verbatim, however,
+adds distracting information like timestamps, module lists, register and
+stack dumps.
+
+Therefore, the most useful backtraces should distill the relevant
+information from the dump, which makes it easier to focus on the real
+issue. Here is an example of a well-trimmed backtrace::
+
+  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000000000000064)
+  at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
+  Call Trace:
+  mba_wrmsr
+  update_domains
+  rdtgroup_mkdir
+
 .. _explicit_in_reply_to:
 
 Explicit In-Reply-To headers
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
