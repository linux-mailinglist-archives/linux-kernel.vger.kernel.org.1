Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683FB2725B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgIUNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgIUNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:37:09 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE7C061755;
        Mon, 21 Sep 2020 06:37:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so255552ilt.13;
        Mon, 21 Sep 2020 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylyiVkvR8OuH1206l+Q6sBqGX7CwiOknrjYvkcbWau8=;
        b=rwdfHu+5p8aQ5tEWJINr4zesW7VuXtdI27MeocOZAN53oHo+syQAprO1siIDDLe/Ot
         H6V7uOuLqTUBuwW6fMajtIWnKiczllFdIfVahO0Kh+Wkw/a6wrjq4cjchNxUpfEqmx4r
         RP2O2zFVXOCMrVgidJIXobvCtuyk9l6JbV4Qtak7NXkWs/8cusGQvKeCLXPibminO80w
         GrtseWweWwTuGtpx4GCOg3HusGx+waZZym4rUkSuRt6xYpJM8KAXtNXnJFGqcNR3Oevd
         SD3y7ytiTP8Dl5SGb9txdy9Fo53WzSgo5u5I/XmUErLMxVW8OWfd0OFyHW6WgeD1WqPV
         ijuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylyiVkvR8OuH1206l+Q6sBqGX7CwiOknrjYvkcbWau8=;
        b=LIdRLGcCXsQWY2S/jkbkbOosAxlBy8zKdb44vXoAxjYxZdTdnidkNPoCLrRralPPkZ
         NuyzOYbqyT5RQ+K5OENHSIv7U/zCbUB71sibOKrSuWPasMpNkvAU+zVHfzzU72jmodz3
         QJ8+eaaYflZ/s7ztwWnf9oNpNdHJV66D/KtFftWwZZCx5UVkwd9xanz8VFrnHVxiW3NP
         rMPcwHrhjbMODvQqSYu6lMDbsxAhGXecO1D+5XYYeyQ2BoyKxc7emXEPNx+13W034CEE
         t64yA4RAB3GapftyCIRa11wRuR5eDcXg8dCDUscfw1Tfr483Owr9DxpXd0qqg9cNuGw3
         iB7g==
X-Gm-Message-State: AOAM530a8S3oFVUL9cAC0D3KWPV3x3JLTnl2WqkWvKu2rF3MlUgqsU7N
        IgV5r8jluevSypE4+NIeGMcM6ACwHvdgNcCUOBAT5SzMAZw=
X-Google-Smtp-Source: ABdhPJw3v6iRMbUog/lTAGLjtxv2SIUb3saKZADmwv4BlgeOEYuo7nf5M0yud3TqLC4CPDNGcyjQsauphmnTI7qIaxE=
X-Received: by 2002:a92:1591:: with SMTP id 17mr6117312ilv.237.1600695428521;
 Mon, 21 Sep 2020 06:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com> <0ec64bdc-66fd-4be1-03cf-561a7c42de68@linux.intel.com>
In-Reply-To: <0ec64bdc-66fd-4be1-03cf-561a7c42de68@linux.intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 21 Sep 2020 06:36:57 -0700
Message-ID: <CAKgT0UdiXLhok1WOq9RoZKKi+f43xUoSBwX2LTYMpUUTU3HRwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, dvhart@infradead.org,
        andy@infradead.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 1:01 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
> Hi,
>
> Thanks for the patches.
>
> On 11.09.2020 22:45, David E. Box wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Add support for the Intel Platform Monitoring Technology crashlog
> > interface.  This interface provides a few sysfs values to allow for
> > controlling the crashlog telemetry interface as well as a character driver
> > to allow for mapping the crashlog memory region so that it can be accessed
> > after a crashlog has been recorded.
> >
> > This driver is meant to only support the server version of the crashlog
> > which is identified as crash_type 1 with a version of zero. Currently no
> > other types are supported.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
> >  drivers/platform/x86/Kconfig                  |  10 +
> >  drivers/platform/x86/Makefile                 |   1 +
> >  drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
> >  4 files changed, 665 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
> >  create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
>
> <SNIP>
>
> > +
> > +/*
> > + * devfs
> > + */
> > +static int pmt_crashlog_open(struct inode *inode, struct file *filp)
> > +{
> > +     struct crashlog_entry *entry;
> > +     struct pci_driver *pci_drv;
> > +     struct pmt_crashlog_priv *priv;
> > +
> > +     if (!capable(CAP_SYS_ADMIN))
> > +             return -EPERM;
>
> Will not this above still block access to /dev/crashlogX for admin_group users
> in case root configured access e.g. similar to this:
>
> ls -alh /dev/
> crw-rw----.  1 root admin_group      1,   9 Sep 15 18:28 crashlogX
>
> If yes then that capable() check is probably superfluous and
> should be avoided in order not to block access to PMT data.
>
> Could you please clarify or comment?
>
> Thanks,
> Alexei

Actually this should probably be updated to "if (!perfmon_capable())"
instead. The telemetry driver code originally had the CAP_SYS_ADMIN
check and it probably makes more sense to limit this user-wise to the
same users who have access to performon.

Thanks.

- Alex
