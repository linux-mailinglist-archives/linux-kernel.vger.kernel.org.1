Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAF71BFF50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgD3Oy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 10:54:56 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:16019 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgD3Oyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:54:54 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 84E9274D24;
        Thu, 30 Apr 2020 14:54:50 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49CdhV2DKQz4tqj;
        Thu, 30 Apr 2020 14:54:50 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
Received: from tails.home (lfbn-idf2-1-900-181.w86-238.abo.wanadoo.fr [86.238.131.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 0F97019F4D;
        Thu, 30 Apr 2020 14:54:48 +0000 (UTC)
        (envelope-from manu@FreeBSD.org)
From:   Emmanuel Vadot <manu@FreeBSD.org>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, noralf@tronnes.org, kraxel@redhat.com,
        tglx@linutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@FreeBSD.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [RESEND 1/2] drm/client: Dual licence the header in GPL-2 and MIT
Date:   Thu, 30 Apr 2020 16:54:38 +0200
Message-Id: <20200430145439.31257-1-manu@FreeBSD.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Source file was dual licenced but the header was omitted, fix that.
Contributors for this file are:
Daniel Vetter <daniel.vetter@ffwll.ch>
Matt Roper <matthew.d.roper@intel.com>
Maxime Ripard <mripard@kernel.org>
Noralf Trønnes <noralf@tronnes.org>
Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Noralf Trønnes <noralf@tronnes.org>
Acked-by: Matt Roper <matthew.d.roper@intel.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
---
 include/drm/drm_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 7402f852d3c4..eb259c2547af 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
 
 #ifndef _DRM_CLIENT_H_
 #define _DRM_CLIENT_H_
-- 
2.25.1

