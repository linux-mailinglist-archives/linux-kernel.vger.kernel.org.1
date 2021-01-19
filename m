Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0DC2FAE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393308AbhASBxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41521 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392765AbhASBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611021056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezAkI9bpjSpShikkGlCQ65kOA/UWx1McNzmfSQ9uZ0c=;
        b=XotPCbkwwHOs8ciOZdle5HmYY5GMBO2w70Xkgeir6NNzk3iuj1YIxsoLEpVnK3OShWIf9d
        cactgjpgaJLcOSaug+DQAiux2/RumMXFecHP6bZommyU87rQ3K2LKp21ic43pHNr1XFca4
        fqhrUJERKOHXVSmY/1pFrHSvIeeJHwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549--qsspRNyNOm2ee3cVe2x1A-1; Mon, 18 Jan 2021 20:50:54 -0500
X-MC-Unique: -qsspRNyNOm2ee3cVe2x1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58802107ACE3;
        Tue, 19 Jan 2021 01:50:53 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-113-206.rdu2.redhat.com [10.10.113.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 315061F471;
        Tue, 19 Jan 2021 01:50:52 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Martin Peres <martin.peres@free.fr>,
        Jeremy Cline <jcline@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/nouveau/kms/nvd9-nv138: Fix CRC calculation for the cursor channel
Date:   Mon, 18 Jan 2021 20:48:48 -0500
Message-Id: <20210119014849.2509965-5-lyude@redhat.com>
In-Reply-To: <20210119014849.2509965-1-lyude@redhat.com>
References: <20210119014849.2509965-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on igt support for nouveau, I noticed that CRC calculation
appeared to be broken when the cursor channel was being used. For example,
if I had an igt test that would compare a software rendered image of a
completely black fb with a green square in it, and then attempt to
reproduce that image by positioning the cursor channel and setting it to a
green rectangle, the CRCs output by the hardware would differ between the
reference fb's CRC and the output's CRC. This was bizarre particularly
because through use of the Chamelium I have, I was able to confirm that the
image coming out of the display was identical between the reference and
output. As well, the issue wouldn't happen when using the outp CRC sources
that use the SF CRC source (so, DisplayPort) - only sources using the SOR
CRC source (so, everything other then DisplayPort and VGA). It also didn't
happen with the ovly plane, only the cursor plane.

Eventually I noticed 0x00000040 being set in the default state cache values
for the CRC methods, which isn't in Nvidia's open-gpu-docs and as such
appears to be inadvertently cleared to 0s when we enable CRCs. After
enabling this again during CRC capture, CRCs appear to be calculated
normally in all circumstances now.

Note that we might need to do this for Volta+ as well, but I'm not
entirely sure yet as there seem to be some bugs with how Volta+ handles
cursors that are currently causing kms_cursor_crc tests to fail.

Cc: Martin Peres <martin.peres@free.fr>
Cc: Jeremy Cline <jcline@redhat.com>
Cc: Simon Ser <contact@emersion.fr>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/crc907d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc907d.c b/drivers/gpu/drm/nouveau/dispnv50/crc907d.c
index 0a89ae9523d4..f9cb484437aa 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc907d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc907d.c
@@ -32,7 +32,8 @@ crc907d_set_src(struct nv50_head *head, int or, enum nv50_crc_source_type source
 		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, EXPECT_BUFFER_COLLAPSE, FALSE) |
 		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, TIMESTAMP_MODE, FALSE) |
 		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, SECONDARY_OUTPUT, NONE) |
-		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, CRC_DURING_SNOOZE, DISABLE);
+		       NVDEF(NV907D, HEAD_SET_CRC_CONTROL, CRC_DURING_SNOOZE, DISABLE) |
+		       0x00000040;
 	int ret;
 
 	switch (source) {
-- 
2.29.2

