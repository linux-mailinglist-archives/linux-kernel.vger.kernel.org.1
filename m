Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBF299A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbgJZXS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:18:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33255 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404304AbgJZXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:18:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id c21so12414811ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cJqtnZ8asq4bny750fVTQgJnYnxKe9lnoylCtFpur88=;
        b=RqM+nxRCebPhd7s1uKaV6vz/hsqV7luhwvkGZt4aL6WxyWg4vSdi+IGsr3XWhD/qT3
         eR27XfcEHxeUlkkc14UyZz5R9QL73pdKw0ZqC5KELHimaVyinTp4jKET8EwFTeX9ZUTl
         h3WEnYUOhvVUudj96KxPwCj4ckNBSmADYDaBHlEGykjLTxqVGPIR+x2cQ0+KJJgpCEXh
         QVh/LvZXIkcPi4y+xP6cXpFUumcDYuQbVt5kQlS0zwPcmKIdl92dQT+gqEtgp9/oO2kF
         pLQaDhV8jXvZFKphgTnhEEkRKZw3B8xeG3fUe267N6GrN53TnPn+lOeJQ3mtu9+vlVC/
         jMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cJqtnZ8asq4bny750fVTQgJnYnxKe9lnoylCtFpur88=;
        b=fillm7qLPOMOfc6Ntkhs+rariYUBFsqOYI7KYXEKLH0CNpPySksj/eKUfFPGtNO1O7
         US0QzhZXh/CU+yHHjnA66z5TL3j8xCvPyhfIcXkDOiFzYCsj9oIEniH1tuikAI1ESr5Q
         w97cnh7bKPyFJzqlJeGJIfPvl24FNLgg+n2i0A1HFxXnilGIxmhm6HIa/LSP1BTa9mIP
         dLy5ZHy6oEx5uzGPDVybj8TcXWQA/GI6ec8doYSpEDyRr5gLYyUm2s6Qao0DJu7PV6Lw
         3R0Oq7p1FgD3yoPZ+yhRwbfvUk8NzrpV+YS/Hb0VvLtYp3J2kzWarYJ363gIozvZPYgu
         mnnQ==
X-Gm-Message-State: AOAM532+mmKgNTb8I0hMhIPXvoJJrsjYMOQBA2F55+W6bPSrIeObiTk1
        96x3n4iya7QhI62q2bY/UUaO9UcraoePN5Nv9nU=
X-Google-Smtp-Source: ABdhPJzsleTazzH4s3ND9aMfT4WQrWA1iR79yBLH0tok4g5DotVCnirrIOAuRnOuDqANgg0ROdaFf4VqrJeKwiQ1ElY=
X-Received: by 2002:a05:651c:130d:: with SMTP id u13mr7705266lja.265.1603754335662;
 Mon, 26 Oct 2020 16:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201026041656.2785980-1-daeho43@gmail.com> <20201026190406.GL858@sol.localdomain>
 <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com> <20201026230555.GB1947033@gmail.com>
In-Reply-To: <20201026230555.GB1947033@gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 27 Oct 2020 08:18:44 +0900
Message-ID: <CACOAw_wLE_om3YChs_jsBTORrOsp2M6SZ+t2arP9tHQeojsgKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I checked that. We seem to need to complement missing parts including
other ioctls in Documentation/filesystems/fscrypt.rst.

Thanks~

2020=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 8:05, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Oct 27, 2020 at 08:02:18AM +0900, Daeho Jeong wrote:
> > I thought I gave the information about that in the commit message. Is
> > this not enough for you?
> > Actually, there is no space for F2FS ioctl documentation now. :(
> >
>
> The commit message doesn't really matter.  What I am asking for are actua=
l
> documentation and tests.
>
> The fscrypt ioctls, for example, are all documented in
> Documentation/filesystems/fscrypt.rst, and they have tests in xfstests.
>
> - Eric
