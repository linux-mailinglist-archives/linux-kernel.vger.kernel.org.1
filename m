Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA431BB557
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 06:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1E2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 00:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgD1E2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:28:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E908C03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:28:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so19927247ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RSyS91ue6QSNeGHcujNqLf4sDv6GWUKUU7b87h1dlwI=;
        b=T1sHGGHIcDlws2EsAOMwHtaHo6fMU2cwytBuSPDwljmvSXHN2cjJGQJr7oKQd8yI7p
         2NPc8079weDg84X/y5vKiERnNUOYAcwho2XpslbuzmDQEe3cG8XdTAOyVGeBHdfwOz3T
         Nz9c6aNibqCKxiJ4zKRWAbhLvSdOppDkluANY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RSyS91ue6QSNeGHcujNqLf4sDv6GWUKUU7b87h1dlwI=;
        b=uTiEJhcb2+K4H2YJD+QmEnePCRMaaosPA5lBeTnNir/Iup/8EPHExFROyl3M3zGNOA
         592yUGoJMJ6gWLZno53k2oqbslMyPlyjwaAs+M2Nu0I+bLZ7aF5jE4u+89qo32dWrYEo
         D9nSCmUPIVKQ+LJMHH2IcpKcQf50kK1pHkKDzG/6iXE9I8iLmazMQQfP4yNzuHn9tCCb
         Eu9Q41V2iVFc9Mnwgyq38kIjMZWAZhHQ0BJHtX+wcJoQ1AKXpw4nXKmsd6cvhHm+7bPV
         vYb3klZcHu7A3SLH9TD3Sf/ODw+UNNMg4mVSZGEHzFfsb6kGfKOdHVbSVyHMrzD7Rz7S
         A61A==
X-Gm-Message-State: AGi0PuaY48q50KK6cD+1zRMlQHuwZsbWnIAJfvTGSaO8XStFk8gUii5y
        +M5PsEkos91cJgkX9dslnu/p8haZ29s=
X-Google-Smtp-Source: APiQypJSZk/E4ZiPhwwKMMYwRX0JHRNotu24FB9rgm5Kz7DdWQKREERUT2qQlT22lI+yx6BhlDCgNA==
X-Received: by 2002:a2e:8944:: with SMTP id b4mr16466685ljk.84.1588048112285;
        Mon, 27 Apr 2020 21:28:32 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id t3sm11595731ljo.51.2020.04.27.21.28.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:28:31 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id y4so19996454ljn.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:28:30 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr14918617ljj.265.1588048110408;
 Mon, 27 Apr 2020 21:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
In-Reply-To: <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 21:28:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Message-ID: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 9:17 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> I hate to say this, but I=E2=80=99m not convinced that asking the gdb fol=
ks is
> the right approach. GDB has an ancient architecture and is
> *incredibly* buggy. I=E2=80=99m sure ptrace is somewhere on the pain poin=
t
> list, but I suspect it=E2=80=99s utterly dwarfed by everything else.

You may be right. However, if gdbn isn't going to use it, then I
seriously don't think it's worth changing much.

It might be worth looking at people who don't use ptrace() for
debugging, but for "incidental" reasons. IOW sandboxing, tracing,
things like that.

Maybe those people want things that are simpler and don't actually
need the kinds of hard serialization that ptrace() wants.

I'd rather add a few really simple things that might not be a full
complement of operations for a debugger, but exactly because they
aren't a full debugger, maybe they are things that we can tell are
obviously secure and simple?

               Linus
