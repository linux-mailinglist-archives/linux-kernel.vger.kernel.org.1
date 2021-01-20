Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC52FDAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbhATUWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbhATUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:21:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D4C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:21:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hs11so33009920ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCzet5L0nxCVD8lCgMuy9Zk/SXca20QY9TXFaVfK/m0=;
        b=z7ZgwC01LO6kgIolKQifAjUHfIK8S7ZunUxX5mw3TJaRwa5fSmFkN2Zb9ul9Yimez7
         FVl4u9G/CbX7Z6bQlVHfAeFphktTJLhYp+YoI2ONOEyuj/ivvmuPreQDsWzCKEBdpZW9
         3ioqFQZ3flqzB5RhaG7bfK6LLkY02hXNnYD0twiunfHczGXixZZiZorsav09qFpw7SwY
         a1mtJcWxN5sw8Krdc5ddQa5mVad+IKmUIil9HpJZZLOr29jhxFsP9HVPnOu6ZfN6e3tu
         as6Hw9D2MQkS1hidKgv03sNmslKNsHl823y6tACzbe416AwXjBVwEHF5jww90sT1RRFi
         SrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCzet5L0nxCVD8lCgMuy9Zk/SXca20QY9TXFaVfK/m0=;
        b=OP3mn3k3Rf1ah+/ntvG7slWMqYiRPsA+Dxe/3zwkw1aK8G3M1hrv30a3ftm431Ydna
         4uURvYyLk2OHWXPlBKELPRA9dtfkv7R7IZtC/CYTTMkS17iOlOI5vN7ms97COcqe8sp0
         z0GerQGE6FCpRcEa6yLd6NdUELkisq5S25WhjnB6am8ei0Zhy/19edoDA10oOt1d5OF6
         /LeFzgHLo8X0tVlSrd4y2NYI2e1ZRYMuvysawyjn5gsHBYjB9HxFKY8KcLZtruPulF4V
         yb14PbxwI1jwydLJbKdJm9PoOJ26GI3tUgpGnd7+PE1opdIL1tkxds92pPq9H/WOCKju
         jgSg==
X-Gm-Message-State: AOAM533xHVT1sGaWWXT5C09QirJM7M8ljDtWxEgx21fkR8PT11s71pvS
        VzafoSfR70E9AUUDEU/I+0zg8V/oHCEoukRjzmJfOM1TDLM=
X-Google-Smtp-Source: ABdhPJxjbd20vFE8n/InbI5J8sGslKS9iLtSPPWcjxWg7uUP4a4WQHUKkLuOMn9oWWU/4fuh0F52VaqkkzWNyRYhPjw=
X-Received: by 2002:a17:907:d8e:: with SMTP id go14mr7317695ejc.472.1611174066233;
 Wed, 20 Jan 2021 12:21:06 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210120194609.GA3843758@infradead.org>
In-Reply-To: <20210120194609.GA3843758@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Jan 2021 12:20:59 -0800
Message-ID: <CAPcyv4jvGfZ1W8KLPO22oYVDBiUYius+Nf8kRNP=xmPvjg+deA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:46 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> The subject doesn't make any sense to me.
>
> But thn again queued sound really weird.  You just have a managed
> API with a refcount and synchronization, right?

Correct.

"queue" was in reference to the way q_usage_count behaves, but yes,
just refcount + synchronization is all this is.

>
> procfs and debugfs already support these kind of managed ops, kinda sad
> to duplicate this concept yet another time.

Oh, I didn't realize there were managed ops there, I'll go take a look
and see if cdev can adopt that scheme.

> > +static long cdev_queued_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>
> Overly long line.
>
> > +__must_check int __cdev_register_queued(struct cdev *cdev, struct module *owner,
> > +                                     dev_t dev, unsigned count,
> > +                                     const struct cdev_operations *qops)
> > +{
> > +     int rc;
> > +
> > +     if (!qops->ioctl || !owner)
> > +             return -EINVAL;
>
> Why is the ioctl method mandatory?

Yeah, that can drop. It was there more to ask the question about
whether cdev should be mandating ioctls with pointer arguments and
taking the need to specify the compat fallback away from a driver
responsibility.
