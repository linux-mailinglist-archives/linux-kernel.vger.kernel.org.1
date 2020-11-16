Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19E42B4002
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgKPJkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbgKPJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605519600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctbNdgMCLqm0MmL6XQ46F/duayfW4vdoR6bBEw0CqiM=;
        b=b8fZC4gueD5StJBsKu7a6oIDMHKdAuHL/RiYLiFpeW1GozT4Jc8TcPHyWbKkL78ZVZI8Na
        vwioMz93VIPBGRRK81+OrOIecfZ/4xZlq5hOVoAm5rgnxiSTI48PU60kTbo81iCtAvCDvF
        UT1psN3gzqxWhD6T1qjv0p/Jf1GY0YY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-bDrmtKJYMdmfkX22IFMpaA-1; Mon, 16 Nov 2020 04:39:58 -0500
X-MC-Unique: bDrmtKJYMdmfkX22IFMpaA-1
Received: by mail-wr1-f70.google.com with SMTP id u1so10917513wri.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ctbNdgMCLqm0MmL6XQ46F/duayfW4vdoR6bBEw0CqiM=;
        b=pgmqH36R+I1Mc1WyddhRRgEfP/9OobXs2kxg2JrLRXOIbCHvffC2Jy2wQv0T2v19aN
         SQxBTI6RWPChs8itv5EsoSnjW/PKJHgaHl7xZgQj2zmJ8xwHhH1I0ijXhNx1pjbIhwtn
         D2c8NYfPFQ95VMdpevVBNlO3xs1sDyNrvisebPwx56yxxLSEv+zM6UZs2qSBLzuXbb+O
         JuHMzuI/vzr5TE74HCvHvU4FZbEbTJhs98NDclTBT4oi1u00ll0Hosji7WaRHa6jleSH
         vJ2tDdyJ+qCcjpd2MXce1eF0EhmedGjSURyBi5hJNn1nHZ1eMFDvLFO0ODQN9EhbGFKw
         lV/Q==
X-Gm-Message-State: AOAM533j5zongMCMxGMWdBihKRxEFMKvLHrKzHEVfzbmS97c0qohNg/y
        q9peQlCwOBCJmVTE0gj+DpU/QumtyWA2Huw6aXHnagqVLWFEYMiaCwtgERq2qlha3MtX9HHCEQz
        qsXI7nYzsgTNtdFJf75fsGI8c
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr11028707wmf.76.1605519597622;
        Mon, 16 Nov 2020 01:39:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3nAGrNoe04CizjIX7ieFEVYDthOVy/X7dUVJm6aMD7Taix3cf0pxgzpGIP9IGHbQZEQHmlA==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr11028685wmf.76.1605519597450;
        Mon, 16 Nov 2020 01:39:57 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id t74sm19457618wmt.8.2020.11.16.01.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 01:39:56 -0800 (PST)
Date:   Mon, 16 Nov 2020 10:39:54 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 02/12] vdpa: split vdpasim to core and net modules
Message-ID: <20201116093954.svf6yjmmn55mdtl4@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-3-sgarzare@redhat.com>
 <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:00:11PM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>>Introduce new vdpa_sim_net and vdpa_sim (core) drivers. This is a
>>preparation for adding a vdpa simulator module for block devices.
>>
>>Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>[sgarzare: various cleanups/fixes]
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v1:
>>- Removed unused headers
>>- Removed empty module_init() module_exit()
>>- Moved vdpasim_is_little_endian() in vdpa_sim.h
>>- Moved vdpasim16_to_cpu/cpu_to_vdpasim16() in vdpa_sim.h
>>- Added vdpasim*_to_cpu/cpu_to_vdpasim*() also for 32 and 64
>>- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>>   option can not depend on other [Jason]
>
>
>If possible, I would suggest to split this patch further:
>
>1) convert to use void *config, and an attribute for setting config 
>size during allocation
>2) introduce supported_features
>3) other attributes (#vqs)
>4) rename config ops (more generic one)
>5) introduce ops for set|get_config, set_get_features
>6) real split
>

Okay, I'll try to split Max's patch following your suggestion.
It should be cleaner.

Thanks,
Stefano

