Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D4C2D9737
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406856AbgLNLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgLNLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:03:57 -0500
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 03:03:05 -0800 (PST)
Received: from cipterm0.informatik.uni-erlangen.de (cipterm0.cip.cs.fau.de [IPv6:2001:638:a000:4130:131:188:30:90])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id E4577240BAA;
        Mon, 14 Dec 2020 12:02:55 +0100 (CET)
Received: by cipterm0.informatik.uni-erlangen.de (Postfix, from userid 67858)
        id DE9123280146; Mon, 14 Dec 2020 12:02:54 +0100 (CET)
From:   Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>,
        ij72uhux@stud.informatik.uni-erlangen.de,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@i4.cs.fau.de, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, mchehab@kernel.org
Subject: [PATCH v2 08/12] media: atomisp: Delete braces
Date:   Mon, 14 Dec 2020 12:01:52 +0100
Message-Id: <20201214110156.6152-9-Philipp.Gerlesberger@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214110156.6152-1-Philipp.Gerlesberger@fau.de>
References: <20201214110156.6152-1-Philipp.Gerlesberger@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING:BRACES: braces {} are not necessary for single statement blocks

Co-developed-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Andrey Khlopkov <ij72uhux@stud.informatik.uni-erlangen.de>
Signed-off-by: Philipp Gerlesberger <Philipp.Gerlesberger@fau.de>
---
 drivers/staging/media/atomisp/pci/runtime/timer/src/timer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/timer/src/timer.c b/drivers/staging/media/atomisp/pci/runtime/timer/src/timer.c
index 00b54a0613bb..08f5c3ea6d29 100644
--- a/drivers/staging/media/atomisp/pci/runtime/timer/src/timer.c
+++ b/drivers/staging/media/atomisp/pci/runtime/timer/src/timer.c
@@ -23,9 +23,7 @@ int ia_css_timer_get_current_tick(struct ia_css_clock_tick *curr_ts)
 {
 	assert(curr_ts);
 	if (!curr_ts)
-	{
 		return -EINVAL;
-	}
 	curr_ts->ticks = (clock_value_t)gp_timer_read(GP_TIMER_SEL);
 	return 0;
 }
-- 
2.20.1

