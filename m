Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428092730E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgIUReE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:34:04 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E984C061755;
        Mon, 21 Sep 2020 10:34:04 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y13so16310684iow.4;
        Mon, 21 Sep 2020 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZxTQM+y7VCL30HjHBeKSPnidXAdXQgBZuNpKs1pbS8=;
        b=eT2I07jM9PMeyjSl/Te6a5BL5oucfVWd7/hkhTLvZwRxrGvJD8bC1xmLDS76suwdSc
         Y42cscC4DD+H8ZBIf+MP7A2iKQ2rZJAdSSVs25Exz+bTJ0I9punJG3/QpuCyr7hYZrbg
         go5eyVVhZjAA2BVKgKx9WZGAlmxoKfK4ozXBRdCvYJyNVVbgq5pQxuYNiI8B1scmaqsz
         R8w8H29Mwt91cgQH6HMMzmPITXATbXbZeayLh7zE6rMyF2Tty/9rhtsKPq6/BXzQa9sh
         SpahehdegJ1qal2j5+g2hvcHo46ua/hVn8+dDHDeNkMCMweR94ZQV0rU3oaKbGpZ017M
         5gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZxTQM+y7VCL30HjHBeKSPnidXAdXQgBZuNpKs1pbS8=;
        b=BqCV3qTkSjkeEmO1+97TIBUDSfQajx51RiWw2gCdZdxi7cZQvBC51J37cPYf80WN7W
         oOIjbYLU9fBpbRawsPznwKemR1CcSR7X8869bndEyjHXJJSH5l3wZIG6ncNmu0WvfetQ
         ev8M8kqP0chVSrcHIgieQVmDgdxCc3h+9Bl0ih+gBhl16aR7+e5QKfP8EjQU8+LsxohZ
         OGyKm2/DoTQoQCOFOib8tzvvEJIIu6gawNViGz3rz25+HW8XTCqD+WFRl5cFKlD0oncQ
         i8T/UraJaUsdZCqPVD7OjTkKRI9gQOvrANDz+HLzuz+35fZmXMfGPRNkWCWhpI6D/JpM
         IB6Q==
X-Gm-Message-State: AOAM5303S/Nub8GgFMCQnEK4OMxNM0rp1SnbZkJGLKh8SlpN/Iru9YRX
        l84g15xTyIvcmvZcKJKeFRQWfaLqJTpvqf91D74=
X-Google-Smtp-Source: ABdhPJxAszQNtzT+y9jstowJPghZLDKpOPnpGa/9DYxZJluq3OIJp+7ThjmX/nVs++E7gVuyTPHwSPyKBWg0nRzs0Bc=
X-Received: by 2002:a6b:7a41:: with SMTP id k1mr364011iop.187.1600709643569;
 Mon, 21 Sep 2020 10:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com> <0ec64bdc-66fd-4be1-03cf-561a7c42de68@linux.intel.com>
 <CAKgT0UdiXLhok1WOq9RoZKKi+f43xUoSBwX2LTYMpUUTU3HRwA@mail.gmail.com> <69a7e595-1b5c-bfb3-f3e6-16cf5fcc9999@linux.intel.com>
In-Reply-To: <69a7e595-1b5c-bfb3-f3e6-16cf5fcc9999@linux.intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 21 Sep 2020 10:33:52 -0700
Message-ID: <CAKgT0UfkV-Sofk9BO_KqnB83VEMcAqN_9p3BeQQp5Ew4oOCwRw@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, dvhart@infradead.org,
        Andy Shevchenko <andy@infradead.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 9:07 AM Alexey Budankov
