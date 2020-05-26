Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173F11D25F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 06:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgENErH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 00:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENErH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:47:07 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEEDF20709
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431627;
        bh=v2k338ZVKb2TLymC3FOJ/qsujLq2OYj+f52HHqgoWn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wy+s/w4FjEDtVchV8rqRwyVLyCLQokXtNbuRlZFWp85TOObbFxCebIpRItBzH0O0y
         fEFNAa077tKvtsnaA3e5YwLENjw02TmacFBLuApPRIwCd5SfV/BusW/aiHWM6IYo0f
         ojBQs7c2IYC8ZI+kSDr2mQcZUxkiOi8+7b0qgjtI=
Received: by mail-wr1-f45.google.com with SMTP id w7so2059997wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:47:06 -0700 (PDT)
X-Gm-Message-State: AOAM532KI+GbIUbUh0sgpoPrMVlCtrklnWZIoggTOk3vxB3+aY9S4KuE
        68I4Aoe09UHWm4CJiz0ECjPUX7jzcXYRJft7h1dBhg==
X-Google-Smtp-Source: ABdhPJwCwE9amHd0SB0x6mmFz3XDxiugtWB4VDwrOqMUKew1TSt/Ihs8x2TQdYfP0w+iJO2vUpRPpr3FBaM5OsoFIJw=
X-Received: by 2002:adf:a298:: with SMTP id s24mr3048386wra.184.1589431624875;
 Wed, 13 May 2020 21:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.258989060@linutronix.de>
In-Reply-To: <20200505134905.258989060@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:46:53 -0700
X-Gmail-Original-Message-ID: <CALCETrUwQ_1APnsL3kRKoQF53Hkdc0yLYWHvEmwvA3qksQx-+A@mail.gmail.com>
Message-ID: <CALCETrUwQ_1APnsL3kRKoQF53Hkdc0yLYWHvEmwvA3qksQx-+A@mail.gmail.com>
Subject: Re: [patch V4 part 3 20/29] x86/entry: Provide IDTENTRY_ERRORCODE
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
> Same as IDTENTRY but the C entry point has an error code argument.
>


Acked-by: Andy Lutomirski <luto@kernel.org>
