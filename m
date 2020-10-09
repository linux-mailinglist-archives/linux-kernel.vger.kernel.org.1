Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A8288AC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbgJIOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388208AbgJIOYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:24:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE077C0613D2;
        Fri,  9 Oct 2020 07:24:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so7027414pfk.2;
        Fri, 09 Oct 2020 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+2Clz/NAhLwQuKk3P4SbeWMBJAyhKSLhdK8Heojwbw=;
        b=jii3OnLA+7tN1244Lz9UoYYMK+tbAX5iKGnCgBaw5Ddw0lpqi0cQxdyYe/0XumeNYq
         N6aW8KssqYU7wCHvcGr264pDV4fY9oScqtlHB/VIgY9OSEzFdzry8KruQ3bKlsaN+pDH
         ELlKllHKlS9a0DTYL+GRTTMtPfjTlF41452r1qqH8LZ8nu05GKbaM0ND4BsPilmHH2qE
         fUOiXgjBZCFQwl7vMwq6zYU1ZPvPpO7asA/59Is28eGfWOtHPJYg6y2JOL91sGdpyHSP
         4p6vupHTPGcWRIvoERRoLWPb33YEHRPTQBJeThRSoA9bZW8X0DCGZbciyrxzLcSeVD0E
         7Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+2Clz/NAhLwQuKk3P4SbeWMBJAyhKSLhdK8Heojwbw=;
        b=U5nCeJZt/Q1uQ9cUipKQcd8eEYuvKhySJ8c5Aim2r8gUOT/CB4trv84lb3aYkq4jrU
         8iNvvu3+hlYUmLm+icjjue36rq4QiZLvZIiXmnIy25PygFODhTJH1mEN9MF/pLsDQMfB
         dwDtZD6evSIVpjUOyVvNgTc9Or75ACwDbkhUnLkXMVKanHPIdLXYst/U/m7oKaBeYhKy
         38p47PHDGdBinWz1t0Q3Sf0FvOUKc3zS0NksiU5h1RlXFUu8c3cU0ORYDVbPIzpkXw//
         35pKEx4gAWeDyuJXYXn0gcED7Fkb/en1aFaA/Rm4igDLpQHI96y27On2ufPPNDVcDy2H
         pKfw==
X-Gm-Message-State: AOAM530GytnWV9BGS5j5mJVV6TxhBRvqacwHeMUAnyvrgOFacpLKxJuH
        RfsGboXR2DDitEwju3vnKYAUCmrRqTCXPd8HrEw=
X-Google-Smtp-Source: ABdhPJwRb+wuaMB05BbRElITfrf6g1EqZsm9diOdR4xAiRCK6THfEfH9L9DDIA/XJUWjcYdrkRTMKNmiYLUOBE+Gaoc=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr5064012pjb.228.1602253461470;
 Fri, 09 Oct 2020 07:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201009141128.683254-1-luzmaximilian@gmail.com> <20201009141128.683254-2-luzmaximilian@gmail.com>
In-Reply-To: <20201009141128.683254-2-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Oct 2020 17:25:11 +0300
Message-ID: <CAHp75VeJ6ep4ibzHG5RX9_Q_vtJ0_gAMscK1UQG2KUbgOYr7xA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] platform: Add Surface platform directory
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

On Fri, Oct 9, 2020 at 5:11 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> It may make sense to split the Microsoft Surface hardware platform
> drivers out to a separate subdirectory, since some of it may be shared
> between ARM and x86 in the future (regarding devices like the Surface
> Pro X).
>
> Further, newer Surface devices will require additional platform drivers
> for fundamental support (mostly regarding their embedded controller),
> which may also warrant this split from a size perspective.
>
> This commit introduces a new platform/surface subdirectory for the
> Surface device family, with subsequent commits moving existing Surface
> drivers over from platform/x86.
>
> A new MAINTAINERS entry is added for this directory. Patches to files in
> this directory will be taken up by the platform-drivers-x86 team (i.e.
> Hans de Goede and Mark Gross) after they have been reviewed by
> Maximilian Luz.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
>
> Changes in v2:
>  - Do not create a separate MAINTAINERS entry for platform/surface.
>    Instead add drivers/platform/surface to x86 platform drivers entry.
>    This incorporates recent changes in the x86 platform driver
>    MAINTAINERS entry.
>  - Fix typo in commit message.
>
> Changes in v3:
>  - Add separate MAINTAINERS entry for platform/surface
>  - Add Maximilian Luz as reviewer for platform/surface
>
> Changes in v4:
>  - Rename MAINTAINERS entry to be similar to platform/chrome.
>  - Rename Kconfig options to be similar to platform/chrome
>    (PLATFORM -> PLATFORMS)
>  - Drop placeholder comments.
>
> ---
>  MAINTAINERS                       |  9 +++++++++
>  drivers/platform/Kconfig          |  2 ++
>  drivers/platform/Makefile         |  1 +
>  drivers/platform/surface/Kconfig  | 14 ++++++++++++++
>  drivers/platform/surface/Makefile |  5 +++++
>  5 files changed, 31 insertions(+)
>  create mode 100644 drivers/platform/surface/Kconfig
>  create mode 100644 drivers/platform/surface/Makefile
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a2170ff3a91..9fea3ce2db2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11532,6 +11532,15 @@ F:     drivers/scsi/smartpqi/smartpqi*.[ch]
>  F:     include/linux/cciss*.h
>  F:     include/uapi/linux/cciss*.h
>
> +MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
> +M:     Hans de Goede <hdegoede@redhat.com>
> +M:     Mark Gross <mgross@linux.intel.com>
> +M:     Maximilian Luz <luzmaximilian@gmail.com>
> +L:     platform-driver-x86@vger.kernel.org
> +S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> +F:     drivers/platform/surface/
> +
>  MICROSOFT SURFACE PRO 3 BUTTON DRIVER
>  M:     Chen Yu <yu.c.chen@intel.com>
>  L:     platform-driver-x86@vger.kernel.org
> diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
> index 971426bb4302..18fc6a08569e 100644
> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -13,3 +13,5 @@ source "drivers/platform/chrome/Kconfig"
>  source "drivers/platform/mellanox/Kconfig"
>
>  source "drivers/platform/olpc/Kconfig"
> +
> +source "drivers/platform/surface/Kconfig"
> diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
> index 6fda58c021ca..4de08ef4ec9d 100644
> --- a/drivers/platform/Makefile
> +++ b/drivers/platform/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_MIPS)              += mips/
>  obj-$(CONFIG_OLPC_EC)          += olpc/
>  obj-$(CONFIG_GOLDFISH)         += goldfish/
>  obj-$(CONFIG_CHROME_PLATFORMS) += chrome/
> +obj-$(CONFIG_SURFACE_PLATFORMS)        += surface/
> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
> new file mode 100644
> index 000000000000..b67926ece95f
> --- /dev/null
> +++ b/drivers/platform/surface/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Microsoft Surface Platform-Specific Drivers
> +#
> +
> +menuconfig SURFACE_PLATFORMS
> +       bool "Microsoft Surface Platform-Specific Device Drivers"
> +       default y
> +       help
> +         Say Y here to get to see options for platform-specific device drivers
> +         for Microsoft Surface devices. This option alone does not add any
> +         kernel code.
> +
> +         If you say N, all options in this submenu will be skipped and disabled.
> diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
> new file mode 100644
> index 000000000000..3700f9e84299
> --- /dev/null
> +++ b/drivers/platform/surface/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for linux/drivers/platform/surface
> +# Microsoft Surface Platform-Specific Drivers
> +#
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
