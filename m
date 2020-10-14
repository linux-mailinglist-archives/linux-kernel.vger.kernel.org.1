Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB628DD24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgJNJWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388213AbgJNJU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE7C00214D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:39:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so1463615ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nST+EHp6dPUeIzQMe4qF0Zs7iUx4bZTLvqvuYC7qQyE=;
        b=rCGpZ855CTranpUFcirWGNIsI75YqvWIhNjARsOl9zN9XmEvfT2jT91KULVFecfhNQ
         BJpGVeWZFF+l/zvXEDZV59cO5+WSsnKN4HugS41JNn0DN3C270FNKsK95lOTiHkf8aL1
         vqbGlyHLaCwRtROTbdcQB3Ju8BSfm4e54DOSijnhGiN8tpFBiFxKIQlPPbhlhYwXbkWS
         nAlUn+pJuQKvd09hS9QX0Y/FogU+3mGZOiQS6tAIQYDNh5lFCycllMSj1FrJPJD/zSCk
         j2tVkm5WpunxDupSCJyrmHR5ovW8zbfnPf+VJ3NTAvIdsNfq1XJvt83/d4bf0FMB7RWd
         /JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nST+EHp6dPUeIzQMe4qF0Zs7iUx4bZTLvqvuYC7qQyE=;
        b=ESPsjanZoG0owwP4UAgZRvpxnKmNoWvFPp81/eU9sTeDb2j4ZNTgkxOonlOj55rZEu
         A64hIUmUUbzkk4LYLtFLyyiS40WZ2rtbiExVz/tvuImfPJ7+FcwTnEiLVvDRLwlvEpUL
         q7t9mgAMd8hsAWIseN3y5Djg95CzlD2VcCawO7FJDZk9ZGcBd4z73Dhm1gw2bmddeUl6
         rbeCvHghnl2trlsmA+Hu1Gbg1Q2LSKhrlinPho7WxFVlQoFdydlGzrCMNs/0LZBFqKS3
         LmpUPj4izQ6Vf4fsz1TIMh214+Z5iEQAhp7/VKBM7UUs+W5EsnPEpIoUmr0VbukoQG6k
         PRgA==
X-Gm-Message-State: AOAM5323JOWNSIVcz0v5xw1thUC6Iw7rTB/B6hg3XcPzKbdMS9M+hXpa
        OiJ+seOwWbmY331sqPL30oY3Xcjp4Um0QVlsnZk=
X-Google-Smtp-Source: ABdhPJwaNNbSZxzioyJbjjgd2dSxq6cBGclMu8gyNcLMFIpJxFZFgY03rPUPfLfAtEaGzQTiAzksbCB1CPY7KsuQALU=
X-Received: by 2002:a2e:45d6:: with SMTP id s205mr856725lja.333.1602639581643;
 Tue, 13 Oct 2020 18:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201013022429.454161-1-daeho43@gmail.com> <20201013061349.GD1062@sol.localdomain>
In-Reply-To: <20201013061349.GD1062@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 14 Oct 2020 10:39:30 +0900
Message-ID: <CACOAw_wZ7=cThwsXL+Yd+r26QdXaUoa-QQ6XLDTeqixdMWA=2g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,
I'll talk with F2FS maintainers about this.

Eric,
Sure, I'll add it in the commit message.

2020=EB=85=84 10=EC=9B=94 13=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:13, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Oct 13, 2020 at 11:24:28AM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a new F2FS_IOC_GET_COMPRESS_OPTION ioctl to get file compression
> > option of a file.
> >
>
> For new ioctls please mention the documentation, tests, and use cases.
>
> - Eric
