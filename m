Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB862FF26F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbhAURv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388179AbhAURu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:50:56 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:50:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id 6so3868516ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqDGr5OXXLDXoZ+kvErdRqn2LWaoGkSZKNVGtOHo0BI=;
        b=eVFeNLK0LrN/WxB0D4SEhXIkmQeMvag+qoGefW6ONj0khNhIHCAYmWw9sI6fc2p/Tf
         iNvWC56d2SekCqH8W6lVW6vuLj7fDrh9atefJI9fHFKN2HbcrU+BybCJPwFsyDFpRFNK
         aCVFjPZzn5Am8jeJnz5DbslQlxvVq2s9ENXpN8U2sPN5shejLfm8wz/+ocREFbtvzFy1
         c+nYHU62Xh+DGpT9kdA3H7YH5d1SS4wIR6W3QDVZ9tK9wT6uvi7iMi4JW1x2KQTscaAC
         6hIH7fPbeJwm/QeZw+nqKA6JnkG1MevMAYjn83JoB8kq1Y5klO9TM5ajhVa7bqHtLcO1
         yNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqDGr5OXXLDXoZ+kvErdRqn2LWaoGkSZKNVGtOHo0BI=;
        b=JxWY5yqNcM/HEQ4jwdTyUiFCz5OB8kHMm0m9U8Ge9otbwm/1zlw6+yPX7rZpYXE/EH
         IsOkie4TahmIghKMdf/Bd2pEC+4rPgmkTdWcOtt0yp3HnuwcbnkD0AasUkcMoy8H5jE2
         uqd5M7wR1vBm4zP5Wlr7Ga6KRRv0H7xlX29+FGtOQqtGSCnEBUzwm3RnSEKYXk4zGCeu
         Wbg6lt+ZMpEXLawFtVYGgGaMroFInwvWHQJzdHfKLDOL4CSrw9Ebq3/+wYlkaTlfHwgy
         vl9t1L3VvpYaOy0lBu86Pc+xTYTlFUBpMTqCcfTcKXA2ThbHSI+A5WMknRA9y66tSX1Z
         MZWA==
X-Gm-Message-State: AOAM531CRbGU7M0Y5frHpQO29NBEhEIi+j53hg7HH2gl4uX9ltWDlCJp
        Q6B3A0kKnvykAbPdh/UBToU7tyV/18lJ1ZSCrWwGww==
X-Google-Smtp-Source: ABdhPJxojGLRdzZFKIOXzAri6ROiq62XZBU5dIKiIeyLRrawBjmoEiHQe3KMqw+7otHRhV8gUwsjuOh2i5mxmcctbnU=
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr413181ejb.341.1611251415063;
 Thu, 21 Jan 2021 09:50:15 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YAk3lVeFqnv5vzA2@kroah.com>
In-Reply-To: <YAk3lVeFqnv5vzA2@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Jan 2021 09:50:09 -0800
Message-ID: <CAPcyv4hEpdh_aGcs_73w5KmYWdvR29KB2M2-NNXsaXwxf35Hwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:13 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 20, 2021 at 11:38:57AM -0800, Dan Williams wrote:
> > -void cdev_del(struct cdev *p)
> > +void cdev_del(struct cdev *cdev)
> >  {
> > -     cdev_unmap(p->dev, p->count);
> > -     kobject_put(&p->kobj);
> > +     cdev_unmap(cdev->dev, cdev->count);
> > +     kobject_put(&cdev->kobj);
>
> After Christoph's patch series, the kobject in struct cdev does nothing,
> so I will be removing it.  So I don't think this patch set is going to
> do what you want :(

The proposal in this series has nothing to do with kobject lifetime.
Please take another look at the file_operations shutdown coordination
problem and the fact that it's not just cdev that has a use case to
manage file_operations this way. I believe Christoph's only objection,
correct me if I'm wrong, is that this proposal invents a new third way
to do this relative to procfs and debugfs. Perhaps there's a way to
generalize this for all three, and I'm going to put some thought
there, but at this point I think I'm failing to describe the problem
clearly.
