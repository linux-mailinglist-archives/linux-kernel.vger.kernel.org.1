Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90A42B3BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgKPECk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbgKPECk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605499359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+x1sdSjYElIzbzoPa6Ux6ilBlwEfssp+DCBplfeClMs=;
        b=WzzIqz07W2i3BrKddWmlRSQvBZozfa0nWyXUiCHhB1YPle495qlIbGeEbGT0UynTi9KwdY
        cXVlp0V7Ox2d8iM9kCwLeO0BAsDufeoF+BxERynViqnHZQmKsI5TE6T+QsdFleJNX5MPUi
        ixwVkDfb/UL08NJh33pglJR8sCViAv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-K-jWbgH0POSB2x4eLQa0bQ-1; Sun, 15 Nov 2020 23:02:38 -0500
X-MC-Unique: K-jWbgH0POSB2x4eLQa0bQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9C3D100747F;
        Mon, 16 Nov 2020 04:02:36 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D74B10002A4;
        Mon, 16 Nov 2020 04:02:27 +0000 (UTC)
Subject: Re: [PATCH RFC 03/12] vdpa_sim: remove hard-coded virtq count
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-4-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a24092dd-bca8-4acb-0c6a-e8da46525b51@redhat.com>
Date:   Mon, 16 Nov 2020 12:02:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-4-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> Add a new attribute that will define the number of virt queues to be
> created for the vdpasim device.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> [sgarzare: replace kmalloc_array() with kcalloc()]
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v1:
> - use kcalloc() instead of kmalloc_array() since some function expects
>    variables initialized to zero


Looks good, one nit, I prefer to do this before patch 2.

Thanks


