Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F243F2DBEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgLPKsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgLPKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:48:54 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E4C061794;
        Wed, 16 Dec 2020 02:48:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2so16349673pfq.5;
        Wed, 16 Dec 2020 02:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BdOUjmGuNqAuHRyGZ2If7iqdw2h6h7+gBbAOpSZBT5c=;
        b=Q1KlwltkkoWkzpfdqwj1Ufyfjap83NEbF6qFXo444jAt3huW+txQ0NYvTXXI2q6BRg
         AySPp7+D7RkNecbF8XMiLtPgK45HChQBi0+fSat/qGHL7ok8xXJPkRGyDwCSG5ST3rdL
         lXDDJljntyQaisuElXyJFxA5wH43WOew6ug4S+o0QxPQ83slW7uB+YZLVcikmvNDfiR3
         gsKvrbfHjp+gl1ixE+6eyFp5VFC2xxdZ7URcDF/GlOQMKjsQA9U32K+AmoNJ6yqtQIDE
         Fsy691Fb2R0G01WZv/3EvWXWWckrRQMaT4AVW1n8UThqLcmq+ZKT1D2odjJn+ZwU55v4
         JVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdOUjmGuNqAuHRyGZ2If7iqdw2h6h7+gBbAOpSZBT5c=;
        b=DesjeX3z191keeaKL252olG9wlNczjSbzAeITfL8NRniRhGz/sKdi70wXbhJawmsdw
         +UGxA8Cff+1Hhx3zBxrFxuRh78oSMqi0mDErQiXRGkORahIJOIlFcEoCggJeq+7CrIWO
         FLLirPyN8slJjlt8Be8cawdYMX2eX4krweddtecJZelo6nm7eUNHHJD7Ozo48j0koy7Y
         KneZHWnNa7lwXnDBvp7SLJ8YNhkF1U6MngF7Bdvi3hph2Oa2+mfUqFjIJ2hVxDAAutMz
         lb/pGNJ81f1XL8Y0jldJwg756vZZrAf+XVJ/8S1O3CmJbxuZFCUlMty9dKmj9Sqw6oxn
         wz/g==
X-Gm-Message-State: AOAM533VwFcOdQBOCbbUHRahjc3VzJSy6VIOD4cFr8Ks2+HEVRmTTeW2
        miIXe9mgK+rGZfmfVlso4eQV6Iu9ztZJFoqGWBF7YTRkCP1sXA==
X-Google-Smtp-Source: ABdhPJwJM421vZFwcMHVpsFxxo+kzrEL+xYa3720J8GZy0j/vMWuThLpjW0HrhHJHbyVu8iuZcG0JRSxEI216O/V9NI=
X-Received: by 2002:a63:b1e:: with SMTP id 30mr32624656pgl.203.1608115693947;
 Wed, 16 Dec 2020 02:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20201211190335.16501-1-rdunlap@infradead.org> <CAHp75Vcckb5NA=tc5s5p_qzYE2qhJOT0vhCtfKhT_eqZe+PgXw@mail.gmail.com>
 <ec8e703f-e1ea-1253-edc9-311f0ee3e8fd@infradead.org> <CAHp75Vf-QcdL+FOd=8fUUQ0+ORC-RVKG+3Yqrar1J7wZMSDF+A@mail.gmail.com>
 <3d5a5c8f-4bb1-6205-ae76-354473d59a18@infradead.org> <CAHp75Vc3_ye3Ph0uVYdcsKr0QY5RGSaHmCgU1A2q-U2GCAafsQ@mail.gmail.com>
 <0f07d6b8-6a28-ba31-9cfa-53abffb0c0ff@infradead.org>
In-Reply-To: <0f07d6b8-6a28-ba31-9cfa-53abffb0c0ff@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Dec 2020 12:49:02 +0200
Message-ID: <CAHp75Vd8jQrMk28UAGNCOPFq-+TzL68tqOMYhDtRtwDbj-Ts6w@mail.gmail.com>
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd.bergmann@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 1:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 12/14/20 3:19 AM, Andy Shevchenko wrote:
> > On Mon, Dec 14, 2020 at 2:53 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 12/12/20 11:07 AM, Andy Shevchenko wrote:
> >>> On Sat, Dec 12, 2020 at 7:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > ...
> >
> >>> Here [1] is the rationale behind annotation vs. ifdeffery.
> >>>
> >>> [1]: https://lore.kernel.org/patchwork/patch/732981/
> >>>
> >> Thanks for the link.  I'll send a v2.
> >>
> >> Could we add that to the Linux BKP (Best Known Practices)
> >> document?
> >
> > Perhaps. The author of that is Arnd, maybe he has something to add.
> >
>
> Where is it located?  My search foo could not find it.

Closest what I know is [2].

[2]: https://kernelnewbies.org/FAQ/CodingStyle



--
With Best Regards,
Andy Shevchenko
