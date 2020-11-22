Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207612BC2FB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 02:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgKVB1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 20:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgKVB1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 20:27:40 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4DC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 17:27:39 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so12875843qkd.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 17:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zkfhzLVatH072ImS2wXfdLY5KZ3yNZ2TyMcG4XszjRc=;
        b=S8G4lL4bWXUNuVDdxi2HYlItqCBEbVWI+A2GSfTeDZdYW5rk0Zp2lYC74VE56/LWvK
         +OqLN8Q1jX+jWnKwW+qrRDBzH5qvfxSt7yHLUNdrjmfwkiUWRJTAwrKwbX1nEWu+yG/d
         +OC10y7zkyhZ7llMlWNy0r4Wz1fX3m5EnI+1SjOLFwUpN0mg5P31pPLMIogorlKaFZX9
         TKj+TGhqrqQGJwjzKDkeUYFzOX4YEbJ1sCBGD1fejqwwu4okR7TPQJowFlcPfbUGs0eC
         IA8Uegkj6V2//7E1gh7xzXtY7jY3nrZ3EFgu8R60urDL0332gLoHyXK6FHy0Wqen7TVJ
         7YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zkfhzLVatH072ImS2wXfdLY5KZ3yNZ2TyMcG4XszjRc=;
        b=mlVaOMKyH9o/YIhWDaKlZibCTuAkPeoew7EI784RZnqWM5afoXo1jYh3TfH8IyXSUf
         BsgH+sxhblm+PEnWhNll+kuZy/g2VHDB5VZZ3TouwWaziJn96Y4q5/tkfYybAPivCykm
         pq9CGjIJx1JsDrEubIdaprSOEDGaJ5jInJ1YjCKkP9hrow81XA1XoM2yXYtv7JgZUQSy
         /BHPS1qk1cGlkfhqXRlPaV6fq9sUERx0tcqZnlnsHLu1J3wYVwGHn6Ruugp4vOaTbElo
         EOPGr0CAtzN+Dco9/KXluHWk5KBBzjIpP5unpEo4drY0/fgsvPUfi0wTLGJzXC6EQ9Yf
         KNYA==
X-Gm-Message-State: AOAM531gCL2NA6qm5ldNpRsVguQT4CwUk5j+HCRLtDdQJaBmpNARydYP
        8aQyycxYvBENjS1/zqJhr6jQluARDC1LAw==
X-Google-Smtp-Source: ABdhPJyw/2Www1Vxy4n9NjI0JKPCMPpO7LWt0xOxlkkHFCOWQmJ0aI4eEpr+iP4SBu+FVMGJk6cnWA==
X-Received: by 2002:a05:620a:80d:: with SMTP id s13mr22349285qks.133.1606008459031;
        Sat, 21 Nov 2020 17:27:39 -0800 (PST)
Received: from ?IPv6:2601:5c0:c200:27c6:789c:5c68:3e93:a660? ([2601:5c0:c200:27c6:789c:5c68:3e93:a660])
        by smtp.gmail.com with ESMTPSA id c14sm5395223qko.29.2020.11.21.17.27.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2020 17:27:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v1] qnx4_match: do not over run the buffer
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <1645927.Y8UaVx19Bi@alarsen.net>
Date:   Sat, 21 Nov 2020 20:27:37 -0500
Cc:     linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <97DE78A8-E2D6-4780-AD77-5F679D6DE098@gmail.com>
References: <20201120212120.2502522-1-ztong0001@gmail.com>
 <2474566.rpppqFFLNx@alarsen.net>
 <E554952E-602B-4711-BEF1-FB3398DA7225@gmail.com>
 <1645927.Y8UaVx19Bi@alarsen.net>
To:     Anders Larsen <al@alarsen.net>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the clarification! This sounds good to me.
I will send a revised patch.
Best,
- Tong

> On Nov 21, 2020, at 4:57 PM, Anders Larsen <al@alarsen.net> wrote:
>=20
> On Saturday, 2020-11-21 22:47 Tong Zhang wrote:
>>=20
>>> On Nov 21, 2020, at 4:40 PM, Anders Larsen <al@alarsen.net> wrote:
>>>=20
>>> On Friday, 2020-11-20 22:21 Tong Zhang wrote:
>>>> the di_fname may not terminated by '\0', use strnlen to prevent =
buffer
>>>> overrun
>>>>=20
>>>> ---
>>>> fs/qnx4/namei.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
>>>> index 8d72221735d7..c0e79094f578 100644
>>>> --- a/fs/qnx4/namei.c
>>>> +++ b/fs/qnx4/namei.c
>>>> @@ -40,7 +40,7 @@ static int qnx4_match(int len, const char *name,
>>>> 	} else {
>>>> 		namelen =3D QNX4_SHORT_NAME_MAX;
>>>> 	}
>>>> -	thislen =3D strlen( de->di_fname );
>>>> +	thislen =3D strnlen( de->di_fname, QNX4_SHORT_NAME_MAX );
>>>=20
>>> that should be
>>> +	thislen =3D strnlen( de->di_fname, namelen );
>>> otherwise the length of a filename would always be limited to =
QNX4_SHORT_NAME_MAX (16) characters.
>>>=20
>> Why should we put something bigger here if the size of =
qnx4_inode_entry->di_fname is QNX4_SHORT_NAME_MAX.
>> Won=E2=80=99t that be a problem?
>=20
> If QNX4_FILE_LINK is set in de->di_status (see line 38), 'de' actually =
points to a struct qnx4_link_info which can hold a longer name.
> That's the reason for the namelen massage.
> (Please don't ask why it is not a union)
>=20
> Cheers
> Anders
>=20
>=20

