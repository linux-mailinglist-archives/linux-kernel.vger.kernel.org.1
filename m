Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6EB2A28FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgKBLYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgKBLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:26 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3A3C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:26 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n18so14132330wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2b8n7EMzvBy3k4mEAO2az4D8TS4174dppxeZhXUMuLk=;
        b=krJnLtc6N+2WBI9zVToa7VVhYxDgv43kZTu2i3mSv8ZTng2O4ydc8z9Sr/myiclZ53
         siYeQfgUBEFUge7+bwqSsiJ16l+BB2MBYw9N3+dhVgAOq/q7Fwak+X1rfticLy8rDLRV
         PBDb8oddR4Accl/4XmaO1d4uEiy4oidROTe0ikOwQxe3u4k6zub7hwpulDY62QaSHZdO
         MijeI/X6VFwss1zybgeqbVY9PxHD4/+C0hPVPl0mwyUqyOcsOW1xhBysZCNm39jb9Qnx
         qPH/KZ1rvk7ILqNyg/M3gVzvpi+nuMPXjT6ppTEnjv8geNO4od40Fw/Z4wqL2A3c7Ln/
         0BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2b8n7EMzvBy3k4mEAO2az4D8TS4174dppxeZhXUMuLk=;
        b=Gt5EiHIYrToo0NqucAWW4uA/YnqaAcA7WNKtMZXeus2bUaL2xyJJuQat/Y3Vw7g6LK
         N8szr81IYCcfzJ4JjTBqkYBCeocuxDAXyWU2PBnmIBVxPVnORYXexcF4KW3j/xaSCqD7
         0XG3MGQfDkIrClAd1aPOBS9en10NekTmsKKc2vHyWtFIDpwLQ1UWxAtWhXXWLfwSdn2n
         udXrCIK9ZwjHDzIl6aUPJCXjSHPxUPb/Zw3XYUOcr85+kod3rb5NlZ0fboMUhbyc0gjS
         WS3VNI3mqyQJu7AEzjMN8J433/GGfA1tO49D6B5GCC3Qqs1/HZtMEkW/6b4ALLjh8cpq
         zrUA==
X-Gm-Message-State: AOAM530h0tL1NlKW0xPG0PM1zTszk+dl2+6YGbBkqxs/yMHxFpk/C9pk
        0v2BwYQt3av2M4WLfYs4DdA/bQ==
X-Google-Smtp-Source: ABdhPJxdJ5ukETt1lUKOYKlpB7LAtUQfWZ5zkazKTiN1pjYEiL7xs962dlK8ZtSzPM1TeAFLDLlc9g==
X-Received: by 2002:a5d:44c8:: with SMTP id z8mr9705045wrr.405.1604316265225;
        Mon, 02 Nov 2020 03:24:25 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:24 -0800 (PST)
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
Subject: [PATCH 06/41] brcmfmac: bcmsdh: Fix description for function parameter 'pktlist'
Date:   Mon,  2 Nov 2020 11:23:35 +0000
Message-Id: <20201102112410.1049272-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:380: warning: Function parameter or member 'pktlist' not described in 'brcmf_sdiod_sglist_rw'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c:380: warning: Excess function parameter 'pkt' description in 'brcmf_sdiod_sglist_rw'

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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index f9ebb98b0e3c7..ce8c102df7b3e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -367,7 +367,7 @@ static int mmc_submit_one(struct mmc_data *md, struct mmc_request *mr,
  * @func: SDIO function
  * @write: direction flag
  * @addr: dongle memory address as source/destination
- * @pkt: skb pointer
+ * @pktlist: skb buffer head pointer
  *
  * This function takes the respbonsibility as the interface function to MMC
  * stack for block data access. It assumes that the skb passed down by the
-- 
2.25.1

