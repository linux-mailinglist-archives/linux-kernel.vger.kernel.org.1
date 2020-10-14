Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7228DC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgJNJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgJNJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:04:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A37AC041E6D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 21:26:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b19so1123227pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 21:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whzGQ73mzzjs9c9ed5e3sLfewX+szU+TbiYBfpWMSEo=;
        b=zZAvvpghxLBCHne8Id5hFwl6kmydFgjV/XPVicNfeIwAk8pPo/4O6jwdNRcY3NQVmf
         p1/QsSzjHerEz8nRvjbkIXSUe3NTkZr9POQVoiQ0dS+v201/yN/e4510l0TVoxs5a/OU
         KAOUyh73MiUfz+E6dSTUa0uzzLn3OTlW5N4qG6Azc4JSVuJs5tNc/oi3rCD8gXg4SzMd
         2vwSHoK3fJxsoNgq+JOIzv182as8mPJFuEnjl4/v/16x0hWeNQeHP1oifOkt4ifZqquX
         bRgs3uBbp9XntvL0kc96v75/3btMtlcQBddscOuMwZsMYKzFwBVJlvvFfkDvRETlo9BN
         TPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whzGQ73mzzjs9c9ed5e3sLfewX+szU+TbiYBfpWMSEo=;
        b=f/ByoEot01+kMA8sPcVW0JrX0YnnhAWb39k+a1pB/hWCpHcGWIfH5XYzO4yKimXYyI
         uLq4HASSPHd1HBhhhOY8NodeywHyAYwQCcvYrP96q3Qs9InUXo1Zt946udiHhkPnQ2+p
         C1nEEvF4Lzs2SkJUOUg4Vm6xlapFvA/LGyGZOEYD87P5X+doi03Sq38BbNyRDRPam+hZ
         uvN09iZNUGSvgXcHhZPq44aU5Nv/GoSvQZh6zHcKNO0vEFRvvEp6kFtihgFYTqRIT5ji
         36Ws8nM6q2sNwW90kkrIuDDFz+BT8Ow27UEkqtzgNUebKzorArIFUKhH+elqwoo6ibSw
         6cPA==
X-Gm-Message-State: AOAM530fks/9jMJ2sT6WP94Pg/QdxnXgOrsACn+mzWV8JW8bwvtxDyFz
        rJ6WfrC4LbouncR7XtOvJvgZ/A==
X-Google-Smtp-Source: ABdhPJzW0xxJSqTbXlczLEjBDwdx6ffSNItDE7RJyY7WO2f7eMwMC3fFvpoE6xE7G60GsV+9EATP+w==
X-Received: by 2002:a17:90a:c248:: with SMTP id d8mr1610634pjx.193.1602649592092;
        Tue, 13 Oct 2020 21:26:32 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id d26sm1366862pfo.82.2020.10.13.21.26.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 21:26:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Don't always remove static OPPs in _of_add_opp_table_v1()
Date:   Wed, 14 Oct 2020 09:56:28 +0530
Message-Id: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch missed returning 0 early in case of success and hence the
static OPPs got removed by mistake. Fix it.

Fixes: 90d46d71cce2 ("opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()")
Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 874b58756220..9faeb83e4b32 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -944,6 +944,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		nr -= 2;
 	}
 
+	return 0;
+
 remove_static_opp:
 	_opp_remove_all_static(opp_table);
 
-- 
2.25.0.rc1.19.g042ed3e048af

