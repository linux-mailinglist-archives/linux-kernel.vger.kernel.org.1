Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60F2D0BF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgLGIrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgLGIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:47:08 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE70C0613D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 00:46:27 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id a6so6464667qtw.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 00:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpdyYEoACj40I4ZoU6WJldnVBTLBOwlyVOBQr8T4Kew=;
        b=sch1nJmJjyLcCpem9TYTDXeAaeeWlxQkuXNCbmblSiPHOtE4NfUqUpcQnUFZJZ/HpD
         kL/Ga9mPGlkojKYjTEqnEERK9cyf+PEsooGLU7l3bY4GVxeLAkIWpKfxxdfd4IPDVvPI
         ngORmXaOooXuleNyvRfEdNDeaQ2NTWXpAAz993L8+48hCcI5XAZ70IGVk9SFkBzjuJis
         tQf/XfsducGWaylpomokcaJIEsvd/fbw8IePOXDgkJVXJHDTGYLC3JDcy1aB0W/e4ojL
         HIzTq5IxkToB1DS1OeQ+jVWpkmypQM85jA5t5IblJIXckHwpfyleUX1IfL4e/Ordiz7G
         PlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpdyYEoACj40I4ZoU6WJldnVBTLBOwlyVOBQr8T4Kew=;
        b=K0K9un4UZ1qJsGGgqd94o8S41L1DgON9LjUKegbI7MrBhKRlwUn1OzQzxEvJa46qxp
         ZqKRzBy3jHNf8fo/cyhsRtaj6E0kPudWt+yYvr4xU4gT59CK7ilkzxCwynGGu67Zos9R
         MwsgncK2eFsfdCGTfHbvysn6SNET5Nskvm7gxm5H0ifTsXspcvuNtkDhBULCx65G2NOC
         zAu/1LisHC4T2YMt18Kj+gNNHTnIWsMVsuR1WxqIz46RRrEwkkmqgqed+P73GY4SE69R
         XjU7gGcrxQNPF9/1u0nkTgLyTmQCO+YVQyBjDYhY/7h0ogvQb9YViahJu3EQlAfJWW+k
         huqg==
X-Gm-Message-State: AOAM531myEUaUR2KV0RkImMUZrgt8ZxjbH0ZyxGIcN4FzM90gseyIXHZ
        sh4YehMlragDLi61E9zwcBE=
X-Google-Smtp-Source: ABdhPJzAJgTIZ1mMj6CcgI4tmLpV4ibh78NNHIWaZzz07FiegjSWTPIUJtrRnvEA7wX0rH1+LEpqKg==
X-Received: by 2002:ac8:1c92:: with SMTP id f18mr10045859qtl.319.1607330787050;
        Mon, 07 Dec 2020 00:46:27 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id a9sm3424681qkk.39.2020.12.07.00.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 00:46:26 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ALSA: hda/ca0132 - Unmute surround when speaker output is selected.
Date:   Mon,  7 Dec 2020 03:46:15 -0500
Message-Id: <20201207084616.411531-3-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207084616.411531-1-conmanx360@gmail.com>
References: <20201207084616.411531-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure GPIO pin for surround channel mute is set to 0 when speaker
output is selected.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 793dc5d501a5..6d647d461eab 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1390,7 +1390,7 @@ static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
 		  .has_hda_gpio     = false,
 		  .mmio_gpio_count  = 3,
 		  .mmio_gpio_pin    = { 2, 3, 5 },
-		  .mmio_gpio_set    = { 1, 1, 0 },
+		  .mmio_gpio_set    = { 1, 0, 0 },
 		  .scp_cmds_count   = 0,
 		  .has_chipio_write = false,
 		},
-- 
2.25.1

