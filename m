Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB72FE89F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbhAULVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbhAULUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:20:40 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D3C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:18:45 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 15so1150529pgx.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAtjI7/BPs0IoV2iaS54lmWpFTE0HbF0Es/G22rWt3g=;
        b=ZpmS5LN1rts74B7Ode0O1RTIMsoc8Gi0J/g/qdh4T4B+Pl5+6gDcpGtwEy3pxwaa1n
         KJMIk8ywsFR4wtEZeD3cynSaQbttOpg++x8NwKSnz5NE2yMDL+xniSZ2kjT0faYRi5pL
         M+Ww1NxEYcW6YGEkuuNHvtUhb0dRL8IgsIE9SQlSprdhSHMaSGscj1dOZ0pc7bkhMeRY
         40VDRsunRhdrZp8VxhHfj0mrnlOz/vOMk0C1DUU9eLTtmhKiclL+GWz1UIm6g+zTmw1Y
         u2QUTm7Kird1vwS6WBpw7kK7Uo1YQ75ztHo2FgLS8AEfwPTzQ4+ugUeRvnqx9lyoBgi/
         jm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAtjI7/BPs0IoV2iaS54lmWpFTE0HbF0Es/G22rWt3g=;
        b=DTTHDxqnysSn2DS1YFOGg186st0FRw5qj7db31bdsXNoZSIQT6+LLrUWI+VieIm6dn
         jO4o7XaYMYieT+HNz5O6io3gc8Agne9lBffXd/taGR1p68RXppGdzYTKt34iTCcGoxt2
         gSf9xDtJYsyz9hJiRghMcDk2Rl3SKENhUUWIgrvKjAMyzKD8i2hDh8i1gDE1ZA9HZ81e
         +HDxZsw1ZinrJXHs+DSgDlHT7kSompJbGUxfTvEO9XcB8KjNkpEPBQ3DsH4jPOPIZ/OW
         ZtTg9SnuNFpf5jpiacgI14/QkXlGn6fksuTm35td6nsS+it935mAhjNkqcsEQ0pWdetx
         qBMA==
X-Gm-Message-State: AOAM530BY8c2HO8PiUvHC4pLaFtXjcio0cyyL6RyhPXH5dhuXEl+vknS
        4VoBu4sdEx0+ZXwVHtFKzEH5ww==
X-Google-Smtp-Source: ABdhPJyts296w7aWmAZLnK+2Ns297gN4vfmOwF34Q5MA6SM/rmkzGZINgd1d7pMVUGniT2QI9Kk1mQ==
X-Received: by 2002:a05:6a00:a8d:b029:1ba:71d1:fe3c with SMTP id b13-20020a056a000a8db02901ba71d1fe3cmr9122927pfl.51.1611227909301;
        Thu, 21 Jan 2021 03:18:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u1sm5595280pjr.51.2021.01.21.03.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 03:18:28 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/13] opp: Rename _opp_set_rate_zero()
Date:   Thu, 21 Jan 2021 16:47:41 +0530
Message-Id: <b55e4579ef70d47ceeec8e4b96108e8f3e0f1b81.1611227342.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1611227342.git.viresh.kumar@linaro.org>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine has nothing to do with frequency, it just disables all the
resources previously enabled. Rename it to match its purpose.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index aea0b9d7203c..9ec8e42981d0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -943,7 +943,7 @@ int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
 
-static int _opp_set_rate_zero(struct device *dev, struct opp_table *opp_table)
+static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 {
 	int ret;
 
@@ -997,7 +997,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	}
 
 	if (unlikely(!target_freq)) {
-		ret = _opp_set_rate_zero(dev, opp_table);
+		ret = _disable_opp_table(dev, opp_table);
 		goto put_opp_table;
 	}
 
-- 
2.25.0.rc1.19.g042ed3e048af

