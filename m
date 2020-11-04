Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B37C2A6979
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgKDQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbgKDQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:25:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB24C040203
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:24:58 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so2938417wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqV2KeQMP/jFy3p+xfQ20dH54ZYHRrmQaU4ia2enM0c=;
        b=TgpHBxydiK0xY7RBNvsdU9Yu+j5Ha0R/S+kR6gjh3E260ncOOfUtbuIQQj/zGA/fIs
         a6c9rBGWZAi3x1dKcHK9Tbg9ZrTA45/6eE/PfJTwxNRM8jWIzBvUqt0MEs9SgWke2w9Z
         Qf9ncIivi1Kn9I5VipWCLMyXFcYVBEmFNq/m1qiYpLu4MR3PjuBdObyOWZdNk8BE88mY
         Eq5HaISwXddNkG3Gyx/OT+xYWjqivnvpJY0n5uCVIKRRYlE8ylLREiW4uNUHxnZTnhr+
         mY0A+J/5780uburyheUsfTypAVqbyDVV9KOABCawsljanzyVoPJF7h/wyXMQE2w4CccC
         rkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqV2KeQMP/jFy3p+xfQ20dH54ZYHRrmQaU4ia2enM0c=;
        b=dK5a4UjVm2HENM8inSQR31wFNzbD/jtqGZJQsxzJ0rhJN9zZ3T5tHTEXICtZe+ZTYv
         /iY6sj3JBluDXoDtp1wuU0F1DP6+EiIvSB1wa1nw+cAOi4GShFlytR6CAl8T8ZSSIT0O
         /y0Ap5oBlEk6bkdLZp8lJFjg1B7pM3UlpC5ZtmLSik3fWz5d4ExJrXJxkfJZOQ8gV+s9
         e0dlZORYN98QXC+o1lfPh4P0al/0vKakMovNkBrr2I28xb4rBL/bayeuYZtu0YnLagnW
         ikpv09QGdsEFurEmBr/f0GeB7r26lQU6WDyw66AnXOL/IJow+ftZTuMGwQqiO/Aq3rzj
         3dpA==
X-Gm-Message-State: AOAM5326MEP2uFCEjOxNTmJ3HuLMXKVXTQwQMCh285MR4lgIPS/CqUw1
        sl4EZj4XK2bDRFMfef0m8XosuK1BdJhFL2sg
X-Google-Smtp-Source: ABdhPJw8fPHgbe9/qhRL11vvZZ1bNdDlY920DUkgfl4LgerotHnx/SYgDgtZu2uk1jR8JBUCEWkwjw==
X-Received: by 2002:a1c:9cc1:: with SMTP id f184mr5351092wme.5.1604507096858;
        Wed, 04 Nov 2020 08:24:56 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arjan Opmeer <arjan@opmeer.net>, linux-input@vger.kernel.org
Subject: [PATCH 12/20] input: mouse: elantech: Demote obvious abuse of kernel-doc header
Date:   Wed,  4 Nov 2020 16:24:19 +0000
Message-Id: <20201104162427.2984742-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/mouse/elantech.c:1837: warning: Function parameter or member 'psmouse' not described in 'elantech_setup_smbus'
 drivers/input/mouse/elantech.c:1837: warning: Function parameter or member 'info' not described in 'elantech_setup_smbus'
 drivers/input/mouse/elantech.c:1837: warning: Function parameter or member 'leave_breadcrumbs' not described in 'elantech_setup_smbus'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Arjan Opmeer <arjan@opmeer.net>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 90f8765f9efc8..47cd0e7f79bd1 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1827,7 +1827,7 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				  leave_breadcrumbs);
 }
 
-/**
+/*
  * elantech_setup_smbus - called once the PS/2 devices are enumerated
  * and decides to instantiate a SMBus InterTouch device.
  */
-- 
2.25.1

