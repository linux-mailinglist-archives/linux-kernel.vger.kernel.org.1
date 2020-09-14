Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674F2268576
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgINHGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgINHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:06:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:06:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so21608915ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzjHK93gF6TNt+MS+qTD/b9Ejjchu3tiLLiAmnKOigs=;
        b=GVuyGNCHt3OvQ6eF2rUvSOr0rU/reUiaOsL5AQskvAlBtwEICewg7AIjbQWATNAvsg
         0QOTbsPNg1FuPEykHQ4PIO2slHHDdVbY+esAt0zfaIcpyCYpi0nAc8lvByqsT/Pw5WFq
         yI/HcgRHr3XCgFrnJdqsQQNUQzaPLg3qEx9Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzjHK93gF6TNt+MS+qTD/b9Ejjchu3tiLLiAmnKOigs=;
        b=UmPdoVJWwavDDOQvjXAnyP18r/5oQzfMZD63AF1yg2FEHucx31Y5K2tU+0PUU7FaA7
         ZBqaIiJTTq0eS7+S9ngK+tOFF9ERQdWRdFM9S1lvxkwjHf8OAicPu4AM+ErbJ/i0KRZJ
         tAGFdP4NMAct93pN0q1Oa30bPF2YjPhMoomEeZMvCkGhEZNzpW3lCOwN84DhrQdy3KJY
         EZdUzxFhM6DyQ14sqXeOzDknHjCAVITKQVPRzwWrL4YmEfGc5TaLplA/cSPUkyxaQYcL
         l7tNKP77A2Sbs81IHkFrLeR6OIrEYRkHzfgL/+Zk5CB7vAvbaTi1TJY0U1SFrTXPoTwO
         OlRw==
X-Gm-Message-State: AOAM531tMhGTi5ckoQRWcOI2adoK8Yy9U6QpWsoTgNGc7qAjrXQBNu6J
        HULswPfCvpBh0ojBih4Y8j5p0i5tBnoX18I+97cyaA==
X-Google-Smtp-Source: ABdhPJwwMHTxbNFbv1ZDSMvwtnnv5t/6jACLhtDPjF+BAh7AYeJ1VPMt4OX16E+iT8UDf1zr5E8OnqzZABT/VwMrjqE=
X-Received: by 2002:a17:906:4c51:: with SMTP id d17mr13102661ejw.28.1600067172080;
 Mon, 14 Sep 2020 00:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <c94c36305980f80674aa699e27b9895b@mail.gmail.com>
 <20200910105735.1e060b95@w520.home> <f9b3c805-cd64-3402-ff73-339c35c4c27a@redhat.com>
In-Reply-To: <f9b3c805-cd64-3402-ff73-339c35c4c27a@redhat.com>
From:   Vikas Gupta <vikas.gupta@broadcom.com>
Date:   Mon, 14 Sep 2020 12:36:01 +0530
Message-ID: <CAHLZf_vfyDR5SrtC48j9jaBK3sONhfDtkDnqHVE8NB8_up=B+g@mail.gmail.com>
Subject: Re: MSI/MSIX for VFIO platform
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric/Alex,
Thanks for your valuable suggestions and get back to you if anything
is required.

Thanks,
Vikas

On Fri, Sep 11, 2020 at 7:23 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Vikas,
>
> On 9/10/20 6:57 PM, Alex Williamson wrote:
> > On Thu, 10 Sep 2020 16:15:27 +0530
> > Vikas Gupta <vikas.gupta@broadcom.com> wrote:
> >
> >> Hi Alex/Cornelia,
> >>
> >> We are looking for MSI interrupts for platform devices in user-space
> >> applications via event/poll mechanism using VFIO.
> >>
> >> Since there is no support for MSI/MSIX handling in VFIO-platform in kernel,
> >> it may not possible to get this feature in user-space.
> >>
> >> Is there any other way we can get this feature in user-space OR can you
> >> please suggest if any patch or feature is in progress for same in VFIO
> >> platform?
> >>
> >> Any suggestions would be helpful.
> >
> > Eric (Cc'd) is the maintainer of vfio-platform.
> >
> > vfio-platform devices don't have IRQ indexes dedicated to MSI and MSI-X
> > like vfio-pci devices do (technically these are PCI concepts, but I
> > assume we're referring generically to message signaled interrupts), but
> > that's simply due to the lack of standardization in platform devices.
> > Logically these are simply collections of edge triggered interrupts,
> > which the vfio device API supports generically, it's simply a matter
> > that the vfio bus driver exposing a vfio-platform device create an IRQ
> > index exposing these vectors.  Thanks,
>
> I have not worked on MSI support and I am not aware of any work
> happening in this area.
>
> First I would recommend to look at IRQ related uapis exposed by VFIO:
> VFIO_DEVICE_GET_IRQ_INFO
> VFIO_DEVICE_SET_IRQS
>
> and try to understand if they can be implemented for MSIs in a generic
> way in the vfio_platform driver using platform-msi helpers.
>
> For instance VFIO_DEVICE_GET_IRQ_INFO would need to return the number of
> requested vectors. On init I guess we should allocate vectors using
> platform_msi_domain_alloc_irqs/ devm_request_irq and in the handler
> trigger the eventfd provided through VFIO_DEVICE_SET_IRQS.
>
> On userspace where you have to trap the MSI setup to call the above
> functions and setup irqfd injection. This would be device specific as
> opposed to PCI. That's just rough ideas at the moment.
>
> Thanks
>
> Eric
>
> >
> > Alex
> >
>
