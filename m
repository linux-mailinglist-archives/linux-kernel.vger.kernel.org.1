Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BA220961
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgGOKCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 06:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGOKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:02:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D723FC061755;
        Wed, 15 Jul 2020 03:02:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so1879985pfc.6;
        Wed, 15 Jul 2020 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Nh0VZckjN06FZSJxhs7hmcKYv3xu0k2u9oXV74eQ34=;
        b=ltRYeljvTrcnJGbqBCgJ+/jtYXLWfHOLrsIZSzj//W7aCHwNjoApoh2uU5OQ2dNHui
         RNUkthyWxxTXv0DtI781+jh1HjdSSNX1TgqUeLTFR/hVDP/roSGk1k3ToyVAxGidAQkP
         bcO02pZFCAzGsdJiU8xaABONAs/WMoNZdYlHGrleydD6qzJtZgfCvegb3Dg3KbuWLABy
         8F+BhHzq70bGG/pOvYWzHKvwlSXlHg6HlvKzDcEZBUBYmGEQmxR/YkLNaYTVBcqur/WR
         wGEN4Tu+tpAYU6ypL0caFPX9MHBWud3VflYPhRJHjTeYP4PMVx1SYHdD5WBpa8CO74V6
         5GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Nh0VZckjN06FZSJxhs7hmcKYv3xu0k2u9oXV74eQ34=;
        b=QESjFuTek9cI0aBfE7cYrMJhJZzsK6fBqQheWnS83B/xr+1/RPZmFDe2PwRT+4ypwr
         CZC4K3jouQor7/F3mt2gW2uwxfuidN0i3jrjNOuW/aumhZVWsH4zst4z7SN/9zO5E+pa
         PxnA7McnQQesJfg8mS7102niHYyGdSKPlZtLJEXuHCOlizVtim2QfzZhx/aXllqdC9Wd
         WYW79p48dHIiBg9OoIH1isRZhQ1n1jkzSc9Ns6eqzgu3bfhpc4h68Mt4YAWBfiEK5FMG
         Fkw3+YlBwyYnIC/PvzJHPP8BqEOS8Vb3hmSlDjFR6IDjTPhzgK4FPb4owGRXISUqu6wQ
         7/Ww==
X-Gm-Message-State: AOAM533d5iRkMCtZq/clGVzrR5Z+jfu2Tx6xTa0RuoUVpcuUpRDnEvoH
        0nWY5sffxj75nBsnbtT2VG3PFo5Qb+VSDFUzbWGZ4aYc
X-Google-Smtp-Source: ABdhPJyNgLiom+tibJ3Wafec8DTUX+KqiDdF09Ir2aUsQBzW9RHJppt+lkvjbJe1B/w8CgUwG+XoZxbOQucyaquElDM=
X-Received: by 2002:a62:8ccb:: with SMTP id m194mr5567303pfd.36.1594807334390;
 Wed, 15 Jul 2020 03:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200714120203.10352-1-vadimp@mellanox.com>
In-Reply-To: <20200714120203.10352-1-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jul 2020 13:01:57 +0300
Message-ID: <CAHp75VdthROggsKZ2e1-9P+_quL8GjMYqQMujf88anXteqxKQQ@mail.gmail.com>
Subject: Re: [PATCH platform-next v2 00/11] platform/x86: Add new features for
 Mellanox systems
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 3:02 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> The patchset adds new features for the existing Mellanox systems.
>
> Patch #1 add string helpers for upper/lower conversion.
> Patch #2 add tests for these helpers.
> Patch #3 updates license for module 'mlxreg-hotplug'.
> Patch #4 allows to configure number of hotplug 'sysfs' attributes for
>                  the particular system class according to the hardware data for
>                  the specific system from this class, instead of configuring it
>                  up-to maximum number in the class.
> Patch #5 adds environmental data to hotplug 'uevent'.
> Patches #6-#7 add more definitions for system attributes.
> Patch #8 extends 'mlxreg-io' driver with complex attributes support.
> Patch #9 extends documentation with new attributes.
> Patches #10-#11 extend FAN platform data with register presence field.
>

Pushed to my review and testing queue, thanks!

> Vadim Pasternak (11):
>   lib/string_helpers: Introduce string_upper() and string_lower()
>     helpers
>   lib/test-string_helpers.c: Add string_upper() and string_lower() tests
>   platform/mellanox: mlxreg-hotplug: Modify module license
>   platform/mellanox: mlxreg-hotplug: Use capability register for
>     attribute creation
>   platform/mellanox: mlxreg-hotplug: Add environmental data to uevent
>   platform_data/mlxreg: Add support for complex attributes
>   platform/x86: mlx-platform: Add more definitions for system attributes
>   platform/mellanox: mlxreg-io: Add support for complex attributes
>   Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
>   platform_data/mlxreg: Add presence register field for FAN devices
>   platform/x86: mlx-platform: Extend FAN platform data description
>
>  Documentation/ABI/stable/sysfs-driver-mlxreg-io |  17 +++
>  drivers/platform/mellanox/mlxreg-hotplug.c      | 114 ++++++++++---------
>  drivers/platform/mellanox/mlxreg-io.c           |  45 ++++++--
>  drivers/platform/x86/mlx-platform.c             | 141 ++++++++++++++++++++++++
>  include/linux/platform_data/mlxreg.h            |   4 +
>  include/linux/string_helpers.h                  |  15 +++
>  lib/test-string_helpers.c                       |  67 +++++++++++
>  7 files changed, 341 insertions(+), 62 deletions(-)
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
