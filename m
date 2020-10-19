Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DA2927DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgJSNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgJSNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:05:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E223C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 06:05:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 23so7497025ljv.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX+5XTwgJ+kyl2IgszHJ3j0XXhTXAzAyYtJEsBeELWo=;
        b=SkChLqgHFZsUFZe1d3Y6qNilGLnPyrLxB0GVVCuylcL0YhXqm/f64dLSyilQpJJX2M
         mXj9uiNunyERDuHn7bhjtmgqgXOkzN1rTtOnW+LoinokZfmH52mMk1Msjez2zMQzvpbW
         nfOLSTVuuJDFYP0tKiIdf59N1NFVtEwGmhDBa3zO6EGGeEuifIbbunUKY7sRyAn3bbb4
         fMW15g0lAW3muZAFSnUp3OE5LGTWVG+jGyHV+XZMdydRG6xFGpSb6DORKQ2kw2s8Y/t0
         7s25leXbRrQ7MdoBi1f3hsumcnbySe4oTxD09wOFbu0qd0yhAEWrlpBNCNFWxmws0ef4
         ZOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX+5XTwgJ+kyl2IgszHJ3j0XXhTXAzAyYtJEsBeELWo=;
        b=d1exVJdU5J6HZUB7cbxugUKsueV5WTSVMGJ/ZM2Z7xtybfdoLFlqMoUqf9eAt6eRbA
         NmLvRtoCxQmfr8hGb/dNoA302ra5ezNy4PqD3ZolB6JQcGY00Cfda/iHkKpOvc/DEtqP
         /f8XHtEjn2MhFLhIThB7Zkn1kmG0K9vOm47DrTjrhkaB8G9pbNYy6eN3TDxIoH8Z0mSp
         XO8m+qqSA+65C76uHe5b4NN76Q9rYQBk4NDDSsXC+AnXiM4IhRNsct3VRn8fIMJ5upv+
         aKwZO4maB98ozLxMoGjLQi2+EP0l/ouswKdyxbJiHq0SzT0hEX9oJhH6G2/AUAiEpOgW
         CR2w==
X-Gm-Message-State: AOAM531/Vrbr2dZXGYW/u0HNZl1cf6Aelv2+7V+4IKj0sM0mH2l6pn7w
        1lCdXtK1VGMZ9ZC6CRzWkx2yjWFlCYi/q6md1MtP014U59BJvA==
X-Google-Smtp-Source: ABdhPJyMmwgqGRkC/jy1QCndHhfKuaKQcEESqu7SGnD6YohTpsbaEGSjJzwVcU1LC3izvP9QjPHjcFTlwXx5QK0NYfI=
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr7045092ljg.286.1603112713567;
 Mon, 19 Oct 2020 06:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201005070329.21055-1-warthog618@gmail.com>
In-Reply-To: <20201005070329.21055-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Oct 2020 15:05:02 +0200
Message-ID: <CACRpkdZs6oUMM7NyfYyU1bjPbHKUBR+VCX07sYNWE-v7nY2y5A@mail.gmail.com>
Subject: Re: [PATCH 0/5] gpio: uapi: documentation improvements
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 9:03 AM Kent Gibson <warthog618@gmail.com> wrote:

> Kent Gibson (5):
>   gpio: uapi: fix kernel-doc warnings
>   gpio: uapi: comment consistency
>   gpio: uapi: kernel-doc formatting improvements
>   gpio: uapi: remove whitespace
>   gpio: uapi: clarify the meaning of 'empty' char arrays

I applied this to my fixes branch now. Thanks!

Yours,
Linus Walleij
