Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204902C5E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 01:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392069AbgK0AbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 19:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392060AbgK0AbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 19:31:06 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C850AC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 16:31:05 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u19so4756595lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 16:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RrO6oiIS1I2DeZeWVb/81GGT/01B9WvFB73uagPOMiA=;
        b=CSImSj4VXCDoV3bNJRk4tZN4naszBmYhls5ZY4BYU6Em/VLZC3/G6EKZlEdJv0jTs1
         CXae/5jsQO9EeuVRuKhFv+4stFaZbjnQK/GIp2adM9jAPMQjZAUbl5piyrCyb+TbXoUw
         qvgWtUyEhkzuRzg2HHLo+pgNFK69V7AeoW/jUZPafF9Key7HYJRCyQHIb4d+tI9O0/E+
         h5YE3dBGlgeIew4pUsx1lcT0Mwh1ssBE09iAg/bfEyJrYgw9HbfkrlC198Wy2VwLMqTv
         F5Pf05s2I+z94N6F+u6DqgNtPpAJH/SuhrrEtCcaVtxgxwyC2bS86opehCYVS325vupD
         2JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RrO6oiIS1I2DeZeWVb/81GGT/01B9WvFB73uagPOMiA=;
        b=YVjNKimwY9yFvMS1vluKeSkQ8A1Cm+h9DFa66Ywr183uE/ZspQjqKEWJeRElZWKIKE
         u5aB/SF9P71dy14Z48ulF2GlSyjLVg2aB5FjDokxsWAMD1uucha4g7cd1Tj75hJSn1D0
         JduIoxarQk6XvRx1hzmP+1S0m8J7+ZPigDrMlV4xNyDR+cfYlgjvbPPoKeQD4wL2pSM/
         DlZllEJf2n37BGQLLoM+nVvnl20CFgffr+mYjRhvt7R0fbMaEhY+M3DTjlhTuk1btyP6
         azo/PWQi8MENlyzlTsWa/vZfEqq40jP06dYup/Mji2VbnsREZ5RV7RT5GXaxn6ZpwSPJ
         JcBQ==
X-Gm-Message-State: AOAM531IevQuZGsFMsf+a3HDK3L4c374jxGy/HeGZ3ZM5KxlXSt085lb
        xqblBzDNzYnD9PsTpizWHzSfL2S1Uz8zKV9CSPTGxvgOGwMGLw==
X-Google-Smtp-Source: ABdhPJx4EcyHZbHeHj47vWxjXYU76LDEhUFsmEfyv8X3fCCeMXHqo3ShzAaEZb5lH+2EcbAlKa8e51BSLP6RaSdKcgA=
X-Received: by 2002:a19:7dc4:: with SMTP id y187mr489182lfc.326.1606437064274;
 Thu, 26 Nov 2020 16:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com> <20201123031751.36811-2-daeho43@gmail.com>
 <5b3cb83d-5d0f-c1ca-2cff-f28372dec48e@huawei.com> <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
 <X7/qr/kVxl3AO/PR@sol.localdomain> <CACOAw_xaJ6pfT_EDqCSaL8UnBVkktXK5N_GXuHT+xzu1ufVacg@mail.gmail.com>
In-Reply-To: <CACOAw_xaJ6pfT_EDqCSaL8UnBVkktXK5N_GXuHT+xzu1ufVacg@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 27 Nov 2020 09:30:53 +0900
Message-ID: <CACOAw_wyGrkadW5Z6F_GEGT217q4+=68T0cVjnqx-DKx9HYvDw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-thinking about this, page_cache_sync_readahead() is not good for
our situation, it might end up with cluster misaligned reads which
trigger internal duplicated cluster reads.

2020=EB=85=84 11=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:46, =
Daeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Chao,
>
> Got it~
>
> Eric,
>
> Actually, I wanted to detour the internal readahead mechanism using
> page_cache_ra_unbounded() to generate cluster size aligned read
> requests.
> But, page_cache_async_readahead() or page_cache_sync_readahead() can
> be also good enough, since those can compensate for the misaligned
> reads reading more pages in advance.
>
> Thanks,
>
> 2020=EB=85=84 11=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 2:49=
, Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Thu, Nov 26, 2020 at 02:04:41PM +0900, Daeho Jeong wrote:
> > > Eric,
> > >
> > > do_page_cache_ra() is defined in mm/internal.h for internal use
> > > between in mm, so we cannot use this one right now.
> > > So, I think we could use page_cache_ra_unbounded(), because we alread=
y
> > > check i_size boundary on our own.
> > > What do you think?
> >
> > What about page_cache_async_readahead() or page_cache_sync_readahead()?
> >
> > - Eric