<alexey.budankov@linux.intel.com> wrote:
>
>
> On 21.09.2020 16:36, Alexander Duyck wrote:
> > On Sat, Sep 19, 2020 at 1:01 AM Alexey Budankov
> > <alexey.budankov@linux.intel.com> wrote:
> >>
> >> Hi,
> >>
> >> Thanks for the patches.
> >>
> >> On 11.09.2020 22:45, David E. Box wrote:
> >>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>
> >>> Add support for the Intel Platform Monitoring Technology crashlog
> >>> interface.  This interface provides a few sysfs values to allow for
> >>> controlling the crashlog telemetry interface as well as a character driver
> >>> to allow for mapping the crashlog memory region so that it can be accessed
> >>> after a crashlog has been recorded.
> >>>
> >>> This driver is meant to only support the server version of the crashlog
> >>> which is identified as crash_type 1 with a version of zero. Currently no
> >>> other types are supported.
> >>>
> >>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> >>> ---
> >>>  .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
> >>>  drivers/platform/x86/Kconfig                  |  10 +
> >>>  drivers/platform/x86/Makefile                 |   1 +
> >>>  drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
> >>>  4 files changed, 665 insertions(+)
> >>>  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
> >>>  create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
> >>
> >> <SNIP>
> >>
> >>> +
> >>> +/*
> >>> + * devfs
> >>> + */
> >>> +static int pmt_crashlog_open(struct inode *inode, struct file *filp)
> >>> +{
> >>> +     struct crashlog_entry *entry;
> >>> +     struct pci_driver *pci_drv;
> >>> +     struct pmt_crashlog_priv *priv;
> >>> +
> >>> +     if (!capable(CAP_SYS_ADMIN))
> >>> +             return -EPERM;
> >>
> >> Will not this above still block access to /dev/crashlogX for admin_group users
> >> in case root configured access e.g. similar to this:
> >>
> >> ls -alh /dev/
> >> crw-rw----.  1 root admin_group      1,   9 Sep 15 18:28 crashlogX
> >>
> >> If yes then that capable() check is probably superfluous and
> >> should be avoided in order not to block access to PMT data.
> >>
> >> Could you please clarify or comment?
> >>
> >> Thanks,
> >> Alexei
> >
> > Actually this should probably be updated to "if (!perfmon_capable())"
> > instead. The telemetry driver code originally had the CAP_SYS_ADMIN
> > check and it probably makes more sense to limit this user-wise to the
> > same users who have access to performon.
>
> Indeed, it is currently perfmon_capable() for performance part but it is unclear
> if it should be the same for crashlog since it's more like a debugging thing.
> It appears it all depends on usage models implemented in a user space tools e.g. Perf.
>
> However there is an important use case that is not covered
> neither by perfmon_capable() nor by capable(CAP_SYS_ADMIN).
>
> It is access and usage of PMT features in cluster or cloud environments by
> unprivileged users that don't have root credentials. The users however can run
> software tools (Perf, VTune etc.) once installed and configured by root.
>
> Even though Perf tool can be configured to use use CAP_PERFMON [1] the tool binary
> should still reside on a file system supporting xattr to convey capabilities
> into processes implementing monitoring.
>
> Unfortunately NFSv3 which is quite popular to be used for storing and sharing
> software tooling in large production systems doesn't support capabilities yet.
>
> Thus, capabilities approach still has limitation in HPC clusters and cloud environments
> and for PMT support this limitation has a chance to be lifted if
> suitable access control mechanism would be designed from the very beggining.
>
> Actually I tried to change group ownership of /dev and /sys directories and files, being root,
> and it appeared that for dev file it is possible:
> ls -alh /dev/
> crw-rw----.  1 root admin_group      1,   9 Sep 15 18:28 telem<X>
>
> So if e.g. perf tool having CAP_PERFMON and configured like:
>
> -rwxr-x---.  1 root admin_group  24M Mar  5  2020 perf.cap
>
> would mmap /dev/telem<X> to provide uncore performance insights
> to admin_group users only access control based on user/group/others ownership
> would suffice without capabilities requirement.
>
> Still haven't had chance to verify it for memory mapped PMT dev files and
> that is why I am asking you guys here.
>
> Alexei
>
> [1] https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html#privileged-perf-users-groups

We will have to see. There is a high likelihood this code will go away
if we switch over to binary sysfs attributes for the data. I'm still
working on the rewrite and hope to have something we can review as an
RFC in the next few days.

Thanks.

- Alex
