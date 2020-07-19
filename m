Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E29224E61
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGSA3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSA3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:29:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD69C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1NsKAmitnyxYMQTDcLS3ZnJZ99g+EXgRPE0e5uk8kJ8=; b=zxQ4yuCffsVqfabXQOf0Ec8mLx
        LMsGY5lhWbbuZRY+aXvKm4OUQC7HLDvVe0zJDGS59Jn8W8PvSC+41SWj9AZwtzXbP37nrBvFu42Bp
        mLZCZyc3NCR+oj7UognYMWWd9BSCxxL9651U0Gyq4UqYU6vwoBga3QpoOF0d8RVodJBZN6aPBeNBR
        engBuJd6Nfc7udi81ua90mLuPItJShoMolwyeCijR4sHHAr7nKT7htJSPxCmqAYCrfbBpQ6LHrzL9
        qmDxSNrYwtHpJQxgzv498aSBXM2o2SJ6VxPGxGt5eR1O8WogYhJOD9E1PhKHB21sGeJkDk7ZjtQ5y
        gUk9nlLQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxCy-0002kn-4L; Sun, 19 Jul 2020 00:29:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] MFD: max77693-private.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:29:31 -0700
Message-Id: <20200719002931.20571-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "in" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/max77693-private.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/mfd/max77693-private.h
+++ linux-next-20200717/include/linux/mfd/max77693-private.h
@@ -131,7 +131,7 @@ enum max77693_pmic_reg {
 #define FLASH_INT_FLED1_SHORT	BIT(3)
 #define FLASH_INT_OVER_CURRENT	BIT(4)
 
-/* Fast charge timer in in hours */
+/* Fast charge timer in hours */
 #define DEFAULT_FAST_CHARGE_TIMER		4
 /* microamps */
 #define DEFAULT_TOP_OFF_THRESHOLD_CURRENT	150000
