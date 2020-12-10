Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAF2D5BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbgLJNaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbgLJNaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:30:39 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35671C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:29:59 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id l14so4716606ybq.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 05:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhMaY0KKzxuLDDtui36uofcO1lLljOXKYW78L9cWppI=;
        b=pbROG8ec1yQACiKFP4sLd6oVElqmA7KlyC7+eJa+7Zeuc65ahXcd6AiKbe8lZEJnde
         EUZloI/ywyva5qpNfLPRtpWBV8UHOgrc/vp7U7OMtCAHkcEVb1XuZ2Lhl6pEgEeek6xV
         gAOm/tVSnRWbmjFTfNqvT6FSIiEMzuEEiB3C3eN/GgO2zG3/i701fvVw5jrUesubbm+w
         //mrrQfJTzudybD3JYp28d4J7KvcldIW0nkiYNYVfgiIMNTGYfDv1vpeVnzlFN4HoCOr
         4SfiyZM1LqGP82fD4nCAo1Tm4rBlkoHdffWAc/gawhw6oFXKHhfyqdzmgCzZpLVtvLPl
         CUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhMaY0KKzxuLDDtui36uofcO1lLljOXKYW78L9cWppI=;
        b=SAZyftI+NvvoAzAacrP7UfaJIFsAVKK74654C9JOPEjq2FgM/jmqn5zig2q1wraTN1
         /H24mKhaLsaswi9H4IlEhWAeGCGN2nv4YJCaQmDxWfIUU9yiNK4Xg00ft1jcb78xZKGt
         zFeTYl1V1FHgB909SKN7rrPmATwUO3Ts3FX6INozEdDh+VF4OsjSQn5orRu07/FMIi/u
         /CQOhDeXixL8RhLkYs2J/HOHFr/p7FIL16AZJl+u+oh5fQK1yEnj4vqu9FwHNg1HHKy+
         9yruwAQfdCq3WJ51QFDgxUwSgxT+xzsiFpYU8ZGamAxFdd2d1Q8KOey/3fQ5w9OH6Wt9
         C52A==
X-Gm-Message-State: AOAM5328fOkwwgchMHspf4tvVYTDGIxrYtJONo+VbD7FJbLY4nteL9jO
        AKeXGjE4RcqMC5XA7qZCHErcyas+gM8rtakWV+w=
X-Google-Smtp-Source: ABdhPJzD/McLgHdA1Es3A3nEl0FKBqRS87iQ+WjCEsS/CNxhGhjfPcp3dl82q3XLzi3uit8hkIfSFQ8hsbc9PMIHlvM=
X-Received: by 2002:a25:2506:: with SMTP id l6mr7829176ybl.115.1607606998553;
 Thu, 10 Dec 2020 05:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
 <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com> <CANpmjNOdJZUm1apuEHZz_KYJTEoRU6FVxMwZUrMar021hTd5Cg@mail.gmail.com>
In-Reply-To: <CANpmjNOdJZUm1apuEHZz_KYJTEoRU6FVxMwZUrMar021hTd5Cg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Dec 2020 14:29:47 +0100
Message-ID: <CANiq72kwZtBn-YtWhZmewVNXNbjEXwqeWSpU1iLx45TNoLLOUg@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Marco Elver <elver@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        richard.henderson@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:35 AM Marco Elver <elver@google.com> wrote:
>
> It looks like there's no clear MAINTAINER for this. :-/
> It'd still be good to fix this for 5.11.

Richard seems to be the author, not sure if he picks patches (CC'd).

I guess Masahiro or akpm (Cc'd) would be two options; otherwise, I
could pick it up through compiler attributes (stretching the
definition...).

Cheers,
Miguel
