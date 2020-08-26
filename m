Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3C252A64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHZJip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgHZJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9770EC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so1066037wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4KvSoafFYDL3t+V7I3USug52YwDVapAvje6j/96TQI=;
        b=PKNmYYfm7KhX1X3aF0zxsjy6kJJLw8wKggaKS4op9K8gqpo9dM/4rcmvwrH3MDSwix
         0oAxkkftzAlBeaNp9Akj/VHuM34NtCusOiLzSTdv/8MNAu0IeXzIpOodLj5E+e3ayJN7
         WaiyidZNZVQeAGHn2SQQlxq+8puoEin4AI6rbVerRbL+e93PU86Q1EQDR7cMTmNRv6SS
         MWGQ7j1RiU1qLICEbZTYdtagogcM8Qdigl0LNk9toA2Lcl8jwwl4SFoh6vPRjl+9PmhJ
         1Zb/cTc3MquDK5AF4dUE36QmokwMjuZAWIlfMNa8ztmg5or2QmV1QB1bQeOxwSTbLM4s
         LOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4KvSoafFYDL3t+V7I3USug52YwDVapAvje6j/96TQI=;
        b=Icw+PAdDGo6LhpiSMkcDQKu4lPKhL2B9tmXufXuOeo1YkR0tCHY700YW2hriVbZY80
         2bxYgQo9oAK2POnrscXLv3iqI/cFEw09+VD54VvoGHTk9EciUcd67xay4NPDtn20Rs6B
         02jpveFMYvwWvnzCBOonxNI5gTv2MjKPlmXdOIirrhxkt1Nxbn8EsdJfkJjvvAxoYxtF
         1G87RsinGactaQqwW3R+icvbHuRW069crDkop3GHCuIEK0HGGicb7zq47fwtn/tqauqG
         K8BuWd6OalGmp+clB6rXKGcyCtOh+UFtQXWNfTwk7SsPpI0S7+0jjRvvcuABt57mgB0E
         QCJw==
X-Gm-Message-State: AOAM531Imu2VYS5AlaNjkB3vaabXT8dynwW8DTWfWBDhhphkFcRIAAz7
        1a+fLPda9uZgo1VdrGjEVu8hdA==
X-Google-Smtp-Source: ABdhPJyv3kF6WpEdqqe3i+tffnTY6lKO6zobwmr/asxTZWONqjhUiPvGfNrZYle6i0TT5oid3TPwng==
X-Received: by 2002:a1c:dd85:: with SMTP id u127mr6531092wmg.65.1598434460238;
        Wed, 26 Aug 2020 02:34:20 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 12/30] wireless: ath: wil6210: wmi: Correct misnamed function parameter 'ptr_'
Date:   Wed, 26 Aug 2020 10:33:43 +0100
Message-Id: <20200826093401.1458456-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
 drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 3a6ee85acf6c7..1439737bbb7b2 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -266,7 +266,7 @@ struct fw_map *wil_find_fw_mapping(const char *section)
 /**
  * Check address validity for WMI buffer; remap if needed
  * @wil: driver data
- * @ptr: internal (linker) fw/ucode address
+ * @ptr_: internal (linker) fw/ucode address
  * @size: if non zero, validate the block does not
  *  exceed the device memory (bar)
  *
-- 
2.25.1

