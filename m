Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F06226EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 21:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgGTTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 15:07:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729237AbgGTTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595272073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYp8hDLa0IjA98YGkayyQ6Kw4QTJdXG0itKNmWlfDu8=;
        b=Z1L8uN7dHr2tlj7LzS6sG7/oOPb9yduEJow0Q0mPX5E7SRSo3mrgWgZpeEBMDLhgPVFjeC
        N3EQsJsDe4dJqxtsKr9u6yXwFlxKCeAWiCjaJ2Rf81Ef7Wv4ed4gbJXyzz8NrBctiVXeJP
        618j0NQpBUj/3V3+z8BrAjsgJVvSgQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-Z5mpDVRvM2KND--pY5kLYQ-1; Mon, 20 Jul 2020 15:07:49 -0400
X-MC-Unique: Z5mpDVRvM2KND--pY5kLYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 731AA1005504;
        Mon, 20 Jul 2020 19:07:48 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 844A35C1D4;
        Mon, 20 Jul 2020 19:07:47 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] drm/vblank: Use spin_(un)lock_irq() in drm_legacy_vblank_post_modeset()
Date:   Mon, 20 Jul 2020 15:07:34 -0400
Message-Id: <20200720190736.180297-4-lyude@redhat.com>
In-Reply-To: <20200720190736.180297-1-lyude@redhat.com>
References: <20200720190736.180297-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only ever called from ioctl context, so we're
guaranteed to have interrupts enabled. Stop using the irqsave/irqrestore
variants of spin_(un)lock_irq() to make this more obvious.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_vblank.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 9891e82939e35..51f2e988205e7 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1551,7 +1551,6 @@ static void drm_legacy_vblank_post_modeset(struct drm_device *dev,
 					   unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
-	unsigned long irqflags;
 
 	/* vblank is not initialized (IRQ not installed ?), or has been freed */
 	if (!drm_dev_has_vblank(dev))
@@ -1561,9 +1560,9 @@ static void drm_legacy_vblank_post_modeset(struct drm_device *dev,
 		return;
 
 	if (vblank->inmodeset) {
-		spin_lock_irqsave(&dev->vbl_lock, irqflags);
+		spin_lock_irq(&dev->vbl_lock);
 		drm_reset_vblank_timestamp(dev, pipe);
-		spin_unlock_irqrestore(&dev->vbl_lock, irqflags);
+		spin_unlock_irq(&dev->vbl_lock);
 
 		if (vblank->inmodeset & 0x2)
 			drm_vblank_put(dev, pipe);
-- 
2.26.2

