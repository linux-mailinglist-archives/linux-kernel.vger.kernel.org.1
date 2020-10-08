Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33F28767B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgJHO4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:56:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9874EC061755;
        Thu,  8 Oct 2020 07:56:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p11so2886385pld.5;
        Thu, 08 Oct 2020 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tp9SYBpLu1pQ8AYTC/6Fxw89TyVflgcGyGGWA6Vb1QI=;
        b=Oy+R2jtC1a351pLZZkJA/ulCoHPJziZibg+tnnSXNukQIsT9lKUff9YsGJFZuZZLmH
         awpkQVqdKR8Vy4FBfuUohXACx8L8MBj3EwfDm9vXDBjZSHGr9qWlfzg1Po+Sxf0ZeORM
         ZebxRfADejXyU7XCn9f1xXcTsuTZ9QBx2Un0T5V4XtPjBX8st/ov+z7FoX6fAeGVr2/n
         pGZ5LaCbxeeWIVWhmyvh3/jcOS8ZWNiW3mH2k1JSuOC6MYJmm/hWIb9oHBSuqC1Lr0uf
         ROpaGTW8hkQMXOPyB39xxBbOjqHDUKaod0fAKE1nuBbnBitBaK4WK1vH1yF4JEssWgfc
         KTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tp9SYBpLu1pQ8AYTC/6Fxw89TyVflgcGyGGWA6Vb1QI=;
        b=Ee/o8i6lYRlc7HbhAWxnCWU2fGcSSt2MSRTxbib3XX7kdseJnUoiVjntIqhVnkp1na
         uiMqc9AnofirBGB/KGv9ZG0mVsEX0OSB2gQU+OdNEdnzqTkIVlmwwjxGbfWmvzWY9K1d
         AlsKGCXR2akkC/nNLdRXaK+DXOHkVMOjQYX0NkFkzOjXUQEg7XVctT8j0Q4Pt98NcvPG
         6Gpj8hjeKVu/OfJK9mn/rioybPDZCR4qLl87Oc+T6bI89pRkir7eswBHBJQ6S8wgNmH4
         eyFdM/PgSe0Kn97PvDmEvRZh/TC7NuOTPcHiHasKgXNqXEYRFLsYYrsWG+YLx7WdLSqE
         5PCA==
X-Gm-Message-State: AOAM533LY7c5RWcmuzBpBFQsqK7eHxM6ewHLu2Ryu2bAk02CkdVC0lzK
        GFm/7s8T8B6BHbCDpIv8hhRrO/ft/97JFU3JFXo=
X-Google-Smtp-Source: ABdhPJzqDxwzIdIqhtJkYQsf6fNIN7bqpEqVNsUCXgjPUKBLIMO4EBobCDVfta4kBt1y+dX7rvc6Yz7pr4QBHJ/c5LQ=
X-Received: by 2002:a17:902:7896:b029:d3:7768:1eb with SMTP id
 q22-20020a1709027896b02900d3776801ebmr7876691pll.17.1602168968129; Thu, 08
 Oct 2020 07:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
In-Reply-To: <20201008143455.340599-1-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Oct 2020 17:56:57 +0300
Message-ID: <CAHp75Ve3f1jtew+NEt+k2mkOAjmA6X+Ko_nJtZjBLNUf9oDQ7g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] platform/surface: Create a platform subdirectory
 for Microsoft Surface devices
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 5:35 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> As has come up in the discussion around
>
>   [RFC PATCH] Add support for Microsoft Surface System Aggregator Module
>
> it may make sense to add a Microsoft Surface specific platform
> subdirectory. Andy has suggested drivers/platform/surface for that.
> This series follows said suggestion and creates that subdirectory, as
> well as moves Microsoft Surface related drivers over to it and updates
> their MAINTAINERS entries (if available) accordingly.
>
> This series does not modify any existing driver code, symbols, or help
> text.
>
> More details regarding maintainership can be found in
>
>   [PATCH v3 1/5] platform: Add Surface platform directory

For patches 3-5
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
1 and 2 have minor comments
You may add my Rb tag after addressing if you agree on them.

> Link to discussion:
>   https://lore.kernel.org/lkml/CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com/
>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Changes in v2:
>  - Rebase onto linux-platform-drivers-x86/for-next to incorporate
>    changes in Maintainer file.
>
> Changes in v3:
>  - Add separate MAINTAINERS entry for platform/surface
>  - Add Maximilian Luz as reviewer for platform/surface
>
> For more details regarding changes, refer to the individual patches.
>
> Maximilian Luz (5):
>   platform: Add Surface platform directory
>   platform/surface: Move Surface 3 WMI driver to platform/surface
>   platform/surface: Move Surface 3 Button driver to platform/surface
>   platform/surface: Move Surface 3 Power OpRegion driver to
>     platform/surface
>   platform/surface: Move Surface Pro 3 Button driver to platform/surface
>
>  MAINTAINERS                                   | 11 ++++-
>  drivers/platform/Kconfig                      |  2 +
>  drivers/platform/Makefile                     |  1 +
>  drivers/platform/surface/Kconfig              | 49 +++++++++++++++++++
>  drivers/platform/surface/Makefile             | 10 ++++
>  .../platform/{x86 => surface}/surface3-wmi.c  |  0
>  .../{x86 => surface}/surface3_button.c        |  0
>  .../{x86 => surface}/surface3_power.c         |  0
>  .../{x86 => surface}/surfacepro3_button.c     |  0
>  drivers/platform/x86/Kconfig                  | 31 ------------
>  drivers/platform/x86/Makefile                 |  6 ---
>  11 files changed, 72 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/platform/surface/Kconfig
>  create mode 100644 drivers/platform/surface/Makefile
>  rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)
>  rename drivers/platform/{x86 => surface}/surface3_button.c (100%)
>  rename drivers/platform/{x86 => surface}/surface3_power.c (100%)
>  rename drivers/platform/{x86 => surface}/surfacepro3_button.c (100%)
>
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
