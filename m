Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2916E23BC56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHDOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:37:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34775 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728560AbgHDOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7efH4yIOHHW4g8YMjqbBd8yHqYmQidXMPn5y6gvFuc=;
        b=AEwBaiSqMEAvbF65zMguCsg1imeM/Bjt24gJH74gadh8QX/GJEYGXNvSdVXoQd2D4D+MfP
        PVa4JfMVt0vJh6jDLeSnE0qPwckc+YxySiaBqXiU6qWu0cGMWZqjfP9C9sY5KF9CCK8ICm
        EIqh/mkCv5Gjk3yar4LytoMODrrfigg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-Trw6BIZsOj27-smuFfkV2Q-1; Tue, 04 Aug 2020 10:36:18 -0400
X-MC-Unique: Trw6BIZsOj27-smuFfkV2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CA0C193F565;
        Tue,  4 Aug 2020 14:36:17 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18BF461176;
        Tue,  4 Aug 2020 14:36:13 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:36:10 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 12/24] virtio_iommu: correct tags for config space
 fields
Message-ID: <20200804163610.48bb7947.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-13-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-13-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:59:27 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Since this is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_iommu.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

