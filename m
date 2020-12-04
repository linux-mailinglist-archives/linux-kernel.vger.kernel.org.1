Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2D2CF5A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgLDUYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgLDUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:24:47 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A923C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:24:01 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id o8so7086405ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LyBeuz2diNtW5BZOOxR9YJ0EXYbYY89wVKeCvPzrcjE=;
        b=bf1tqjlOkIiqWnBELCLRFxaJORzepD4AS0smEm/6N1CPF7s1/O22M96EejOte+swWq
         IDusL1tHfzrsqcSXqWfGA+9Ii7X1Uglwj9pgauO8x6oUjSIY8/Uw9p8BnKIZ7TXAlA2G
         /VLMDLHXhWDDLcg2mXmTevt1v84usxfoZxCEdYHbq6qQbn2FkgXmIGO82btnvwPr5t0/
         o9Tt3AErwgQaD/Ox+zlYEtePEvrIfcnVyZpQDUFaszywL9s9DVfM/OnjPpUCrJtoxoH9
         +FRgOTRbJYVYhWE1XL8voymfCNr3yteByOxaeAb7yqC8M4ruKASQKzSoDfkDL7eQpB1Z
         HlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LyBeuz2diNtW5BZOOxR9YJ0EXYbYY89wVKeCvPzrcjE=;
        b=rBxL5XJyBpyJahzN8q16MdXs0yOVIleUUBOHnjhozCnClIv1w+UVyg33uYleJ4RUwH
         tUpUaNNKN40+/uUzcHEqp9J3T2Etyt6DPHTF6kpIZ44SplZe57x7nKPatU3HDeYrwnOs
         w4NyzCCjFrRcrjVZVekm7yUEpaUqpGMNxSjW9rIuzFbOMNIjakMDpWMqB4VsKqPjVSdm
         5lNnrNmo2kBcDqthcfXOjD+US9AaekIwKf8I18Fp5r3JzK4we3kzqmD7nGJKmOt05vCQ
         +caRnyBKQTFVMB87YTpkDDsHCcJ8PtA673GJXI6SgBfcbjs/fXCuK8BcRTkfjV0eCQhJ
         l6vg==
X-Gm-Message-State: AOAM532MUEDumGyphRDwYKy+OjkcpQ3UF+EOcBt2IaNJDjIb8u7HB7Q/
        kffZ6hnTV8zdMsSKMQ4SnXYSyYFC+wZYZiAe27jOeQ==
X-Google-Smtp-Source: ABdhPJwOAWCvvVVlsZREqnduaO0oSDeLZEXm0B+vno+CjrVYWY8xV6h2OBF1/rmfGNpRH96UFlF5t91L3X6U4E8q3PU=
X-Received: by 2002:a02:ac18:: with SMTP id a24mr3436057jao.24.1607113440935;
 Fri, 04 Dec 2020 12:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20201204100039.19159-1-brgl@bgdev.pl> <20201204100039.19159-3-brgl@bgdev.pl>
 <CAHp75VdWMVoXyBBHFhweygAWpwOYg8GPU09DvXsgpGF2Oi04FA@mail.gmail.com>
In-Reply-To: <CAHp75VdWMVoXyBBHFhweygAWpwOYg8GPU09DvXsgpGF2Oi04FA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 4 Dec 2020 21:23:50 +0100
Message-ID: <CAMRc=Md7OsgsFRuq7s9Yy9AB3-MSywUoQnPCOGi6665YPrqbng@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] configfs: use (1UL << bit) for internal flags
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 8:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Friday, December 4, 2020, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> For better readability and maintenance: use the (1UL << bit) for flag
>> definitions.
>>
>
> And I didn=E2=80=99t get why BIT can=E2=80=99t be used?
> Maybe some elaboration?
>

I agree that BIT() would be better and did try it in v2[1].

Bartosz

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2398294.ht=
ml
