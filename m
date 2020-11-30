Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD02C8680
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgK3OTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:19:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbgK3OS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606745853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9prsWoGXCRXLL1OI4BrWzM/wk3x2f0Z7sUXp0RoUalg=;
        b=Z7n1qgKqKwr707d6Avbac57eVjYmJ9F6dzU54XhkP7A3rCRGOvV+S4nvCaALmCNACr/3Iq
        dMjXvVK7qALdOntaivO+5oeQJIv2wyag96cviZ85Dcqd2ghEWtdDWIs0OfvGTJJAayeSYV
        1ajAg/rYJd9bgR0GoMXP7nEJgAl1C6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-lmuUw0TUMpmyamXCXjt1NQ-1; Mon, 30 Nov 2020 09:17:31 -0500
X-MC-Unique: lmuUw0TUMpmyamXCXjt1NQ-1
Received: by mail-wr1-f72.google.com with SMTP id m2so8513879wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9prsWoGXCRXLL1OI4BrWzM/wk3x2f0Z7sUXp0RoUalg=;
        b=BvyXurYuiDpxyi8eIWczyvOc5emAMFLp7Hu5y2BPaFeyaOafKTmwff/1V5n+0+rhDb
         EIOhInwh0ybZBYy4R6eTLbWb6EjFiz3GOWOG9446EKCsKJP1UaXNYsDh4xm0f12swMOL
         MSG1M1EvVrdILho6IbD1UArz5uG2r0cV0gQC4aSOcl3pOFU1F9bDmGSwu7IPE6L87+yf
         ALD5aW8Thk1z1hZAhL8yLICDD4Ns88r57IELhh5s8NRjqaF3pFDnp6eDSf/AfQ6nVtbj
         MzFuB85Ncv8IeYJIbCbAvMDk3xFFYAfbzfpaRDGgzLLLiINbvqDFg1xYe4YJJwJC1V/V
         UM5w==
X-Gm-Message-State: AOAM533xIx29fJKc/fBwIxhho8Po5F/ESih0O27GOLqtBm4hCi5+40zu
        CfJGDHJ1u6BS1zvHCxQ3s9/8Jv6biDrPlEwoDRPYSEWyIK0LcxvM/2VSjnxsS4AIAmnpU9QKz/T
        NSYrhmbxGBoI/5CjoeG648IJA
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr8353724wmj.16.1606745850164;
        Mon, 30 Nov 2020 06:17:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytEilOYibEaRt1OubviG1B2ypJ06x22ayeguT4QXkdSoR5ocTTJpdRPmZfnCl2gZgvNpyKSA==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr8353700wmj.16.1606745849962;
        Mon, 30 Nov 2020 06:17:29 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id x10sm21703399wro.0.2020.11.30.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 06:17:29 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:17:26 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 17/17] vdpa: split vdpasim to core and net modules
Message-ID: <20201130141726.wm732gw4khvbgm34@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-18-sgarzare@redhat.com>
 <ce5f1f8b-a0e2-5c3f-2e49-48e0379d1bba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce5f1f8b-a0e2-5c3f-2e49-48e0379d1bba@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:31:43AM +0800, Jason Wang wrote:
>
>On 2020/11/26 下午10:49, Stefano Garzarella wrote:
>>From: Max Gurtovoy<mgurtovoy@nvidia.com>
>>
>>Introduce new vdpa_sim_net and vdpa_sim (core) drivers. This is a
>>preparation for adding a vdpa simulator module for block devices.
>>
>>Signed-off-by: Max Gurtovoy<mgurtovoy@nvidia.com>
>>[sgarzare: various cleanups/fixes]
>>Signed-off-by: Stefano Garzarella<sgarzare@redhat.com>
>>---
>>v2:
>>- Fixed "warning: variable 'dev' is used uninitialized" reported by
>>   'kernel test robot' and Dan Carpenter
>>- rebased on top of other changes (dev_attr, get_config(), notify(), etc.)
>>- left batch_mapping module parameter in the core [Jason]
>>
>>v1:
>>- Removed unused headers
>>- Removed empty module_init() module_exit()
>>- Moved vdpasim_is_little_endian() in vdpa_sim.h
>>- Moved vdpasim16_to_cpu/cpu_to_vdpasim16() in vdpa_sim.h
>>- Added vdpasim*_to_cpu/cpu_to_vdpasim*() also for 32 and 64
>>- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>>   option can not depend on other [Jason]
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 103 +++++++++++++
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 222 +--------------------------
>>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 171 +++++++++++++++++++++
>>  drivers/vdpa/Kconfig                 |  13 +-
>>  drivers/vdpa/vdpa_sim/Makefile       |   1 +
>>  5 files changed, 290 insertions(+), 220 deletions(-)
>>  create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
>>  create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>
>
>Looks good, consider there are some still some questions left. I will 
>probably ack for the next version.
>

Sure, thanks for your feedback!

Stefano

