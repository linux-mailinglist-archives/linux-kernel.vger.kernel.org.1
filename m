Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7905C22411F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgGQQ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGQQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B85C0619D7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so15943414wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5VMi11gyu7YagowBqZgb+iOtuPEVBAr50ImKPiNX6s=;
        b=nlLaOOQYdj6COawHywehL+uIslG8GGW7Zd+HR8CE/RBqDIxrYnRaXheKONmsk/d4z4
         1253X+HPxeJsfuyIVd2P1SxvASoQnF+ZjxdXfC5/g9ti2j2E8je61o06ktuvArxxQqJa
         yh919W9bswOHr1uURS4wbh2wOBiJAaL4nsHRFZfXSJH1ThZptLnYShcnAVhUvXEKk4xp
         SxTodoxyQtaFK7JN7tUzlLsMmDeIGuhoVSUbdJ7LmLjpC8Ccf/J2w43MEkmrYIIhZsZC
         HuoSVtXelnZqc9x+znqgll3nvr7TUE7ZK0S5MrDyp/FPGH7BFmtvBFv0JIXKlEjm39kX
         MdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5VMi11gyu7YagowBqZgb+iOtuPEVBAr50ImKPiNX6s=;
        b=lN9cvc0EDDh0xVPOtzA5W8gEOxlMnVSqnFnRDY663/inz1F2ltigFbKqPFsvIAHMP8
         FaG01rXi/c4Puj4uMV6sxpPny31E59Yx+uc4XPpgij4ppTURKmHJU/8yMMT9HWRB4mhk
         m+V1B4AWB5m6fNWLGFeLtoHfzPB3PWgI39qp+umVhm4NciAzmPA8BgRP3nIShA+mdr7y
         suh7CpudQuwyHE0F+sO0IqHyH/t0WD80hxunkLIdKjfmOiNSBLlpoaaiTYcylH5gMyVF
         +9r3rBTS5zrUvpJt/ue6Z6ipN2GmrTTfcAVA9kdBx55HI/P/NGRiwHdO12JSX15qZYsH
         OBNA==
X-Gm-Message-State: AOAM530T0SR39eUd0csYyjpH6BGpQr2LPMtIE3DPSF9DDe3ih+VrDS82
        v9uHqWjR+DGmLFH54CpVyygy9g==
X-Google-Smtp-Source: ABdhPJz/dnU1oVaIfi3DiolGTqevMFpFyFT/sUC0KZbrG5hWrZl4hIOPfOv6eihpEOTuuE/XSpLb7A==
X-Received: by 2002:a1c:a986:: with SMTP id s128mr10887191wme.121.1595004966324;
        Fri, 17 Jul 2020 09:56:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 07/30] iio: light: si1145: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Fri, 17 Jul 2020 17:55:15 +0100
Message-Id: <20200717165538.3275050-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here

Fixes the following W=1 kernel build warning(s):

 drivers/iio/light/si1145.c:192: warning: Function parameter or member 'data' not described in '__si1145_command_reset'
 drivers/iio/light/si1145.c:228: warning: Function parameter or member 'data' not described in 'si1145_command'
 drivers/iio/light/si1145.c:228: warning: Function parameter or member 'cmd' not described in 'si1145_command'
 drivers/iio/light/si1145.c:1186: warning: Function parameter or member 'trig' not described in 'si1145_trigger_set_state'
 drivers/iio/light/si1145.c:1186: warning: Function parameter or member 'state' not described in 'si1145_trigger_set_state'

Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/light/si1145.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 0476c2bc81384..37a6a59030929 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -181,7 +181,7 @@ struct si1145_data {
 	int meas_rate;
 };
 
-/**
+/*
  * __si1145_command_reset() - Send CMD_NOP and wait for response 0
  *
  * Does not modify data->rsp_seq
@@ -215,7 +215,7 @@ static int __si1145_command_reset(struct si1145_data *data)
 	}
 }
 
-/**
+/*
  * si1145_command() - Execute a command and poll the response register
  *
  * All conversion overflows are reported as -EOVERFLOW
@@ -1176,7 +1176,7 @@ static const struct iio_buffer_setup_ops si1145_buffer_setup_ops = {
 	.validate_scan_mask = si1145_validate_scan_mask,
 };
 
-/**
+/*
  * si1145_trigger_set_state() - Set trigger state
  *
  * When not using triggers interrupts are disabled and measurement rate is
-- 
2.25.1

