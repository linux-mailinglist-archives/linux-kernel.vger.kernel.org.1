Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862FD2AFC70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgKLBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgKLAHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:07:01 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF26C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:07:00 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so4726331lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b5+3c0cB/SNlhOoBLVTOeycqTJnQtYQ+Gz41CVSnI4A=;
        b=kI8Q/TtNpemHOgCzxgdmdiqyDeaP1lqzQ58biRx3W0Jvk8YmrwOAmyT1z1qfD2FJzu
         SUYn/qr5EyJ5pXsS8h9GJp6Az9VQLYUWqBh7aTs8W8PFS/FOiJwEfYe47SyQIzq85SDq
         A/ojdk2FEIY6yc5KdpovoY0JvsDF6+PAIZH0kwp2dTpZQhgThA6vzXh9M+nr2fJ2wnvh
         NVsEKhd1ZaXJa7mfl0GmB/SPbSFg2XOgCwz1nlWrdONQGOoNzFroToSprB/kDru2z4nd
         nr9sI+ektQzrj3My/Z+8UonERdT4ZE83cKP2PBQGlQDGpSXJtDH4mayLvvVVEzpgCOR8
         H5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b5+3c0cB/SNlhOoBLVTOeycqTJnQtYQ+Gz41CVSnI4A=;
        b=YQxSRVAXgmpOITKtGnvAHgjj9zLWCIdwIFLH4qElsVM4ylOSIH8oE3m+JMtabbNgrr
         roh42trlrQqQSKppc4o66D4nbh0cRqKh0reLS5PfFXHMJTQJ7fpNQDUjWjG+ZSw8VEbn
         dTbvwZ1IOdeh9EwrfwfhNlv+FWaxuURRfYxWn8u1oIP8GaA3o14MKGSwdRQVU5yw0Tuo
         MVLnJihKuENnBVY0dBVhHKPbSBSiUSeVuDIKsx04m79KsfxiZF529EpC3JjpsfOSXwW8
         9gFg3W9DT3+E2SiDiJJV56lR+qYCPpVwTztszspu/zhWZGEY435TDyEri/5uWQcNtRoY
         RcVA==
X-Gm-Message-State: AOAM530rPdU0iSDLWyTYspT1f4/VCnd//gTdCHKQJp2akB4WfNLsUl4m
        c/+ZxCX2vbCfS7yfZXn8QSxAjZyT8nBI0FLY2zfidA==
X-Google-Smtp-Source: ABdhPJxLUwzQg+4puz6IXIXVIJDaCLsNykZEHy3XRoeRDBcT8S0yIQcax7ZPrlX3T98rcJfBswkiGdi4TsdMJUQtuK4=
X-Received: by 2002:a05:6512:200e:: with SMTP id a14mr9439357lfb.573.1605139618856;
 Wed, 11 Nov 2020 16:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20201109191601.14053-1-zengzhaoxiu@163.com> <20201109192508.14186-1-zengzhaoxiu@163.com>
 <CAG48ez3OyH61+hJ+Azyoae0fA6=8tnVOw3VqKebCcH=dTvh2dg@mail.gmail.com> <2442c8fb-ff36-41ce-9349-d162639d5c3b@163.com>
In-Reply-To: <2442c8fb-ff36-41ce-9349-d162639d5c3b@163.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 12 Nov 2020 01:06:32 +0100
Message-ID: <CAG48ez1O-mVnkFdbt5To7XucyFSVtJO0prv6DLjQuwfZDzGz3A@mail.gmail.com>
Subject: Re: [PATCH 2/3] lib: zlib_inflate: improves decompression performance
To:     Zhaoxiu Zeng <zengzhaoxiu@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:06 PM Zhaoxiu Zeng <zengzhaoxiu@163.com> wrote:
> =E5=9C=A8 2020/11/11 11:46, Jann Horn =E5=86=99=E9=81=93:
> > On Mon, Nov 9, 2020 at 8:27 PM <zengzhaoxiu@163.com> wrote:
> >> This patch does:
> >> 1. Cleanup code and reduce branches
> >> 2. Use copy_from_back to copy the matched bytes from the back output b=
uffer
> >
> > What exactly is copy_from_back()? Is it like memmove()? If yes, have
> > you tried using memmove() instead of the code added in patch 1/3?
> >
>
> If use memcpy(or memmove), the code will be like this:
>         while (dist < len) {
>                 memcpy(out, out - dist, dist);
>                 out +=3D dist;
>                 len -=3D dist;
>         }
>         memcpy(out, out - dist, len);

Ah, thanks. So basically it means: "repeatedly copy a pattern of
length `dist` from `out-dist` to `out` until `len` bytes have been
written"
