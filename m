Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B4298F69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781568AbgJZOeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:34:19 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:37913 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780904AbgJZOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:33:25 -0400
Received: by mail-ej1-f41.google.com with SMTP id ce10so13879991ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=E/rHwyHstBtFx+2oIPLuGDkFNZ5+Epy0kc85HssH4xs=;
        b=SFQbPyIve02J4LqaTq6zkgkhCIEgOdzT6Qmg7jEMouLEnl1ISwPn9SuwdtPNhhrJEs
         ryXxIh9FfvtoBg2uxNTBY3C92pIq03vmyEm97fuZDziJPWb0mxibI4KvimqjoqyrY0E2
         2MPcJTN59Yz2ZgzdGp4EPbBNhqV9f7iBxUs1rLvTXryewsSlc0eQteq+jqgtX4EB/w6B
         To+NWxt2h8WWtc9S7KB9WBaHqMoKMwpBEfRgxwioWpn86UnpnoRbgrCiXDe0a3eEfrs9
         Ep+SQdzeD5n6l2qrVuUNvuotBCW+NxxKnJC0DTXs4jHPag/hQWT1OyW8FL0+ElRL9YmQ
         wkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=E/rHwyHstBtFx+2oIPLuGDkFNZ5+Epy0kc85HssH4xs=;
        b=IKZ8wTOzODDJIWFBWZRB1XeVc+sDDgzgrc4YqLW0rCA+sRwB18FJ/Ue8ZWL2HawqRs
         MYYgAA2Swy+osBbwxH/iqJZV0394nGWrX26PeRVJznVPxk1Zv0iqmPy1UD9GZNqGqEBm
         Qaf4JYUq/K8WcKk3mPJjL1fCfkFm9XWQpmj/6KaSzI1ziI2kj2xBg+ci6CGSaAwg9Kdn
         nmoiFjikGQ9nDXoDb6HY1ylZirGK9aBfcpUd/QnIRBnTHEGn9vgdLc2tyDlSdD8AEVad
         zYhkRxu7t8nl7ZVhTHFZni/4/X8oZ1eb8t2l4/VXpSZc4Y8boNxIYPbgtevacrSQ9pGO
         x7bA==
X-Gm-Message-State: AOAM5317J6AOfaURHhpvug7LAo/9fM1hwKRnePN/xFjTj600bmeJ2zTX
        bsz3Gs4jdjc3L+hlilOnAxLLndhk9iPD47vU0cnZhxn6jaOaXJSM
X-Google-Smtp-Source: ABdhPJxZ2lGDG0TsL8425km3QyMmh8Zl1x0eua3hQt1rDFExFM1Xyzku+3GcwNv4HHtJjL/5/HWs+xFMfhmQd4WrfFs=
X-Received: by 2002:a17:906:b285:: with SMTP id q5mr16495210ejz.135.1603722802857;
 Mon, 26 Oct 2020 07:33:22 -0700 (PDT)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 26 Oct 2020 07:33:08 -0700
Message-ID: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
Subject: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no longer
 reported in dr6
To:     open list <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After resuming a ptracee with PTRACE_SINGLESTEP, in the following
ptrace stop retrieving the dr6 value for the tracee gets a value that
does not include DR_STEP (it is in fact always DR6_RESERVED). I
bisected this to the 13cb73490f475f8e7669f9288be0bcfa85399b1f merge. I
did not bisect further.

I don't see any handling to ever set DR_STEP in virtual_dr6, so I
think this code is just broken.

Sorry for not testing this when I was CCd on the original patch series :)

- Kyle
