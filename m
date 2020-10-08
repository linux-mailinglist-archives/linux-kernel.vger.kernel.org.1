Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FB287668
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgJHOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:52:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BDFC061755;
        Thu,  8 Oct 2020 07:52:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b26so4207175pff.3;
        Thu, 08 Oct 2020 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYh7aWK4xIgcsuY1+FJJjva+eJ1k1GLi/gSRWTHUeCM=;
        b=lY68qoXZoea7DaLmCvM8oHJ6+uklyANHT2wmYcbOzL0L8+EGHspmX/YlaHdJ6631df
         i1VN3oXOXebUBrmo0k8ZLh3TCQocAYLu5NfYw4vDhe6dGvYEQzqtoq4Oz3Pq5T+PMnhu
         DV7SPaCtHUy8IzY1ZiOF0hroveWvz+Pm2I3/K245K526t4LhoH4Zwd1zqh5MFYEU9D2T
         di5oakXnuASpmX0ZpjqDkjzFWRLqueLMsKm77tFLw05vZJVJHNAMnRrO8YA/d8nlzSCT
         mJn4S5pZ7iWAApb+LaDRWYS3T9kD7aIflBP8mcXl8nV0+fjo7LHe+b9W4J7PHWbRjlLd
         L2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYh7aWK4xIgcsuY1+FJJjva+eJ1k1GLi/gSRWTHUeCM=;
        b=aSjGkU+/avGf2iGzzbvRDuLZKWqlrKAsVhgtVWQXZ14pByvsKbnIYozO+DT7Ky1j8i
         5vB3qRlYjNgTYC2FFBLbxw0AGLHYytRRRrFshGMSlSd1Vsv30yrYLobxDYJz7esK+NrB
         0dxUBHRc+pscMo+hBO9MHeNwHRC3/g/M3puHssuURxoK6cdY/9rnXDvcl7X203NS2/9H
         C/Rn/hRUQ3JDnPBMvJDWly4JR8orXRgKgT+pDvJGvp870Myebf/xH0UiiQJNJc1lSWRf
         jmRp7Ijri/bvUtOH3O3xIIFcmSHrAPQqjWOS8idJFpvFq5rIa4kNqL9QFFsgsmtmqgIo
         95HQ==
X-Gm-Message-State: AOAM531p7WGdCrk47KwclDKwWuFOpowC7pg7DoVeHvwpCVL1G3cs2LTN
        mByuRT3+H0au3wqshJUDlSnZ95DCucVo+HnrdhaluHI0Wo0GhCr/
X-Google-Smtp-Source: ABdhPJzfj6+Va3YRM5LtE93jDVpdMBlQa0rDrqpIpTpApWkQwJTUr9fyLEk9IVCTX1LzCQsThx92GvK0dYgrvpvt+LQ=
X-Received: by 2002:aa7:81d5:0:b029:142:2501:39fa with SMTP id
 c21-20020aa781d50000b0290142250139famr8041946pfn.73.1602168729817; Thu, 08
 Oct 2020 07:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143455.340599-1-luzmaximilian@gmail.com> <20201008143455.340599-2-luzmaximilian@gmail.com>
In-Reply-To: <20201008143455.340599-2-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Oct 2020 17:52:59 +0300
Message-ID: <CAHp75Vd61qnLMUbted_ohqEtMdVFbqKhKf3kKh0ombAwhf8dCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] platform: Add Surface platform directory
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

Thanks for the patch, my minor comments below.

...

> +MICROSOFT SURFACE PLATFORM DRIVERS

(1)

> +M:     Hans de Goede <hdegoede@redhat.com>
> +M:     Mark Gross <mgross@linux.intel.com>
> +M:     Maximilian Luz <luzmaximilian@gmail.com>
> +L:     platform-driver-x86@vger.kernel.org
> +S:     Maintained

> +T:     git git://git.infradead.org/linux-platform-drivers-x86.git

It's now on kernel.org.
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git

> +F:     drivers/platform/surface/

> @@ -9,3 +9,4 @@ obj-$(CONFIG_MIPS)              += mips/
>  obj-$(CONFIG_OLPC_EC)          += olpc/
>  obj-$(CONFIG_GOLDFISH)         += goldfish/
>  obj-$(CONFIG_CHROME_PLATFORMS) += chrome/
> +obj-$(CONFIG_SURFACE_PLATFORM) += surface/

(2)

> +menuconfig SURFACE_PLATFORM

(3a)

> +if SURFACE_PLATFORM

(3b)

> +endif # SURFACE_PLATFORM

(3c)

I think in (1), (2) and (3) it makes sense to mimic Chrome, i.e. use
plural: PLATFORMS.

-- 
With Best Regards,
Andy Shevchenko
