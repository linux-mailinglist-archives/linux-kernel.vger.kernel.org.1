Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3782323E700
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 07:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgHGFTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 01:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGFTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:19:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 22:19:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u128so387840pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 22:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKoQxM83Uc+FXvx6t5Ymg1IK53B/gKt39Gp0pbNTE/w=;
        b=VyAVOpNiqddmfKMBU5li60da/RuApY8f29CHkpTimPilQ86j/gYbLdXJ1JoEKt6vpD
         d2y9EUvtPB6CzlyDFnlal3mfMmer+GsWBqAAIygnmP1BPWq0yKdn9T5KLNJws9XbR+VJ
         GgtQ18JNlytDCtEX7K8cs1KdMErJEwTQy/v1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKoQxM83Uc+FXvx6t5Ymg1IK53B/gKt39Gp0pbNTE/w=;
        b=dKZubFXHNi+D3dPpU+3rr97ZNlK3N3ZoJv2pROKV4ty6EgsaNPRude0muCSbZMqnBm
         7mMhpD5gykuF0rLk5F16c788csidWj3iyaBbZhQISkLxALwyk4q7V9wCxvyw+JheYOIN
         YHGhdoQ4AXqPhBUHrPj1Js9PG9TFgo5pQScs2mp900Qj5MI7rF9eYTqwecPT6/tMwxUL
         B/gRBD91UcFVpGpMJF8IgAhDfNBKzXwlaAby7INBYuyPSpVDj4qrjLEdJKD47/deIWAP
         bbRjBIWiHlC95BnL85hZIkUe7Wq3bfngN7TfQ80lDuGRrNLgeKRM8PewGt8UIU9ZZaqq
         0Gsw==
X-Gm-Message-State: AOAM531C9XxNfMpnBGlLMJVbrQ0dfMx5ZGwPg4Ykejn9LHqBgCSq3f1l
        zqri/QL7TUlZBsrpIYHwk9w5Hg==
X-Google-Smtp-Source: ABdhPJyip5WtaSgO5LZF/l7/MXW9QhJe3s0OYmfhC0kSr5YBXvM+tKuZ31k0S09mlDItrxz9IXrAAQ==
X-Received: by 2002:a65:4b85:: with SMTP id t5mr10043682pgq.36.1596777575437;
        Thu, 06 Aug 2020 22:19:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id r15sm11381147pfq.189.2020.08.06.22.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 22:19:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Akash Asthana <akashast@codeaurora.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: qcom_geni_serial: Fix recent kdb hang
Date:   Thu,  6 Aug 2020 22:19:08 -0700
Message-Id: <20200806221904.1.I4455ff86f0ef5281c2a0cd0a4712db614548a5ca@changeid>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e42d6c3ec0c7 ("serial: qcom_geni_serial: Make kgdb work
even if UART isn't console") worked pretty well and I've been doing a
lot of debugging with it.  However, recently I typed "dmesg" in kdb
and then held the space key down to scroll through the pagination.  My
device hung.  This was repeatable and I found that it was introduced
with the aforementioned commit.

It turns out that there are some strange boundary cases in geni where
in some weird situations it will signal RX_LAST but then will put 0 in
RX_LAST_BYTE.  This means that the entire last FIFO entry is valid.
This weird corner case is handled in qcom_geni_serial_handle_rx()
where you can see that we only honor RX_LAST_BYTE if RX_LAST is set
_and_ RX_LAST_BYTE is non-zero.  If either of these is not true we use
BYTES_PER_FIFO_WORD (4) for the size of the last FIFO word.

Let's fix kgdb.  While at it, also use the proper #define for 4.

Fixes: e42d6c3ec0c7 ("serial: qcom_geni_serial: Make kgdb work even if UART isn't console")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 07b7b6b05b8b..e27077656939 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -361,11 +361,16 @@ static int qcom_geni_serial_get_char(struct uart_port *uport)
 			return NO_POLL_CHAR;
 
 		if (word_cnt == 1 && (status & RX_LAST))
+			/*
+			 * NOTE: If RX_LAST_BYTE_VALID is 0 it needs to be
+			 * treated as if it was BYTES_PER_FIFO_WORD.
+			 */
 			private_data->poll_cached_bytes_cnt =
 				(status & RX_LAST_BYTE_VALID_MSK) >>
 				RX_LAST_BYTE_VALID_SHFT;
-		else
-			private_data->poll_cached_bytes_cnt = 4;
+
+		if (private_data->poll_cached_bytes_cnt == 0)
+			private_data->poll_cached_bytes_cnt = BYTES_PER_FIFO_WORD;
 
 		private_data->poll_cached_bytes =
 			readl(uport->membase + SE_GENI_RX_FIFOn);
-- 
2.28.0.236.gb10cc79966-goog

