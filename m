Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9E729E042
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgJ2BMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404300AbgJ2BMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:12:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF6C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:12:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h6so1227623lfj.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+uYu86LDWGsnC4W37LGE2qpMcN2MpffcV3JWIw2MFQ=;
        b=vciGCxCgV8AP2QARHScqr2zKoGS/+nJtrToSziCQ8d8h1NRdDiev7b4FY2OwCqgP1d
         pQbxRv3nm4M5jbQFhB27QEFUsCLY1i6eh1m09u0GR/aIZBCnQqfxLzxjTF3jSSNq63Ix
         7tc/61a9Eg7G4x1Q2ubkcaETyM84zF0DBSoX0Z35kXIp9RaUo5oEwdbRcGo1NCv5ThrS
         xv91Ll0nIZQR9E4a8eCFWpzRS93StI1OfrXVYHm3aQtiSQCjRfQnJM7yFQeATQ7e3KqK
         nI1O4QIZNutVL1kAoz9zNnzUTHY2AP0CtWCW2iHkQa6Wv2OlTNpHsTkIDscq6Ww8Qb6w
         b/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+uYu86LDWGsnC4W37LGE2qpMcN2MpffcV3JWIw2MFQ=;
        b=dQgWCquPiUTQ4tc7LhlBBwiA8LIUwt16aX2o39rp5L+wRDMW0MUFJlUdEd0D4Cs0U6
         2USEjOsVfFYECeVeL6p8J6g3WPnjlCTAqyOj8tKyb0ICTpChFZ/77aqeNy07XP631Sni
         zU0lOqiqH5kizHATI+vLSVxa147elu8CwY6w52SvFN/fztuKi3KJunH9mFgY+EMyN5vB
         q9coWSefWHCSVEwWZsmPbx36zC6LXukezltOx60GOvg+3CCl8GaOpFGhpdWHC+iDLAIX
         SGezpK7LahvRoWbui3F2ZuU4WlctEv5uee6Bh+FXTYWYvVc6TsA+Wr+ZRoCzHz0zTj4h
         qoMA==
X-Gm-Message-State: AOAM531phJeBPmOqIREBiJwU8GhZBX4tPLXtXEdulLiSHQh4tf36Ir2r
        Mxt8Cx5La9PskVIdH460IepWkaW7nnq1qeQifYYHpw==
X-Google-Smtp-Source: ABdhPJzzc/J1JBJXAToRCeQHDdOVsoNE6U9yTJzDUPWdlDCEb1Uk4v5ySj0pBCeZjS4xxD+zSOrd96XH4omhzWIDEkE=
X-Received: by 2002:a19:83c1:: with SMTP id f184mr559337lfd.97.1603933926604;
 Wed, 28 Oct 2020 18:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco> <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco> <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco> <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <202010251725.2BD96926E3@keescook> <CAG48ez2b-fnsp8YAR=H5uRMT4bBTid_hyU4m6KavHxDko1Efog@mail.gmail.com>
 <CAG48ez2OWhpH3HHUJSrAmokJ8=SVwKrmQMSw0gEbTJmKE4myCw@mail.gmail.com> <202010281553.A72E162A7@keescook>
In-Reply-To: <202010281553.A72E162A7@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:11:39 +0100
Message-ID: <CAG48ez0FS49ki=RfO_nrSnwH32g9oRS73OSUOhz6tVh+YwCNLg@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:56 PM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Oct 26, 2020 at 11:31:01AM +0100, Jann Horn wrote:
> > Or I guess we could also just set O_NONBLOCK on the fd by default?
> > Since the one existing user is eventloop-based...
>
> I thought about that initially, but it rubs me the wrong way: it
> violates least-surprise for me. File descriptors are expected to be
> default-blocking. It *is* a special fd, though, so maybe it could work.
> The only case I can think of it would break would be ioctl-loop case
> that is already buggy in that it didn't handle non-zero returns?

We don't have any actual users that use the API that way outside of
the kernel's selftest/sample code, right?
