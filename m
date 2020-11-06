Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3B2A948F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgKFKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgKFKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:39:47 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF74C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:39:47 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f9so1260313lfq.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J2yvdHsoKp1oMN1psgcnuYwd/2InocpPLSKi5LUXlgY=;
        b=DOxSvSO6p3ITlvfLOX0xa5YgF9eLZhy9CsZ9nlQ2njxpWX0Y4NsBg5GX0ioXld/N4o
         8Kxm/vzF3VyILxdu86LKszT670k8+rDcmiDgX1wpjlpjj5ypgOeOqmnyI1+bmOAIA9vV
         oZQwdprT/YABRmjWzrKMo5rDMjDWbmhRwi7MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J2yvdHsoKp1oMN1psgcnuYwd/2InocpPLSKi5LUXlgY=;
        b=VmhmenI/a1bF2bwrkvzIJfaAXK5LG7JhV0k0aoj73yFotMjJR2ELtJx6wc2OJgCVkL
         Zx9MJuROsO4RM8NAOA7cCx+aEcaWyb7qjYHJs3KWSRkyoa1SfhUOP5mmOFLhH/RIkn5y
         oHVKfYUTNSU0xdQLzCNscErYapgmkFBzbfK87p2Vhmg99h7M6572IW57RW3kxSmXbjtd
         jTG0oMU4zeyx4qHwHzfla4D6orx3VuChydyH2/tvi9A1jS/IbOSSFupov2Y6D5IS5FcP
         SVgz2LbvsXafzI2LR8ZQLAx472DxGMnlP3VVUpIC9Sl4x96nVDgzyG+9kgSv/IcmkCgy
         aw6A==
X-Gm-Message-State: AOAM533nt9GlobFHjqevJsy3ny0U4z+vsEUYT27SFvCdt4cL6DJmBh/I
        uWIitabuftFH4F4MO6kVVd8s2q7Ck0Tm1TMIPKoNcw==
X-Google-Smtp-Source: ABdhPJyeP7xRVY/y3shA3XXPN/+BGxlH2GFZDqB4MLTzVW559sj32dKbBNeK1q/sp3XNYonhQ7jgeD3Oyi9A+bHls2g=
X-Received: by 2002:ac2:562a:: with SMTP id b10mr606392lff.562.1604659185518;
 Fri, 06 Nov 2020 02:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20201105225827.2619773-1-kpsingh@chromium.org>
 <20201105225827.2619773-9-kpsingh@chromium.org> <20201106021418.w34sar72sbddzwqo@ast-mbp>
In-Reply-To: <20201106021418.w34sar72sbddzwqo@ast-mbp>
From:   KP Singh <kpsingh@chromium.org>
Date:   Fri, 6 Nov 2020 11:39:34 +0100
Message-ID: <CACYkzJ5yQUywf3bkmh1dmmN3xmK5nED94oHs6cfEGcby=-j-Hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 8/9] bpf: Add tests for task_local_storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 3:14 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 05, 2020 at 10:58:26PM +0000, KP Singh wrote:
> > +
> > +     ret =3D copy_file_range(fd_in, NULL, fd_out, NULL, stat.st_size, =
0);
>
> centos7 glibc doesn't have it.
>
> /prog_tests/test_local_storage.c:59:8: warning: implicit declaration of f=
unction =E2=80=98copy_file_range=E2=80=99; did you mean =E2=80=98sync_file_=
range=E2=80=99? [-Wimplicit-function-declaration]
>    59 |  ret =3D copy_file_range(fd_in, NULL, fd_out, NULL, stat.st_size,=
 0);
>       |        ^~~~~~~~~~~~~~~
>       |        sync_file_range
>   BINARY   test_progs
>   BINARY   test_progs-no_alu32
> ld: test_local_storage.test.o: in function `copy_rm':
> test_local_storage.c:59: undefined reference to `copy_file_range'
>
> Could you use something else or wrap it similar to pidfd_open ?

Sure, I created a wrapper similar to pidfd_open and sent out a v6.
