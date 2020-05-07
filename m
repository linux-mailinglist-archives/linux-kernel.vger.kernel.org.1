Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7611C9EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 01:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEGXMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 19:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgEGXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:12:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B0EC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 16:12:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so3762097pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/3HPQN7W1ZKY/vF6kf3W74SkxKV+nge4or+WiAyuSA=;
        b=KDcfxey5JIeGwWZPE5JoJOlaG6N/dElrdB6K50KHlFNelrxKbvTlkPWInDHxs8alm/
         NX3IKCFYgAxWXCG9PdEvu9YXEAfEcE2Nze27cHGAKW5PPMDiXPcZsxWxOItkDTN0ekWq
         LYsQeiFSGwWQ73N+eS/xnETE2JkSx8/6CnM7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/3HPQN7W1ZKY/vF6kf3W74SkxKV+nge4or+WiAyuSA=;
        b=UJz7AJmPU0Nmvc2MvyCU3yd7SyWOoELc3R2D1kOYesJS5kjq1bgt4TpIvMA+i8ZhFm
         V8h3Uip/UF66mk7rv2C4bWCOVAutVlDezIl90CYTCb4n6fjMRgkC9UFy0rHjViiwLyXV
         ZQPwTlfkFu6gG2jhJx8HG5ORQe2CkpLp1KRPOJXEEDpCRGufC7k8iPKMmLv/1y/r/8W1
         apeSpNOSuWb8AcaiZr5E1AEyP9YUXSRJj2hEcYn1CQoXxHoeNqYWnJOZWuf4N9zdpxzi
         KKJFaNuJlVUB1ew1XuQSBNMAoxwDiNAPlJj+IqPWwERnrIwEPVYVpI0mjn17iV6LU9Kt
         foVw==
X-Gm-Message-State: AGi0PuYVqTpERviG8xd/dlaEmPspBi+8tGmrZkoyHLlJNIp627HZBNaG
        FRZSiNuK/7Tff4Q9LI0GHZTOtw==
X-Google-Smtp-Source: APiQypIkBJ7SdIhSa8KYeQISr03jagf7wOKIy319ImOEn53vTqQ6U/9cCflFav80DgkHzgPHRdd4JQ==
X-Received: by 2002:a62:ed14:: with SMTP id u20mr16651128pfh.69.1588893134874;
        Thu, 07 May 2020 16:12:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id w12sm5861057pfq.133.2020.05.07.16.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:12:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     sumit.garg@linaro.org, Douglas Anderson <dianders@chromium.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Cleanup math with KDB_CMD_HISTORY_COUNT
Date:   Thu,  7 May 2020 16:11:46 -0700
Message-Id: <20200507161125.1.I2cce9ac66e141230c3644b8174b6c15d4e769232@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From code inspection the math in handle_ctrl_cmd() looks super sketchy
because it subjects -1 from cmdptr and then does a "%
KDB_CMD_HISTORY_COUNT".  It turns out that this code works because
"cmdptr" is unsigned and KDB_CMD_HISTORY_COUNT is a nice power of 2.
Let's make this a little less sketchy.

This patch should be a no-op.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 515379cbf209..6865a0f58d38 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1108,7 +1108,8 @@ static int handle_ctrl_cmd(char *cmd)
 	switch (*cmd) {
 	case CTRL_P:
 		if (cmdptr != cmd_tail)
-			cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;
+			cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
+				 KDB_CMD_HISTORY_COUNT;
 		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
 		return 1;
 	case CTRL_N:
-- 
2.26.2.645.ge9eca65c58-goog

