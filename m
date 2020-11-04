Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6102A6E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgKDTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbgKDTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9711C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:40 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w1so23362662wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4M+x+ojOX9/j0b18l2nyNSsTW7aGEnj4NPBfBMnktmA=;
        b=eQRD92TcE8sbfMjX9CW3rHawxF8A0uvKnpoemHmQX4zwhDKACpuwZzch3j5/yy61W+
         30kDKwo06VOnTgfzpdaunqKZ4XX93HVT2xNyE4Ir3oE3heqtQp2WoasYQl9XNO4KwzBo
         WSSF1Bsx0hdqSgcqa3caySZIURrFp7+J3fU6JyBoGg/mhgVrrupUbMRTWr3FQvOYOxRt
         vnrZvyXVKvfcXeb7aVgCJSb8BbeShk4aWQ6K8LahM8LH5o/oRZrlSE0tpmOwUi1bDh9R
         lKAKncyS/Kg2kxVkhNee4o/lchfDGWnEV84vWfIpu3xj2renx8IUuEtRXauNU9Rp/FiM
         TIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4M+x+ojOX9/j0b18l2nyNSsTW7aGEnj4NPBfBMnktmA=;
        b=MM0HmUm5wCElV1WvV+IhaXP/yxVHlEVjkajuV8qO911MlrFdHb4s5zNPWK9mUkT+6Q
         P7p2tRcf0Ht3k1ZRTZ+98/BEUGDM8kEhq3tNxPZqxzYl8EBC3d2AGEv4cvvQ19gV8MBI
         vNCpL5+uDpGgvrD4snrU4PjVQ18TlA0AVEQzMywQcOicW5zzI1I3Mp5F0K2dS/N19Dg2
         HnTWS53ERDVbjORy2SRDy5tlb8mZPRCa1kfErMzOeKiptWqMj9+bfwKRdlvU2uhs8iUI
         o/W8Y7CUVDlGY8gCln8En1Q3zsLChQwKknNWpvrLBG9n/kzm8agKyFuR2Pv87v9hBJjA
         0PUQ==
X-Gm-Message-State: AOAM533GjJUXgZ+UZsUY+N/JJpGj8oLNwikAFvIjy7M8oZNMz2BtnkRF
        MlVsWV+o7o4NFBPIrBqT7Eb/5tNkH+zKBJ8R
X-Google-Smtp-Source: ABdhPJyMBafHtSHCRjGZ6+aEmuR9VQQygDBd92gwz8/dMPyopMsb23CtvVgzM8G01N5cp/79ike+Vg==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr33892322wro.197.1604518599514;
        Wed, 04 Nov 2020 11:36:39 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, paulkf@microgate.com
Subject: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as __always_unused
Date:   Wed,  4 Nov 2020 19:35:40 +0000
Message-Id: <20201104193549.4026187-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/synclinkmp.c: In function ‘init_adapter’:
 drivers/tty/synclinkmp.c:5167:6: warning: variable ‘readval’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: paulkf@microgate.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/synclinkmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 0ca738f61a35b..75f494bfdcbed 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -5165,7 +5165,7 @@ static bool init_adapter(SLMP_INFO *info)
 
 	/* Set BIT30 of Local Control Reg 0x50 to reset SCA */
 	volatile u32 *MiscCtrl = (u32 *)(info->lcr_base + 0x50);
-	u32 readval;
+	u32 __always_unused readval;
 
 	info->misc_ctrl_value |= BIT30;
 	*MiscCtrl = info->misc_ctrl_value;
-- 
2.25.1

