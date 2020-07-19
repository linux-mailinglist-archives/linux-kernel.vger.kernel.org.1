Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B57224E60
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGSA30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSA30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:29:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE02C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=h6N9U27WTTY2VWKxLUuc/INMzq48sOwdvmkrHLir0Gw=; b=uOSnXYQQUGbm3v1N/NHmwR8PKn
        h/DNkh6HK58Bzg7zf8VxnJBlJSB8iz6VavMQHPn4+A7vCUXFudOuGUBi1oDBww8N2XYmJq537LUFS
        RlVglBGRIKc56DVKHTx1ZaoWzmZ8xX0MbRs5aU7xmhMj3Bix9aSLA3qtjPYpw4X7aT21baSYLVfR2
        uvjF8h5XNPleNF6IFsAhgLYu8pg5yB1QPUvWI2xQqABp8XaR4boT1SG1k+7/gej8L9YDpgTVxSfUc
        0tDFRNpO1sYp8/d13ELiP9a5RvfqWPJdkzA3CZ/Sw3yPOLxLSMB7VRiRQIIq3T//oROGgH44+Wmz9
        C3JPPXRw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxCj-0002k0-GB; Sun, 19 Jul 2020 00:29:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] MFD: da9055/pdata.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:29:17 -0700
Message-Id: <20200719002917.20521-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "that" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/da9055/pdata.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/mfd/da9055/pdata.h
+++ linux-next-20200717/include/linux/mfd/da9055/pdata.h
@@ -35,7 +35,7 @@ struct da9055_pdata {
 	int *gpio_rsel;
 	/*
 	 * Regulator mode control bits value (GPI offset) that
-	 * that controls the regulator state, 0 if not available.
+	 * controls the regulator state, 0 if not available.
 	 */
 	enum gpio_select *reg_ren;
 	/*
