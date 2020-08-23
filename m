Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0425224F065
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 01:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHWXDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 19:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgHWXDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:03:47 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1F020768
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598223827;
        bh=jBUme/XbahWR2rDPGjnU9WIaSk+4ze9DM9lqZ4h0aBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ix6AL38bR9EJjw8T6WO7S9w8Gp+VE+lf1u9RonhDbt6siQJCZimie0ME8T4PX+0kv
         lQTB9sRGAqyYg2Xm0xO7xrqO74TRYHxVt1h4ZVXKXqR87KTPyj79GiOSSeBvwuayFl
         ifkSO7bHM6+l8o81o/p9122pdTJI0qbPvAf5D0r4=
Received: by mail-wm1-f47.google.com with SMTP id t2so6404308wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 16:03:46 -0700 (PDT)
X-Gm-Message-State: AOAM532Um4avZrdXtQ+URhGmLWjODN40pgR67GNkaLZZRceK6Q81eNJa
        LdRc8+498V06p1VAXTKXpkC+QFPUs8Z3XsSffvvjPw==
X-Google-Smtp-Source: ABdhPJwwETcEqsI7u36ASK9skGyItuYMl8385U6bR5uol7GO+vYuxRQIkOhDQaZ1wnO+5SV/y4PtMErADyBtBS9ENPU=
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr2884793wmk.176.1598223825437;
 Sun, 23 Aug 2020 16:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200821093912.815135402@infradead.org> <20200821102052.851667174@infradead.org>
In-Reply-To: <20200821102052.851667174@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Aug 2020 16:03:34 -0700
X-Gmail-Original-Message-ID: <CALCETrWN2YBd=VSiiCo40hFvaHn0uYLh=pmrO0aH6o01uVjjCg@mail.gmail.com>
Message-ID: <CALCETrWN2YBd=VSiiCo40hFvaHn0uYLh=pmrO0aH6o01uVjjCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] x86/debug: Sync BTF earlier
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Move the BTF sync near the DR6 load, as this will be the only common
> code guaranteed to run on every #DB.

I don't think this code is strictly correct, but I think your change is
still an improvement.

Acked-by: Andy Lutomirski <luto@kernel.org>
