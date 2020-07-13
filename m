Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E221D8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgGMOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgGMOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30172C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so16857895wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJLr4motzozLLZVc3EnKW+yD22+TDxcp2fROtmtF5gQ=;
        b=ffV2wfG6IyKlQhh4ojP0OpROd3zfmjD+C4pYAmtbAXq4j6GZtxD6TiszNh4An3QJf4
         NGNnaeR2/2VYMJ9FaNC+c/5ryX9WLH9Daxd04bFGmdsF6Gpi6SATHGs2me2JKpYuWYKF
         jnrA8JdgGfS88n43twjaoFPHZnCPGX43M2tsyI4St6KayxdGzlrsm4uLUy0cawmjSvV7
         I/AJar4yTMVd9sY3JIzg69QyCnD4rMMG8Jx4cRw8zWBoGH54GmyiL+dHdLYO4fBpUWui
         0qKf43y9AOBFVB/rmDlCf+igCPxbIt4yycZ9jnoIblUJX5vVpVhTvQjXrbCUVPF+2CT+
         edxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJLr4motzozLLZVc3EnKW+yD22+TDxcp2fROtmtF5gQ=;
        b=LfxM/F4rwGgbi8oub00hM64LGP6vC0+3vocYEm1Acm/Sh5x2kqOfduiPfhb8TDPFxH
         uXMI0Mqahkk0aecN7c1NKW4JgehOD3TgFjJPcPFdAcoSUNutqhJsEMrG7153wTNlqdg/
         4khLjubm1B1AL7Lp5t55H9owGLGY1Bt/+r/QaZ4KdGj66wK80pOA7Cjry8Wf995ONr0H
         CfraYteuaxsk9wGp+K/rPJ2uGag6bgOkcowIIOw5g9dtdu7aRAJt9k30A03zAPlAbd53
         SJnWJxVx/zjHj2r/5WnLic0krusCRuC1fQRLGn0pE9Mxor+RJplXwvmjaKqGzg1J6pjL
         v1dw==
X-Gm-Message-State: AOAM533yXRI8oOAploGrZTvIpOhgq4dj3KeKRN5f+TrA6VFQ+0J4jZwE
        v60UlI37M4U27Q4zNjgyY4y6tw==
X-Google-Smtp-Source: ABdhPJyFbdFGX2jy7CgZX2JIh5a+6wH+BQCwffGTPYoRYHrgk7TjVwDNaORLzk1nL642HOjfdNBdpg==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr79223166wrr.230.1594651787968;
        Mon, 13 Jul 2020 07:49:47 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 14/25] pinctrl: pinconf-generic: Add function parameter description 'pctldev'
Date:   Mon, 13 Jul 2020 15:49:19 +0100
Message-Id: <20200713144930.1034632-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling/typo while we're here.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/pinconf-generic.c:242: warning: Function parameter or member 'pctldev' not described in 'pinconf_generic_parse_dt_config'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinconf-generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index dfef471201f60..1e225d5139888 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -231,9 +231,10 @@ static void parse_dt_cfg(struct device_node *np,
  * pinconf_generic_parse_dt_config()
  * parse the config properties into generic pinconfig values.
  * @np: node containing the pinconfig properties
+ * @pctldev: pincontrol device
  * @configs: array with nconfigs entries containing the generic pinconf values
  *           must be freed when no longer necessary.
- * @nconfigs: umber of configurations
+ * @nconfigs: number of configurations
  */
 int pinconf_generic_parse_dt_config(struct device_node *np,
 				    struct pinctrl_dev *pctldev,
-- 
2.25.1

