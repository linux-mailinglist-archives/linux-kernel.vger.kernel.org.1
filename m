Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BFC2F814B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbhAOQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbhAOQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:56:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D617C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:55:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c5so9963335wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WFi24hS9BNe0YKy3AUzwISCsIab6xsbI/zt4Uj4n4M=;
        b=RGTAeXPwLoRI5axLLhf3PPE4LhQNT+hG/v0Fe9qCHoom3h1snDAkwXPWEZkWkFHCXA
         BGIX5l7irJT1sTHqfDuwF31F1M23Ox8hDOV04PlIopCgt5eryrj7HAlTTXJNTQhSyJJT
         BH00gVnEhBx1kBY/YMxD4HpPF4IyyqFzgFvSv3BlGSjZirDH25vdIe4uuwPhmUEGOwfp
         PzZhnrBdDTAjTt9AT7/5CUKnwmu7A232xqTxXIuwJB0Oo4Jgya7sZZgr5L7FSeZSfaTQ
         HaJtSKi6aNERpI3FPoPlwCTobkfKfWo9BWFPhZ7NRGzsoHt8Svtg0Hez+OHZIQnuvpiY
         6UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WFi24hS9BNe0YKy3AUzwISCsIab6xsbI/zt4Uj4n4M=;
        b=GHkoQSY4WHyDG71u/ygTkWnFYCAOStoN5q83BYueLGEVpQpbSYom4IIaIni5SXrutl
         SRLUN/x25Zv1atgxjVfu1Iho7Iv27+McnugpeuyCNMDDVYHZbwzrrYP49Jp0fzAHDmx4
         aRevEPUCOiZd7+S4aRzT13G+Iu2kGoUw7k3Pjc3YzNYo/u7Z29SO997b+I8rgbYC5uOx
         qMiAh+MqdmffrKvsKL77A88pmPq9h5SADSQ6HIO+xQ4Qw8tygfer7MQyajv8autiBe5+
         B7zRmZwdR1CNQBC5NWYgxSyOniWjo72BPzZsoeTQrecRgR+0MRlzR+n85SsCY1LAKrV9
         Sdgw==
X-Gm-Message-State: AOAM53397F2FU02skY13FW1sgKieWiKL0JEQLb8si8Dr0yj9iDrNwIdi
        1+MsiXlhC0YkPBKr2fq4v1tRZZct83/NLQ==
X-Google-Smtp-Source: ABdhPJxMp8ldC7Meu2zkgPjbbc72MuqlTbTnF7gLAuy832IUr9pwzFN3mZPm939YAdfGx9sPRq4MzA==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr13913611wrt.287.1610729731954;
        Fri, 15 Jan 2021 08:55:31 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b7sm14655045wru.33.2021.01.15.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 08:55:30 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linux-kernel@vger.kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] MAINTAINERS: update maintainers of qcom audio
Date:   Fri, 15 Jan 2021 16:55:19 +0000
Message-Id: <20210115165520.6023-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of qcom audio drivers, as Patrick
has very little time to look at the patches.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Acked-by: Patrick Lai <plai@codeaurora.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..b1545817c899 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14512,7 +14512,7 @@ S:	Supported
 F:	drivers/crypto/qat/
 
 QCOM AUDIO (ASoC) DRIVERS
-M:	Patrick Lai <plai@codeaurora.org>
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-- 
2.21.0

