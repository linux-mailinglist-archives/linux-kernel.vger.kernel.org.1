Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD58286CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 04:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgJHCPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 22:15:35 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:37828 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgJHCPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 22:15:35 -0400
Date:   Thu, 08 Oct 2020 02:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602123332;
        bh=B1wAESJVuS+GsSF9/mSAS6lCbLjALb6I1zRkvEvPt2o=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=FzTwjWcDKbLTkEyoxW0ckGM3jACHqyEfAW/3pyqXtqgeIc86XlUFSzyMF6qk/Y2SU
         m7/CkHVgILUYKEDQwFFltk0vDnnaUDB5UIigYgntTlRi5OWs42caV1eTrIjt1uYl4D
         XKrP+qM6FifHAVUtJFDZ7fzNTLT0+mfyrOfHi47M=
To:     Matthew Wilcox <willy@infradead.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH] docs: Make automarkup ready for Sphinx 3.1+
Message-ID: <C674RBXSO9XN.1LXXU71QQNTF1@ArchWay>
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

On Wed Oct 7, 2020 at 8:40 PM -03, Matthew Wilcox wrote:
>
> On Wed, Oct 07, 2020 at 11:12:25PM +0000, N=C3=ADcolas F. R. A. Prado wro=
te:
> > While Sphinx 2 used a single c:type role for struct, union, enum and
> > typedef, Sphinx 3 uses a specific role for each one.
> > To keep backward compatibility, detect the Sphinx version and use the
> > correct roles for that version.
> >
> > Also, Sphinx 3 is more strict with its C domain and generated warnings,
> > exposing issues in the parsing.
> > To fix the warnings, make the C regexes use ASCII, ensure the
> > expressions only match the beginning of words and skip trying to
> > cross-reference C reserved words.
>
> Thank you for doing this!
>
> I have a feature request ... could you automarkup NULL as being
> :c:macro?
> Or maybe just anything matching \<[[:upper:]_[:digit:]]*\>
> (i may have my regex syntax confused ... a word composed of any
> arrangement of upper-case, digits and underscores.)

I think what you are suggesting are two separate things.

For NULL, what you're interested in is that it appears in a monospaced font=
, as
if written ``NULL``, right? As I don't think a cross-reference to "the NULL
macro definition" would make much sense.

While "anything containing only upper-case, digits and underscores" would
actually be for cross-referencing to the definition of the macro symbol in
question, right?

At the moment, this automarkup script is being used only for cross-referenc=
ing,
but it is indeed a generic automarkup script, and could be used for the
formatting of NULL.  But we also can't just make every upper-case word writ=
ten
in monospaced font, as that doesn't always makes sense.

So if I understood your two requests correctly, I think we could:
1. Always automatically format NULL using a literal ``.
2. Try to cross-reference every upper-case word with the macro definition u=
sing
:c:macro, but if the cross-reference doesn't exist, format it normally, sin=
ce
it's just normal text (this is what we're doing for C references at the mom=
ent).

What do you think?

Thanks,
N=C3=ADcolas

