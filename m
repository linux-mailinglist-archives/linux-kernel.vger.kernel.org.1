Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7DC2C5E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 00:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbgKZXrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 18:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgKZXrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:47:02 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC2C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 15:47:00 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id b17so3999542ljf.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 15:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hgk+y3R/+wKHwY8AHHPwfYUtuRseW4QHOS+AXJzFHJc=;
        b=UmZCklVE+6LJBZ0ksVoPTJGBuaE/NBsqmU1zhUV2JHO+B1a3YZprPMTxMvlFYLe585
         8phq9Up9vzDLmSOQwsIG1W+AxT4EyUf2qOm/wRGyf4WS+Q26VYwYp3rKHA3t0qOp2ZfE
         wZfH2QRJP1xMN1Mc8kgAd8naaakEi0S6S5At8gW5g+iZYYHtlIVeOeQy5YcdzDsPZHNw
         qGs11TL4maxG7T8+iBgl9Zf/xxKo4X2KJopi6ZGaV0jEzPH9yqojYS45ehjH+O3lMvIa
         pm1g3qUpd1nm1ZxSyoFELZw+5BItIOwHelBeDNijVZriJ7sSVJ63VuNHPKzWXF0DjV1E
         8B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hgk+y3R/+wKHwY8AHHPwfYUtuRseW4QHOS+AXJzFHJc=;
        b=WrpLaWf1j6tfwrJ2K5fqprULtPCSF0nkQl4UI6DwgaHM9RlKPY1/2UsYn7eDKeUdfu
         jUurw2pEumfCFkXCs6fG406Ujd981s6RP/aDQ+SkYzu5ASNTO5jbsPT4uDgJqdBehBmN
         mwYoeqQEXm1zVcWZNo+wWT3XjRpGBbmleuh1G46m939obm74BijLlAvJoESYukzDHlNJ
         OijMPZQ7RALQSQLIHxC+9k567AJBZsIbnfDiph7sJLhgaSK5gB2DzFDWf2q+4Qb3yN8F
         gJVvB50LdvVqY1uecAv9l0rQS/cKEtLykjtwZkTgE+x5vfuS81oy/pgNJOHstrfqjhg2
         CuDw==
X-Gm-Message-State: AOAM531QiZiYaPWOPadHdNebwlQRmzWqvt55uReuR8B/xHExUcaWDeWm
        Vomvs7yBQzz8dEy0LWrhgvDPWAbLkHhSnYqO4JA=
X-Google-Smtp-Source: ABdhPJyRNLpKaqnV8O473Pl/YaIe0OR/eS2o+HSGUuD84MarnbDCD5StxxWczokLGXB+yMtV9I/q6Ok8wEfPj6Xqjns=
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr2089989ljn.250.1606434418814;
 Thu, 26 Nov 2020 15:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20201123031751.36811-1-daeho43@gmail.com> <20201123031751.36811-2-daeho43@gmail.com>
 <5b3cb83d-5d0f-c1ca-2cff-f28372dec48e@huawei.com> <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
 <X7/qr/kVxl3AO/PR@sol.localdomain>
In-Reply-To: <X7/qr/kVxl3AO/PR@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 27 Nov 2020 08:46:47 +0900
Message-ID: <CACOAw_xaJ6pfT_EDqCSaL8UnBVkktXK5N_GXuHT+xzu1ufVacg@mail.gmail.com>
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

Chao,

Got it~

Eric,

Actually, I wanted to detour the internal readahead mechanism using
page_cache_ra_unbounded() to generate cluster size aligned read
requests.
But, page_cache_async_readahead() or page_cache_sync_readahead() can
be also good enough, since those can compensate for the misaligned
reads reading more pages in advance.

Thanks,

2020=EB=85=84 11=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 2:49, =
Eric Biggers <ebiggers@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Nov 26, 2020 at 02:04:41PM +0900, Daeho Jeong wrote:
> > Eric,
> >
> > do_page_cache_ra() is defined in mm/internal.h for internal use
> > between in mm, so we cannot use this one right now.
> > So, I think we could use page_cache_ra_unbounded(), because we already
> > check i_size boundary on our own.
> > What do you think?
>
> What about page_cache_async_readahead() or page_cache_sync_readahead()?
>
> - Eric
