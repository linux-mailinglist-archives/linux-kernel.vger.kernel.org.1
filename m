Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551202A3E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKCILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgKCILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:11:09 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BFFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:11:08 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id m9so3924989iox.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWNEcvYHB1Y+hYGFC0n25x7P0WSWWMjwyFtXRi1KVuc=;
        b=WIVn5uphjuvxZyJn06lfWTowtZ7KxvFDIHfU4LM3/vHTIGvTPCkuYQJUOKsgAdQxuo
         Q7ckz+8b+vcpj2IhVBOWLnW2HQKvOD0DVeoIftB/QKHZeGOtcRLYzOhjx5l1J2XbOmEB
         3xMGIi1itApit8gOK6UN18yMh2bEKbz7Gb61oM4VFASLAiiuEK8WHC4N7mKmEuf8M/8S
         Uh7wWL9Ua/3l78eoi4pXvIZRQXVGBfOOiVfdph/PRp/auZpeqsyYxonQFl62C/UY+Xr/
         D0QbovbM/C5XglVBGvgpt31RmPRjGuJ4hdD5L/cjGURDakj2dOQSiAgD8lFwMXGP9yOO
         id5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWNEcvYHB1Y+hYGFC0n25x7P0WSWWMjwyFtXRi1KVuc=;
        b=VVj+CcgvHzy3Y9YU75/urGUvK4SI387FgDVAPHlXWsLl1HCXZ1QEKfhvA0fNzHaQKf
         6qA4ovVY/Mz036mkbLP890ZZCnvCPQBGtuQjaH+kTwbYi67lZuOwX23nL3fZa8aPsaSJ
         BoUy+nQF4DzP4jZEbjlONZr/FB9YWFO7l26m/Q3dWXiaTFGTZ8hSSLqlkXqYgfUohnuR
         s7CHF3AbAodJcMYZU5aMbv1KFVCcaJq3tDL9PTyI/C91X5eRdi1sYGDFpVZ8JrS6hc6a
         GRvR7qcsGQWewXUPmI4k0Why0AtvC60CH4wPfdrRwb1p6IQ36sH5eYY6G94JNZrYSRjw
         e5wQ==
X-Gm-Message-State: AOAM530cFtJoBGnLJ1M6T78RHdVyUz/fbQASdys/eQ2zjWDcjcgJUMV8
        7u33mdxd9ZNzq9KBxl6YbjrK8gP56IM90xPr0rcDdfxY6CE=
X-Google-Smtp-Source: ABdhPJzSJwDJoErUxdthW2TS1p6R8cFpiAGMGXVdITnOSnwZCtXtdKBT1Gkl4Pwe+ETTYi63amCPX1kdS7W3DXuCBW0=
X-Received: by 2002:a5e:9743:: with SMTP id h3mr13036096ioq.158.1604391068175;
 Tue, 03 Nov 2020 00:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20201103054810.21978-1-dwaipayanray1@gmail.com>
 <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com> <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
In-Reply-To: <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 3 Nov 2020 09:10:54 +0100
Message-ID: <CAKXUXMwH+tEBSV6xA952xQQFe+HvdJ5ew6V=n63sk89enj6p7Q@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: improve email parsing
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 8:28 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-11-03 at 11:28 +0530, Dwaipayan Ray wrote:
> > On Tue, Nov 3, 2020 at 11:18 AM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > >
> > > checkpatch doesn't report warnings for many common mistakes
> > > in emails. Some of which are trailing commas and incorrect
> > > use of email comments.
> > >
> > > At the same time several false positives are reported due to
> > > incorrect handling of mail comments. The most common of which
> > > is due to the pattern:
> > >
> > > <stable@vger.kernel.org> # X.X
> > >
> > > Improve email parsing mechanism in checkpatch.
> > >
> > > What is added:
> > >
> > > - Support for multiple name/address comments.
> > > - Improved handling of quoted names.
> > > - Sanitize improperly formatted comments.
> > > - Sanitize trailing semicolon or dot after email.
> []
> > What do you think? Should warnings for the names which should
> > be quoted be reported considering this result?
>
> Clearly the quote suggestion is unnecessary.
>
> I think that "cc: stable@(?:vger\.)?kernel\.org" should be
> treated differently from other forms of invalid/odd address lines.
>
> My suggestion is that the case insensitive form of
>
> Cc: stable@vger.kernel.org
>
> or only another similar case insensitive forms with a
> # comment separator like
>
> Cc: <stable@vger.kernel.org> # some comment
>
> be acceptable for stable.
>
> All other forms with stable@ should emit some message.
>

I agree that handling stable@vger.kernel.org should be a special case.

We can even ask Greg KH and Sasha if they have certain preferences for
the format of this meta information after the #, so that their scripts
could pick this up.

> And other <foo>-by: and cc: addresses should only have a form like
>
> Signed-off-by: "Full.Name" (possible comment) <email@domain.tld>
> or
> Signed-off-by: Full Name (possible comment) <email@domain.tld>
>
> etc..
>
> and any additional content after .tld in the email address be flagged
> with some message like "unexpected content after email address" rather
> than "might be better as".
>

I agree with refining the error message here. Also, Aditya, Dwaipayan,
here we can probably have some suitable fix methods, e.g., detect
where the parsing fails (a missing ">" or a space where the should not
be one, or a just few characters at the end, or a long list of email
addresses which should be split etc.

Maybe you can coordinate among each other who would want to create
suitable fix rules here?

Also, start with the class of the most frequent mistakes for
unexpected content after email addresses.

I imagine that a maintainer can simply run a tag sanitizing script
which just cleans up those stupid mistakes before creating their git
trees or sending git pulls to Linus. Let us try to add these
sanitizing rules to checkpatch.pl with fix options for now; if that
sanitizing feature becomes a monster script of its own within
checkpatch.pl, we can refactor that into an independent script for
cleaning up.

Lukas
