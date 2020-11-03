Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B22A3E49
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKCIDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:03:12 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:03:10 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id i6so20979169lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8mlm/Qp/onAhk8/kvztnd8MhySLP+TPn3sjDt5NLiQ=;
        b=cxW3zUmhRl1EB3w2jHglo2o82jpPpZKF8Gdu2qJZceyQogIHaxCoce4L+DzBT0y5G+
         yauB3QTSzekB1R3Eh9Wn6JB3i75nqp5j/k72WuFRpXp1ytynkuV0be7B3Fw9r/Ob6MxL
         6FtL3PQ3zT6zqSakjJirME5goCPS2XVW9roHWx3232IsDu6oqBIgVmFkUbGQsk9WvtnJ
         cB0K0jjd//W2vLR7ooWoAZMmvfrs40loSbHJ2vo5/fB8CRy6mQyBCoXLUaMbIsCvv+BR
         6U2o+OEPv0LSkZC+YU5vj6mhAXyJ6pV+yRmGEI13H0JC8sXN8D+GCOh92MFxeqXX5PuJ
         Y7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8mlm/Qp/onAhk8/kvztnd8MhySLP+TPn3sjDt5NLiQ=;
        b=LPjhBrTZVHGk02W7TlqxDd2uevlwCKR4wUK06XCWO7iXmL5zflWJoPqWe7RUyXj9BU
         LxOFvDnDIJOGKouXEr4juAZ3MPql/oxlCDHQSgWc7wWzMOkOpt2+MxryLIRcBYE1WmVU
         VEQ8iNcWkiGM0cL5VfzDrX0yLtp+137xrx/OXJC8lUXb9gqQpl6aZVyslTAmrQkdP/xz
         mc6x9wSLSDDZztPY4zGM2+xAKt+BI6HDJ//k0qfdnIN6SYgXzfPN+1hbt6djxkfeKGTq
         uLGEa57LX/lFgcrAX7X/DUL4RO7d/0eaYtDs11WkVt/B47sdjXprdcErLt895+WE52YN
         R3GA==
X-Gm-Message-State: AOAM530tM0ZHmLlFBhGYCzNpvwi04iEbZ7uobFJnzmWEjauYHkqY+4Tr
        4czmvpmrx/upv0Xoi7HcJcd+x2z269HTVLe+teBt8i1iZ6MJ4fGz
X-Google-Smtp-Source: ABdhPJztgVgZuzzhImE3PmiV7kc6P7RWG1BbSzEJkZpReb6ALVgGXw1c4V4FjifQn0T6SL9E9b5zMDkSfxsapPalOlE=
X-Received: by 2002:a19:e016:: with SMTP id x22mr6868888lfg.400.1604390589169;
 Tue, 03 Nov 2020 00:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20201103054810.21978-1-dwaipayanray1@gmail.com>
 <CABJPP5DkJ3gwZDW+FBShs3Yo8z6GfP4LSMRW4hO5hL+fVXjShQ@mail.gmail.com> <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
In-Reply-To: <e9d540c35ac04f0bb69e26d29c76c7cbd5693df8.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 3 Nov 2020 13:32:38 +0530
Message-ID: <CABJPP5D3v9ZGCCqn_wg43H5CN0ff=C8J8jDGYU6LHJBBn6-wAw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: improve email parsing
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 12:58 PM Joe Perches <joe@perches.com> wrote:
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
> What do you think best?
>

Hello,
I think the warning "unexpected content after email" is more reasonable.
But maybe we can allow addresses of type:

Full Name <email@domain.tld> (comment here)
or
Full Name <email@domain.tld> [another comment]

I checked the following:
$ git log --format=email -100000 | grep -P '^(?:[\w\-]+-by:|cc:|CC:|Cc:)' \
| grep -P ".*<\S+\@\S+>\s*(?:\(|\[|\/)" | wc -l
280

And for stable ones, I found another pattern which is common:
Cc: <stable@vger.kernel.org> [X.X]
and only few instances of:
cc: stable@vger.kernel.org (X.X)

Apart from these no other style has been used for stable so far.
Maybe placing it in the generic check would suffice.

So I think we can introduce the unexpected content warning for
anything other than the braces or c89 comment styles. And
maybe a separate check for stable won't be necessary then.

What is your thought on this?

Thanks,
Dwaipayan.
