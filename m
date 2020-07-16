Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D48221EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgGPIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGPIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:52:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC04C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:52:39 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j11so6231940ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4SkJVL9wnAlCfKY4DdUogrbTCM+/fohgbxw2ivrMDI=;
        b=IVPN7uQz4RycEvnB+kUblr+7G5kcMWSjxVyOau6YkD2OKaEdg3pVafN4Qlgs/SvWRG
         q6685eGAmEKhKiTPTJ10fgjhS6Haazk+r+a3l/p2Q35RKXjp6DYrzZ6YOB/YLKdRfZlJ
         E0D4ZWts2qIQzCDvCKCf0NGu8uyicx9/v5gNydH3S6g3oa7h2mhuRSdmfKLlDUUXing+
         /yKbvxVnqmJKid3I3lZ8Eezjp22hnoAkIOEkpyGM4pc78E1Q2NYd1/TRKKDhhSM9Fqwz
         5sbOW1PIIWD/bN+fdagqfOD03K5TeyNWHcSSKkyssRpuLgumiGtK+qLL4J58A3QNdPkj
         9t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4SkJVL9wnAlCfKY4DdUogrbTCM+/fohgbxw2ivrMDI=;
        b=nI6JK9YOtIhSOabM6I01KgU9gdL9+JBCoivljRE7oOUlAE6oZwfsuNXJaW5f9NbO7x
         +L//dF9Zjit/ebzpi3VtH9pWhrywZqQHzTO8Wp3CU9zm7khdaF+RcufrQ7ORyZiasq+M
         MY5Wm/umGbSP0+ZAmtsQQaEOjX5i+I5xkFGbDPwkFMzWFppMrn0dyeHN4+H0ucti2Jf7
         8ndEE7iDiLzCJSWHnHLPVEv2XoTskQwGuoWdahM0EDre+RItPFrCu+soyphNkm/o4ZkK
         SP5bNrh/nxxDe6buDWj/6cT9Qds2CHxW7kMStcaJriwUvc0IzuKSZpa/ZD22GCXtSl4c
         jgtw==
X-Gm-Message-State: AOAM530/DVnEcwK4/lZ0KlKGgxVTbtdUqEMfNIK2H501VonsLAZ9q6/W
        qCrD6lA56ATyy6tx9BpHEzwpY6O1KXLCfI9viZ4L/g==
X-Google-Smtp-Source: ABdhPJxnjmMYaXbpYxjf3I78rpw/gV+A21zEdTZdXJDis0U9G4POoYVAm8UXaPmX1Ni16xc0ABeAmnVEozCLRMOC1lo=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr1452133ljg.144.1594889557461;
 Thu, 16 Jul 2020 01:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200709171203.12950-1-digetx@gmail.com>
In-Reply-To: <20200709171203.12950-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 10:52:26 +0200
Message-ID: <CACRpkdZNLDgsrPRenyvPZD6A+Wvj-P3AJBf5Ke-uY9=R9DyjxQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Improvements for MAX77620 GPIO driver
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 7:12 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> This series addresses a problem that I discovered on Nexus 7 device where
> GPIO interrupts may be left enabled after bootloader and the driver isn't
> prepared to this. It also makes a small improvements to the code, fixes the
> non-released interrupt bug and converts driver to use irqchip template.
>
> Changelog:
>
> v4: - Added stable-tag to the patch "Fix missing release of interrupt".

This v4 series applied, thanks a *LOT* for your patient work on this!

I need to fix the USB port on my Nexus 7 so I can test how the
mainline support is working these days!

Yours,
Linus Walleij
