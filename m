Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE9295375
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505303AbgJUU2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:28:08 -0400
Received: from mailoutvs41.siol.net ([185.57.226.232]:50333 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438637AbgJUU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:28:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 72205527E38;
        Wed, 21 Oct 2020 22:28:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6EpMvPOddic6; Wed, 21 Oct 2020 22:28:04 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 1F8D0527E43;
        Wed, 21 Oct 2020 22:28:04 +0200 (CEST)
Received: from kista.localdomain (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 5A2AD527E38;
        Wed, 21 Oct 2020 22:28:03 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, wens@csie.org, ezequiel@collabora.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: cedrus: h264: Fix check for presence of scaling matrix
Date:   Wed, 21 Oct 2020 22:33:25 +0200
Message-Id: <20201021203325.543189-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If scaling matrix control is present, VPU should not use default matrix.
Fix that.

Fixes: b3a23db0e2f8 ("media: cedrus: Use H264_SCALING_MATRIX only when re=
quired")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/s=
taging/media/sunxi/cedrus/cedrus_h264.c
index 28319351e909..781c84a9b1b7 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -446,7 +446,7 @@ static void cedrus_set_params(struct cedrus_ctx *ctx,
 	reg |=3D (pps->second_chroma_qp_index_offset & 0x3f) << 16;
 	reg |=3D (pps->chroma_qp_index_offset & 0x3f) << 8;
 	reg |=3D (pps->pic_init_qp_minus26 + 26 + slice->slice_qp_delta) & 0x3f=
;
-	if (pps->flags & V4L2_H264_PPS_FLAG_SCALING_MATRIX_PRESENT)
+	if (!(pps->flags & V4L2_H264_PPS_FLAG_SCALING_MATRIX_PRESENT))
 		reg |=3D VE_H264_SHS_QP_SCALING_MATRIX_DEFAULT;
 	cedrus_write(dev, VE_H264_SHS_QP, reg);
=20
--=20
2.29.0

