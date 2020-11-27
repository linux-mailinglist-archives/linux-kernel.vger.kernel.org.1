Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73A12C5ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 03:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404162AbgK0CvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 21:51:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730961AbgK0CvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 21:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606445462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDQkslNn1bs9ms9Q14yiNJoO0vMzZ4WNFafjj5jooJ8=;
        b=Pnc6PvsCCZfc810/HH2VL5TdgNgP9umRBHPuztM9Np9LhiKqRThaNgSubVJ0PPUNKBRobv
        SIFDSdz+vvoT7texCjGw065HdKmd5GocunJH8ztzmXa18vlPACqvvWopXSVIAh8oUdGpbl
        HD1zEXK+LC+mFT4zplMkYvfNb2E9OOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-VWLlNBS1NBSuh4z9sZYDlA-1; Thu, 26 Nov 2020 21:51:00 -0500
X-MC-Unique: VWLlNBS1NBSuh4z9sZYDlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B30209CDAF;
        Fri, 27 Nov 2020 02:50:59 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD9775C1C2;
        Fri, 27 Nov 2020 02:50:54 +0000 (UTC)
Subject: Re: [PATCH V2 01/14] virtio-pci: do not access iomem via
 virtio_pci_device directly
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
References: <20201126092604.208033-1-jasowang@redhat.com>
 <20201126092604.208033-2-jasowang@redhat.com>
 <20201126084436-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3b65ce4f-9b1d-1542-ffbb-836269e9e80e@redhat.com>
Date:   Fri, 27 Nov 2020 10:50:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126084436-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午9:46, Michael S. Tsirkin wrote:
> On Thu, Nov 26, 2020 at 05:25:51PM +0800, Jason Wang wrote:
>> Instead of accessing iomem via virito_pci_device directly. Add an
>> indirect level
> well this patch does not add any indirection it's just refactoring.
> which is ok of course let's just say it as is.
>
>> to ease the life of splitting out modern virito-pci
> typo


Will fix.

Thanks


>

