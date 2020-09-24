Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4B276FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgIXLQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgIXLQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:16:24 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6EDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:16:24 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u48so882595uau.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nk3vQHf7m3aiScaUunynzr1pMU90udNzOFKcaYY1Og8=;
        b=aaCzl4nv5nzTj9EGJEU3mKQiR9PJx6/CJsNnnFqHU6HhqBwzQbCRhlsDC977JBDA3N
         cdZV4V+2eKCqhUsiD3Rw43a1tj+MEeVs2nT7eKxoIF1ZAy42mLIb16R9/rY8nrkjDXS3
         fP31qSj6gGSjUKYuoXDhfR+PikvI8GjT1xnSKAywezXZiwMFTjsp70EY8//fFsSEyUoQ
         qD+nOL3T9PwB6MoItve4iZZY3hE3Tv8h9yw0AWocEzAgQv3DGA5HjPxEFrswSHuC1Wwf
         Vk/Z56XCmxtiZtYv/rhA0rr+5EHhq0VWAhULxIvgOwY4YhIh1uLB8CjxqCc2aldG2W5L
         nijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nk3vQHf7m3aiScaUunynzr1pMU90udNzOFKcaYY1Og8=;
        b=jgU79+6oIiLtyzkT7p3c5AUfWltARZ6lNG7BGEi+cms0QDr9PRIPbxTz1ALpw+LuK7
         XH6yZKmGNJrPj7Ay00uftSgqqaWnTdHuOAEvIfM86LFQtK1M5xyiFVVotIsmogmbL4M4
         R4Kbd2axMtjCXDkCiIDXlN3l88ORxxLJb8/UNUkLzQEhe9R5rfL3rleC/VPwziapvNyV
         JZN23CyOqnphp5Mw+QZrUxisAtwNLGkhlX9VPoc+EoIkNFMGuuujdPNkbPPzpWaXVk6U
         qjS3+Tpj9RFL6AJdpRXU0YaXJ79xc16CKKkrGcY63po2BnH8N3RWmzetsDdWP0P//dGF
         3erw==
X-Gm-Message-State: AOAM533c3d6X4m46JluPUbYXE7e+VaptXD75i5AasPCeiXP6etK8yLjD
        XXSZAt0mCYT/0X/6jnC2aF15bRU4cQ/Ivz8oUeq1GDiWITZ/6g==
X-Google-Smtp-Source: ABdhPJztYC3bPd02xROVe1j/dcaglzm0oLQNe+n67Q+i8BWT7pMhmZgatS0vPhEVTaxbNrIuQ5mTVWKE2OgxgQzy3UY=
X-Received: by 2002:ab0:130a:: with SMTP id g10mr2490969uae.100.1600946183277;
 Thu, 24 Sep 2020 04:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <1600933221-3496-1-git-send-email-rui_feng@realsil.com.cn>
 <202009241736.oeTpczA1%lkp@intel.com> <26c3f3e19bbb440798a791c5c7359b14@realsil.com.cn>
 <CAPDyKFpko92mcdim1UsnzGcPZD+KG0bNsq+DPhB-U+_kZ2Cr0w@mail.gmail.com>
In-Reply-To: <CAPDyKFpko92mcdim1UsnzGcPZD+KG0bNsq+DPhB-U+_kZ2Cr0w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 13:15:46 +0200
Message-ID: <CAPDyKFoRwQsMBRMzwxoJxBcLyvKhMGc2LJM+8z4SCHme+deADg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: Add SD Express mode support for RTS5261
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 at 12:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 24 Sep 2020 at 11:48, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn=
> wrote:
> >
> > Hi Hansson,
> >
> > This patch is based on your patch "mmc: core: Initial support for SD ex=
press card/host",
> > If this patch is compiled alone, there must be errors.
> > What should I do in this situation?
>
> You need to pick my patch from the patchtracker or the mailing-list
> and fold into your submission as part of a series. In this way the
> 0-build server will build patches stacked on top of each other.
>
> Moreover, if possible, I would suggest to split cardreader changes
> from mmc host changes. In this way you would get a series along the
> lines of below (not sure what order is best).
>
> PATCH 1/3: mmc core changes.
> PATCH 2/3. cardreader changes.
> PATCH 3/3. mmc host changes.
>
> Kind regards
> Uffe

One more thing, please send the series to linux-mmc as well.

[...]

Kind regards
Uffe
