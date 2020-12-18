Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF372DEA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgLRUgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387521AbgLRUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:36:09 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DDC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 12:35:29 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id a12so8659351lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 12:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gG6mCf6v7fYse6hOM6yE0JGOuHH0YNhZes9w/QL8tHw=;
        b=R3yzZrDSS0+vsgCuyTFWk6wTgJpFZggaojIhJX0VVtDxhasYavTkCQlwRa17W1GYPP
         e9OjN5qMJVFNfgasUGbAsg3PkiGWvKPrNU+L7jzOl3Jc0twhpVEz+uiKveRA+lc1uk1+
         tyHneDCy3wmIUha5NS4t8V505z4KeIu42wQ8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gG6mCf6v7fYse6hOM6yE0JGOuHH0YNhZes9w/QL8tHw=;
        b=JLFSsiSerwlVsLZrdeKJqlUuqw5QXL3mUrIAfVTn6Tk7hecVRpLHTmRGq7kXJeAXGj
         1diBRvPhPRm4bmKoKShuxcFVNWUFi3sB5BOO5m23cH4TJ+Zm71BkAjdCsR/PC1KYPG5m
         t7xAgXXgc9R1aIKm3UJsPaRdtNHiPuNPMa+9Ia815jEgwj6MpAWGa17thv+HYliO8pFr
         TQgXtH+EW1CpBGT+7YnX0v1EYaJt0+qzT+lM+j5qrBOvf6Sx4ULQtc1wzd+XR4dxFIpu
         jULtZMtgDd45g8MVRHnV29jqeb+McgA0J1/+BvZGt3ROe6ClNtatsBL4ILIbT5/BRSkC
         x7ug==
X-Gm-Message-State: AOAM532chMEtXPi+L74ehwwxNGAxYkCDaC8WDLEAIeQWtkFssbSWtmgD
        E4sAixypx1iMy6optMSkcug4GJUUodX+5g==
X-Google-Smtp-Source: ABdhPJySQtLzJ+O7KrkRXQGXS5YjH5u9QMDBvPRcFhZHj9tg492dTOvenakd8AecwzMOnzXrMi4snA==
X-Received: by 2002:a19:ac07:: with SMTP id g7mr1973933lfc.125.1608323727301;
        Fri, 18 Dec 2020 12:35:27 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c136sm1036420lfg.306.2020.12.18.12.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 12:35:25 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y19so8555363lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 12:35:25 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr1995208lfr.487.1608323724985;
 Fri, 18 Dec 2020 12:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20201218160401.2478999-1-thierry.reding@gmail.com>
In-Reply-To: <20201218160401.2478999-1-thierry.reding@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Dec 2020 12:35:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfVj3n5qftaLwk3ZiMiKooO-vzk_XHbcRKPCpBWbtq7w@mail.gmail.com>
Message-ID: <CAHk-=wgfVj3n5qftaLwk3ZiMiKooO-vzk_XHbcRKPCpBWbtq7w@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Changes for v5.11-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 8:04 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> This is a fairly big release cycle from the PWM framework's point of
> view.

Why does all of this have commit dates from the last day?

It clearly cannot have been in linux-next in this form, at least.

I pulled and then unpulled. Don't send me stuff that hasn't been in
next without a _lot_ of explanations for why, most certainly not the
week before Christmas.

            Linus
