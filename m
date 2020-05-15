Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFCF1D4555
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 07:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgEOFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 01:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgEOFjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:39:13 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC635207D5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521153;
        bh=hhJZrS4dQlrOqWtpzbORUG3FsoCBJnnxn4paG3NwSGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F5aYRi97x8bI6pkuCxd768c4bPWRH3DEwX2DhSO20o+h5VLWwT2Yx2AiOqOlOGpFf
         U7+U3Hyh0FLTz8MJPFiLiABgBfxndYZTlhx/gkxKiRUOPXhxC7q/BZmeVkntwvIgyF
         e9Q05B4VmRvfMSByxH4xJA58FDoZqtPuyxkuiifY=
Received: by mail-wr1-f54.google.com with SMTP id h17so1938313wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:39:12 -0700 (PDT)
X-Gm-Message-State: AOAM533A7C89vRJB/3s2oQmNlCpGP1Jw7YnsmyPG7NDonsPVgPJtiVyo
        +r4fSPC5rcluCq1NH94NadT6V3n7uw5Ma2VFvE6ULA==
X-Google-Smtp-Source: ABdhPJyf51GqXssxcRTstDl1tswRgHXC8Blvay7WP4A6ao00Ke3RW1j49q0aQfrKwzzoWHhbbm+oEZ2yTZwfpoIXcE8=
X-Received: by 2002:adf:a389:: with SMTP id l9mr2277021wrb.18.1589521151382;
 Thu, 14 May 2020 22:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135315.283276272@linutronix.de>
In-Reply-To: <20200505135315.283276272@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:39:00 -0700
X-Gmail-Original-Message-ID: <CALCETrWLvUtxqsM5fpWvjKan3_QE3ut8c+v8NQTV1RqC7zWE+g@mail.gmail.com>
Message-ID: <CALCETrWLvUtxqsM5fpWvjKan3_QE3ut8c+v8NQTV1RqC7zWE+g@mail.gmail.com>
Subject: Re: [patch V4 part 4 20/24] x86/traps: Restructure #DB handling
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

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Now that there are separate entry points, move the kernel/user_mode specifc
> checks into the entry functions so the common handling code does not need
> the extra mode checks. Make the code more readable while at it.

Acked-by: Andy Lutomirski <luto@kernel.org>
