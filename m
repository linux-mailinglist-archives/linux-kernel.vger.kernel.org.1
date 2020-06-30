Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7587920EF05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgF3HKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 03:10:49 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:40977 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730600AbgF3HKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:10:48 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id DCD1A1F3FC;
        Tue, 30 Jun 2020 09:10:45 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Tue, 30 Jun 2020 09:10:45 +0200
Date:   Tue, 30 Jun 2020 09:10:45 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v1 2/6] console_struct.h: Two members for mouse report
Message-ID: <e8b89a24f746bcf311e3c4eade85e91efd5a8541.1593499846.git.tammo.block@gmail.com>
References: <cover.1593499846.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593499846.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need two values to store the status of mouse reporting, both need at
least two (vc_protocol_mouse) or three (vc_report_mouse) bits, so use
chars.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 include/linux/console_struct.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 153734816b49..dd42287ed553 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -132,6 +132,8 @@ struct vc_data {
 	struct pid 	*vt_pid;
 	int		vt_newvt;
 	wait_queue_head_t paste_wait;
+	unsigned char	vc_report_mouse;	/* Which events to report to userspace */
+	unsigned char	vc_protocol_mouse;	/* What protocol to use for report */
 	/* mode flags */
 	unsigned int	vc_disp_ctrl	: 1;	/* Display chars < 32? */
 	unsigned int	vc_toggle_meta	: 1;	/* Toggle high bit? */
@@ -144,7 +146,6 @@ struct vc_data {
 	unsigned int	vc_priv		: 3;
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
-	unsigned int	vc_report_mouse : 2;
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
 		 int	vc_utf_char;
-- 
2.27.0

