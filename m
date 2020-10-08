Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1A2870ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgJHIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgJHIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:46:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D2C061755;
        Thu,  8 Oct 2020 01:46:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 144so3423029pfb.4;
        Thu, 08 Oct 2020 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q60gp173H9SgykxsKwtd874GVKOU5yfh2AOhYZ8R2WM=;
        b=VmsXUAcZXJcP3MNOP/D/aRlcoNgyYQPm5mYtmhZTYE4JUUMTViAY8HAUOfmr8wKO7t
         KLuAr1ser35b77gZxJYIub0/xyLvifYxsKLpOhHT6iij97si3VjPbep8450SAATK9n6W
         9o2RVx3vmW98qu+ZAzc75K0L2inSSGfzbE3XDY/i1dj1gxvqxcM+q3+VFtEXDjLJ+egG
         T1jTIiYXLK7CSuulVwWahJlfwwRWLveuERsFFjijbkUrFDKU5QpVAPKjxVb8vGy+R39x
         X5/7reqAUzqEwvKOXb0YprTP0ywk0TTUotI+9NUUd7WZSHVEIUIi4edlFIheAEgsIGJz
         UuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q60gp173H9SgykxsKwtd874GVKOU5yfh2AOhYZ8R2WM=;
        b=MATuCVwp2vHYC+vyhpY8RCMpsxsIDpkRS8B5Tt9wKNa6rrVOsx3NeSIcPCn5QY6duZ
         4jjWiIkWnuPv8iP9kS5+xdg4CvvZLsqGeFmEo9LGTeuPrfp9EXvJDn1LrXY8wLnHYt32
         xg3Z4PuOtRaO7gzgKDwRxwumkdpAMpbYGNcwoNP3RH/bUpDAStmBOst8bZ8lVlsC73fY
         0ndtLKf2hDUgDFoA52KQ4U2yCKnqy7HML39Ooo5GWE5ojJTtD5yafcKTgJp24ydeReX/
         fUbiqi6z84agUFn1HWTifQ16GAGGEsDSmWCNoxIucPvRmoB9zRVPJT9kaECQnhXNarWC
         jGPA==
X-Gm-Message-State: AOAM532nYHgeoJkK8PPJgi4BVwQ/iMldxkGxrW8brW4kHhr+E6MDxXY2
        aKQfSNyQXB3uMNyBagaf6j/JFtXR8PUJ/uQp3mI=
X-Google-Smtp-Source: ABdhPJw8WOYfg5Hq23GWbx43JXgzi7hRIMhlgbLHTFUFFC3BwK8mu0Ct1IkIr4ReS2yNUr+2pq7If8e4snW5v4Ak+XM=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr6382483pgj.74.1602146793707;
 Thu, 08 Oct 2020 01:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com> <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Oct 2020 11:46:17 +0300
Message-ID: <CAHp75VeBTKc9HnqVV-RAoQVa=1dfTH68Mido=18JFaRxVtUZ2A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted
 Firmware Service call
To:     muhammad.husaini.zulkifli@intel.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lakshmi.bai.raja.subramanian@intel.com,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 5:48 AM <muhammad.husaini.zulkifli@intel.com> wrote:
>
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Add header file to handle API function for device driver to communicate
> with Arm Trusted Firmware.

Arm -> ARM ?

...

>  .../linux/firmware/intel/keembay_firmware.h   | 47 +++++++++++++++++++

Please, drop dup of 'firmware' in the filename.

...

> +/*
> + *  Intel Keembay SOC Firmware API Layer
> + *

> + *  Copyright (C) 2020-2021, Intel Corporation

Hello from the future?

> + *
> + *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>

Author: ...

> + */

...

> +/*
> + * This file defines API function that can be called by device driver in order to

an API
by a device

> + * communicate with Arm Trusted Firmware.

Arm -> ARM ?

> + */

-- 
With Best Regards,
Andy Shevchenko
