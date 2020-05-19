Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7B1DA248
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgESUNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgESUNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:13:20 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6804A20873
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919199;
        bh=9NZsvYQ6ewI+7zKbe7RoQSsXiOldxw/MbYtAogsMHvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O1XnzQ8/H9KoqmA0KUZdEXfFjvNSqi81zvozYARXdm40i8hKiLuwwJUhdtdGFIi3b
         AQkWn9d0a1MzH9NxL9YWTqkMiJ93GnoCZFch+Hf1ujwkCSSBzAIawdPimvR7ECequ4
         B2D6lmzT1el992Ff41CH0hp7i5IKh+f+m96GX0tQ=
Received: by mail-wm1-f45.google.com with SMTP id h4so505201wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:13:19 -0700 (PDT)
X-Gm-Message-State: AOAM531v33VZ9tkL+uWQmvhhFvmNoHMKCS6P9+wMdGBwVIDXZaQrNt6c
        zlY/oiu75oMUkI/HWHHSNoxqwv3yCQeS3EgpjK0ivQ==
X-Google-Smtp-Source: ABdhPJx3qSXBm4AlqzAQo6+pYSodcWQ0s9IPQK37A6V5ZPvDbjWGRsKY5YG+nazORP+m5G0Z9upVOIY/EluBTXOuoCk=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr1150725wmr.49.1589919197874;
 Tue, 19 May 2020 13:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.813664171@linutronix.de>
In-Reply-To: <20200515235125.813664171@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:13:06 -0700
X-Gmail-Original-Message-ID: <CALCETrUV1jC19H_EUFxF3pbqHgq2Nk8J-jpVWX4t_tf9NOUZVw@mail.gmail.com>
Message-ID: <CALCETrUV1jC19H_EUFxF3pbqHgq2Nk8J-jpVWX4t_tf9NOUZVw@mail.gmail.com>
Subject: Re: [patch V6 14/37] x86/entry: Remove the transition leftovers
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
>
> Now that all exceptions are converted over the sane flag is not longer
> needed. Also the vector argument of idtentry_body on 64 bit is pointless
> now.

Acked-by: Andy Lutomirski <luto@kernel.org>
