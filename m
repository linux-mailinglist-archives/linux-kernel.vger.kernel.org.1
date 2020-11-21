Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAC32BC252
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgKUVr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 16:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUVr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 16:47:28 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD7C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 13:47:26 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so6551017qvb.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 13:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zMK3ugo36GZeCZ16ac8L6uDuMviSdsynldnkXAbr6nA=;
        b=uPKgPmysYRbdSHuoayncQg/O+xme06PtzVAWfkVF/iCz1k0JA1oPzCIPIPBsBNm004
         TIOWAf0SocbVzpUDv+kMrAYEwIhC2oEeiZfaT9CuJsc1f0RFHuUjttxZyBCs9Urt6s5X
         +x6YH3R9RA95usKWptaR/WZpxelxKxPR49VC0bueIIuRTyBYdv/mJ9c4eDDj7iuQh0Mo
         Zm3kL3pC63zCR28QRnhL9eGDA9KFrOchbtQEe3kQKEiZuLaxUriJ7MHa0CeeuCY5zJZi
         Cak4JlK13922nsOLuBzFxb3uZSqlTjPtlDhYekNGiCupC+aFNj6CZx7j/PplpCDEij10
         BcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zMK3ugo36GZeCZ16ac8L6uDuMviSdsynldnkXAbr6nA=;
        b=CN+Q0J6ZtKq8oe1r7Mywfdshudmur98bcV53sORwFdZ5dzzRQ11DL04w3UYTvH3HfR
         onIU/vS8eO/azrj5eElLUW7ZSy8b1UnAs3muNRiiUlBfSHt4mjWx1XUs/7bq5nO6+Su8
         AB/HrMbVq2BdsB7DOycGIZ/ij4lY3ajJc6wb6rY+qEWq+dhv/RsU5w9n+xWr0xnU0M4R
         I8vIQFCoRIA7QoDcZ4zI51S8waJHRNtZVjAl0XXN6nF8oy2BimKeC7pvM0F/pIdRIfE0
         Xnkk6ZyQBpXxMi2+wqXJVifef2RthQg9f1i3h+3FWH7iozT6eiYZ9Nr1FwqcKFkMv+Lj
         xNqQ==
X-Gm-Message-State: AOAM530gFrmlYqb0+MA48UMNsKJZgz2C7NHwbZtiPtfmvawJsYKh0fIB
        sDeD8tdo2cDFw8Nn85daxqSW9oF3Iywz6Q==
X-Google-Smtp-Source: ABdhPJwl8L+/BjJN2HEmxNCNbOr9JRbKoz0WfPG/3QvGyhFOZO6vKMkoooWQF54tMfOZZ1d5Sr4I6Q==
X-Received: by 2002:a05:6214:10e3:: with SMTP id q3mr22645071qvt.3.1605995245919;
        Sat, 21 Nov 2020 13:47:25 -0800 (PST)
Received: from ?IPv6:2601:5c0:c200:27c6:789c:5c68:3e93:a660? ([2601:5c0:c200:27c6:789c:5c68:3e93:a660])
        by smtp.gmail.com with ESMTPSA id s7sm4814495qkm.124.2020.11.21.13.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2020 13:47:25 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v1] qnx4_match: do not over run the buffer
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <2474566.rpppqFFLNx@alarsen.net>
Date:   Sat, 21 Nov 2020 16:47:24 -0500
Cc:     linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E554952E-602B-4711-BEF1-FB3398DA7225@gmail.com>
References: <20201120212120.2502522-1-ztong0001@gmail.com>
 <2474566.rpppqFFLNx@alarsen.net>
To:     Anders Larsen <al@alarsen.net>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2020, at 4:40 PM, Anders Larsen <al@alarsen.net> wrote:
>=20
> On Friday, 2020-11-20 22:21 Tong Zhang wrote:
>> the di_fname may not terminated by '\0', use strnlen to prevent =
buffer
>> overrun
>>=20
>> ---
>> fs/qnx4/namei.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
>> index 8d72221735d7..c0e79094f578 100644
>> --- a/fs/qnx4/namei.c
>> +++ b/fs/qnx4/namei.c
>> @@ -40,7 +40,7 @@ static int qnx4_match(int len, const char *name,
>> 	} else {
>> 		namelen =3D QNX4_SHORT_NAME_MAX;
>> 	}
>> -	thislen =3D strlen( de->di_fname );
>> +	thislen =3D strnlen( de->di_fname, QNX4_SHORT_NAME_MAX );
>=20
> that should be
> +	thislen =3D strnlen( de->di_fname, namelen );
> otherwise the length of a filename would always be limited to =
QNX4_SHORT_NAME_MAX (16) characters.
>=20
Why should we put something bigger here if the size of =
qnx4_inode_entry->di_fname is QNX4_SHORT_NAME_MAX.
Won=E2=80=99t that be a problem?

>> 	if ( thislen > namelen )
>> 		thislen =3D namelen;
>=20
> These two lines can be dropped now, as the result of strnlen() cannot =
exceed namelen anyway.
>=20
> Cheers
> Anders
>=20
>=20

