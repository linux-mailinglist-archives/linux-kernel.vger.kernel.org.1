Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626BB210ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgGAPNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:13:50 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37041 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731555AbgGAPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:13:49 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 22DF81F42D;
        Wed,  1 Jul 2020 17:13:47 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Wed, 01 Jul 2020 17:13:47 +0200
Date:   Wed, 1 Jul 2020 17:13:47 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 5/6] vt/vt: Add URXVT mouse reporting protocol
Message-ID: <149cd3c8dcb13405af00a54248c6e218cc588c0d.1593615440.git.tammo.block@gmail.com>
References: <cover.1593615440.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593615440.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URXVT protocol easy, all data analog to the old X10.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9aae3eac7989..33e43cbfa1fc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1861,6 +1861,9 @@ void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 			len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
 					mrx + 1, mry + 1, rel ? 'm' : 'M');
 			break;
+		case Mouse_URXVT:
+			len = sprintf(buf, "\033[%d;%d;%dM", butt + 32, mrx + 1, mry + 1);
+			break;
 		default:
 			len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
 					(char)('!' + mrx), (char)('!' + mry));
-- 
2.27.0

