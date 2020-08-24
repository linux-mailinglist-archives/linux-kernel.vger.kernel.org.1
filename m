Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC97250167
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 17:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgHXPqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgHXPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:46:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01417C061575;
        Mon, 24 Aug 2020 08:46:08 -0700 (PDT)
Date:   Mon, 24 Aug 2020 17:46:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598283966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XW44TtTM39puFK29r2Z1U/n2rm1H4SidXLcRJnMMlmA=;
        b=dk17feOTeW+1t5Q/8v7UsiKCKLnvXMcdkw/NRcBOjStCnViSBi2PLuh2RgtdYvtnuhe5hN
        AaQ2+dMoRBrjz5CL+iWWlkXQFTtUdqgPzoyLX7u5u+6EH7murKCuffAtn3dlNyia/S/sYU
        /lHuPSoVpxEm8zY9Fz//rXmbwqeFdfD1jX1yyyVPqJi/xdzKbcO5r0CylSmCdBb/pZd9/s
        eblSFmhZR8Q6HBh1dxO//24ofbQvVSh/SIicYVBIesjozQOQ7SmySAf2BnCZzgRd2d+as5
        6tHEUslyN/zCxDa3nx2TZgVCmW0EQDZz7aBH+HbcVhEcNsYD+B2bWTgFsJofEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598283966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XW44TtTM39puFK29r2Z1U/n2rm1H4SidXLcRJnMMlmA=;
        b=uoxPrnEimQi6WRdAXuN/Xr3MXTD5nNxslAPBCH0UvkXxxTgtLxmePw/Yzz+GlKR0nHNh9J
        hMsGaUBbbUgUSEDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.9-rc2-rt1 patch set. 

Changes since v5.6.19-rt12:

  - Rebase to v5.9-rc2

  - The seqcount related patches have been replaced on top of the
    seqcount series by Ahmed S. Darwis which landed mainline. 

  - The posix-timer patches have been dropped because upstream changes
    cover all of was needed on RT's side. As a result RT relies on
    HAVE_POSIX_CPU_TIMERS_TASK_WORK. This is provided only by x86.
    The RT patch provides this option for ARM/ARM64/POWERPC as long as
    KVM is disabled. The reason is that the task work must be handled
    before KVM returns to guest.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9-rc2-rt1

The RT patch against v5.9-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9-rc2-rt1.tar.xz

Sebastian
