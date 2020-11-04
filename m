Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389972A6E24
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgKDThK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbgKDTgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:47 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8FC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:47 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so2546150wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxBTDWs68qW2IKMyEc77XRI2Jnwwebqtmwz2IV/xXfE=;
        b=lBGC22hrQ40oIvqXRErxf0OYpYRByN+EoViOk/xvc/ZcFLq19660h8+8xXVsiu9vud
         +/CliTSp2aP8RZ+UvcpoXEY5DopYhvMr2BCPDjYw9pF6/ehngNnezDgWTPiCaGK105bv
         rGlbQkZVvkB7ujPAREYsSgjeYk7omOrHtr6mftUmSAYQJB/i6OIRHZrNiqGPB4gh90R/
         XGzS0cShqv30RMA3wQJeeugIKOe1F+nhFGAb9p2Y71kCD+yk/jpQ2LBCMLqnPxSeihKH
         RtOfR3/LIkVTYtur3KydW9GjMbmy6l46Tl6UvV4MTu+bj0+tVtHSsLhjGvQu/OOhLgGx
         fFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxBTDWs68qW2IKMyEc77XRI2Jnwwebqtmwz2IV/xXfE=;
        b=WV5Yffu58n2qpHbPVdxkCkAXoFgdOL/cJChUhKym7qSM0/QryYPoTg5NVtTxozjoz2
         ZAvixVIhcPaZCjKE9/GED2VafXx18UU+34pZMPwsm/KvkNg2eGfkXtHgEEu9i1uTtTMH
         mIovSsKbbIBRuBlsWWVZSdHduXi1TPn0l9j2ul8t7D3yawyXDvSo8+lW2LHpAjs0mrMs
         dEPJ8MRPRwCSCYzwunXD2kY2i4PZ9DWPGKiwL5Ti+ml/G172ExAE/oBwSSCCWLZ9R94s
         ypdQa7E3T51VKD/J8nJ+o+b0CLdJvA5Hmq/zK871e6U/QgXBGw4lZDcAHamkHZHNEwuU
         qqTA==
X-Gm-Message-State: AOAM5319XJzPqSd4zT6yfp9ZEBZ5lM9QJPd2XB4TUYiQzvudqJvzugT3
        JQ1ZSAcbI/IMcF01P3wM8HJBeA==
X-Google-Smtp-Source: ABdhPJxXR1wM5qdy4HdVNYzdft1GlgyNDm7GFF04Vwdmpm24W7EfG3N0V4cq/CqyRxar/qGpno05eg==
X-Received: by 2002:a1c:1f91:: with SMTP id f139mr6057124wmf.187.1604518605931;
        Wed, 04 Nov 2020 11:36:45 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 32/36] tty: hvc: hvc_vio: Staticify function invoked only by reference
Date:   Wed,  4 Nov 2020 19:35:45 +0000
Message-Id: <20201104193549.4026187-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/hvc/hvc_vio.c:181:6: warning: no previous prototype for ‘hvterm_hvsi_hangup’ [-Wmissing-prototypes]
 181 | void hvterm_hvsi_hangup(struct hvc_struct *hp, int data)
 | ^~~~~~~~~~~~~~~~~~

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/hvc/hvc_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 7af54d6ed5b84..798f27f40cc2d 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -178,7 +178,7 @@ static void hvterm_hvsi_close(struct hvc_struct *hp, int data)
 	notifier_del_irq(hp, data);
 }
 
-void hvterm_hvsi_hangup(struct hvc_struct *hp, int data)
+static void hvterm_hvsi_hangup(struct hvc_struct *hp, int data)
 {
 	struct hvterm_priv *pv = hvterm_privs[hp->vtermno];
 
-- 
2.25.1

