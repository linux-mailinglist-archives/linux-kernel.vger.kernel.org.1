Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB112A6E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbgKDTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730524AbgKDTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BBAC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:14 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so23340247wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tU1mUc4W5Lzy2WY9cL2mEm8m85V8Ux3xTQGFy/e/dKU=;
        b=m0CSfPJtvCG6yqYBusiM7REUUMdj5ssB2WfDe5irz/FfpUzbCxmQTAx7J3pYH/Xf6G
         zlKccO5dx4k3ucnV/UDMmdb/knh0hgH3IEiuD3uweglCeSCzL1HH1vE/qbCScp74k/vf
         rnc8LUCTizSwGFL2CUZElMlqA9QORzemZDXk4YSx7F0UAb62xSrhqIlGA0z+tr+NlRos
         bZmEno93PfsxgndnXyvvla76giYhv5JuquKidlqqj95cDwCGgGsUFBlJB0fcfq4XN7pC
         +y3e81ojD5v6wLd83TmZD+rlMqgrP45u7kgyou39yrlnz4Axs5c6uqWebnKwfQtJaYK+
         VYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tU1mUc4W5Lzy2WY9cL2mEm8m85V8Ux3xTQGFy/e/dKU=;
        b=aodab2vCpS0RajzVhWTGrgxVC2EdRNviAYZikRLW6VtccS1SCAbNRkK4EIkAptUJn6
         FKY2X6uDIbudPOAT/EkneSYsS6SgNv8WHX5tiZc3MOqLGDFVZXZx7/HwYWEJsk8n5Luc
         1m0lWB877NHGW+3n/wXKmde6o/mWEtlkoajAQbIJufJ0QAHnm58E5gB7RJgWyiArrjBP
         rgi23DBzeITgT5ZwIuFBWi26XZKw4aI9gGeuaSWSDGSlKl/DkEsMtpNvZJtUAKTzeDTI
         etx6pk4/TqaM17mc3XdouemeHLX7jv+HBC3y2Eq54eEi+niG+grs7iJfXvI3bWKBdENt
         RsXg==
X-Gm-Message-State: AOAM531SuH5ey1EXQOcyP3gpHLZLZmLnY7+8u1Nvv2at9UaOCPI9Vkik
        5dY/kO7U5VwBT2LLjcAKrvOkTw==
X-Google-Smtp-Source: ABdhPJxCiy/2tCu3X8ltb8i82Ja7gKVNmLhTQfCrZWJS+RnJWiNlaSIKalE2qhtiBYk4+OO+nGIuUw==
X-Received: by 2002:adf:e681:: with SMTP id r1mr32889770wrm.181.1604518573581;
        Wed, 04 Nov 2020 11:36:13 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        processes-Sapan Bhatia <sapan@corewars.org>
Subject: [PATCH 10/36] tty: n_tty: Add 2 missing parameter descriptions
Date:   Wed,  4 Nov 2020 19:35:23 +0000
Message-Id: <20201104193549.4026187-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/n_tty.c:405: warning: Function parameter or member 'tty' not described in 'is_continuation'
 drivers/tty/n_tty.c:1701: warning: Function parameter or member 'flow' not described in 'n_tty_receive_buf_common'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
Cc: processes-Sapan Bhatia <sapan@corewars.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/n_tty.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 7e5e363152607..319d68c8a5df3 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -396,6 +396,7 @@ static inline int is_utf8_continuation(unsigned char c)
 /**
  *	is_continuation		-	multibyte check
  *	@c: byte to check
+ *	@tty: terminal device
  *
  *	Returns true if the utf8 character 'c' is a multibyte continuation
  *	character and the terminal is in unicode mode.
@@ -1668,6 +1669,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  *	@cp: input chars
  *	@fp: flags for each char (if NULL, all chars are TTY_NORMAL)
  *	@count: number of input chars in @cp
+ *	@flow: enable flow control
  *
  *	Called by the terminal driver when a block of characters has
  *	been received. This function must be called from soft contexts
-- 
2.25.1

