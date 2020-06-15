Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB21F907E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgFOHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 03:50:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:40054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbgFOHtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00CF0B03B;
        Mon, 15 Jun 2020 07:49:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 21/38] vt: simplify vc_attr handling in vc_con_write_normal
Date:   Mon, 15 Jun 2020 09:48:53 +0200
Message-Id: <20200615074910.19267-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert the attribute on the only place, without the need of checking
'inverse'.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d3cd256ba0fa..72ae8ede1ac9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2730,7 +2730,7 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		struct vc_draw_region *draw)
 {
 	int next_c;
-	unsigned char vc_attr;
+	unsigned char vc_attr = vc->vc_attr;
 	u16 himask = vc->vc_hi_font_mask, charmask = himask ? 0x1ff : 0xff;
 	u8 width = 1;
 	bool inverse = false;
@@ -2769,17 +2769,13 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 				tc = conv_uni_to_pc(vc, '?');
 				if (tc < 0)
 					tc = '?';
+
+				vc_attr = vc_invert_attr(vc);
+				con_flush(vc, draw);
 			}
 		}
 	}
 
-	if (!inverse) {
-		vc_attr = vc->vc_attr;
-	} else {
-		vc_attr = vc_invert_attr(vc);
-		con_flush(vc, draw);
-	}
-
 	next_c = c;
 	while (1) {
 		if (vc->vc_need_wrap || vc->vc_decim)
-- 
2.27.0

