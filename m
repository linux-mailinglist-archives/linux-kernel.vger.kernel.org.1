Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A176123BBE2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHDOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:18:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728560AbgHDOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596550718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw61jMeCuZdbDRLwviwnpjt8KTeY+4WKos8mwU2Av5s=;
        b=BoPTUJWCftZzjUkYW1P/WSw9SgG6Q3YUnNJWUebrNu1bABA8RmJi2AK47/WdbIpbGTX3Ot
        FA73UOI6CM70Tz77AxIBpRQLd89MpxLOl/U1dAn24FnMZ5E9M70NwMjiX1HotQY0r4xFF9
        rb+hV7+Q59IcuFNFA3rp2bYipoBvJWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-gCRcc1HPMnaBWNWm9ylx3g-1; Tue, 04 Aug 2020 10:18:35 -0400
X-MC-Unique: gCRcc1HPMnaBWNWm9ylx3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E5A719057C9;
        Tue,  4 Aug 2020 14:18:33 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 326667F5CC;
        Tue,  4 Aug 2020 14:18:29 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:18:27 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 02/24] virtio_ring: sparse warning fixup
Message-ID: <20200804161827.5e1851a6.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-3-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-3-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:58:42 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio_store_mb was built with split ring in mind so it accepts
> __virtio16 arguments. Packed ring uses __le16 values, so sparse
> complains.  It's just a store with some barriers so let's convert it to
> a macro, we don't loose too much type safety by doing that.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio_ring.h | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

