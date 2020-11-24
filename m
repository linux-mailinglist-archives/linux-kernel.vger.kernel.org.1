Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDE2C2FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbgKXSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:12:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390718AbgKXSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606241554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2oBIff2vrXptsOCDgJqXcxsBYnjbQeRRHymVbCela8Y=;
        b=X+oLQ9pnJ2bDthSAi3HXuDzwY5KfJhI/skkexk5Rx9Pn2nNkdrDwmVdDJvfhFhQz8Kvs3z
        Xd5jORpE+S311cC2TnnGEv4lvoOTQDqPas1+3PDBB5uAp/WNAj8VhtdZ7eIlq9BkcvJyAy
        41x88GeO8ZNFT7TtLb8I3Vr2/Ns2uLw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-1b57qiFUPluPtKnuAz8pVA-1; Tue, 24 Nov 2020 13:12:31 -0500
X-MC-Unique: 1b57qiFUPluPtKnuAz8pVA-1
Received: by mail-qt1-f200.google.com with SMTP id 100so16874028qtf.14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2oBIff2vrXptsOCDgJqXcxsBYnjbQeRRHymVbCela8Y=;
        b=hUQaAUsg2meQce8eMrOGk1U8saXRl07WgsFrV4hqnfEkXYn7ZH0+8Xu+BSEFJw7o82
         RUwgU2EPg3cRJsiVYbDw3gXDb11HQAu/+ndOsccUmfjLF5NRSJUDm/P2lPWvABijnCDQ
         jhWoCyWIvK24jkxrUk51higQIKhcHiu8RWghPlu1cUtd8xGJSPi9fWkGNe6qwHoLOjXV
         ezkKCxnYDgMlatJwsoMHw+N9J7oMOCrL2Nf/+6h1wiSr2NAbGo0Y//kRe0ML/kGlslrt
         ZqGZCOEhPeAFyiXt3OLnAyCcL2BUtxQMPESceQNJrQ2KItqPo87e0GSw4sTGs8v5NoZG
         TdUA==
X-Gm-Message-State: AOAM5304nGWWGA1pi9t/iC3YpfR4+nySUaxndtMGNgKdFIwkYYu1SARn
        8oEMDh9RSilhYnhnUwXjKsygsZxLfAyCs/4MSZ87NmRHZvvfWKAb1FAJNf4Inz9TVhExcX3rbyn
        J8Ltcn4zBw2+1MPc23ZBcICL9
X-Received: by 2002:a0c:eec4:: with SMTP id h4mr6166752qvs.35.1606241551010;
        Tue, 24 Nov 2020 10:12:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYkcubJCjDfr3L92syDxFxlSzaLINmTiYCYOGr9X/iVg27guubvICQfcGQ1RnmdVIfefltCQ==
X-Received: by 2002:a0c:eec4:: with SMTP id h4mr6166727qvs.35.1606241550714;
        Tue, 24 Nov 2020 10:12:30 -0800 (PST)
Received: from xz-x1 ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id q32sm14116193qtb.71.2020.11.24.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:12:29 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:12:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jia He <justin.he@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio iommu type1: Bypass the vma permission check in
 vfio_pin_pages_remote()
Message-ID: <20201124181228.GA276043@xz-x1>
References: <20201119142737.17574-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119142737.17574-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jia,

On Thu, Nov 19, 2020 at 10:27:37PM +0800, Jia He wrote:
> The permission of vfio iommu is different and incompatible with vma
> permission. If the iotlb->perm is IOMMU_NONE (e.g. qemu side), qemu will
> simply call unmap ioctl() instead of mapping. Hence vfio_dma_map() can't
> map a dma region with NONE permission.
> 
> This corner case will be exposed in coming virtio_fs cache_size
> commit [1]
>  - mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>    memory_region_init_ram_ptr()
>  - re-mmap the above area with read/write authority.

If iiuc here we'll remap the above PROT_NONE into PROT_READ|PROT_WRITE, then...

>  - vfio_dma_map() will be invoked when vfio device is hotplug added.

... here I'm slightly confused on why VFIO_IOMMU_MAP_DMA would encounter vma
check fail - aren't they already get rw permissions?

I'd appreciate if you could explain why vfio needs to dma map some PROT_NONE
pages after all, and whether QEMU would be able to postpone the vfio map of
those PROT_NONE pages until they got to become with RW permissions.

Thanks,

-- 
Peter Xu

