Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D421F51C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgFJKCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:02:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DF7C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:02:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so1728121lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/ZiUIIV8iMk3Rf5VRCT4Eiot6h1rdh+GgTRfXX5OTk=;
        b=iRkvyWtbKG9FeaqfyEPsStoeGXfM3aS4dkrQhpFqfltnvXhwdkTqtgztvDpaIZzGmH
         RtTZO76xVc/3qdy0J9rSVKrLaKNYBl/GS83JoQTuvNV6rm7N3OprgfsjHVGpoNUWFi+R
         RqoFqq3Gw2koDSIrukPF1J78Az79usDNRWUtZWwWDOCtdwr5bpeintbgvc/pxtAgE+Cv
         C8ihjLEojMlA3EDqHnfq7BJ9bY3Nh5iFfEY817yXS1KYQf8LL4SoR+jqzJqYAM+PO/xD
         IUvJuO/LW50XQV+DioljyezibAVwSq96QLyM12buU5/s7AIsOrDcXaNS/E7i8CLNyozo
         NlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/ZiUIIV8iMk3Rf5VRCT4Eiot6h1rdh+GgTRfXX5OTk=;
        b=jAK6tAd8grpjh+oyubZ5zFE46Yy1Q86+qH8wpCsqa1jk0TXEV+ZIapfegVGy3bISuk
         J2XnfhHuoNaO9lW8V5MOj0v2rVc/LObETatXSbgHJzcERdKi5xa4l4xnkp1ayD8P+bkF
         +UgTcNCOR7Y+1ER3wYB+2Ny14xemxFyrGURQH6EPWjCzHWbZNaagyaSe25AGdlXYcE7R
         X5l+uPfbZoDb7ZWOUMFmkZOGWO9N2ULV/FQx+xfxSkmjDtNfw7Ukc405cF9v+BosNJ8z
         m7gK7mBnLAjTPA5OjZpbRWX83LBFQQc+YvaaxTsgLdJ2rpZLjlc4G8wvjPJFGfN3VTMm
         CWrA==
X-Gm-Message-State: AOAM5321rx4WZjU1o2btSMe3MZsSHM1w8t1BDnE4pirj5oztQucjtl6V
        JUgWD82Ogy860qSA5LiOFRMMTCjyRuTdyb/nQYsnbQ==
X-Google-Smtp-Source: ABdhPJxy0MwTfdtGLEADWrUxJKMn/lX/2cr8fh3TgJePLWUwPx481uUyfXCrk3EVKsfi51DxnDYboh8qt8cSxvyP4Gs=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr1249133ljo.338.1591783358305;
 Wed, 10 Jun 2020 03:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFAFadBs5UNsktWR072dXwvJpk-rk1wqPBCb=gkLfxMbE55QUQ@mail.gmail.com>
In-Reply-To: <CAFAFadBs5UNsktWR072dXwvJpk-rk1wqPBCb=gkLfxMbE55QUQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 12:02:27 +0200
Message-ID: <CACRpkdbkThMGRd=7zCpuuVqfZQSofLodvQwf9gKhxTxweM5gpw@mail.gmail.com>
Subject: Re: [PATCH] max732x_probe: remove redundant check
To:     gaurav singh <gaurav1086@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 6, 2020 at 5:09 PM gaurav singh <gaurav1086@gmail.com> wrote:

> The pdata is already checked for its validity above:
>
>     if (!pdata) {
>         dev_dbg(&client->dev, "no platform data\n");
>         return -EINVAL;
>     }
>
> So no need to check again. Hence remove the if (pdata) part. Please find the patch below.

Please send the patch as a single main using git send-email.

For further help see:
Documentation/process/email-clients.rst

Yours,
Linus Walleij
