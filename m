Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5523BC01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgHDOZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:25:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58813 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgHDOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BM2JMxKOJj4ZXY6F1Nf7SDJuSC0Of4l58aNBBuBK3iQ=;
        b=JCR6ViXIQwk/fZOar6hWodK1gAWTaUINwnDwPz7t0bbnD9zjUSHTZg4aTiTFVlzgqxZhlt
        Cr38tC+gOeHdQCZNzdvHqgjYP7AkpcW9TFf1vPweHR2OQlBXl4D3Z1RT64XTp9JOtVC4CQ
        dFT600G1qnWezlnEF6iCABsLi5u9dm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-kxlU5sKgPl-pVpOICdJONQ-1; Tue, 04 Aug 2020 10:25:21 -0400
X-MC-Unique: kxlU5sKgPl-pVpOICdJONQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E7679ED9;
        Tue,  4 Aug 2020 14:25:20 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFA4C5C6DD;
        Tue,  4 Aug 2020 14:25:15 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:25:13 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        virtualization@lists.linux-foundation.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2 04/24] virtio_9p: correct tags for config space
 fields
Message-ID: <20200804162513.6c0448ab.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-5-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-5-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:58:50 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Tag config space fields as having virtio endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_9p.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

