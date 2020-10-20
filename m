Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ABC29440C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgJTUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731327AbgJTUlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:41:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88D872224A;
        Tue, 20 Oct 2020 20:41:23 +0000 (UTC)
Date:   Tue, 20 Oct 2020 16:41:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>, Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Patrick =?UTF-8?B?U3TDpGhsaW4=?= <me@packi.ch>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 9/9] riscv: Fixup lockdep_assert_held(&text_mutex) in
 patch_insn_write
Message-ID: <20201020164121.32626e45@gandalf.local.home>
In-Reply-To: <CAJF2gTSU+M+b+bn5zH_EyE7Ksh=5+ZkO8LkAn=Tm-p45CgYW1w@mail.gmail.com>
References: <1602918377-23573-1-git-send-email-guoren@kernel.org>
        <1602918377-23573-10-git-send-email-guoren@kernel.org>
        <CAOnJCU+oTRcJ2p8WQDX5P-EsOHmkn3kP9s54VQa+iw2wXDvzkg@mail.gmail.com>
        <CAJF2gTSU+M+b+bn5zH_EyE7Ksh=5+ZkO8LkAn=Tm-p45CgYW1w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 19:18:01 +0800
Guo Ren <guoren@kernel.org> wrote:

> > What platform are you testing ? We are seeing a crash while enabling
> > any of the tracers multiple times
> > on Qemu/HiFive Unleashed.  
> I use qemu for testing. I've changed dynamic ftrace mechanism from
> mcount to -fpatchable-entry.
> 
> The problem is made by the lockdep checking of text_mutex.

If you are switching to "patchable-entry" you shouldn't need to use
stop_machine for the updates. No?

-- Steve
