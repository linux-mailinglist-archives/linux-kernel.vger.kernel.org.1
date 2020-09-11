Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1578266597
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIKRIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIKPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:02:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F414C061363
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:01:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o68so7684325pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFJYLvWtKd0gWhl3s1dZJrARfNTei6xcNX2ZyXTTyO0=;
        b=IpnVtLgdVGxhyuhCaS3cPthT9iWbMsqXgb/fu9cWcyRQ9WBj7UKn73b4/hSmaDNGdT
         vbToscSU7CgC3GpktUaHD1tHLwWiHiumDKkD1k3t6SGJNRVP5UsQYkKbEqb1wCTOYpTj
         Sv++5PX7M5QblxUKx6v415lGt6T8zSYIy8yNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AFJYLvWtKd0gWhl3s1dZJrARfNTei6xcNX2ZyXTTyO0=;
        b=DwqjJ4iq8AGjsBR32JtBAybMZd8KbucVdZ8k6L/zfrYeSX1jNWofz1IwpnlSiBOFDo
         qIlAYGA8nrRXxwmuRJgyxdlAh097VnzPf1RnHqZgOfu+4Pvp82ce8/WsgPep4DWaFZUk
         tHweWyxbKi7GidbMlRlCpPUCWC6OU14ppvsT/Jbn2R28tjrLiFa7ys0g4cw9Pxdq1x1C
         o4FeKj8BSrFUdewraUzJJ7NeTcc6dl2Glg4RvYWDlF8gsrejmhb1KdVf8v/4gf5SOc27
         6Q765wQEIANe26TQYbixNIhAwDGCRyHWfglXWwqWfN2uwK17tgSQh4/E9knRYWW+XGa2
         4uIA==
X-Gm-Message-State: AOAM531Y7cE7906FO3n5Rz7WTKfO7RyJ9RsdPamea4nHlyBxlpUaPhWt
        xCRmiGz7ZycQgy7+JyRw/MxArA==
X-Google-Smtp-Source: ABdhPJxR0SrJk8qEMtS/78b14//HJcWkWdb22wVtMM6VdsZAhtXPxe9ZkJhbyfNjy2GKsy5A3IFXxw==
X-Received: by 2002:a17:902:123:: with SMTP id 32mr2248956plb.143.1599836486326;
        Fri, 11 Sep 2020 08:01:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id v91sm2657228pjv.12.2020.09.11.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 08:01:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, robdclark@chromium.org,
        Akash Asthana <akashast@codeaurora.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        jwerner@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: qcom_geni_serial: 115.2 is a better console default than 9600
Date:   Fri, 11 Sep 2020 08:00:57 -0700
Message-Id: <20200911080054.1.I4c00b921c2f17b6988688046fa7be0f729f8d591@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c5cbc78acf69 ("tty: serial: qcom_geni_serial: Initialize baud
in qcom_geni_console_setup") fixed a bug by initting a variable that
was used in some cases without initialization.  However, the "default"
baud rate picked by that CL was probably not the best choice.  The
chances that anyone out there is trying to run a system with kernel
messages piped out over a 9600 baud serial port is just about nil.
Console messages are printed in a blocking manner.  At 9600 baud we
print about 1 character per millisecond which means that printing a
40-byte message to the console will take ~40 ms.  While it would
probably work, it's going to make boot _very_ slow and probably cause
the occasional timeout here and there in drivers (heck, even at 115200
console delays can wreck havoc).

This has already bit at least two people that I'm aware of that tried
to enable serial console by just adding "console=ttyMSM0" (instead of
"console=ttyMSM0,115200n8") to the command line, so it seems like it'd
be nice to fix.

Let's switch the default to 115200.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index f0b1b47c3abc..e390ffc8bbbd 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1107,7 +1107,7 @@ static int qcom_geni_console_setup(struct console *co, char *options)
 {
 	struct uart_port *uport;
 	struct qcom_geni_serial_port *port;
-	int baud = 9600;
+	int baud = 115200;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
-- 
2.28.0.618.gf4bc123cb7-goog

