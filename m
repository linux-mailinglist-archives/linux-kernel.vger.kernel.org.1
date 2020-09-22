Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20DE274B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIVVbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVVbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:31:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8C0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:31:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so2099241pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHNrmMIOnOH4W4z3cRVv4aMVAMUCUf7Yh+iyJNJWMwo=;
        b=DtaDnTrKbmbRHgVTy67yui0nXY2+8KZRWq51I4xO/PrE2kx7/yZjEfYff62PXvONj4
         Ff6B+k3tglJNHl5qLa9tCFtnoQYq39mtNVwjzwL01nhHjWsYDX5Ezc3boVkkMNEVlqet
         t6fmQXPZen/Hu8V82NYrfhLvTRMdTMikCfaRJACjZ0eFmt0AuxGrQJ67LtNXiRxV4+hF
         NGZrBy4Cl2AoDMwrlSs31GW9DeQvWhzfyuGYCsyUjG+4Ooi0TRzf85NeOv1/gXQYVeEo
         pA9chUijiDu3Q4nwIwBgoLBeYffYULJU4/9htVkLEw2qe5cNFCGUqrPBroGHNdd/ST1i
         8cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHNrmMIOnOH4W4z3cRVv4aMVAMUCUf7Yh+iyJNJWMwo=;
        b=adbg36fbq5fLycAKlGNqg9qlXW0OSb7hBi2dqazZ+xd9o/pDe2qV+kH355Vh/d06qd
         IEsuuQycZRsTg8up3gw37NJ9otRzQobgfrtP//bVK+m4MIlb3Aeo40c7TXnMW+Dtw+KU
         cYoB2fSq1DkjxRPAHVGMAJkFHue2HeFYxBdljEgaOxuH+yzXzr6tUqyrJcv3gqjLs5kI
         HyLRCbJCi7XM7sPmco44pKLYhelB6cLbguyoYRP37GwSF3tZkUvgFkal8YVvLBr+GWPH
         Nc5VVKHPJVadG2c9M3HxLAESQ/+NZze+45FjQ6wElxeJ0rNKqYITVVkQ7egHq7dIpjE0
         MGOw==
X-Gm-Message-State: AOAM531m0y6uQ2GlS1lQHWeUuoLTC/E55ZJsdt5D72Odon0o/+3uN8zR
        y8Y6lu2xpmW2Zcnq8cF6S2HoZnwkQ0Qtmovr4b/RrnhyvMU4fA==
X-Google-Smtp-Source: ABdhPJxda1f8CY6wMa6tY7iX/+P7Wu8tSjqDnIa0KEqPpTUYMBj+T0SttpSjCpg8EKVrBHTGjbH3StlYVBQ2timi9ko=
X-Received: by 2002:a17:90a:fd98:: with SMTP id cx24mr5224777pjb.181.1600810304987;
 Tue, 22 Sep 2020 14:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com> <20200922192659.14535-3-rikard.falkeborn@gmail.com>
In-Reply-To: <20200922192659.14535-3-rikard.falkeborn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Sep 2020 00:31:28 +0300
Message-ID: <CAHp75VfQNs=JvhPn6rWvvSdUn2a4PZtQ8LWndQoJ54W7ebrtsA@mail.gmail.com>
Subject: Re: [PATCH 2/8] mfd: intel: Constify static struct resource
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:32 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.

How had you tested this?

-- 
With Best Regards,
Andy Shevchenko
