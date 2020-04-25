Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3921B8576
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 12:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDYKDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 06:03:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43135 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgDYKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNfXbsW3ndC67Tvtn4fclxwzfeCMHhj711ruKCrMin4=;
        b=dscTD405swBtSQFNsOHcMPkXn6kyDaQB4Id3CnLItmbDbcfNVeh6RT9FpZr7B5ydENuPIv
        TS88Cl4rHPnRpN35HrCYswvcNYAcKTr1t4xOxR5E24aOrdCzt+bMlxJKeRCvRpxWDoomUZ
        Qq+6zIHGyZUnavf6twgNgECL7NbIkpQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-popu25-ENkCHSRMFczMZ6A-1; Sat, 25 Apr 2020 06:03:32 -0400
X-MC-Unique: popu25-ENkCHSRMFczMZ6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7BC580B70D;
        Sat, 25 Apr 2020 10:03:30 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9428E60623;
        Sat, 25 Apr 2020 10:03:29 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 08/11] x86/unwind/orc: Don't skip the first frame for inactive tasks
Date:   Sat, 25 Apr 2020 05:03:07 -0500
Message-Id: <7f08db872ab59e807016910acdbe82f744de7065.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

When unwinding an inactive task, the ORC unwinder skips the first frame
by default.  If both the 'regs' and 'first_frame' parameters of
unwind_start() are NULL, 'state->sp' and 'first_frame' are later
initialized to the same value for an inactive task.  Given there is a
"less than or equal to" comparison used at the end of __unwind_start()
for skipping stack frames, the first frame is skipped.

Drop the equal part of the comparison and make the behavior equivalent
to the frame pointer unwinder.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 45166fd50be3..e9f5a20c69c6 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -657,7 +657,7 @@ void __unwind_start(struct unwind_state *state, struc=
t task_struct *task,
 	/* Otherwise, skip ahead to the user-specified starting frame: */
 	while (!unwind_done(state) &&
 	       (!on_stack(&state->stack_info, first_frame, sizeof(long)) ||
-			state->sp <=3D (unsigned long)first_frame))
+			state->sp < (unsigned long)first_frame))
 		unwind_next_frame(state);
=20
 	return;
--=20
2.21.1

