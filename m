Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19352A6E09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgKDTgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgKDTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79019C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:13 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so2545278wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdlDuZxlieflLUlw5O6ewQ0F0d78ZenbIh62fAhvELg=;
        b=rw86CYT54kSh10X4JKc+Q3rHjo19IplcHBIG2iw8uFXEVnrmYKuHR1A0pIBIy4MM0d
         qpRNy6jEgxWsgGQPxYfryBxfHkic+3thVv5FfjE+k3YEwrReTFmbSlNMVaqov3zMb4Kb
         KXHRgERWwLEqpHpkSq3pOaMvhPjg4HMDHktYUEwKLJrH2zxdrR1ccGUGcFnT3+Us0ifu
         FtItGfBzlaBfqHYdxhOg3pOYMJE1CVp0hZ9DgqFp9/q9o706LR2XRyLV72NWS1fpMSYC
         gEbhXLojN5GHClD6hpZyjwFkfdvZktm45reTxeIqD9JWnHwP6EkPRCOoPAeSF7ihfYAv
         /yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdlDuZxlieflLUlw5O6ewQ0F0d78ZenbIh62fAhvELg=;
        b=JpA2mIlJVY4mOYtrYjdJ79f5vsMO4q4Lm+zmV9Hc32MP8iQ2h88JgeHSYCeP6DlhNj
         GyZdJyZKsRCRf0DWwwWw21Aps9FtlmIoJJ4l2HKkxJOZ6AafGpwRXlbM6ITjH5+oXjU7
         msubCHQbIyXzdbPqhHG3Gop6zxuh1nlgraKjmtZdE1R/wBGm+Pjt9VVaHt3jTreJk4XT
         aggyU3+yEg0Gh4p9rsFP82nowl2/nF+DZsMlRnRKQq23wjGehcu4ahrqH1pn+pwsE59F
         gU18PlzfwIzHJY0TD+2wF8+9p6x2YLoLTdIVA2KrO+DMt3OufkRdmNpmHB8Z50wNrctv
         aGpw==
X-Gm-Message-State: AOAM533oZ8I4KyBzZFmzCFZP/MXyyG8YgZJHvspJa9HTphcL63RbJ9o/
        lyrVCf9wycirttQv+eF8P3oTzQ==
X-Google-Smtp-Source: ABdhPJweWd+P/yRhz7yh788oFLTqlgYUinWcpB45a5gnfGEaN4cl9Sr2VT++ASJ2qMggOyII05Ox+A==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr6304890wmq.30.1604518572200;
        Wed, 04 Nov 2020 11:36:12 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jakub Jelinek <jj@ultra.linux.cz>,
        Stanislav Voronyi <stas@cnti.uanet.kharkov.ua>
Subject: [PATCH 09/36] tty: vt: consolemap: Demote weakly documented function header
Date:   Wed,  4 Nov 2020 19:35:22 +0000
Message-Id: <20201104193549.4026187-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/vt/consolemap.c:739: warning: Function parameter or member 'ct' not described in 'con_get_unimap'
 drivers/tty/vt/consolemap.c:739: warning: Function parameter or member 'uct' not described in 'con_get_unimap'
 drivers/tty/vt/consolemap.c:739: warning: Function parameter or member 'list' not described in 'con_get_unimap'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Jakub Jelinek <jj@ultra.linux.cz>
Cc: Stanislav Voronyi <stas@cnti.uanet.kharkov.ua>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/vt/consolemap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5d778c0aa0091..f7d015c67963d 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -728,9 +728,8 @@ int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 }
 EXPORT_SYMBOL(con_copy_unimap);
 
-/**
+/*
  *	con_get_unimap		-	get the unicode map
- *	@vc: the console to read from
  *
  *	Read the console unicode data for this console. Called from the ioctl
  *	handlers.
-- 
2.25.1

