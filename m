Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1645027BDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgI2HUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbgI2HUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:20:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601364048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4YPMWYaZn/NlSCV+4SJY1EF6+YsEiEQ6nhQ9wb6D5w=;
        b=S5LuHFtlWLl2UzJp8bhBG+H+zes+s+g/nOBaKIDRzWsAR8dIUzUCrOkkgkmRhqbn9XGo1j
        xH86hQQjROatPBgbluVjdlNkXt1uLyKyuX8sc906URAJo7mRnsdz8cPCUKn1raamooH649
        +5CaSdHwd4ltQMD6au1DIIfyj/YvjEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-UoTOZ8xuPUSEUzduIvcDKQ-1; Tue, 29 Sep 2020 03:20:44 -0400
X-MC-Unique: UoTOZ8xuPUSEUzduIvcDKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A32A9801F9A;
        Tue, 29 Sep 2020 07:20:42 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADDB378815;
        Tue, 29 Sep 2020 07:20:37 +0000 (UTC)
Subject: Re: [RFC 2/3] iommu: Account for dma_mask and iommu aperture in IOVA
 reserved regions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, dwmw2@infradead.org,
        alex.williamson@redhat.com, jean-philippe.brucker@arm.com
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928195037.22654-3-eric.auger@redhat.com>
 <20200929060307.GA6564@infradead.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <35b5ff6b-1c6a-ced0-aeb0-6135b9fa26d5@redhat.com>
Date:   Tue, 29 Sep 2020 09:20:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200929060307.GA6564@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 9/29/20 8:03 AM, Christoph Hellwig wrote:
> On Mon, Sep 28, 2020 at 09:50:36PM +0200, Eric Auger wrote:
>> VFIO currently exposes the usable IOVA regions through the
>> VFIO_IOMMU_GET_INFO ioctl. However it fails to take into account
>> the dma_mask of the devices within the container. The top limit
>> currently is defined by the iommu aperture.
> 
> Can we take a step back here?  The dma_mask only has a meaning for
> the DMA API, and not the iommu API, it should have no relevance here.
> 
> More importantly if we are using vfio no dma_mask should be set to
> start with.

You will find more context in my reply to Alex.

Thanks

Eric
> 
>> +		if (geo.aperture_end < ULLONG_MAX && geo.aperture_end != geo.aperture_start) {
> 
> Please avoid pointlessly overlong lines.
> 

