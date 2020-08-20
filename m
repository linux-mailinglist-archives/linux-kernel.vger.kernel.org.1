Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9124BA99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgHTMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 08:13:14 -0400
Received: from crapouillou.net ([89.234.176.41]:47050 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbgHTMNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597925582; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=fVj37TIG+mvs7lftpVXU13Q2HOoYZx+9DhCxLihuqvk=;
        b=t5eSugjJtimK8UxX9PPKhP8StyA8sWuspF56PdTYS/PHVZyzzhQk+gvYt4UW6rMfm76mMy
        zwm971CP9BE+LS6Y8dgwSS0umu4TwFKt9Fj5h7owDW6/CPBSN78twzl+lVNX1u3szGDBvV
        OpAo74M0rVPa5CE/0WSMVumKxYQ+aZc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/2] NT39016 cleanup
Date:   Thu, 20 Aug 2020 14:12:54 +0200
Message-Id: <20200820121256.32037-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few cleanups to the Novatek NT39016 panel driver:

- Reorder function calls in probe, so that drm_panel_of_backlight() is
  called after drm_panel_init(), as requested by the function's
  documentation;
- Use the 'dev' field inside the drm_panel structure, instead of using a
  separate field in the driver's private structure.

Cheers,
-Paul

Paul Cercueil (2):
  drm/panel: novatek,nt39016: Reorder calls in probe
  drm/panel: novatek,nt39016: Remove 'dev' field in priv struct

 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.28.0

