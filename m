Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9980229FA86
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgJ3BYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgJ3BYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604021057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQyRgbJ3/l+vJVJDtTjuVGXBelnseiL1niBB0iYvzho=;
        b=QYNiiNbUFovC4UBV6fvCl7Ydw+XPynuOfEWb++AZHVwySsyURfVdDcHXYOj+F9cQBq32+p
        qCcKJn0Hw/Up5PkWjFlgVFu0ypRwTfAV7CC0+R2CftkQDFrPERen+LAH3f3mif1L+SqGUd
        6FyVSMtaOrcjjkv6j9NjmhWVLKuYX/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-nKiaQDVyNZqJuHKC09Ghuw-1; Thu, 29 Oct 2020 21:24:15 -0400
X-MC-Unique: nKiaQDVyNZqJuHKC09Ghuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53EBD1868400;
        Fri, 30 Oct 2020 01:24:14 +0000 (UTC)
Received: from [10.72.12.249] (ovpn-12-249.pek2.redhat.com [10.72.12.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1358110027A5;
        Fri, 30 Oct 2020 01:24:09 +0000 (UTC)
Subject: Re: [PATCH 0/2] vdpasim: allow to set MAC address
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20201029122050.776445-1-lvivier@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <105012ef-7dd2-728d-0885-521c14ae7a9c@redhat.com>
Date:   Fri, 30 Oct 2020 09:24:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029122050.776445-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/10/29 下午8:20, Laurent Vivier wrote:
> This series starts by fixing a bug:
> vdpa_sim generates a MAC address that is never show to
> upper layer, and thus virtio-net generates another random
> MAC address, that changes each time virtio-net is loaded
> (even if vdpa_sim is not unloaded).
>
> Then it adds a parameter to vpa_sim module to allow the user to
> set the MAC address. With that we use vdpa_sim with a stable
> MAC addres, that doesn't change between reboots.
>
> Laurent Vivier (2):
>    vdpasim: fix MAC address configuration
>    vdpasim: allow to assign a MAC address
>
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>


