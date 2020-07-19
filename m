Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B28224E5A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGSA2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSA2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:28:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB654C0619D2;
        Sat, 18 Jul 2020 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tZPxIcoas50l8hkBX0GX89mPgIztsXYb64qSQgpJmwQ=; b=rrXDFd0Z0cb/pfHFWRBtZ1Pcg9
        O+j48oso7dP+6yqS2q3srZmbJCA3g824nJ+uz4w2NyQMxwa+sP7j4F73DxPpKmIlh29myxTPQe9Yz
        DW1SjuCWSsLJLRw03AICQ6hns459tDqDFb8uu2X7A2xF+iHmOb8iakNf200lYPPPL5goolA08C1Ru
        C38nG7KIgV+PI1EP6BJVXcj3EarDpdGpTWrcoJO2YZqjnQo/rG4V5qCu1wSGGaZc/mMgBaPcrzGLN
        UQGBRoQzTaEtkki4q12MaVPJh70kGmZRnddLpMbpKDrPD6aEYV7EX6EsGUvXl6hwgSGJQSNErfHcV
        XqX5ADmw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxBy-0002h4-7A; Sun, 19 Jul 2020 00:28:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: <linux/clk-provider.h>: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:28:30 -0700
Message-Id: <20200719002830.20319-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "not" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
---
 include/linux/clk-provider.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/clk-provider.h
+++ linux-next-20200717/include/linux/clk-provider.h
@@ -189,7 +189,7 @@ struct clk_duty {
  *              and >= numerator) Return 0 on success, otherwise -EERROR.
  *
  * @init:	Perform platform-specific initialization magic.
- *		This is not not used by any of the basic clock types.
+ *		This is not used by any of the basic clock types.
  *		This callback exist for HW which needs to perform some
  *		initialisation magic for CCF to get an accurate view of the
  *		clock. It may also be used dynamic resource allocation is
