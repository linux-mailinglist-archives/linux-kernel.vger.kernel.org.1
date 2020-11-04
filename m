Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F72A6E13
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgKDTge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbgKDTgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:31 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328DFC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:30 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so2556600wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+W+IzJVlcwSw8IRMXBzJb1dzB3GDzrAyqgcs95IwTfA=;
        b=VxWQRFEV0vC/Lf0jlmwNBvW8/0FLvKwzZEu+uH7X7FkNBGaGg76oETtihBzGB6HVq2
         XK4SJALNsE0+8RJw6V9q4QjSsOGtnVDGq3e8I8p/X/R5VgutNA7Q50JpK+MLy1su0nFL
         WNHLL9q3oM3G68w/0/99xDzA24KWCw0JLP3sZb20mex9BpL1V3jUrsoCzosgJPpAH7t9
         MAyfOM2MiBBC5vKlcUH05ngWxEKclBvMkAmwYQ15XI360iUMoZeNQTaLWxLFJvKsuOyC
         3nE9SEcMceJi5iN9U9n45tzdaucar/krRG6kuL23V8brq8Q3XZqLmK1ix+SV4gvPnj9U
         llRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+W+IzJVlcwSw8IRMXBzJb1dzB3GDzrAyqgcs95IwTfA=;
        b=WXE/EwWco1lYDzVXoJ3xQgcszZMBedkcx4RgWurfuCHKRts8wEB7Swq9MWx42tsTVP
         ty5pYgJFzJPxAedzgQtlKV5/IXcTjevwiCqKVYitO62qLyEJiRJzoFetZ4wxWu0/kfvz
         rrgHUGIQKNhW01xoQtX64DwPsxhLgtEedvWwAYqS2V0FRzKa3qwfdooQA4AH8SY+FqQU
         dPZkOwuKY+pl4Bl961EY0kufjM/D8U9qjTykBhLxaKkvA2vOd20Q3Aj+dHg26Gvlr/12
         KuDVql2j0XEHOxaYVswGRX/vP4diqW9WPzsx0ZVcfTRFgC7MDvviFksGq6bLVVO4rBV0
         RyjQ==
X-Gm-Message-State: AOAM530qZF1trRCXpEI+8IL4eEp00SAQSdkScy3BXLosYdAj5ueutTZa
        0OMk1TAQkDOs6DNVNpfVCqfnJg==
X-Google-Smtp-Source: ABdhPJzdsHB0gRKZUlixDWWHCwavM98eiP6QAn36+VXXgHdWKN98UOhPp3e0gizULhrigHzF6tsHyA==
X-Received: by 2002:a1c:81d7:: with SMTP id c206mr6119967wmd.140.1604518588914;
        Wed, 04 Nov 2020 11:36:28 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Filip Aben <f.aben@option.com>,
        Joseph Barrow <d.barow@option.com>,
        Jan Dumon <j.dumon@option.com>,
        Russ Gorby <russ.gorby@intel.com>, linux-serial@vger.kernel.org
Subject: [PATCH 21/36] tty: serial: ifx6x60: Fix function documentation headers
Date:   Wed,  4 Nov 2020 19:35:34 +0000
Message-Id: <20201104193549.4026187-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/ifx6x60.c:553: warning: Function parameter or member 'tty' not described in 'ifx_port_activate'
 drivers/tty/serial/ifx6x60.c:728: warning: Function parameter or member 't' not described in 'ifx_spi_io'
 drivers/tty/serial/ifx6x60.c:728: warning: Excess function parameter 'data' description in 'ifx_spi_io'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Filip Aben <f.aben@option.com>
Cc: Joseph Barrow <d.barow@option.com>
Cc: Jan Dumon <j.dumon@option.com>
Cc: Russ Gorby <russ.gorby@intel.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/serial/ifx6x60.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 21d519c804cb9..182e0ccd60b2c 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -545,6 +545,7 @@ static void ifx_spi_hangup(struct tty_struct *tty)
 /**
  *	ifx_port_activate
  *	@port: our tty port
+ *	@tty: our tty device
  *
  *	tty port activate method - called for first open. Serialized
  *	with hangup and shutdown by the tty layer.
@@ -719,7 +720,7 @@ static void ifx_spi_complete(void *ctx)
 
 /**
  *	ifx_spio_io		-	I/O tasklet
- *	@data: our SPI device
+ *	@t: tasklet construct used to fetch the SPI device
  *
  *	Queue data for transmission if possible and then kick off the
  *	transfer.
-- 
2.25.1

