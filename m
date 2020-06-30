Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB50C20EF10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 09:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgF3HLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 03:11:50 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:41032 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730653AbgF3HLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:11:50 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id CA8CC1F436;
        Tue, 30 Jun 2020 09:11:47 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Tue, 30 Jun 2020 09:11:47 +0200
Date:   Tue, 30 Jun 2020 09:11:47 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v1 5/6] vt/vt: Add URXVT mouse reporting protocol
Message-ID: <fffb6242f211f6d27e5eda940c76230702e18a60.1593499846.git.tammo.block@gmail.com>
References: <cover.1593499846.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593499846.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URXVT protocol easy, all data analog to the old X10.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 36520f7f0315..903c81c52887 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1855,7 +1855,9 @@ void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 		if ((butt & 227) == 3)
 			butt = (butt & 252) | last_button_pressed;
 		len = sprintf(buf, "\033[<%d;%d;%d%c", butt, mrx + 1, mry + 1, rel ? 'm' : 'M');
-	} else							/* X10 */
+	} else if (vc_cons[fg_console].d->vc_protocol_mouse == 2)	/* URXVT*/
+		len = sprintf(buf, "\033[%d;%d;%dM", butt + 32, mrx + 1, mry + 1);
+	else							/* X10 */
 		len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
 				(char)('!' + mrx), (char)('!' + mry));
 	respond_string(buf, len, tty->port);
-- 
2.27.0

