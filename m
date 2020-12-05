Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E42CFF85
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 23:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLEWaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 17:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEWaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 17:30:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594ACC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 14:29:34 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so12678531lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMTdh3IPgdRuXxX87is/6wJPLYrmhs/HNBuxcqKLHTg=;
        b=t+Ptj5pEah/xk6CZ2KbkAwGN0wNN2uaBvfTP4RgpyzDWhhvHttAXtkQPF1QIVUAilF
         8InGv8EqX6E54966Bq2ISiorZGqTbgdl4cMBKydPBoCH+2gIkZVZw+UfL3gd1nBHl95i
         i3cvpfSN5hS2yayablWljT3sAM6reoHHyZLGkSzrpxr41xOvyBMwUxw3m/2sUkVIi8K0
         eb5lT2wwfgvR7lq6I097fKn4K2YJqldodbNsFcp05tEw1ceLmX6Sz3x6OdHY4HtNb4dN
         ehifGQ4KgjpRIO/EpJyQqJvwOfpicsBoIHh2KEZGu1eIV8shRdfFep1qMV+lGMOb/twB
         UlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMTdh3IPgdRuXxX87is/6wJPLYrmhs/HNBuxcqKLHTg=;
        b=TE9SMDYdB4scU7i4WShI4amkZCCyuMhrx6OeE62LKkuNwybNcL6NeeunZogV+bKxsd
         BzFNd163Jd3viiorX38ZT4IBhktRyuclGrNecu7+RTUejpofuhG0kjs5b1LJAtd13ugu
         qW5H1c85hCZZtZNoMPuMsXO23rRD8dGNGhhwy0Ks8FpMFUWZvqsSwH6fl0ITXv/ijieE
         56/LGEpfGsA/LfWn6qBCfz9XuzVUxwFOuEW7yj7CKBlG+C+aM/A/hvJ0YTaj50wCjtue
         oz24bWUUhhRGd4KQ6Z6JeTOVKTRwrlz8lo8fTd8shJSq8b+/58B3PfYif31Kdtxau7YP
         BSAQ==
X-Gm-Message-State: AOAM533TNaqm32nCLQ/SgkmZ+rThPc1ownfIkh4nq4B722fATlVpDRvX
        BE3WjOI3rwgB9IbYA00bEN1tCSocCV1k9/3qIpIc1Q==
X-Google-Smtp-Source: ABdhPJzHUgmvKq8q28ZSiDGGIDCIYrwWQye5w9LKp3k38/zTa6J3yn9ZTt94kb21qBI5xhuibZfBwrlBP6A/WJDyiCg=
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr5382718lfq.585.1607207372900;
 Sat, 05 Dec 2020 14:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20201202133754.32045-1-info@metux.net>
In-Reply-To: <20201202133754.32045-1-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Dec 2020 23:29:22 +0100
Message-ID: <CACRpkdbG3ZSBCk_8QaP+7g5O-Otjrxv2VU3fXnsSuDDuQRMYyA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: just plain warning when nonexisting gpio requested
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 2:37 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> From: Enrico Weigelt <info@metux.net>
>
> When trying to export an nonexisting gpio ID, the kernel prints out a
> big warning w/ stacktrace, sounding like a huge problem. In fact it's
> a pretty normal situation, like file or device not found.
>
> So, just print a more relaxed warning instead.
>
> changes v2: drop defining pr_fmt()
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

Hm hm. It would mainly happen if someone was using the sysfs
ABI right? I don't mind if sysfs feels scary to use.

But I see it can happen for other code using the old GPIO
symbols so OK I applied it.

Yours,
Linus Walleij
