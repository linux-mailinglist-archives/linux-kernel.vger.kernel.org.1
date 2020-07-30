Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9209B2329A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 03:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG3Bqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 21:46:36 -0400
Received: from crapouillou.net ([89.234.176.41]:45620 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3Bqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596073593; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=Nkzm7+SJ8S0uEbvir2Ri0RhcYGlcBnAXNM+14mPSXL4=;
        b=anZX3nB5q5L6g50HathDLjTJiZbwhJK3gileOtgVQag/sofblzgPv/nmyQzVwaMjE8O6tN
        +DDSbOrRyAe5/uobD41naAIW5QU7xFz6u+AAaZMvLakumbkD5jzAj4B6JTU+z96WANmdSW
        gmvYh5toPPH6on/mMuh/Sy2gnUzXJNI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     od@zcrc.me, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/3] More ingenic-drm IPU cleanups
Date:   Thu, 30 Jul 2020 03:46:23 +0200
Message-Id: <20200730014626.83895-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few more patches to the ingenic-drm IPU driver.

Patch [1/3] fixes the behaviour on newer SoCs at high resolutions /
framerates.

Patch [2/3] drops YUV 4:2:2 support on the JZ4725B SoC because of what I
think is a hardware bug.

Patch [3/3] makes the IPU clock enabled/disabled when needed.

Cheers,
-Paul

Paul Cercueil (3):
  drm/ingenic: ipu: Only restart manually on older SoCs
  drm/ingenic: ipu: Remove YUV422 from supported formats on JZ4725B
  drm/ingenic: ipu: Only enable clock when needed

 drivers/gpu/drm/ingenic/ingenic-ipu.c | 38 +++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.27.0

