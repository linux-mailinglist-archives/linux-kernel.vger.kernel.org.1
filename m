Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750881D25EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 06:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgENEm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 00:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgENEm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:42:28 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86123206C0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431347;
        bh=UrOGb8u164dhMlOpt09ZNCaXgyXlvDOKQLYIfZcgCaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zq64d4k4OG2OMI6kcjWfm+VHNmk7YbE35GKNd+Kh/IqQpV9F4W4ZSApLv84kyWlj8
         gCDuxVT7sH80cEy298Ku6s2cqkEYBk++v83HtojgqwHCjdqIxkK4oTOByI5EA30oOK
         dxLH5eY+fyywCNx2R4TTiN/rOuZD/ocoaohCq3z8=
Received: by mail-wr1-f49.google.com with SMTP id i15so2061458wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:42:27 -0700 (PDT)
X-Gm-Message-State: AOAM530Ly4GTnwiB8HvI3BuzbCZIsYQDD+x60cDBl91TucW67tKJeexV
        UFwoBA0PB/Ne/im23mNOe7ACCNwSfTmou4d2lVhKZQ==
X-Google-Smtp-Source: ABdhPJw+h8cutS9UY3qfGwjqysmqT+WO6vtWYgUGeyIhQtfz68v6mCt+ZK1E6WSq1DqelQQnmTahEFERhXkpo7sVBd0=
X-Received: by 2002:adf:a298:: with SMTP id s24mr3022622wra.184.1589431345998;
 Wed, 13 May 2020 21:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.863001309@linutronix.de>
In-Reply-To: <20200505134904.863001309@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:42:14 -0700
X-Gmail-Original-Message-ID: <CALCETrVX=4oR9wCMywzB_EB=_h-76PQF2ivL=8d3mJF2Hh-+6g@mail.gmail.com>
Message-ID: <CALCETrVX=4oR9wCMywzB_EB=_h-76PQF2ivL=8d3mJF2Hh-+6g@mail.gmail.com>
Subject: Re: [patch V4 part 3 16/29] x86/entry: Convert Bounds exception to IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #BR to IDTENTRY:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes

prototypoes?

Acked-by: Andy Lutomirski <luto@kernel.org>
