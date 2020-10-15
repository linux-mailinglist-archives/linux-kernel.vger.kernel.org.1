Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B128ED1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgJOGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgJOGbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:31:53 -0400
Received: from coco.lan (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB24921D7F;
        Thu, 15 Oct 2020 06:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602743512;
        bh=UbqtsMiwQlRKPA9UOVSwsEJWtdDTefpeP47lLEJ/s68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=malaeoMC4a7ZQV1gOI7PmRoMYacz9SqqTP8Qb228LPsIc/kSwDSG5j/uWZqsN6z2h
         /gqAkqfwOP2W9eVEfLqf2eW+n2s3ZNLuBqPuLf5QeRz7Zjnf3/1WcQj6DV/eGtZZyw
         sckQNvuL6nG+Uy7II8tu3m2NJQ8T89/Paz8FQDuE=
Date:   Thu, 15 Oct 2020 08:31:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Subject: Re: [PATCH v2 2/5] docs: automarkup.py: Fix regexes to solve sphinx
 3 warnings
Message-ID: <20201015083147.56029afb@coco.lan>
In-Reply-To: <20201014141616.63082d5d@lwn.net>
References: <C6CVK7V449HT.12X5MRPR3R7TK@ArchWay>
        <20201014141616.63082d5d@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Oct 2020 14:16:16 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 14 Oct 2020 20:09:10 +0000
> N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> wrote:
>=20
> > One I had noted down was:
> >=20
> > WARNING: Unparseable C cross-reference: '=E8=B0=83=E7=94=A8debugfs_rena=
me'
> >=20
> > which I believe occurred in the chinese translation.
> >=20
> > I think the problem is that in chinese there normally isn't space betwe=
en the
> > words, so even if I had made the regexes only match the beginning of th=
e word
> > (which I didn't, but I fixed this in this patch with the \b), it would =
still try
> > to cross-reference to that symbol containing chinese characters, which =
is
> > unparsable to sphinx.
> >=20
> > So since valid identifiers in C are only in ASCII anyway, I used the AS=
CII flag
> > to make \w, and \d only match ASCII characters, otherwise they match an=
y unicode
> > character. =20
>=20
> OK, this all makes sense, as does your fix.  The one thing I would ask
> would be to put that warning into the changelog for future reference.

I added yesterday patches 1 to 4 from N=C3=ADcolas series on my -next tree:

	https://git.linuxtv.org/mchehab/media-next.git/log/

Today, I changed the changelog in order to better describe the ASCII issue:

	https://git.linuxtv.org/mchehab/media-next.git/commit/?id=3Df66e47f98c1e82=
7a85654a8cfa1ba539bb381a1b

If this is enough, I'll likely send the PR to Linus later today or tomorrow,
depending on next- merge results.

Patch 5 can be added later, after we find a way to keep it safe for
parallel reading.

Thanks,
Mauro
