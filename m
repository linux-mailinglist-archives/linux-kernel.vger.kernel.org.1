Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C12C82EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgK3LLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:11:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgK3LLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606734622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBA2P9rkCmIFocbgo88SKG1Ky5jlDdKUXcYMQbA/xcY=;
        b=CeetdH0ylHGFawhzGS76tCL39S9AoajbaDfb4fkr27Gb9gu1IGA7v1eVZuKvreeIWcFivB
        T8ga7qjJQz1ppa3y2T7UZ3EmEViwXSKDZj66lXuT8RsjjI/P6/LBmov+aXwfvPgmxFPt/E
        /HSAR7SAU+CziIcRj/6XgAbvs26Kxn8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-ZX0dSAC8M8KGmWE1Zuf90Q-1; Mon, 30 Nov 2020 06:10:20 -0500
X-MC-Unique: ZX0dSAC8M8KGmWE1Zuf90Q-1
Received: by mail-wr1-f71.google.com with SMTP id f4so8297701wru.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bBA2P9rkCmIFocbgo88SKG1Ky5jlDdKUXcYMQbA/xcY=;
        b=jxM8MnrayLxEy3n4DiKW+mtKX6LuqtNL1i3Xea/HZH+GVZbqdsP+Bwc/MMJPvBaITh
         U2VCb8JC91dZrNUxpUNlrQaraQ9VZ9TQ1i35/kcqgq704/eefuERCuR1SYE3N+LK01ti
         dz24j8rWoEKXH2augVRfx1uruX3h55zR4VzFC6eko/ezrWQTMK1RvvDEs0ME3w343BI9
         HM7koADC3ZVhqjEf2hMrN0Q7WnvU+gGID6ppxI8E76bT1cVcLVfjJupVzw8/BiZRyHTd
         OCLHmZpRr5S+LqcSDa9NyAIoILWSCPaWDTS/TPk/JgSVCzuy/AF06bTg9pq8DY3eQJbQ
         BRHA==
X-Gm-Message-State: AOAM5309xTylWvSmnOZkU4KuShtTeefpO67mtg3ltXjbEBx9ZpxLI0F3
        YMyu0qv9DqAqFZhgfPrNJwrWsmSD/z+55xrUg042sKwhNyQB6gntmiPfpLuw3KiQswmenWt5hzp
        Famrt0nzYFs+XhL9KQUkUZaUA
X-Received: by 2002:adf:c452:: with SMTP id a18mr28254909wrg.189.1606734619413;
        Mon, 30 Nov 2020 03:10:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymQVb/kChQ/Fx2/IqMU8g40mwj11rjePfVOwyuBCUP+xmJ0inwWZbZZ1mfbCHPL0E3AvfBFg==
X-Received: by 2002:adf:c452:: with SMTP id a18mr28254887wrg.189.1606734619219;
        Mon, 30 Nov 2020 03:10:19 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id f199sm24129875wme.15.2020.11.30.03.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:10:18 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:10:15 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 02/17] vdpa_sim: remove unnecessary headers inclusion
Message-ID: <20201130111015.74h3ratcegf6xlw5@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-3-sgarzare@redhat.com>
 <f900316d-a642-714e-65b6-5b6cc4b79b48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f900316d-a642-714e-65b6-5b6cc4b79b48@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:04:49AM +0800, Jason Wang wrote:
>
>On 2020/11/26 下午10:49, Stefano Garzarella wrote:
>>Some headers are not necessary, so let's remove them to do
>>some cleaning.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>index 6a90fdb9cbfc..c6eaf62df8ec 100644
>>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>@@ -7,24 +7,11 @@
>>   *
>>   */
>>-#include <linux/init.h>
>>  #include <linux/module.h>
>>-#include <linux/device.h>
>
>
>I think the rule is to make sure e.g the structure definition can be 
>via direct inclusion. E.g struct device {} is defined in this file.
>
>
>>-#include <linux/kernel.h>
>>-#include <linux/fs.h>
>>-#include <linux/poll.h>
>>-#include <linux/slab.h>
>>-#include <linux/sched.h>
>>-#include <linux/wait.h>
>>-#include <linux/uuid.h>
>>-#include <linux/iommu.h>
>>  #include <linux/dma-map-ops.h>
>>-#include <linux/sysfs.h>
>>-#include <linux/file.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/vringh.h>
>>  #include <linux/vdpa.h>
>>-#include <linux/virtio_byteorder.h>
>
>
>And the  __cpu_to_virtio16 is defined in this file.
>

Okay, I'll keep this two includes and check better the others.

Thanks,
Stefano

