Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04B2DCA46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgLQBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbgLQBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:05:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFA0C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 17:04:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id g24so18402199pgh.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 17:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9UyTDYfqM3TtmK89ynr8ba5E/LpsXqcOhuEVAOoZ6N8=;
        b=HBjOw7t9Lkbhi5gcKqn1zqM77nxJa5QVq1lXgMkV8gzLZ7mSE4hZLAA0nmC+/XEr5N
         D8XqDsFZ+K/uNJTwKpX6pu24MPp5/9PVL5o26UR55PCV3sQeZchkFCrHz2LHcZqKDSgW
         ecldepyaSf0OZ+NCWctWMmQ8Mr062OFJPJb9Tvez5TomDnP1ilvBWZKlTW7BoR0n7Ho5
         pmmiQ/92QMdhuCjO+jFOM1s7CpOfMZIn9zV0BGjl9nh5rZJXnzPVD7YIOBwKTDl00X8e
         ghE56pEpJTX3J5I6jhVb+VGqLtBC6EE55WJeglVKFT4n8QcBCo68BkaJm3N5RucfQbFa
         dKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9UyTDYfqM3TtmK89ynr8ba5E/LpsXqcOhuEVAOoZ6N8=;
        b=U19KgUr7Xhg65XJb20Xalf0CffCZqgEJ2YZY0mW3dIw31qxnEKVRrdRylTWS9DDSXB
         xgwopZYkKw6niMEb1liNwIgnpbTQrJcU8YbO6O424J44gi4BcFHI8E0e7dQOBqE06xlK
         sGvwNPHaSCVViTp6it37oXkYgLKtsIzoY3a5jHwlSWB+4jPYG4rSlsYc9gCTiz7JLnsX
         iNKOwpCHrqQwvK4H99EocFTWq0zYE/Rs82bDLmGIEyf2vpZileL777IXz2YQkkEdJGmG
         Kc/PziIAt25ZTi9gi0LwfQWv93sBj0ypvfCevn4eWXOwdNhDc0C0qXKogOWE+kIw9xXj
         lnhg==
X-Gm-Message-State: AOAM531sCgQcvhydY7eOBDt+esJn0QKsL2IYfjKmXAHOpiMVFi435I5d
        VvyhKF8pPuXCr9ARRhqdHWKO1Xw0S8w=
X-Google-Smtp-Source: ABdhPJzdozWH2wCmsGvOeHonubYD6OmAvqCcGwWUr8HosN7lFduex6FAgLSPmAgd1BjsVqTHDHwE4XUQchk=
Sender: "pgonda via sendgmr" <pgonda@pgonda1.kir.corp.google.com>
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:f693:9fff:fef4:e3a2])
 (user=pgonda job=sendgmr) by 2002:a17:902:bb95:b029:dc:e7b:fd6e with SMTP id
 m21-20020a170902bb95b02900dc0e7bfd6emr6823968pls.12.1608167061140; Wed, 16
 Dec 2020 17:04:21 -0800 (PST)
Date:   Wed, 16 Dec 2020 17:04:09 -0800
Message-Id: <20201217010409.3675060-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH] x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc handling
From:   Peter Gonda <pgonda@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Peter Gonda <pgonda@google.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The IN and OUT immediate instructions only use an 8-bit immediate. The
current VC handler uses the entire 32-bit immediate value. These
instructions only set the first bytes.

Tested with a loop back port with "outb %0,$0xe0". Before the port seen
by KVM was 0xffffffffffffffe0 instead of 0xe0. After the correct port
was seen by KVM and the guests loop back OUT then IN were equal.


Signed-off-by: Peter Gonda <pgonda@google.com>
Acked-by: David Rientjes <rientjes@google.com>


---
 arch/x86/kernel/sev-es-shared.c | 8 ++++++--
 drivers/Makefile                | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 7d04b356d44d..6c790377c55c 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -305,14 +305,14 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0xe4:
 	case 0xe5:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (u64)insn->immediate.value << 16;
+		*exitinfo |= insn->immediate.bytes[0] << 16;
 		break;
 
 	/* OUT immediate opcodes */
 	case 0xe6:
 	case 0xe7:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (u64)insn->immediate.value << 16;
+		*exitinfo |= insn->immediate.bytes[0] << 16;
 		break;
