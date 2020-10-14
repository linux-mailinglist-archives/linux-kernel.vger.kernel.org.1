Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780BD28E7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgJNUJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:09:25 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:25872 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbgJNUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:09:24 -0400
X-Greylist: delayed 75370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 16:09:24 EDT
Date:   Wed, 14 Oct 2020 20:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602706162;
        bh=m+9mUGof6WvkvHmvP4DPlTU5NvCNFlaEPlnO4Gog/ow=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=iyKgt6JLgdpOo3FVStXlZD4ds4/kRh4fACosu8AN3wgSxSD9AoQjioaLT1eg6p0Qi
         aMkIJ8KfjoZpL+rk2/X1vEeJZOKyUxlG37t3ZvlGkgM/0wRIKOKDHne1MOBXralREX
         5ResfZCHctHT5xV/wapzfRjV/vhp1ci3mpjufM74=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH v2 2/5] docs: automarkup.py: Fix regexes to solve sphinx 3 warnings
Message-ID: <C6CVK7V449HT.12X5MRPR3R7TK@ArchWay>
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

On Wed Oct 14, 2020 at 4:11 PM -03, Jonathan Corbet wrote:
>
> On Tue, 13 Oct 2020 23:13:17 +0000
> N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> wrote:
>
> > The warnings were caused by the expressions matching words in the
> > translated versions of the documentation, since any unicode character
> > was matched.
> >
> > Fix the regular expression by making the C regexes use ASCII
>
> I don't quite understand this part, can you give an example of the kinds
> of warnings you were seeing?

Hi Jon,
sure.

One I had noted down was:

WARNING: Unparseable C cross-reference: '=E8=B0=83=E7=94=A8debugfs_rename'

which I believe occurred in the chinese translation.

I think the problem is that in chinese there normally isn't space between t=
he
words, so even if I had made the regexes only match the beginning of the wo=
rd
(which I didn't, but I fixed this in this patch with the \b), it would stil=
l try
to cross-reference to that symbol containing chinese characters, which is
unparsable to sphinx.

So since valid identifiers in C are only in ASCII anyway, I used the ASCII =
flag
to make \w, and \d only match ASCII characters, otherwise they match any un=
icode
character.

If you want to have a look at other warnings or more complete output let me=
 know
and I will recompile those versions. That sentence was the only thing I not=
ed
down, but I think it gives a good idea of the problem.

Thanks,
N=C3=ADcolas

>
> Thanks,
>
> jon


