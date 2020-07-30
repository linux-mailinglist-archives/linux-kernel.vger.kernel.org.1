Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D712334BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 16:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgG3Osi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 10:48:38 -0400
Received: from crapouillou.net ([89.234.176.41]:35466 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Osi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1596120515; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=PQkagFlHg2d5KzpMhd8eaAxlglNrzK6R7YdWS3ZyGw4=;
        b=sbJRwlRK3mtagHtlYLsdJFIW4k1HPOaVFrpjnzDiEG3pXKa7gEgPCqU7BblfEKlP82y1dC
        KXbB8FeCnXzylEiIGcay6gw6ErwCczxxP7VDPZ4Z6aMsxiK+ZGbyoEk4txRNoSYdExm8k+
        wx/gDYHCncKFNc1iSlFn/ZKtqhy+rNg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/3] More IPU cleanups v2
Date:   Thu, 30 Jul 2020 16:48:27 +0200
Message-Id: <20200730144830.10479-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch [1/3] unchanged. Patches [2/3] and [3/3] have had their commit
message slightly modified, but the patches themselves are the same as
before.

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

