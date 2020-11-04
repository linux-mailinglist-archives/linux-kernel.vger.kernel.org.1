Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0362A6E06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgKDTgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgKDTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:02 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA54C061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:02 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c18so3510896wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdvKCUKq0nojtCMM0KGT5aJAZNDW8NuYQSO90sv71Uc=;
        b=wCoMoeCFqY5xu2QfY9z+bw7Fb0rt4bPqAm9TgvJfuztLnk3LS2eB4RBQN8IKGJQHeo
         QIxK4cM+2rXVVq5RY8y9PiSnGkmIjNG/xerHzh4P+oZUcldSLI7zV1kMAX5/TPaBfV+5
         z5LN5rnxwkGKXtvHUAeLXET8FYURlnu/B5VLU/6/H3oYm9PuQx5XpKSWCXOzm0xkMR7S
         HAsZm+K3U808leuckF38vTXdCGZC7VBMbQxxunr9lHtwEZH5kfEf25WCwQIudiLeIPHT
         H8R6bwVHk/Pu5ybw7dwFPnEUeEDwDDbc78qJybX+BrAQGW7ZLwgOezXVhWrGbjNA2B9i
         p5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdvKCUKq0nojtCMM0KGT5aJAZNDW8NuYQSO90sv71Uc=;
        b=inO3NMKYaMtQ882MspdCFxujuxLWw+NBaxzWDoT9ZlC8qtLh9zqIlKO63LCweYf4GE
         g+B8ln7W6Piu1ruWmNDupMT+Qks6U6bzsfykJxk3R8KNLGGRIRTlbIwajI6LCHnHmwSp
         lvqTwIy+cAD+9IpVY88APauBrJB3qdJadN7+ppZjqzH85/JeAZ/qPrZMnZFM0zyN68iu
         aPusqopTz7twpzMvBZ+o1qyij8vUdiaEhQKOeueQ7mzF1CP5DxC55EZ8eDGyWPBiZNBD
         6xY8akNYRpM/Hv7wvBr01vjehc031OyLrW9uj72ecXrBnLfXrA0sl+qXm4kRTu5FFqQo
         Fk+w==
X-Gm-Message-State: AOAM530IfXaS58N8E/OvhbcPlOgmz1z6k7jSZalsxwzh4Iv8G05vKnoc
        Uj9Zm2T3lbAoDuYHosGxInKJUw==
X-Google-Smtp-Source: ABdhPJwx7kUiYY8L5I9M732KlsD1JyaCYlJzpq20HsGlssz7jN+MlqlZZRjSrqsABpXKAFnWarXOWg==
X-Received: by 2002:a1c:490b:: with SMTP id w11mr6237078wma.101.1604518561307;
        Wed, 04 Nov 2020 11:36:01 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 03/36] tty: tty_baudrate: Add missing description for 'tty'
Date:   Wed,  4 Nov 2020 19:35:16 +0000
Message-Id: <20201104193549.4026187-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/tty_baudrate.c:234: warning: Function parameter or member 'tty' not described in 'tty_encode_baud_rate'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/tty_baudrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 84fec3c62d6a4..6551b188b736b 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -222,6 +222,7 @@ EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
 
 /**
  *	tty_encode_baud_rate		-	set baud rate of the tty
+ *	@tty:   terminal device
  *	@ibaud: input baud rate
  *	@obaud: output baud rate
  *
-- 
2.25.1

