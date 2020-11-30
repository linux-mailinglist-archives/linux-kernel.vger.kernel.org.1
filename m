Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF32C8981
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgK3Q3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgK3Q3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:29:16 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7B0C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:28:36 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id o25so14784139oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0lbgp5okuFqa4v6AVBwCvjd204XDmam+ZlFn0h16Po=;
        b=yCdb+pxB79NwwSGe3bqjrEfTaIMl+S7UFAYclT70TXMXj1tPmWJLnr2QgsOZl5sBPH
         asZ38Yk50c6ZXYerptgEtyWFMFwh/e5qrIVnmlj4gL5X4SErYo8vjzT2QMziXku522Nl
         7ipU6KpcRIfiI1UwZ8l4lg8mo8dPWQNMfQjm7ohJkHQCDlpF6jmwy1DPbhKqlR6tR0+Q
         muWjYL30bWMu5IWmEAtEyWS5onvbiNSSeUiifU9qh91FKdnpzzwsZxnshlpp9G/TxQML
         WgL7MWL7wmcjAZE8duTdI9Bdg+bVrMF2e7s657X82iHThGng81H1aAg4fVpS+bV20DhX
         5X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0lbgp5okuFqa4v6AVBwCvjd204XDmam+ZlFn0h16Po=;
        b=PM7sHf3V5NNscwjSgSfoxzCPgVCEcrQSAPdiR9OlR4oYWXUNMjVCwbbNS80YUNdWjj
         DSiwKTHj4r+Il2VMGouwbs18MU7fSYjQnFLaAHuLTLI0naMnPftQ8HByu7xJJnSC8jbU
         UYbsqRXIRX9TWHPSlgkkbdixqtraSNm5WYP9nCWs0Rilmjwfq5uzWNTOKHvUOfyfXDnq
         3Vwb9vlftOgf9x/kjk3BuQAerdf05eeB557jLwN7gjKcJqjn7N2XabjVvuLIZIBRCMJq
         i9r5bRQ1a0+dOR+suGb8FJ959r5BzhtNxjfSWv0ZJGNqYNBX86cHU+qedZX+DLirxgDx
         m7kw==
X-Gm-Message-State: AOAM5306buUNz73mG7+FhDUice5uF4zgn4DqWAxA+Y1eW9JF8F4h/bCZ
        SazpS54bql0MoPVb8tOKlCRzyg==
X-Google-Smtp-Source: ABdhPJxSw9sP92TsSBqYlqaxDA1j+iOHEwsVmi/Z0qzRx3/1e5RDG541GqwZ4nIZAPUoZF1j6Bkv0A==
X-Received: by 2002:aca:72d3:: with SMTP id p202mr15194163oic.162.1606753716064;
        Mon, 30 Nov 2020 08:28:36 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e19sm1135678oou.42.2020.11.30.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:28:35 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable HID multitouch
Date:   Mon, 30 Nov 2020 10:28:34 -0600
Message-Id: <20201130162834.310282-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Yoga C630 relies on HID multitouch support for proper
touchpad operation, so enable this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e3ed05b655a..f4d0b3a61e41 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -737,6 +737,7 @@ CONFIG_SND_SOC_WM8904=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
+CONFIG_HID_MULTITOUCH=m
 CONFIG_I2C_HID=m
 CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
-- 
2.29.2

