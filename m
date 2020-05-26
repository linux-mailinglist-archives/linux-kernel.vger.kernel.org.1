Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065E61E187A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 02:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbgEZA37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 20:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEZA37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 20:29:59 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B58E2078B
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590452998;
        bh=jiUY9V1Bkztcy/8t94YHlJD2RQ8+uVmK8V+BpsmrT84=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BW5Enqv4WR4JyXZJdRRGLYXdZr3N6KfpHYCM4QRjtAOoLAvkGODYbq8m7cSUpYr/p
         wz3aBLKG5OYqZsQtZL6H+G+OReE+9bkwqnvO2bg72f53fNq45Wc1OryZUwmiPv17DH
         eOy4QFeACjU4/YCPtfDuuTM3YAJZs89XfudA510U=
Received: by mail-lj1-f170.google.com with SMTP id q2so22390864ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 17:29:58 -0700 (PDT)
X-Gm-Message-State: AOAM533nAmdVieFKlI2gft8aX2YuGrWR0VoGyPThBYGcpan1SxSSrCdt
        hXEKc2OqjyCqbTsXFm9vU4vvBhwTT0Xvn7fabwE=
X-Google-Smtp-Source: ABdhPJzFPVX/ZQf6wS3uG4u1AQO/qZu5mRLPhUvY8Gw1ZniByoGz0/NOLxDK7AXmEvwSyD7D/23iC3BzwLGiaZ/F7/E=
X-Received: by 2002:a2e:160e:: with SMTP id w14mr12316006ljd.66.1590452996282;
 Mon, 25 May 2020 17:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <1590416306-66453-1-git-send-email-guoren@kernel.org> <20200525143648.GM2605652@cisco>
In-Reply-To: <20200525143648.GM2605652@cisco>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 26 May 2020 08:29:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS4gM39KWuksRRT9ONPhbhYuN9r1oOP_qRT8KvDga4vyA@mail.gmail.com>
Message-ID: <CAJF2gTS4gM39KWuksRRT9ONPhbhYuN9r1oOP_qRT8KvDga4vyA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Remove unnecessary path for syscall_trace
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     keescook@chromium.org, palmerdabbelt@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tycho,

On Mon, May 25, 2020 at 10:36 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Mon, May 25, 2020 at 02:18:26PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Obviously, there is no need to recover a0-a7 in reject path.
> >
> > Previous modification is from commit af33d243 by Tycho, to
> > fixup seccomp reject syscall code path.
>
> Doesn't this suffer from the same problem, though? a7 is clobbered, so
> the -ERESTARTSYS behavior won't work?

Look, the patch only affects the path of ret_from_syscall_rejected,
and there are two possible paths:
1. ret_from_syscall_rejected->handle_syscall_trace_exit->ret_from_exception
2. ret_from_syscall_rejected->ret_from_exception

All the above skip the check_syscall_nr and ignore the current a7, in
the C function they use the pt_regs in the stack to get proper reg's
value.

For the -ERESTARTSYS, we only process it in:
ret_from_exception->resume_userspace->work_notifysig->do_notify_resume:
do_signal & handle_signal:

                switch (regs->a0) {
                case -ERESTARTNOHAND:
                case -ERESTARTSYS:
                case -ERESTARTNOINTR:
                        regs->a0 = regs->orig_a0;
                        regs->epc -= 0x4;
                        break;

All above are done in pt_regs and when returning to userspace, a7 will
be recovered by restore_all in entry.S.

                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
