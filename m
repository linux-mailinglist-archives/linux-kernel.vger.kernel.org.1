Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E722C920E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgK3XHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgK3XHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:07:42 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98317C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:07:02 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id k3so13003054otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PnTztF+FlUgaAq9XkO60WUpJIEuULvqxGIpa85tZq+g=;
        b=lNKqiVQwINxybDuZ4rmetn+MIu9vFeEyutvPXJsg/GaBOseHK9yhfQJxpjOve9gIux
         g1Ki/1HV4uats4FwWKUJSPf9SVqTTMDQ0CLVRS0sk4ReaKu/kEcdjuGrgTrXHrPyuIm7
         ZYZiIlyC3Pp5s7BJjaXo7HBto/Uz3A7MwB9clz1BJgNqTUnxuTXjEv99A7+9v5ZIuvzF
         XdQ8CMUOHt/krqzzD174Wi142Yffb3Zfu5mjBknvTccq3rtEw4Wlv0/R4Y0NQMj/upP9
         Opft6MAj/i+kyZ0GSy8fCTac3BcLraRg2YRwTM6E2RRVG63PmjmAIMp/pEOvf/UlXS1S
         WzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PnTztF+FlUgaAq9XkO60WUpJIEuULvqxGIpa85tZq+g=;
        b=QKSbZdogqEzhdQEil7uSuf//7z5CDqD+1XGh982AVvCLhAaN5hK+QT3atlfhHtu0je
         B4dzMTTN7dmpLVBjBrAnXc5U2nkuXU3m0rE/iKP/gN6exAS89MkMHviNl/IWWzNEp2eg
         sRWBW+NiPT8Xv1D2UFe+1Cw71GzQtcpLybQkyqQUJ5eDwwE3N8cBWcRXIwQ1bgRVlNXJ
         UKpdG+Vk1ds0wtGAjfO3AbO0QAIkrJcakKpHcW97vvbyEUq3EZBtbsl25vfV1qPWqjWN
         nV2sWhxB7ZGUq2sbCc60qWc0upV4h6yOgYKFsJ3/IC2P2qAYdEjipcrC3X1h33cgcAar
         L/eg==
X-Gm-Message-State: AOAM532t8ImUtR8czv3uCqNsEuL+Ta4kcm2ISnQG2IJVh2P3zgP4yacE
        HrMnQ/pVp61wC4XaFazNPLpAhO2n0gFLTw==
X-Google-Smtp-Source: ABdhPJws/gtUXOZD6rXdMCGZWmI4EUNSaiby5xgEAJ84Ovoapa4Z4vDWb3OVgefYaCbQPnRVKSAIzA==
X-Received: by 2002:a9d:80e:: with SMTP id 14mr19136362oty.130.1606777621853;
        Mon, 30 Nov 2020 15:07:01 -0800 (PST)
Received: from linuxmint-midtower-pc ([135.26.31.16])
        by smtp.gmail.com with ESMTPSA id e47sm9538282ote.50.2020.11.30.15.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:07:00 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:06:59 -0600
From:   Travis Carter <traviscarter2@gmail.com>
To:     clabbe@baylibre.com, mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging:media:zoran: Fixed grammar issue
Message-ID: <20201130230659.GA10362@linuxmint-midtower-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed repeated word 'in'

Signed-off-by: Travis Carter <traviscarter2@gmail.com>
---
 drivers/staging/media/zoran/zoran_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index dfc60e2e9dd7..c77aa458b6d2 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -39,7 +39,7 @@ MODULE_PARM_DESC(card, "Card type");
 /*
  * The video mem address of the video card. The driver has a little database for some videocards
  * to determine it from there. If your video card is not in there you have either to give it to
- * the driver as a parameter or set in in a VIDIOCSFBUF ioctl
+ * the driver as a parameter or set in a VIDIOCSFBUF ioctl
  */
 
 static unsigned long vidmem;	/* default = 0 - Video memory base address */
-- 
2.17.1

