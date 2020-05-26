Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C471D8B77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgERXH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgERXH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:07:27 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D99C2084C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843246;
        bh=OrLCaPTj9rIsDogaLBEUTknXFDgWFJhcptX+6acdAFA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H0yj6dWopxkj+HUpfIbdevDcLm54O1CymUX7h8qvcYhpCNdhwO0F5yHKm4oS8sunt
         jfCEpihPHZShwnXLVWgO4VYl5gUVHqdLSuG9RBcBvq95sxavAggux5eB+2TJLA/237
         ROQGMngmHowBg0vP8QCp8EYkOIjBCrYWjRg5RDbs=
Received: by mail-wr1-f54.google.com with SMTP id e1so13723606wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:07:26 -0700 (PDT)
X-Gm-Message-State: AOAM532sRuNIOnhHvnGGSAb/UVj4ZXllL3jXppWS0HnOSTIGR6XbDjl6
        LkFcEJy0ECEq/IQs8itw657ruz7a7a5xeIAJ+igIqA==
X-Google-Smtp-Source: ABdhPJyd+wgT8H6utEjJItlzB1q8h/e0LIVRSStKNHBDkAsHlYOWtY0HmTMXlhHyLzfpOzIt952NKHWEOhYSJ0ADk8s=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr21878009wro.70.1589843244857;
 Mon, 18 May 2020 16:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235124.999721601@linutronix.de>
In-Reply-To: <20200515235124.999721601@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:07:13 -0700
X-Gmail-Original-Message-ID: <CALCETrX4_r0Pa3NpMA7Oec_kjR9bpyEjG2QajoHptG3jgAMu1Q@mail.gmail.com>
Message-ID: <CALCETrX4_r0Pa3NpMA7Oec_kjR9bpyEjG2QajoHptG3jgAMu1Q@mail.gmail.com>
Subject: Re: [patch V6 06/37] genirq: Provde __irq_enter/exit_raw()
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

Reviewed-by: Andy Lutomirski <luto@kernel.org>
