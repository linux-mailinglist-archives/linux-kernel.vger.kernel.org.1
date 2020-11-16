Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0EE2B410A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgKPKWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:22:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbgKPKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605522165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbuGc0/uWmZkkv1PjDNiiAipM9HKIfrFobewTRjKHTE=;
        b=hVlkDmmvWJpZHrbsJM0QbIinysxGc5EVy2P8brl+gJrm6wdfbIRbsvLgtg9Ra+GsWxxgBQ
        MyHgr1SfX9cmsloNjWToGBpNneF9skAEqv9qcnboDlKMO4m1dOY4Bl0x7aCVvfaeZX1+AT
        IZqJzu6ATqCKHts3QVDoAxnvQgYjiy8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-ZJYZjfIuNTahJEgdYrNYBg-1; Mon, 16 Nov 2020 05:22:43 -0500
X-MC-Unique: ZJYZjfIuNTahJEgdYrNYBg-1
Received: by mail-wm1-f72.google.com with SMTP id o19so10184765wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LbuGc0/uWmZkkv1PjDNiiAipM9HKIfrFobewTRjKHTE=;
        b=n0bR2nKAeS1rlW8kD1ZIbZI4bCyCb6J9zHn9IDur6q1QfMGmQP3gocGicyE5Dr04Pm
         QE9lguwqFO1KZUe4tZkLXsLKV2O1FBkjnPJc/iLekmezC9rzvxKQVocXXGJ9JWSlB9Jq
         wu4WLsdMqFYGPVRP5psHfkzCJMJmnNMvzbD6IJ4ymQl8AmPHlrX9nCUw/uPC3HX4GsDV
         lKfYjpNY/k5QL18wNmEa9ZWbFA4uM+tVLKfSh/6JtJ8en6v6nxKmAb8dPy8/glO8FSWY
         tB0CaI0Wx18/WRyYMzIeilXrDbhUUpDdkLS/h89TcFKpY1s+hEVesy4apDCeQEGxQFt0
         KR6A==
X-Gm-Message-State: AOAM530yRRYwWSWmxR1Z6BYaEA2XEnssAo9jX8tEnDrcUdcPxsCpvoza
        H5h7oHeekuv2qaUYq1jBB2v21Q/uECvVCHBHSF2YZuAJDqSHWFIHIsHh4RMfaHajOlCdLJ7a0iH
        2n3izob4cIh8rEu6t8YfzA5c4
X-Received: by 2002:adf:9b95:: with SMTP id d21mr18023450wrc.335.1605522162408;
        Mon, 16 Nov 2020 02:22:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx139v61XiPzgtOleGag58qeN3Zua/6HVQ+vfxq5o0fOMqggcja1P2b8rKUEvt/WzM8J+HV8A==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr18023430wrc.335.1605522162245;
        Mon, 16 Nov 2020 02:22:42 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id j71sm20107227wmj.10.2020.11.16.02.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:22:41 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:22:39 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 05/12] vdpa_sim: remove the limit of IOTLB entries
Message-ID: <20201116102239.bdqxbqfsdpbydkw2@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-6-sgarzare@redhat.com>
 <67e0358e-0ae8-75e9-156f-4156f58387d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e0358e-0ae8-75e9-156f-4156f58387d9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:12:21PM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>The simulated devices can support multiple queues, so this limit
>>should be defined according to the number of queues supported by
>>the device.
>>
>>Since we are in a simulator, let's simply remove that limit.
>>
>>Suggested-by: Jason Wang <jasowang@redhat.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>
>It would be good to introduce a macro instead of using the magic 0 here.

Done.

Thanks,
Stefano

