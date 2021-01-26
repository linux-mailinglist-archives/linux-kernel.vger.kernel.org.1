Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEC7303E35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbhAZNL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391931AbhAZMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F2C0698D5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so16317760wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uU6U7e+Bn+fD4ver5DjrrStmc291AlsHBOuXfK4dxLs=;
        b=IwFo0CYdlUafY6Byo0R+b6bvvlGXaOENiKJ2ZQwlgfkJsf+VoYu3/yjUzAtePy9TAX
         HbHRg8cIC0ko9QV9ElrO+pb5yB+MSfM+bN28fKBVoKKUMEArKMGSPGa3pbdQ1sYfRViK
         CMf/h5hBhebHXfv4JWun5jdh0n8xiz8VDi2yzG4908LH/BUdQbqOd/iyPYgkiigtWvX+
         TtAHaCnXn9xqgeOZsuyDsKzw87+x+r5fWGCbAAquK3sLssEoCrwk3nc88SFjDEiU9uuR
         gx2RBFBQdmS/SX5nP4mg2DV/3cYIRDRx1k2QRzvgWN1sbvuvqxQxRjXeWJZRfjDV9TXb
         nWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uU6U7e+Bn+fD4ver5DjrrStmc291AlsHBOuXfK4dxLs=;
        b=BwIqqWFFYCiOvqGqPtSYSkSiVzTNsIBkuabKWPDGVf5hw5ZH8VkJeWsi11H1dd6kpR
         C+nj9jYbiuLH3oPl7yAxZV1CSCkvCo8jjgKZKMDwbIbEd4OrIGXnJTsKqEJZSvvCd5le
         THsziAIMnFk9TaNNBFXSFASHuOW8hhGHMWZEf3YRibeoV8jMLbS8ZvrvPBD+Fi9j1EZO
         M6ZbS0YiLLBQRonn0Oeg1NZjJeQJkaud8IHbDHCGudXzrwiHGprHQJFEq6yRz6O6z4Fs
         u+gnbGeiGpy/rAnzFHVwLNYkkt8F9J8hz4rCFr9E+BYteN2DJ2R1+wXzB6dPFBbkdJVm
         N4Yg==
X-Gm-Message-State: AOAM531On0molkq9ssY4LTtY7I+IvCWRyuJPSR1Fro2x9pVpiq6k9lp+
        sn82bxHHaMcjGXtGosn7n+ODPQ==
X-Google-Smtp-Source: ABdhPJyYah5l8tpqi8HzCI+EEhW6f18InEXMudNL+zdJgmVDef+U6MN1L6N18riaoIOyn4yKX7D4pg==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr5605872wrm.376.1611665155292;
        Tue, 26 Jan 2021 04:45:55 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 09/21] clk: tegra: cvb: Provide missing description for 'tegra_cvb_add_opp_table()'s align param
Date:   Tue, 26 Jan 2021 12:45:28 +0000
Message-Id: <20210126124540.3320214-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/tegra/cvb.c:106: warning: Function parameter or member 'align' not described in 'tegra_cvb_add_opp_table'

Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/tegra/cvb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/tegra/cvb.c b/drivers/clk/tegra/cvb.c
index 21115c4e5d3a1..a7fdc7622913c 100644
--- a/drivers/clk/tegra/cvb.c
+++ b/drivers/clk/tegra/cvb.c
@@ -86,6 +86,7 @@ static int build_opp_table(struct device *dev, const struct cvb_table *table,
  * @dev: the struct device * for which the OPP table is built
  * @tables: array of CVB tables
  * @count: size of the previously mentioned array
+ * @align: parameters of the regulator step and offset
  * @process_id: process id of the HW module
  * @speedo_id: speedo id of the HW module
  * @speedo_value: speedo value of the HW module
-- 
2.25.1

