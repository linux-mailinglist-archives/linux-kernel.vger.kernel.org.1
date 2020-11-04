Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30C2A6E37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgKDTh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbgKDTg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5849C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so3419119wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVONQyKASNJVxWgtOx5GH0AkmLYPVTFM927HFJJjccw=;
        b=NdJzMXtVxWJ7nasQqbcbanX2Q2xhkyvXALxvm+9BXvtqzMTJNNCWUbf1829oYNXnH6
         VQjCV3I8zR1CoACqnbxylgYGl7bVTZkOkUCgKV2cnf3PIlnD8vka1xLBzHRhyxbpRyfb
         FvGUlWGwGlzExz3ryNhc/ocJZMi82Fuj2r50wMc/9SCISwewsS3sD9aF2fm+71h+BZuV
         WcwNxezJKg6fE1+/gs2ocwX/HE49xYen6jBa3jPhu6dOWDk6nIh1GzJQWjw1Q7qAc8wz
         Xan592RZeuXmLnnC2EMnrkX93dlRYL+tVESz0s7sxlIGoLxPtGZv2QiQBpLd0YOqIJ7q
         dr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVONQyKASNJVxWgtOx5GH0AkmLYPVTFM927HFJJjccw=;
        b=ZcQ9fVSTD/hrPNVCbZ4jFskbJpktyxavD6obV9oB7sM2qe/a1fIKL1Q6GZhgmg6N1N
         I4qGa1B1xAxCfvpbI2uz0Gk76syG+ji856pokj4jZyQScbbEo0FN7svhCbnGXz8zIR8e
         xqK+p0VqJCNJajqEWo5Un6WQl4W+E+oXk4RgZAsgEQmjPDZ84HL9b4SQgO6yHp/Wda0Y
         TB7YS3NfXNKMYGBuBFr/9h4kP/sHfi3jqN253/eZjVb/+AYS/HmszpXgPbHYz/UkjMp1
         MzXIf3c0TDQCQ0ZQS47gGF6QEmZygBliprXbAUJkhMnwMUz6Gxx7qbGMMH5heobEs/hK
         989g==
X-Gm-Message-State: AOAM5332JVyX6AOgG7f0ZzMCNkuJ3Gyb2dpRVhnnqXeeVAc0SukmtHc6
        In/viZqOLUByR5hVDEwM3+3O/w==
X-Google-Smtp-Source: ABdhPJwLMbtcZCiUhn4VouoqB9oq1lDWIUPlvvC3IAreliq3b9V+qdC/nt/71l5H8R5goESLlrYevQ==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr6141976wma.126.1604518584375;
        Wed, 04 Nov 2020 11:36:24 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:23 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 18/36] tty: n_gsm: Demote obvious abuse of kernel-doc and supply other missing docss
Date:   Wed,  4 Nov 2020 19:35:31 +0000
Message-Id: <20201104193549.4026187-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/n_gsm.c:85: warning: Function parameter or member 'ref' not described in 'gsm_mux_net'
 drivers/tty/n_gsm.c:85: warning: Function parameter or member 'dlci' not described in 'gsm_mux_net'
 drivers/tty/n_gsm.c:664: warning: Function parameter or member 'dlci' not described in 'gsm_data_kick'
 drivers/tty/n_gsm.c:1015: warning: Function parameter or member 'clen' not described in 'gsm_process_modem'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 25f3152089c2a..c676fa89ee0b6 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -74,7 +74,7 @@ module_param(debug, int, 0600);
 #define MAX_MTU 1500
 #define	GSM_NET_TX_TIMEOUT (HZ*10)
 
-/**
+/*
  *	struct gsm_mux_net	-	network interface
  *
  *	Created when net interface is initialized.
@@ -651,6 +651,7 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 /**
  *	gsm_data_kick		-	poke the queue
  *	@gsm: GSM Mux
+ *	@dlci: DLCI sending the data
  *
  *	The tty device has called us to indicate that room has appeared in
  *	the transmit queue. Ram more data into the pipe if we have any
@@ -1005,6 +1006,7 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
  *	@tty: virtual tty bound to the DLCI
  *	@dlci: DLCI to affect
  *	@modem: modem bits (full EA)
+ *	@clen: command length
  *
  *	Used when a modem control message or line state inline in adaption
  *	layer 2 is processed. Sort out the local modem state and throttles
-- 
2.25.1

