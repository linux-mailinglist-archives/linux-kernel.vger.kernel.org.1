Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2B2F09B0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbhAJUUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:20:38 -0500
Received: from mailoutvs6.siol.net ([185.57.226.197]:50838 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbhAJUUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:20:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 828A55210C8;
        Sun, 10 Jan 2021 21:19:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NtujHtSMxWPr; Sun, 10 Jan 2021 21:19:55 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4919F520E9D;
        Sun, 10 Jan 2021 21:19:55 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 8F50B5210C8;
        Sun, 10 Jan 2021 21:19:52 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     jernej.skrabec@siol.net, irlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] drm/sun4i: de2/de3: CSC improvements
Date:   Sun, 10 Jan 2021 21:19:44 +0100
Message-Id: <20210110201947.3611649-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series reworks CSC handling to remove duplicated constants
(patch 1 and 2) and adds BT2020 encoding to DE3 (patch 3).

Please take a look.

Best regards,
Jernej

Jernej Skrabec (3):
  drm/sun4i: csc: Rework DE3 CSC macros
  drm/sun4i: de2/de3: Remove redundant CSC matrices
  drm/sun4i: Add support for BT2020 to DE3

 drivers/gpu/drm/sun4i/sun8i_csc.c      | 109 ++++++++++---------------
 drivers/gpu/drm/sun4i/sun8i_mixer.h    |   6 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c |   2 +
 3 files changed, 48 insertions(+), 69 deletions(-)

--=20
2.30.0

