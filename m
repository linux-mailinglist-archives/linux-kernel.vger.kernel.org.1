Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BA2A6E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgKDTiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgKDTgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:08 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86652C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so3440362wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdzVKDlkEX5ZFy/tDHbuv+1vE6lvBksI87KGQQrqJ6s=;
        b=rfHcH1DalpI+w5RwAiF4aeupO6Gs0uuRh6Ww10t9jjblSWYJkjDh75PqB8RzwtqDSY
         luZfvZeqT/aD4KOtW+uTZ28ezZGEkpS4dWjAgaqTkwv7JujeKHjWSDy3oRewJyXP/vNQ
         KthEy+npJOX2bzjC0OeQPCEbHfVHdkCPPuWCDob28c8kbuS67koxMxrOAge21x8mJ0h+
         bL14aRNmt/1GC0HO3ggfTI2zGS8Gl5Rg5Yu2U7BupVOPsEqurTkPnK24b9YHbgsaPiqY
         Hcbjr18Wv7QX2I+y1qRHiuiBKH1l3N9g+wLAxE7qPeHbRWbQKE9vP1UJ1xyDKG4thRO+
         ixuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdzVKDlkEX5ZFy/tDHbuv+1vE6lvBksI87KGQQrqJ6s=;
        b=bVq12coxTR+/50jxTpXlD9TbLFbUshghFH/siQgSr/Dv8zjChf/RQwwf/4xp/DUKfK
         d8o0xjHMsRgakWPKHxJoPXTEZINaUZJOoGZRUCDpoP/O2HV8wMhfwI1cd2PrOlVI0tjf
         u4uNCFqGG4V9YAM+91O39Jb+/ohYQXknpJZ9H6ol69mw0ZJgIF7hCpzpfELAlQ/DyuJD
         5oS46Cj+EzTpibeLndF0oWfjEdpE23NUFGS7v8/zcJKXtXe7IgodPoUDkwkPAZ3EC9Rj
         bf+3Q2EbQJnLy0T6b29gTrFkQredqxZug+le0ewAUqgWGrOv1F3C7w3kWORxaHrIzsVD
         hfeg==
X-Gm-Message-State: AOAM533pb3nTlcB4qK53jjzBv+3ke/aRUjIskzB5Ti57O1eI6iXwRzKu
        Hsl4oX6sptZ0/KJ1NOmg1t2g3Q==
X-Google-Smtp-Source: ABdhPJzfTBCxPR0//Ct8KF8RO05qhRSTZhgkEDZJRWEHAyRLd7kpCxS5OcA7/mgIuuH1uccLV6uizg==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr6580980wmi.78.1604518564974;
        Wed, 04 Nov 2020 11:36:04 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 05/36] tty: tty_buffer: Add missing description for 'limit'
Date:   Wed,  4 Nov 2020 19:35:18 +0000
Message-Id: <20201104193549.4026187-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_buffer.c:592: warning: Function parameter or member 'limit' not described in 'tty_buffer_set_limit'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index bd2d91546e327..6d4995a5f3187 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -583,6 +583,7 @@ void tty_buffer_init(struct tty_port *port)
 /**
  *	tty_buffer_set_limit	-	change the tty buffer memory limit
  *	@port: tty port to change
+ *	@limit: memory limit to set
  *
  *	Change the tty buffer memory limit.
  *	Must be called before the other tty buffer functions are used.
-- 
2.25.1

