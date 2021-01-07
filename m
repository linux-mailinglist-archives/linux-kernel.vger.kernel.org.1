Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBC2EE9D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbhAGXfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbhAGXfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:35:30 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B66C061290
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:34:12 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m23so7958202ioy.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXvh8jYOYWtdC8QC3OBzUsPQ0KcpblQhbm1OQDC0Ass=;
        b=hLK246czR6y41dWnJ6Ykv8dKD3cB3MKIt1vxoKGRLQ/bwq8kBn6gf4SpnQu+kt7cMS
         GiWFB68A7v+bYEY03QRvwTctkQRPf8OgL2pUkcFhWJ5aYG0ZJfVAvmPwIy/yf4uyOqLz
         S3Jo/Usapg5IfpOar/YJFys0OfIDH4pnHtm+7215amwMkvhwPVL8+NVAQyChpeF5bNkz
         0nFyavqBsnytWpnH3OtL2NqLji1SZ0d5tT/RIUOAcUYrxxY4zygh7Db4KwsKMGzGaU0a
         2lhe/nX/rePRZ7E42VA+Zlt/AyCah2l8rudzPBmTdaSl41ZZEQvg2E1hirPbd1iEC1iT
         JrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXvh8jYOYWtdC8QC3OBzUsPQ0KcpblQhbm1OQDC0Ass=;
        b=HenaUPbpqEcXpsoZOKxClFp/bcLWUSaeQyixan9MPZv626LrV6VH9+rxvbXadhnpB8
         ZFFq78amMi57l2YS9TD7uJv99gbrNtOSJfYoES+yoMiizAlLb70QRoXt1btJGimKpqve
         4ExHOYMEfwFdLF8hPTrpcj2DzF80fTmkQZiulkLyoBKrRH94SA5gi2sJh6TcEkUo4KND
         YJsBxr5vwcxdJE05W38BCSGXfoafiWis45JM5LdPks86DJQ9Hm4X0Q05Y10MmnUEry2K
         lc5iS/GZNkO7kW3FWB7+UF2my0arVchtMjPKzYf5GRocOgXjUtZdRoNZY8Pn967J2wHV
         COtQ==
X-Gm-Message-State: AOAM530XGT+Yn800jdLtVpMtcTzG+ka5HK2G1E1PZG2eobvcao6yp/S6
        vMRgF+cQWMjgIFEgou8FkfIpJ1IKhfdgAw==
X-Google-Smtp-Source: ABdhPJxJSgiPtz+sh9VkfGJzoQQQOw3sDE8aSzL2A8Ep/tM98HlIWU98VvYmIVawQg32aW2ffIfStg==
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr3230986ioc.30.1610062451444;
        Thu, 07 Jan 2021 15:34:11 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o195sm5648521ila.38.2021.01.07.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:34:10 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, ohad@wizery.com,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, lkp@intel.com, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: ipa: declare the page pointer type in "gsi_trans.h"
Date:   Thu,  7 Jan 2021 17:34:03 -0600
Message-Id: <20210107233404.17030-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107233404.17030-1-elder@linaro.org>
References: <20210107233404.17030-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second argument to gsi_trans_page_add() is a page pointer.
That declaration is found in header files used by "gsi_trans.h" for
(at least) arm64 and x86 builds, but apparently not for alpha
builds.

Fix this by adding a declaration of struct page to the top of
"gsi_trans.h".

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipa/gsi_trans.h b/drivers/net/ipa/gsi_trans.h
index 4d4606b5fa951..3a4ab8a94d827 100644
--- a/drivers/net/ipa/gsi_trans.h
+++ b/drivers/net/ipa/gsi_trans.h
@@ -13,6 +13,7 @@
 
 #include "ipa_cmd.h"
 
+struct page;
 struct scatterlist;
 struct device;
 struct sk_buff;
-- 
2.20.1

