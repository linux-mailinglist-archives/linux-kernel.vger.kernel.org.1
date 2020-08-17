Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4729A2461D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgHQJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 05:03:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728725AbgHQJDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597655029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWLBVVWGQzp5rvaiSkpRpGi21EkmGXSL34WymXzDWrA=;
        b=XKLTYemfR8Y5I9gxJm4we2pECXyNP8fnWoBhxCSCfQoDTnpcDOFHr05L66DFp9AAHpqXKx
        IGc4Gs1as2lS27UxsZO/BnERNBLZSJJl8JATgN6E0BnUxHkM9pLh/KdfeOffJuw9QVUg08
        W8Wj9BhtyIhvT/BbDpqgIqu1uUTG7io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-XOr0Q0g5Pm2_V_1gskoIRA-1; Mon, 17 Aug 2020 05:03:45 -0400
X-MC-Unique: XOr0Q0g5Pm2_V_1gskoIRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3A50801ADB;
        Mon, 17 Aug 2020 09:03:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 746637A1C0;
        Mon, 17 Aug 2020 09:03:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AB9611753B; Mon, 17 Aug 2020 11:03:42 +0200 (CEST)
Date:   Mon, 17 Aug 2020 11:03:42 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, 1882851@bugs.launchpad.net,
        David Airlie <airlied@linux.ie>, Chia-I Wu <olvaffe@gmail.com>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: fix unblank
Message-ID: <20200817090342.bemmtkvz4seayp2i@sirius.home.kraxel.org>
References: <20200807105429.24208-1-kraxel@redhat.com>
 <20200807130956.GE2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807130956.GE2352366@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> > @@ -100,6 +100,7 @@ static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
> >  	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
> >  
> >  	output->enabled = true;
> > +	output->need_update = true;

> > --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> > @@ -163,7 +163,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
> >  	    plane->state->src_w != old_state->src_w ||
> >  	    plane->state->src_h != old_state->src_h ||
> >  	    plane->state->src_x != old_state->src_x ||
> > -	    plane->state->src_y != old_state->src_y) {
> > +	    plane->state->src_y != old_state->src_y ||
> > +	    output->need_update) {
> 
> Uh instead of hand-rolling what's essentially a drm_crtc_needs_modeset
> check, why not use that one? atomic helpers try to keep the usual suspects
> for state transitions already handy, to avoid every driver rolling their
> own. Or do I miss something here?

Well, the virtio-gpu virtual hardware can't do plane updates and crtc
updates independant from each other.  So the crtc callbacks handle
disable only (we don't need a fb for that) and leave the enable to the
plane update.

I suspect calling drm_atomic_crtc_needs_modeset() in plane update isn't
going to fly ...

take care,
  Gerd

