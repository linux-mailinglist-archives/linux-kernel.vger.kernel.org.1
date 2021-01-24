Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B0301F92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 00:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbhAXXXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 18:23:13 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:47184 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbhAXXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 18:22:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A3BDF180C83BB;
        Mon, 25 Jan 2021 00:21:03 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6D2F1lcsI7Qi; Mon, 25 Jan 2021 00:21:03 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IYOF_6MQpxn8; Mon, 25 Jan 2021 00:21:03 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     miklos@szeredi.hu
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        boris.brezillon@collabora.com, rminnich@google.com,
        sven@narfation.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, fuse-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 8/8] MAINTAINERS: Add entry for MUSE
Date:   Mon, 25 Jan 2021 00:20:07 +0100
Message-Id: <20210124232007.21639-9-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210124232007.21639-1-richard@nod.at>
References: <20210124232007.21639-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MUSE lives in fs/fuse/, make sure that linux-mtd@ is CC'ed
on patches such that MTD related aspects of changes can be reviewed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f79ec98bbb29..dabd9fd2e5e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12151,6 +12151,13 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/musb/
=20
+MUSE: MTD IN USERSPACE DRIVER
+M:	Richard Weinberger <richard@nod.at>
+L:	linux-mtd@lists.infradead.org
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/fuse/muse.c
+
 MXL301RF MEDIA DRIVER
 M:	Akihiro Tsukada <tskd08@gmail.com>
 L:	linux-media@vger.kernel.org
--=20
2.26.2

