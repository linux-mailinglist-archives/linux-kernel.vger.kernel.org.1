Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5964A299A13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395108AbgJZXCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:02:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37527 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395099AbgJZXCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:02:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id j30so14497085lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=buCB+4RoMRIbdC0QeRyjEHgbWG3DCkz/Mz9ArEmit6s=;
        b=HG5SdGunBYRQfgKYvp3Owt306/Iw3uX8QNtG3mcJkbwuqdq3FidJzV8cRQVMz9/1Oq
         FVCxgOpX79UuAa1C2KGg0kSEipNo+tT/MFHlUi19ga98e1GQarIwTGsKNZaJWtVsON43
         gY2qxZEDXMVD7EBCuNi8OUZoE1RPwfx0cBYejOm1+YaBfMRyhwTIA4IigLDNFYcVs+9L
         259zIBq1Ib0ECnzkiBKcXoMDbboiJRQg2VgK9C+lSZm/2iTIOte386C8ip47cUFz75PK
         r7kBo4WATDSTbad4YQe0ia4OyVL/rw730qNW5InwOiGbyO0pSkxkPSYinQpQh21/Qzvk
         XD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=buCB+4RoMRIbdC0QeRyjEHgbWG3DCkz/Mz9ArEmit6s=;
        b=DVaet4JSyvHYuc8X3T0e/9NtSWWV/hgQNL9l4sETdAc9QZiwYjlZgTOOwo2K/+7Tfa
         5iWdn35QPqrP1j6hlEMVu8KWD0jjiBNV4yitE80AW22Ns36+C6lTKNilNvKoIMC8w7bB
         uyncVjdJlS+pPY+nHtgjnBPviJjgS1IRq9hoyKxsg8sx5pgvMoohcB+xoPJJsIu2nws1
         UIIhPMsgTsLU+0L2TjLqWlncMDEv8bw+iF0ovmH2ZuOoAJ8U9O34utGglKmvRDQLdDAg
         O+MO26DTDJB7RGpwaIhvZfUDOzlDyXhjIrIKQHudVk9xFj4h/YQK4SIMmEz7Wa9V9m8a
         s13Q==
X-Gm-Message-State: AOAM531dZ07cloTDwhYn8EclDGgOWuZpiXityvdCAghxghwAFqABRVbK
        mOZAqU5KKMj/Qlke/s5YKBwWkJAs/oB8unBTtTU=
X-Google-Smtp-Source: ABdhPJxlHaGAp5V4BSaIpcRwt7a13CSTOH5HYz5vgkZWKYgcHCVw5sllwsvPwc5xU6/ZA8N8A3IonOhM433GwtqtxaY=
X-Received: by 2002:a19:f71a:: with SMTP id z26mr5691238lfe.90.1603753349569;
 Mon, 26 Oct 2020 16:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201026041656.2785980-1-daeho43@gmail.com> <20201026190406.GL858@sol.localdomain>
In-Reply-To: <20201026190406.GL858@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 27 Oct 2020 08:02:18 +0900
Message-ID: <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
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

I thought I gave the information about that in the commit message. Is
this not enough for you?
Actually, there is no space for F2FS ioctl documentation now. :(

2020=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 4:04, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Oct 26, 2020 at 01:16:55PM +0900, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Added a new F2FS_IOC_GET_COMPRESS_OPTION ioctl to get file compression
> > option of a file.
> >
> > struct f2fs_comp_option {
> >     u8 algorithm;         =3D> compression algorithm
> >                           =3D> 0:lzo, 1:lz4, 2:zstd, 3:lzorle
> >     u8 log_cluster_size;  =3D> log scale cluster size
> >                           =3D> 2 ~ 8
> > };
> >
> > struct f2fs_comp_option option;
> >
> > ioctl(fd, F2FS_IOC_GET_COMPRESS_OPTION, &option);
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
>
> Please don't add Reviewed-by until it is explicitly given.
>
> The actual code looks fine, but there's still no mention of documentation=
,
> tests, or use cases.
>
> - Eric
