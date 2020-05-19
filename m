Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50B81D9F79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgESS2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgESS2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:28:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1789CC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:28:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so813333ljo.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAQPJr9ukcoBKjOXNq0ngI2FbToix/GR1U4DwPpfSy0=;
        b=JjHp/TA1wdi209GQDxk83iIpqXnffl3eJS5MEEAgukuWcKDbwj37gts7DFLkHruGuU
         nuDn1vvGhdSeq273vqMgVsMiaMP4nc1F6Pk64YouAMejNS/pKU4WwKHY+HH7P561hq9G
         XIbucUyW2ftN8EdLLtxsWXuyZC+00nekrisfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAQPJr9ukcoBKjOXNq0ngI2FbToix/GR1U4DwPpfSy0=;
        b=DFCtYrFCZkc9nrNAEmghx+LgZqkoDpnPnwCnJOP6Wh2lYo8CclDQjU0UfGMkpFEapW
         LN95CYgmUkO/QQXrHAhJa6P5yaa0rhR3uXRwwFjArk/vhvV+K2bVBLW8bjvnmMj/Kz08
         /GxLKh7MwP1+dVZfO6H+fKpD2Fb+lpB6DOJFUBoHlcEhDoo6Bp/mbMIrdYKFq+625DzU
         HhP7S0iXXZ702nQqaurfLCTesBnisd/LNDldA+A0iHGePLIZUzUYPVQucH+eRoFqY3jP
         /eFAvM87R0f2nkQ+wFf1Ud+5T4YswXnNyY4DroycO5pifSlhoFVBi6H3SwvBzX1XqBC2
         rKgg==
X-Gm-Message-State: AOAM533McqqkgL4nlNtYV1f10j418VWbqDhdhZKai2+Epric79Df1Oea
        IyXDwfbW2TWQe42P7Y3V4S1C4ioj2eU=
X-Google-Smtp-Source: ABdhPJyiEh2/Ps39RfSHvaWStqTRJGg0z9fEAZDejYVMeJgLRREpg2DabJztJ7yTbYN3XkEqVQnDsQ==
X-Received: by 2002:a2e:8310:: with SMTP id a16mr438379ljh.194.1589912911976;
        Tue, 19 May 2020 11:28:31 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g3sm227150ljk.27.2020.05.19.11.28.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 11:28:31 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id x27so346840lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:28:30 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr156726lfn.10.1589912910469;
 Tue, 19 May 2020 11:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <871rng22dm.fsf_-_@x220.int.ebiederm.org> <202005191101.1D420E03@keescook>
In-Reply-To: <202005191101.1D420E03@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 11:28:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Message-ID: <CAHk-=wjeoeh-F-PJmpYRpR_HoiB4r4qYgd3U6igtrUD6q5d_cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] exec: Teach prepare_exec_creds how exec treats
 uids & gids
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:03 AM Kees Cook <keescook@chromium.org> wrote:
>
> One question, though: why add this, since the repeat calling of the caps
> LSM hook will do this?

I assume it's for the "preserve_creds" case where we don't even end up
setting creds at all.

Yeah, at some point we'll hit a bprm handler that doesn't set
'preserve_creds', and it all does get set in the end, but that's not
statically all that obvious.

I think it makes sense to initialize as much as possible from the
generic code, and rely as little as possible on what the binfmt
handlers end up actually doing.

              Linus
