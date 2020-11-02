Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E3D2A2949
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgKBLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgKBLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:45 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66717C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id i16so8725465wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3cuHd2jEUylto64ny3My89MZqKNpm0uIQ6VIWr/6yc=;
        b=dnwc/0wcVwBYP3pEeQaNCoPL1Qzo0Oep6UPa2V7evv+cCkyMgSryELcMxMSWPupDD5
         NEGtO0y3TBTdq1EelpQn/cRj+lZXhBudOBeGyVz1Kd3AiETmflhUA1LNhvoIkDbHEpFW
         G9CZ/o5FGS+gx2UtgtoJWOwtBxJWnqMgmql/aM4SyXhMoTAYua2VA9SI70nkOPSv21DN
         R6sr6qTihcaw4XxI137BWr+lVQ2HXNITZ/Q/e18vfb8nH8XqdVcq4sQtftbyX6hflRB1
         iysFNqf5927Q16p321KS1SYsv/QhXotxvqEwbJwBRG+gQxlL7WQAmHrjLajjfwUeTClM
         mvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3cuHd2jEUylto64ny3My89MZqKNpm0uIQ6VIWr/6yc=;
        b=lLTTCAMqbtbwWWxW7k7/jFi8w7UjW/HREtPLHnGh03DHzjqX8jA7WhQgLKzSUv0NNX
         PdHPmecKW0vMLPfidYEBDgxuJ1usA/MLbkSGvFMe77sl2EIUu4THxGp9HAkfoj4uprqo
         nF2LVUbExw64dhZz4hlebiQzelCgthn6XLAXSTnuI6elE/RWvz1/4DDPHiJTYaZqEoYe
         JgPcHppjAyiveaJRl59Guk/taFSLs+W6TpXt7b0//YcItVIYBEikbMOlT/y5pE26+QZF
         h5LGCFz+mu5X773tDv3ggoVnMyb/WQ9uPjUbSmupgYMS8Vr+uqYxNsAkmxmevU6XeGbu
         0Tsg==
X-Gm-Message-State: AOAM530lPgBhfnyEPLLCtJVYgMVSUJ6HQys1nSXH3ar4guszT+aR1lf0
        mkffF/5LjIfmrSXW5/XcznnE/A==
X-Google-Smtp-Source: ABdhPJzDGo9ApX9ptXXbooXzR38IWoiQ+jaCDTlYA2S3+DJNXLpkNLICSrVsVYMycSfTV3hIikIlOw==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr18862767wrr.190.1604316284171;
        Mon, 02 Nov 2020 03:24:44 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
Subject: [PATCH 18/41] brcm80211: fweh: Add missing description for 'gfp'
Date:   Mon,  2 Nov 2020 11:23:47 +0000
Message-Id: <20201102112410.1049272-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:394: warning: Function parameter or member 'gfp' not described in 'brcmf_fweh_process_event'

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index 430d2cca98b33..bc3f4e4edcdf9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -384,6 +384,7 @@ int brcmf_fweh_activate_events(struct brcmf_if *ifp)
  * @drvr: driver information object.
  * @event_packet: event packet to process.
  * @packet_len: length of the packet
+ * @gfp: memory allocation flags.
  *
  * If the packet buffer contains a firmware event message it will
  * dispatch the event to a registered handler (using worker).
-- 
2.25.1

