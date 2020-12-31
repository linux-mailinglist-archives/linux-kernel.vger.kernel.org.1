Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6935A2E7DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 04:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgLaDxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 22:53:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgLaDxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 22:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609386746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WK2g2N52OBXmMOcR7zvVT2FcLYBhxstRgX3djP/XcFw=;
        b=Y1D7NVtuVJEw31gUtnWeURlKuV0nAG1GQyiDInqb9E8m1VOe0KhIyIooi7znjzEPGKeitP
        Dod7OJje6lq1R3qHoAb6jU/DAPlotXyq7gMx6xBmYjBMKU6ciyS0ZOsLUCerOBTWoOAX2n
        QNc7iLT8rAKaLIyrUQE8YaVNg0FvWJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-nsGEDtkxNvWxEfPkdFPNsA-1; Wed, 30 Dec 2020 22:52:21 -0500
X-MC-Unique: nsGEDtkxNvWxEfPkdFPNsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FED08015C4;
        Thu, 31 Dec 2020 03:52:20 +0000 (UTC)
Received: from [10.72.12.236] (ovpn-12-236.pek2.redhat.com [10.72.12.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0B4D27C3C;
        Thu, 31 Dec 2020 03:52:15 +0000 (UTC)
Subject: Re: [PATCH V2 00/19] vDPA driver for virtio-pci device
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
References: <20201204040353.21679-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
Date:   Thu, 31 Dec 2020 11:52:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 下午12:03, Jason Wang wrote:
> Hi all:
>
> This series tries to implement a vDPA driver for virtio-pci device
> which will bridge between vDPA bus and virtio-pci device.
>
> This could be used for future feature prototyping and testing.
>
> Please review
>
> Changes from V2:
>
> - don't try to use devres for virtio-pci core
> - tweak the commit log
> - split the patches furtherly to ease the reviewing
>
> Changes from V1:
>
> - Split common codes from virito-pci and share it with vDPA driver
> - Use dynamic id in order to be less confusing with virtio-pci driver
> - No feature whitelist, supporting any features (mq, config etc)
>
> Thanks


Michael, any comment for this series?

It's needed for testing doorbell mapping and config interrupt support.

Thanks

