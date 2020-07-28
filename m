Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42938230D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgG1PQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:16:51 -0400
Received: from crapouillou.net ([89.234.176.41]:38744 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbgG1PQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595949408; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=w4oYRintr6C09zqyRCO+Nd06xt5Y8NV9/ZwsT/feY0w=;
        b=EW0ScNjIk/KEALxQPnhcecrCSLlEVsahz77Yp+ATZSDpgpqoQ2QXNm39OKSKsSIAV90Qtk
        mY48JXKZp07qlEYONVhHzLvtdxCuVHbwru1FRbiNHqwkzZMQEtCiHGhydtN7vELiqv2HRp
        rbxY1NtIDh0/x5iZoGwYfa3FTyQcRJw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] Small cleanups to ingenic-drm driver
Date:   Tue, 28 Jul 2020 17:16:39 +0200
Message-Id: <20200728151641.26124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few cleanups to the ingenic-drm driver.
- some error paths were missing and have been added;
- the mode validation has been moved to the .mode_valid helper callback.

Cheers,
-Paul

Paul Cercueil (2):
  drm/ingenic: Handle errors of drm_atomic_get_plane_state
  drm/ingenic: Validate mode in a .mode_valid callback

 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 41 +++++++++++++++--------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
2.27.0

