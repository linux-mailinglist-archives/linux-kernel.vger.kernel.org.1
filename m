Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2107285ED5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgJGMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:12:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C70CC061755;
        Wed,  7 Oct 2020 05:12:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d6so885104plo.13;
        Wed, 07 Oct 2020 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XaZlHDNH/DSELiM8FQZNAJ3/IW+tUlDn4zzRGRnH5E=;
        b=Fl4hpCsAEngY8IJGeqjY3EKl6MJbBmYK0z33+89yl6/WeooBLy+UV6dFHLtuYyEFQf
         2K6+lobQcWzRm8Y/T/HbMgwuEwFY1TAD7lxga7kfOHTsMWxT7xwhJdEOFeOj56YT2TUN
         jvjwNPuk4kM8ws4iTY1eKtmsaJJO2ewe5pfQ2vW/7101npJpdxNfRFCa8PK+LTzaqRzF
         RKlaNW4nIqFhcpQVHo3mLQQm8Z7YfG4P0Y/yCsb+GyvEiwjJIz4OxYjHHPDdeOpFkEtB
         ff/EZd1pOYB5WajN1sgbS1y4S8t/mXtRng6xXFp62TqlsY6NDr8OkMEUVImtk2/2DpOz
         sMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XaZlHDNH/DSELiM8FQZNAJ3/IW+tUlDn4zzRGRnH5E=;
        b=YQ3w1F69jKAMbafLvBuns++WcjEGZ625cn88eOLwCuXnfqEQgQV2LAk2VsH4t9xvKH
         Eo3ZzvRrgTmaA8pqXM21j6czRWRJ4oAl/BM4Xy9t+7UiDaijkLAmhe9yqjB+hS5+dDop
         eSKfWdc6BInfF156EeOK9Nnfxjb+YCoo7DYpMXJ8sxzD0FuFtj7dzM6wjwGOsAZbfAQW
         YUzDaUcbrflIR59dPQyBTqSM/Kvz4Vpfmd0CCT+sz4P619eHlt7dg5pdiPAL8jO6pNym
         Ps54rrlCFb6/AeqL7xpwbo6QiX8Nxxsy69hw1B1HIcfU9+aJ2EYQwHrVPNFgyGiIswST
         iQEw==
X-Gm-Message-State: AOAM532nyzCRhJJRR03QGQR7Sh1kCXIbioZxkxTf2tKgHonrTE8HBa3O
        GhzbFW3Lmycq/0jcBp3PoBxgvMmADVzGG3M+OhE=
X-Google-Smtp-Source: ABdhPJxvGc6tR2mwP+Ya40OEpjEHY+M1J09weAEkl/PrK23yB2bwBxq6HK+JaK2jsK8ZohS/JS/UfecmuIiEYLnS4do=
X-Received: by 2002:a17:902:ea8c:b029:d2:8abd:c8de with SMTP id
 x12-20020a170902ea8cb02900d28abdc8demr2677302plb.21.1602072749621; Wed, 07
 Oct 2020 05:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201007035108.31078-1-david.e.box@linux.intel.com>
In-Reply-To: <20201007035108.31078-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Oct 2020 15:13:19 +0300
Message-ID: <CAHp75Vd8byvCZw6Ls4uqGVQ77Cd2bZRK0GJKVfHtdeQE5ET-Cw@mail.gmail.com>
Subject: Re: [PATCH 0/4] pmc_core: Add RocketLake and other changes
To:     "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     irenic.rajneesh@gmail.com, "Box, David E" <david.e.box@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 6:51 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> Add RocketLake platform support and other driver maintainance.

Hans, Mark, this series has been internally reviewed and tested on
affected hardware, I think it's ready to go for v5.10.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

David, I'm not a maintainer anymore here.

> Gayatri Kammela (4):
>   platform/x86: intel_pmc_core: Clean up: Remove the duplicate comments
>     and reorganize
>   platform/x86: intel_pmc_core: Add Intel RocketLake (RKL) support
>   platform/x86: intel_pmc_core: fix: Replace dev_dbg macro with
>     dev_info()
>   MAINTAINERS: Update maintainers for pmc_core driver
>
>  MAINTAINERS                           |  4 +--
>  drivers/platform/x86/intel_pmc_core.c | 39 ++++++++++++++++-----------
>  2 files changed, 26 insertions(+), 17 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
