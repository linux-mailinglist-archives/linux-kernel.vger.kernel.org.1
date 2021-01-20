Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725862FDD84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbhATX5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbhATVkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:40:20 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F95AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:39:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g24so51415edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSf0ToA2jort2u5AL1d6u4W1M1rj7Hzrgs+Or59IlL8=;
        b=Wx00Bh5rJYoL4qGksYW4rVJ/kBgxBKt2mOLjC9TC7EeE3ZEq7q4OnnIIHafptQ73dK
         hJs8dnWkRE7Ft9iev9hpbP0dhrGvSrUgOIwvpPVUn0DEnkQntiVbhynN9+6Nrl/QMlr0
         QIzkdvK0iA7LxlsR8LWoQAktVCmDEl5Q9AD+oo/NJTKRYT25BZZ036v+RyeLrx0pf+1A
         Xf0xCxYM3WUJWkMajd8WBdhD6zvIWSVrAOoV2wNOxiuDri1pt2mSAFQ1KGXr+7q3FlH2
         I5QqfpEz/N4nnkmWNI856YGLiBkPtO9C0OZtW4O/N28KHzANFfcQlUcqFMitar8vKbRz
         PPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSf0ToA2jort2u5AL1d6u4W1M1rj7Hzrgs+Or59IlL8=;
        b=A/YQlatcK8xnRRqfqVsrdfqfWaFK/45s9P5zU6yo1K8zJpfk1xOL/DY+RkB258Lk8M
         IeVEf8IdGlPW8VuwQIyySQaYmB9vZZfUIgZWmr3lxKCDKGOmOmKze321/vZvkUt38KL5
         hHrLsAIKasrIqN5tu7wonQcI2Lpaf/GDGt1yfcrTvtb2Gu8gWz2F8Cs75nN8z9oCVPPd
         f6CSduhK8SfnuliGkTnuS2IZUx7k9v9TlU8Y50pkGFO++lRAM28XXbbtK2LMT5j2ebOI
         802aiSvQ/qjTUv4YQ+oKR52drnWr5oYwEYSe7QwG7e3DsT4WmAFVTpO8MpRwwZgmqkKR
         I3Xg==
X-Gm-Message-State: AOAM5337eycVuu4s36cFuQNv4r8NMiWz5eS3YSKLOtWU1/AacZm63Jv4
        zLlItp6kYbjFfrLiiJkJ1F19+jvvZiKxyUYp9Amarw==
X-Google-Smtp-Source: ABdhPJxcE/BaYJOETLqDHllMKGvULEympsLIRRmfqU1RvhqTEPz1/TeaeZVph7DeRnSY0l0uDtErKNbemEGpEsLi3tI=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr6643099edd.52.1611178778234;
 Wed, 20 Jan 2021 13:39:38 -0800 (PST)
MIME-Version: 1.0
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210120194609.GA3843758@infradead.org> <CAPcyv4jvGfZ1W8KLPO22oYVDBiUYius+Nf8kRNP=xmPvjg+deA@mail.gmail.com>
In-Reply-To: <CAPcyv4jvGfZ1W8KLPO22oYVDBiUYius+Nf8kRNP=xmPvjg+deA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Jan 2021 13:39:31 -0800
Message-ID: <CAPcyv4g+Pd+A6Aa9uXK1GwMo726niSF9jZ=fQvEuyNocso1zcA@mail.gmail.com>
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

On Wed, Jan 20, 2021 at 12:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Jan 20, 2021 at 11:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > The subject doesn't make any sense to me.
> >
> > But thn again queued sound really weird.  You just have a managed
> > API with a refcount and synchronization, right?
>
> Correct.
>
> "queue" was in reference to the way q_usage_count behaves, but yes,
> just refcount + synchronization is all this is.
>
> >
> > procfs and debugfs already support these kind of managed ops, kinda sad
> > to duplicate this concept yet another time.
>
> Oh, I didn't realize there were managed ops there, I'll go take a look
> and see if cdev can adopt that scheme.

So in both cases they are leveraging the fact that they are the
filesystems that allocated the inode and will stash the private
reference counting somewhere relative to the container_of the
vfs_inode. I don't immediately see how that scheme can be implied to
special device files that can come from an inode on any filesystem.

I do see how debugfs and procfs could be unified, but I don't think
this percpu_ref for cdev is compatible.

Other ideas?
