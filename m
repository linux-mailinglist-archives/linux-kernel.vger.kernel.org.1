Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FB32BC257
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 23:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgKUV5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 16:57:40 -0500
Received: from mail.alarsen.net ([144.76.18.233]:51758 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgKUV5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 16:57:39 -0500
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:40e7:424f:4d36:7fd2])
        by joe.alarsen.net (Postfix) with ESMTPS id A9E202B80567;
        Sat, 21 Nov 2020 22:57:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1605995854; bh=0prA2mAxOXVRxgOag0HSSSlb1gTpAasr/b/3VfKzszs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAsA26Q+j0AzrW9nmjgn/dUXphgK3OQhQDkK1PosFMHbUU0HKC5jaT9v92x6mBYDM
         JUlD3pHhnR4P9HnG5AxmtKZWMKKfG1t9+QCJMy484HQCYhJ0oh9/FBEWDkxBIKO9VS
         A6I6/YIPpDfvMYwiYqurQWrqqaFrROOQ6sUJQr+U=
Received: from oscar.localnet (localhost [IPv6:::1])
        by oscar.alarsen.net (Postfix) with ESMTP id 87E0827C0918;
        Sat, 21 Nov 2020 22:57:34 +0100 (CET)
From:   Anders Larsen <al@alarsen.net>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] qnx4_match: do not over run the buffer
Date:   Sat, 21 Nov 2020 22:57:34 +0100
Message-ID: <1645927.Y8UaVx19Bi@alarsen.net>
In-Reply-To: <E554952E-602B-4711-BEF1-FB3398DA7225@gmail.com>
References: <20201120212120.2502522-1-ztong0001@gmail.com> <2474566.rpppqFFLNx@alarsen.net> <E554952E-602B-4711-BEF1-FB3398DA7225@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 2020-11-21 22:47 Tong Zhang wrote:
>=20
> > On Nov 21, 2020, at 4:40 PM, Anders Larsen <al@alarsen.net> wrote:
> >=20
> > On Friday, 2020-11-20 22:21 Tong Zhang wrote:
> >> the di_fname may not terminated by '\0', use strnlen to prevent buffer
> >> overrun
> >>=20
> >> ---
> >> fs/qnx4/namei.c | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
> >> index 8d72221735d7..c0e79094f578 100644
> >> --- a/fs/qnx4/namei.c
> >> +++ b/fs/qnx4/namei.c
> >> @@ -40,7 +40,7 @@ static int qnx4_match(int len, const char *name,
> >> 	} else {
> >> 		namelen =3D QNX4_SHORT_NAME_MAX;
> >> 	}
> >> -	thislen =3D strlen( de->di_fname );
> >> +	thislen =3D strnlen( de->di_fname, QNX4_SHORT_NAME_MAX );
> >=20
> > that should be
> > +	thislen =3D strnlen( de->di_fname, namelen );
> > otherwise the length of a filename would always be limited to QNX4_SHOR=
T_NAME_MAX (16) characters.
> >=20
> Why should we put something bigger here if the size of qnx4_inode_entry->=
di_fname is QNX4_SHORT_NAME_MAX.
> Won=E2=80=99t that be a problem?

If QNX4_FILE_LINK is set in de->di_status (see line 38), 'de' actually poin=
ts to a struct qnx4_link_info which can hold a longer name.
That's the reason for the namelen massage.
(Please don't ask why it is not a union)

Cheers
Anders


