Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455F628766E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgJHOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgJHOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:53:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CFDC061755;
        Thu,  8 Oct 2020 07:53:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g10so4200113pfc.8;
        Thu, 08 Oct 2020 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ha0d5CLuHhVVoYjJQruOkutfT7+02DFIs5Gu0a061nE=;
        b=ucE2HXFTBzt2xCH+lw/zkhvBygbUz6gMTAx/aZ1kStXt8D4D9oXH+LNPa3EvEwQdgl
         je6OhGCPH5du0dpl32RB4U9XxYn3iLOjpdM4KnTa1ELXGJlSEkFuvvB8/08nSh+MnrN9
         dcxuu3FEfscqo1I7qKL+SR2EcQ6wVvOf72HvxATlbxzQZ2q5zMS5zUfJIXks/vrhzvgC
         iM3M10tZQcK+EWpSE/DqfO+VI138W6PYhs8FFQ2kM0w80HGqQMXTz74PBEE48s/uSgE/
         QmDR0FZO8Lgj5KBaCtX0NnWprmy3Exs6ezLNxZ0zDDd6+TP8Q/pEMYt1LgBLdXrSShqV
         8o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ha0d5CLuHhVVoYjJQruOkutfT7+02DFIs5Gu0a061nE=;
        b=o5R92ffQa9MpZrVmsaPrOGaWmJJ/6Inp8p7MimLzPwseywUbEDX9EoRjIOn97DNnt3
         mFF1kbDEsJfaaz3bsz8HOAS4EihAT/KPsupItchF0v8/tzZ5KsADqaTMF16P2e0QEaRw
         itYjEkyP1A+GZjODJYrqo0wJ9Xm6XcfcjcbQ2wJeGFmaWuXTuT4qYP86eiK2etIm71qt
         4jNsb65Si4EdJ4DeijQQQgsR2ZFgymp60hhblip2/yc80oA+eIXSZpQQly6FhIs67//C
         PudsQnZTatF2UcX0usRFWMKxqH+8kfsxTA3Z5l4GNh0YOMkf1a7f3L11Nvl4i0+fyptQ
         AsQw==
X-Gm-Message-State: AOAM53294bTtMLRUkHoo4jI3RchU3fMMBCHor+3MoVQmFJ3t2Gt2l20b
        Py/6W3rnt+5YCODoEnZDUaHAD7KdrIdP03/SoOo=
X-Google-Smtp-Source: ABdhPJzH0YUIt357lYfLm+tps99aiJ+RrH5f2bg8DC16qMOhR4eBjpysHxmP4fb31EFv9NUmVS9L+7Wm+8/v6XDmJcQ=
X-Received: by 2002:a17:90a:fb92:: with SMTP id cp18mr9009139pjb.228.1602168804458;
 Thu, 08 Oct 2020 07:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201008143455.340599-1-luzmaximilian@gmail.com> <20201008143455.340599-3-luzmaximilian@gmail.com>
In-Reply-To: <20201008143455.340599-3-luzmaximilian@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Oct 2020 17:54:14 +0300
Message-ID: <CAHp75VfPaGqb=yCpi_2f8SNzrj+0pd-r5VqAEgRgMCiJJB6D0w@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] platform/surface: Move Surface 3 WMI driver to platform/surface
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
> Move the Surface 3 WMI driver from platform/x86 to the newly created
> platform/surface directory.

> -# place Microsoft Surface platform drivers here

> -# place Microsoft Surface platform drivers here

Not sure if we need these comments in the first place.

-- 
With Best Regards,
Andy Shevchenko
