Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692A22AD56F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgKJLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:39:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJLjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:39:02 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605008340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V5tgrA9mzGrDzhEZn2WdPClqxxggWGyrkJ8LW+RVJ5E=;
        b=XFDkZZh7VfYQNeF3TtmrTaKsNJJQRRoTs0Qsj0R7LhOoybDpj9iUwWAGmjamJUrpnp3QPA
        0RTGux80GFcHV92zQrwh5jLVhmxHGnmuSEVKwMSNvSM7GBac/VRUwKZEgWGAmJTy7WHN6K
        uH8+BYGnOKOG9Q+46EoGulUt/q0fD9Sb8vQWU3usPvMeGMcLN3TxCZ/yyVtU8pgAJkJ3tB
        3lgct1qDhdAjcSSxUZyVz22xM+UwvCEerk2eBYKA9dXizTgeN0SecaNH/DGz9TMQGMiMgy
        uUkjlSXk8XjW0tJwWSnLqw1UbiulcKZIlHZJcgwZoHjwkorjIgFiCxZeiC08TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605008340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V5tgrA9mzGrDzhEZn2WdPClqxxggWGyrkJ8LW+RVJ5E=;
        b=hzp07aYixIJ62foUWVnsOuaUAURo3cMN5AUfaEnLRymMSkq1/OyTC2PCXFUTD24zZovMCk
        163f3zKhIuYVfkCA==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>, Mike Galbraith <efault@gmx.de>
Subject: [PATCH 0/2] genirq: Move prio assignment into the newly created thread
Date:   Tue, 10 Nov 2020 12:38:46 +0100
Message-Id: <20201110113848.801379-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike reported [0] a lockdep splat triggered by the nouveau driver together
with enabled threaded interrupts.
I can't easily tell if moving / changing locking within nouveau does not
break anything and does not create the same lockchain in another path.
Mike did confirm that the lockdep splat can be avoided by by moving
`request_irq()' out of the picture [1]. He also tested the two patches
which are scattered in the thread.

Mike is betting on commit
   710da3c8ea7df ("sched/core: Prevent race condition between cpuset and __=
sched_setscheduler()")

as the source change that introduce that problem assuming that locking
within the nouveau remained unchanged. He did confirm that this splat
exists also in a v5.4 stable kernel [2] which is where the change was
introduced.

[0] https://lkml.kernel.org/r/a23a826af7c108ea5651e73b8fbae5e653f16e86.came=
l@gmx.de
[1] https://lkml.kernel.org/r/431e81699f2310eabfe5af0a3de400ab99d9323b.came=
l@gmx.de
[2] https://lkml.kernel.org/r/f7e43b369c7d168c2ff04bfd91dfdf3afd0da12c.came=
l@gmx.de

Sebastian


