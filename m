Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367781D452F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 07:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgEOF0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 01:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbgEOF0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:26:32 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C159A2065F
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520392;
        bh=VUmFIrlWsW2f8Q7aDNt8jAyUcPvWfwfAVEl+roNWc8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OJ7pzOLa+30H7JSndKuuzZbh+sJ8M2bwgqdk/+VSK8falT0AgSEhNW7wWLEpDsb/v
         3dvEexa8iUhoh0XYFQcf+0VHAwLBQi5rlhdk057hYNEk4fotaOlWboWeJnGcOmoNF/
         LK13UPma5dT9+hbl2+oFwBd1lDXpVxLmaQDz4JZE=
Received: by mail-wm1-f45.google.com with SMTP id m12so942495wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:26:31 -0700 (PDT)
X-Gm-Message-State: AOAM530TXMmzJAkm5W4Fzrs8pj/9zAIBV8tGsQ5C/cPnql6IMV0hMuOO
        F1orDPL8OZcLp2kYrFe/VPdT3czfA0W/S7HTs/s0Lw==
X-Google-Smtp-Source: ABdhPJyiUq0pJ3GKHkqNIDZEJ1rC/+ZRu5jJqr8iA8bwmxRaLkZQZeNo5+WHk4Fb4AdwuLxq1xubGAi4RWfE95NqJ1I=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr1945537wme.176.1589520390331;
 Thu, 14 May 2020 22:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.609932306@linutronix.de>
In-Reply-To: <20200505135314.609932306@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:26:19 -0700
X-Gmail-Original-Message-ID: <CALCETrU0M9cET0-td2_XdQKiYYxwDsE20n+J4o9Cdk7sKbLesQ@mail.gmail.com>
Message-ID: <CALCETrU0M9cET0-td2_XdQKiYYxwDsE20n+J4o9Cdk7sKbLesQ@mail.gmail.com>
Subject: Re: [patch V4 part 4 13/24] x86/entry: Convert NMI to IDTENTRY_NMI
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
> Convert #NMI to IDTENTRY_NMI:
>   - Implement the C entry point with DEFINE_IDTENTRY_NMI
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
