Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0B1DA6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 02:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgETAdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 20:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgETAdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:33:18 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0FE20884
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934797;
        bh=SAzIvB9/KlljR9/+QQM7s6jGk448vsklZKoyBEgSIZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0WIw2M4nB4wFPtK+kKnrRFmZ7QbA5g5mnxWFRQmgp7Lo+M85mtKy+XCAzYaRaKf+c
         zBwaVvPwXy0u4Z57KYMp7EpqTrw+ahz2vDsPeJcc2ikn3X8ZfFaroEk+Jh/uTAA6fJ
         ZhruESKjsxJ7aK3gCv/R2/WOgUZe7sdFjj7RcD5E=
Received: by mail-wm1-f51.google.com with SMTP id z4so976374wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:33:17 -0700 (PDT)
X-Gm-Message-State: AOAM530BTb2uoMCxJijBWtraIpuTjDRiYdIudxG6Ev1qhlf3KNqHHZhC
        Bna/gitQ9KBq7aKuZhVvWbGwH+OFcrJSnyxyHf7cbg==
X-Google-Smtp-Source: ABdhPJyjV+47YKc6lyCfMCpB5CyVHHbeGAfAsPauUnNG75r+5QLHXKVDjoYDZmmiBW9oGFBYz+lV9jmJDq3VLVMhLpQ=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr1930926wmd.21.1589934795733;
 Tue, 19 May 2020 17:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.607881162@linutronix.de>
In-Reply-To: <20200515235127.607881162@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:33:04 -0700
X-Gmail-Original-Message-ID: <CALCETrWm2G_NMKyJ-gPERUyi_WBXmGs8Ct2YwSZcdeL5=ZBu7A@mail.gmail.com>
Message-ID: <CALCETrWm2G_NMKyJ-gPERUyi_WBXmGs8Ct2YwSZcdeL5=ZBu7A@mail.gmail.com>
Subject: Re: [patch V6 32/37] x86/entry/64: Remove IRQ stack switching ASM
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>

Acked-by: Andy Lutomirski <luto@kernel.org>
