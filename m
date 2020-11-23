Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B812C04B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKWLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgKWLiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:38:17 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDDBC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:38:15 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id i18so17786677ioa.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 03:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEIHaRLdY4svcO0dyu5eHM/rtedUHkcmJRMa0FJMPJ4=;
        b=GP6m8RyIlIMmZWhzQpFvb5uqltAbBrJIWzbigUfPD/CoTvEfIbJUved+YUui+XamxY
         k5QVhcO/me59EEhzByCglAbrUOUOGk98xLwY7/bImqoCc8qdH2hrlHubzkgM8PwKbKm4
         zNuZV84srSen76EKhGMTd29pdnTEkKYqLXTS/A86ZZuXmRcwMRmGqKaOUuzll6u5Tuqh
         kiNtxCysEvymxxuqzORRu+no96GgOtLJ0F3skW9e4+oJgyVTF4bolmPY4HguK1d2yfbU
         P6+sXExhA0tZM7zScpKtlkSiD2acEjI1gf1aqfdXBN/aEgRZJRQ0TgeO8TRA/iC7Zaec
         6Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEIHaRLdY4svcO0dyu5eHM/rtedUHkcmJRMa0FJMPJ4=;
        b=gKCpmH4ITmYjfGe2ZaRTozPhrL1nZlGXXSUPG6b1qEolGnD57ib3ynPRaIr6jj//xI
         2YdGdaRGiMaP4qnpp0nr+8Cb1kFDzrFrg3JZ9E3tcnFz60+BxdEd9xekPTfCMs5yuBKE
         vx/lhx19T17sf+Dlx0NaIAxQT2zIHIFLBImYC/rWHQccCBw5yLZ1NAFkpVwB9xahX4SL
         zCoX20k4Tgug+hJosEp0bvHa+L8jSnodXgDTT9sP2TyW/Ba9BpwNJMcXqyAbOXjjsbXV
         gZXoHNwRgnFNgGwNR9OAoZ/L8/Esx1bipE1dxdHSe3FbnJCsq0J1OUPt/o8b86lIAlJ4
         VNSg==
X-Gm-Message-State: AOAM531E3GXZuSM5BHV6gtvqaJKBy5eg+A6OTIlG34SKSs0Lh/Paw0Z9
        Hq72qDgQSChCpT+X7Wthf8RgO7JGbDa0xBGHXGzzDQ==
X-Google-Smtp-Source: ABdhPJwVWjnYz+DgMBvZLuctxMME863ELoTZlJt0e3QGm9tmGD80Gw3gBjJBbEg2Uy/5yLtDkdjEqNDARU2M0VxgukY=
X-Received: by 2002:a02:65cf:: with SMTP id u198mr28286999jab.24.1606131495039;
 Mon, 23 Nov 2020 03:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20201116104242.19907-1-brgl@bgdev.pl>
In-Reply-To: <20201116104242.19907-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 23 Nov 2020 12:38:04 +0100
Message-ID: <CAMRc=Mdkr+65Nu7ddjtMHTbedpNf22w1bE97vipKSdXBYm8=fw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] gpio: exar: refactor the driver
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:42 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> I just wanted to convert the driver to using simpler IDA API but ended up
> quickly converting it to using regmap. Unfortunately I don't have the HW
> to test it so marking the patches that introduce functional change as RFT
> and Cc'ing the original author.
>

Hi Jan!

Could you give this last version a final spin before I merge it?

Bartosz
