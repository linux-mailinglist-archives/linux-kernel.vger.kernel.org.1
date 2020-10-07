Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B345285ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgJGMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgJGMLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:11:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128BCC061755;
        Wed,  7 Oct 2020 05:11:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t23so2727575pji.0;
        Wed, 07 Oct 2020 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1sZMTj1z8WWAiutDAamKfkKSRHz+5FYZvwSDHX5MtA=;
        b=oPHaFA+YLSHnaICvsrlsvQtpanVzndTElHkuk2LQ3y524GBCXYDhnSVWjqQrv5Gjgi
         OcQ0oc4b1B16uASt4NexAMV7RXc8ZH7cxpCkxoOXgmbXBWVML3uAT4nGiB2U9FyseEwc
         1OpPTEB/OWWUCGXjmvjxQQ1ZIkYjzPZOwu4h7x3aOVLPbaqoot3yoTK1BKOgyQooMx5S
         9Npev39M+KdMHO9Pze0j9o7pr35XjWrI6NQ50p4coUnBt85Vwm4SiBQxiwirj3lRvV29
         3hvWT5D237eyVu1R/OHaVcdhGh3IS54OL9/vJvZeXNou2TuQELJysNG9jlrOMB89lxsf
         DPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1sZMTj1z8WWAiutDAamKfkKSRHz+5FYZvwSDHX5MtA=;
        b=eQ48KG/PGr+P9O5VLe7leauBJjiT7TlM/9leIp/4VeFm71ZmxP98zfImnmF2+Wm8AL
         4s8Ki95/bVIuDBV/1dPNp7CiG3sstsnhLYox1qVABaOSpX5zjg5NSHrs+ZXUtKWDSdIl
         +WuAby0jgcneokWo/mlT7kBo4VCXklti7yllg6bKFqs3ToF8jnZJ87nEoUVn+1WsLDkI
         eG1cxMf4zy22klefoTD3pyGagcos5B3KNOgisUdUZkr6Lr4qZs8p+tYFbWQTnG2Xtcu4
         rLHtST0KgIhmIFX3/ypX1PSxpWc7yN71lRyLprjcbyN6FxqhCVh2rvbirc7skfVxLNij
         8X8Q==
X-Gm-Message-State: AOAM532YWIysuha5zJFMUThlWLnj3G90TG15TOFVXUhR1RlfyBjceyYv
        EUuL+wSjn0OpTbAWbTc1vGY8gvoudr4AVUt1PXufhuRn3LPgwA==
X-Google-Smtp-Source: ABdhPJy+DLEsp4m18nWyTpGlKlTUJWwja+pUAPzURu8adjBO163pOP+0d/D5OkAoRmyjEDZmbLZ/piavh55f7H3GysE=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr2713556pjb.228.1602072712530;
 Wed, 07 Oct 2020 05:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201006224702.12697-1-david.e.box@linux.intel.com>
In-Reply-To: <20201006224702.12697-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Oct 2020 15:12:41 +0300
Message-ID: <CAHp75VeT4NwaZ851FHqpdFH=JeTwteVJdUPemHBtMJS-s_R15Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Tiger Lake PMC core driver fixes
To:     "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 1:47 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> This patch set adds several critical fixes for intel_pmc_core driver.
>
> Patch 1: Uses descriptive register names for the TigerLake low power
>          mode registers. Not critical, but was requested in review of
>          Patch 2.
>
> Patch 2: Fixes the register mapping to the correct IPs in the power
>          gating status register for TigerLake.
>
> Patch 3: Fixes the slps0 residency multiplier to use the correct, platform
>          specific values.

Hans, Mark, this series has been internally reviewed and tested on
affected hardware, I think it's ready to go for v5.10.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

David, I'm not a maintainer anymore here.

>
> David E. Box (1):
>   platform/x86: pmc_core: Use descriptive names for LPM registers
>
> Gayatri Kammela (2):
>   platform/x86: intel_pmc_core: Fix TigerLake power gating status map
>   platform/x86: intel_pmc_core: Fix the slp_s0 counter displayed value
>
>  drivers/platform/x86/intel_pmc_core.c | 82 ++++++++++++++-------------
>  drivers/platform/x86/intel_pmc_core.h |  5 +-
>  2 files changed, 47 insertions(+), 40 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
