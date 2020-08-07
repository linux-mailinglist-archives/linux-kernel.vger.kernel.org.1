Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF5D23EC52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 13:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHGLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 07:22:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgHGLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596799346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYOzzMQ/5Pz2gxVyfxrOyOInaBGjLZuQwDWYrECBlYE=;
        b=Arepc/Qbzl8dgb5X4kE14/cyIrunj7Kpfmur0TJDYD9kzVh9+tfJiQDZM8RlZDg58t9FaQ
        PSTIuAg02vhs2Y4rTPMDBT8WAUlhSZdjVLi4C+fQZ4Hmz2WAmRTKBpxHkSxGWPkfp4R9TI
        TDOByb6T72qHQuIlywriwwaDr3Aj8f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-FMsxcogXOE-ix8JgUM4iKQ-1; Fri, 07 Aug 2020 07:22:24 -0400
X-MC-Unique: FMsxcogXOE-ix8JgUM4iKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 658CD8017FB;
        Fri,  7 Aug 2020 11:22:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA1A108AA;
        Fri,  7 Aug 2020 11:22:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8A4047828; Fri,  7 Aug 2020 13:22:18 +0200 (CEST)
Date:   Fri, 7 Aug 2020 13:22:18 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 10/38] virtio_gpu: correct tags for config space fields
Message-ID: <20200807112218.gbjiwdxjfzd7h6ah@sirius.home.kraxel.org>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-11-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-11-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:43:42AM -0400, Michael S. Tsirkin wrote:
> Since gpu is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

