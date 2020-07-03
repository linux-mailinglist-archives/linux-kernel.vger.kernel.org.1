Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17170213EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGCRmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGCRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:42:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE627C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:42:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so34855985wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rg3aFGb8OfRKBHM94n8q4FN1ZasqFE+4EzVqNDg7yKc=;
        b=YxY130FyIPR9Gm07AHbGYOGYZ5uDSYNgEhKE/C8aNhqL0yl8qgwg6rJUkdr2CCU2YW
         AtopIVNMNXMk47KxDB72Sj9A0L+dPsHtfXJA12sLuN2SWhKv+LkgOVOmMbDdpCr2Br75
         OmCUEdF/2uQ58MLoN0jVA4nrwnOU7TVriTfuR2ggV0OueDEdCv0f27/TDEJKITw+vl2c
         X9eJHC4Z6ZZC594uHVV1hjOQpMWfai3gaKh2m+Map4HqjdepflZHEKdAbyCzC0gpr14j
         MBKxodujMzGU+ZAD48XZM8Gx6heyNRAfAjRvj9Z2FUJNpiG/EVBOcsd+KbZYw2BG6Rnw
         t5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rg3aFGb8OfRKBHM94n8q4FN1ZasqFE+4EzVqNDg7yKc=;
        b=g7TvKwtq9/6XgZJatafPifCb/U23qafDWEjVFDlIKMJvy1qs/A81x+YYRQ/dRJIFsz
         1WT9IjapdQ6NuRHaLkkvqoK2FgdqK+fQABir6wDQw9AFgj9j18o91q6xf6sRu1ayR+qw
         HH8nRmWThW0HtNLQRfpxGOE0dERbVycQHolt/lJHIXnRdjrmvPF8Qwahq9csSQCSd+a6
         7ibtGpH0sZjoJXdjjXljgudqTz9esSsDIRgeIeqWs+R1/vI1YDf62cav4gzGDfQ/f6Pa
         Jw+RUuI0Nsst1CGvoVcFLpAifaCha/r0xeV1UytMfaLmxPVV6Is0GEItZ1fOlQUNPTrs
         pkGg==
X-Gm-Message-State: AOAM531dTBTRCiy1sXpFQyUZy+KyitY+CXZqWNUIDY9oWYxaNXfCGDAN
        +HOgU7lijyKF9ksFG+v7YqrkkA==
X-Google-Smtp-Source: ABdhPJy+9vIk0iVFK825nCyPVCUC0qAi9muP8YyXvlu55JUrNIhVbPA9fpJn844SKSTCo2SOUdiiIg==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr39360654wmk.21.1593798127542;
        Fri, 03 Jul 2020 10:42:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:42:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        David Lopo <dlopo@chipidea.mips.com>
Subject: [PATCH 07/30] usb: chipidea: core: Document hw_port_test_set()'s missing 'ci' argument
Date:   Fri,  3 Jul 2020 18:41:25 +0100
Message-Id: <20200703174148.2749969-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/chipidea/core.c:163: warning: Function parameter or member 'ci' not described in 'hw_port_test_set'

Cc: Peter Chen <Peter.Chen@nxp.com>
Cc: David Lopo <dlopo@chipidea.mips.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/chipidea/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 9a7c53d09ab4f..1016596532a9e 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -155,6 +155,7 @@ u32 hw_read_intr_status(struct ci_hdrc *ci)
 
 /**
  * hw_port_test_set: writes port test mode (execute without interruption)
+ * @ci: the controller
  * @mode: new value
  *
  * This function returns an error code
-- 
2.25.1

