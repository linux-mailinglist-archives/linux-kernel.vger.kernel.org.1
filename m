Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAFB2C8328
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgK3L0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:26:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgK3L0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606735481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+IfSyc3oeRx7gQiNyYPDe/qMdnGQeeK0VYHxr9f3Tb4=;
        b=AcIosT/+oxoGWwStE0jWlW8M6p73oDevmB1HKSMQruwkaO9Ug5xRsl0nleKcEQUCd3GIkv
        chroKLP+2zP5ORBQ2BS1JEPg3qo8cR3ubJILdSHMqwb1z77dHVaMaT40yExMurFAUKwaA9
        Mti28yMtkx0eoVle5JTNoGWinbnaQog=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-UpHxe725M4WrkijMeu6TmA-1; Mon, 30 Nov 2020 06:24:39 -0500
X-MC-Unique: UpHxe725M4WrkijMeu6TmA-1
Received: by mail-wr1-f72.google.com with SMTP id n1so8325152wro.22
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+IfSyc3oeRx7gQiNyYPDe/qMdnGQeeK0VYHxr9f3Tb4=;
        b=lPkkvVtnekqeutpqNmSlj/35w1TYt14h6aFmt8Vj0v++AA83xn5UvbwFROwCzHfUhR
         R+zYDlZnf4eZd4W1/iUOrTjxXs1ZqyOXvMiMOjvcN405w1O1noaUW7jWefT+gOxlpxTH
         FcAsJPeLlsHanMKel/e1E2M6XdhB42luva2j7vOLTtubHmoLW7RfTMBUlLhQSLWk1dSZ
         6PB6avZUfdvMqEXZ5QwESTp8Vht9mTj+BcfLGj6jXLGb3lwe0SiN53EkPFNuTxkEr83z
         BxQgWZz64U19ebtw+qwvHR9Ac1Yc9DWed/V4Ev4MVyzwnM/MfOgV8fPBmr5iLVStXvG6
         Warg==
X-Gm-Message-State: AOAM533Vs/zJPqtt1uaQRF03DyEvodJIlf5M1onVihF7fwfraAJpCEuZ
        E03F2XOGOcTVulZKmgUbi18cpZr7YQI+L+8yEHo4mBvjRWxbsk1t9DpzvgsuS6VOhU80acJWion
        g1jfPQcVGY9xYPFXFVi9ZTbdy
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr18766788wmc.105.1606735478650;
        Mon, 30 Nov 2020 03:24:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/AvsYD6gHoCniifoJdETBrqkKIGVgtgec5OdlwKQMCfot5hGiMNa6XokE458kB5aHmeQjsg==
X-Received: by 2002:a1c:7d94:: with SMTP id y142mr18766765wmc.105.1606735478412;
        Mon, 30 Nov 2020 03:24:38 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id b62sm16322794wmh.41.2020.11.30.03.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:24:37 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:24:35 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 04/17] vdpa_sim: remove the limit of IOTLB entries
Message-ID: <20201130112435.sbxqi2wpm3vlmpfi@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-5-sgarzare@redhat.com>
 <42989b66-9d53-cc2e-4d8e-5a93aad2efa1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42989b66-9d53-cc2e-4d8e-5a93aad2efa1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:07:08AM +0800, Jason Wang wrote:
>
>On 2020/11/26 下午10:49, Stefano Garzarella wrote:
>>The simulated devices can support multiple queues, so this limit
>>should be defined according to the number of queues supported by
>>the device.
>>
>>Since we are in a simulator, let's simply remove that limit.
>>
>>Suggested-by: Jason Wang <jasowang@redhat.com>
>>Acked-by: Jason Wang <jasowang@redhat.com>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v2:
>>- added VDPASIM_IOTLB_LIMIT macro [Jason]
>
>
>Sorry for being unclear. I meant adding a macro like
>
>VHOST_IOTLB_UNLIMITED 0 in vhost_iotlb.h.
>
>And use that in vdpa_sim.

Got it :-) I'll fix adding the macro in another patch and using it in 
this one.

Thanks,
Stefano

