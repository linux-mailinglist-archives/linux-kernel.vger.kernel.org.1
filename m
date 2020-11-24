Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4AF2C3004
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404268AbgKXSfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:35:21 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44471 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390718AbgKXSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:35:19 -0500
Received: by mail-ej1-f65.google.com with SMTP id k9so15125819ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02zyVIZESHQBccfGArgKEYjRejMAdJsOe44mFAYJcQU=;
        b=A3tOceFvUr7GL88O5JpLkj9VvF2nHIwp9JBf+L/LAaKK3fJPPA3VYN6S+BnaAhzrLc
         nTH1lI1fJAu+12TUwjmNew0O+Gr71TgC6ofS/CZFx/Wc6fmSbFS6TN3a39HpGKdnpr1m
         HpuepVqSQ+Vn6YrhqStYz9h37TSqQoQAxB2BxlpQ8WkqQPTAhiSCCug4PPrQjGuxaO8C
         4oQq3Ytelxw2nloEa6g5co7uIdy8THghWhGIRGJjeqATKAUHtELtJNtN+AKD8uq+G7An
         iadWSrMakO4RSpgEtowYwOvFSleX00CuR5BfK+/ZAadScre4NhXuuWXhcKv6CwMegb6u
         CD0Q==
X-Gm-Message-State: AOAM533fUmlbUcstQ/QuT11cGFb4AEraWEM7QgtytWdCNkVueTpBjmyf
        8ZMv7nF0cSAIuP81Dw63RFEIGja6nqdKRm3utbU=
X-Google-Smtp-Source: ABdhPJz7q44nigsvJWkTLUNxZV5uuGyLBmOdtoJx+It6cKroBZsj74spoBKK5HiHnuC8Q5poZfEFFIt1uptnrqMFPns=
X-Received: by 2002:a17:906:578b:: with SMTP id k11mr5466043ejq.330.1606242918760;
 Tue, 24 Nov 2020 10:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
 <20201119233257.2939-15-chang.seok.bae@intel.com> <CALCETrWhw_PfdhTY6zzewwwwB35x5LFDouZJ8+C_pcePNc69-w@mail.gmail.com>
In-Reply-To: <CALCETrWhw_PfdhTY6zzewwwwB35x5LFDouZJ8+C_pcePNc69-w@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 24 Nov 2020 13:35:07 -0500
Message-ID: <CAJvTdK=DKWrLSpmrxEc6JDT=dHrHxXNOuj-iQVW_FvFxBcfPAQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/22] x86/fpu/xstate: Inherit dynamic user state when
 used in the parent
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:08 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >
> > When a new task is created, the kernel copies all the states from the
> > parent. If the parent already has any dynamic user state in use, the new
> > task has to expand the XSAVE buffer to save them. Also, disable the
> > associated first-use fault.
>
> This seems like a mistake.  If init uses AMX for some misguided
> reason, ever task on the whole system will end up with AMX state
> allocated.

Andy, you are right -- the child can (and should) start with the
un-expanded context switch buffer, and as a result XFD should be armed
to fire on the child's first access to TMM hardware.

TMM registers are scratchpad, they will never be used to pass globals,
say, from parent to child thread.
Further, they are volatile and caller saved.  The callee can assume
they are empty -- so even by virtue of being in a fork system call,
that state is already gone.

thanks,
Len Brown, Intel Open Source Technology Center
