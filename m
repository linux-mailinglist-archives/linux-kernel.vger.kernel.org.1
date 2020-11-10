Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80F02AD755
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgKJNSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:18:43 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:18:42 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 74so17458412lfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbtNRUPuQPl2iPHtHsFzIyJlFka3u6ABmz9AweEvBgw=;
        b=JEU+FpCQ4IbiXRB7mCcxfDQmNhCAL3Z7wxJyaND/4hv2laT+z8uY+XF51xWMjgOz3Q
         V71ntAa1mko7FwZr9u6SMprNPIilW9Xj46sh19ntel+CGfwXPxr1UFGpbrXshCAuCrd5
         j75+beOtbw68yN4Y43uvCvvBHyazspeJT0TLMENviP9R2KMTUvJHI12ZB5cLst7m6JEv
         bIS1TR0x1opMRhe1+qgas7wlC4pgz93XK6HBdTZXvydtlhIK5UD6sfgPs8TcE4H6wSeS
         1YAiXStukw9jxytvk7+1oX6P9WPseaZmSrxSAsZHB4osdR+VxBthaIA9sRykzh7eqeXw
         PJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbtNRUPuQPl2iPHtHsFzIyJlFka3u6ABmz9AweEvBgw=;
        b=ZT8zz14cslA1u6VZJS8PRG0ChXnWgLmaGc4QufYggCVcvxHl5jKjLj30es83m3LuaE
         fmIKmF45EVmFvOYKaIPed+Opx2UDVypocz5QuFJ2H5FchQDiJxnZ0YmR8ZafDVO1/1jv
         PGEmKOv/gm+W9e4mHbAelXtVk22NlU/uJZb5X6K4Oj8Al96sod+A2fU3h/D5dkVcyLFk
         CsmBdghnblfKRVwSDg9GJfEu3oH4uwznPS6AUzCUp2BYsRnMRFme6IUmE6/4N3zd10BM
         O7uBTI+Fb4ZswEGBZ2otb740vO20EBYjkCVzQAtJG6jPBS28t7mRUaQMGiK8UkEm3fX9
         kvyw==
X-Gm-Message-State: AOAM531WcmnosxPAONlLk1FCJwnXD9ipG0fgej4WaE8iqOWY48FpE3lS
        ABbUdpDw2cdPajNBeg+iYtpTTneB9/627MittEwepDuYEn/N7Q==
X-Google-Smtp-Source: ABdhPJxbENFIcFdIy0BtvMJE7at99ADDRfiC2tMAFYrsLb/EWwJPTu+QbDj7QZ2jlNXlZKOAZtK0ok5mUjQbr18UzpA=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr7151465lfm.333.1605014321429;
 Tue, 10 Nov 2020 05:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20201105231912.69527-1-coiby.xu@gmail.com> <20201105231912.69527-2-coiby.xu@gmail.com>
In-Reply-To: <20201105231912.69527-2-coiby.xu@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 14:18:30 +0100
Message-ID: <CACRpkdb51B-bx3SPHZOeFG=+Qu5Ev-Sv9=wsFqXs3d-ykzcJ2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pinctrl: amd: fix incorrect way to disable
 debounce filter
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 12:19 AM Coiby Xu <coiby.xu@gmail.com> wrote:

> The correct way to disable debounce filter is to clear bit 5 and 6
> of the register.
>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Link: https://lore.kernel.org/linux-gpio/df2c008b-e7b5-4fdd-42ea-4d1c62b52139@redhat.com/
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

This patch applied for fixes and tagged for stable.

Yours,
Linus Walleij
