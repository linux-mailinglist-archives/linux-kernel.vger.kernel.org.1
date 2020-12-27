Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607542E3169
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgL0OAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 09:00:08 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:33716 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgL0OAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 09:00:07 -0500
Date:   Sun, 27 Dec 2020 13:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609077564;
        bh=YljSvU7AD7QZcNa1WxrVV3YXtj4LJS3zWAnWwLu+YdA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DlSga1RDI35jH7OyuyfnRdQpU7t7h0g7Lgf+e3vNkYtFTSvjV1Gfp+2fLnNS0gZWP
         35nYnspdqU+KhExqPaBNCaLSH37GZu2IwH48o4KjmMVRXfvNXU15gztsWd++c8q+bH
         L0ZXyFfRV/dzkr6+oelyu/IENWuzVz86BumTwgEg=
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Stephen Boyd <swboyd@chromium.org>, rcu@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH] docs: Fix reST markup when linking to sections
Message-ID: <C83MDQBAV3L7.2F306EF3F3Z6H@ArchWay>
In-Reply-To: <20201227105949.549cc6ea@coco.lan>
References: <20201226131759.724711-1-nfraprado@protonmail.com> <20201227105949.549cc6ea@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Dec 27, 2020 at 6:59 AM -03, Mauro Carvalho Chehab wrote:
> Well, docutils define two types of references at:
>
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#refere=
nce-names
>
> The first one are "simple reference names", defined as:
>
> ``Simple reference names are single words consisting of
> alphanumerics plus isolated (no two adjacent) internal
> hyphens, underscores, periods, colons and plus signs;
> no whitespace or other characters are allowed.``
>
> On this type, "-_.,+" characters are allowed. "%" and "#" aren't.
>
> The second one is "phrase-references", defined as:
>
> ``Reference names using punctuation or whose names are phrases (two or
> more space-separated words) are called "phrase-references".``
>
> Here, the spec doesn't specify the charset associated with
> "punctuation".
>
> As this kind of reference is auto-generated from the chapter titles,
> I would expect it to allow all ASCII punctuation characters
> (e. g. all non-alphanumeric symbols between 0x20-0x7f).
>
> So, a reference like those:
> #Summary
> #Forcing%20Quiescent%20States
>
> Violates the spec, as it would be a simple reference with invalid
> chars, but:
>
> #Forcing Quiescent States
>
> Should be valid, according with the spec (still, while doing such
> cleanup, I would remove "#").
>
> I would add something like the above at the patch description.

Indeed, some of those references aren't even valid according to the spec, b=
ut
that isn't even the real issue. The issue is that they only work in html. T=
hey
*don't* work in the LaTeX pdf (already supported) and in the rst2pdf's pdf =
(not
yet supported).=20

Even "#Forcing Quiescent States" only works in html, and doesn't in pdf.
"Forcing Quiescent States_", on the other hand, works in all of them. More
details below.

I should have been more clear in the commit message about that, and I will =
for
v2.

> > @@ -596,7 +596,7 @@ maintain ordering. For example, if the callback fun=
ction wakes up a task
> >  that runs on some other CPU, proper ordering must in place in both the
> >  callback function and the task being awakened. To see why this is
> >  important, consider the top half of the `grace-period
> > -cleanup <#Grace-Period%20Cleanup>`__ diagram. The callback might be
> > +cleanup <Grace-Period Cleanup_>`__ diagram. The callback might be
> >  running on a CPU corresponding to the leftmost leaf ``rcu_node``
> >  structure, and awaken a task that is to run on a CPU corresponding to
> >  the rightmost leaf ``rcu_node`` structure, and the grace-period kernel
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/D=
ocumentation/RCU/Design/Requirements/Requirements.rst
> > index 1ae79a10a8de..d4125caf394e 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -45,7 +45,7 @@ requirements:
> >  #. `Other RCU Flavors`_
> >  #. `Possible Future Changes`_
> >
> > -This is followed by a `summary <#Summary>`__, however, the answers to
> > +This is followed by a `summary <Summary_>`__, however, the answers to
>
> Hmm... why are you ending "Summary" with a "_"? This should be
> equivalent to:
>
> `summary <summary>`__

Actually, that doesn't work. To reference a target in rst, like a section, =
an _
is needed at the end of the reference (and when it is a named link, this ha=
ppens
inside the <>). Take a look at [1].

While reading [1], though, I noticed that it should also be possible to not
have the link anonymous, that is, to use _ instead of __ at the end. And th=
at
fails in rst2pdf specifically, so that's an issue I'll report there.

> In this specific case, however, you could use, instead[1]:
>
> summary_
>
> as there's no need to use an indirect hyperlink target here.

You're right, this does work. I didn't realize these references were
case-insensitive. So for v2, I'll also see if there are any other reference=
s in
my patch whose text only differs the target in casing, and use this simplif=
ied
syntax for those.

Thanks,
N=C3=ADcolas

[1] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#embe=
dded-uris-and-aliases

