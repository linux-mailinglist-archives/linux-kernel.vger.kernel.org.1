Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4592319D255
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 10:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbgDCIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 04:36:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37885 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCIgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:36:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so7513582wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 01:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmqsIpFQyQQ2Lq3jQLn2ED6h63YdDDqWuKLktL963FE=;
        b=SJ97OZH9O5N5ygZtYvx6VRn5CNZ+eeV+YYI7T0CiEY7zG0dvON0OrGcvocQ7veqYIa
         VzuoDgTpADbKCDXTukTMGr+UvsFzbzfIq/irZJAZzZHthm1AnQT8vYHGP+vvKaoq+Co1
         O/GxLMd9P+xpRTC//DTv/x7GkV1AApGmZWkFnhYEUSKtIAoq6zAQBN1BkmsRCKpMzrpt
         PwdjNFrD6VFzQT3PzO0nDXHqWp0MIPKFuQaUpObifydDjtB1KUWD2yw8v7i+H5LtNl5M
         bAfuMk18cUpS1KhwE+vYTE1vHxhxHj2KzjY/OLHnF7uUuQoryk/gx5jLvbqdi7FzcTXE
         ZEyw==
X-Gm-Message-State: AGi0PuZLI5pY86mJl6u4L2oyNSJbcsst/pOxMsvy+B47dCFQ0EVP4XYK
        VKacbUInEyFUOtFXmMaNwKTW9hP4
X-Google-Smtp-Source: APiQypIG8pcQaw6IRSWQM+d3AwV+GjfW87kcXS+FPtd04pS58lgtBWpzeJsDAmRETTcbde+50hc16A==
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr8126218wrx.115.1585902959941;
        Fri, 03 Apr 2020 01:35:59 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id v7sm11010275wrs.96.2020.04.03.01.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 01:35:59 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neil Brown <neilb@suse.de>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/2] mm: make it clear that gfp reclaim modifiers are valid only for sleepable allocations
Date:   Fri,  3 Apr 2020 10:35:43 +0200
Message-Id: <20200403083543.11552-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200403083543.11552-1-mhocko@kernel.org>
References: <20200403083543.11552-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

While it might be really clear to MM developers that gfp reclaim
modifiers are applicable only to sleepable allocations (those with
__GFP_DIRECT_RECLAIM) it seems that actual users of the API are not
always sure. Make it explicit that they are not applicable for
GFP_NOWAIT or GFP_ATOMIC allocations which are the most commonly used
non-sleepable allocation masks.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e3ab1c0d9140..8040fa944cd8 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -127,6 +127,8 @@ struct vm_area_struct;
  *
  * Reclaim modifiers
  * ~~~~~~~~~~~~~~~~~
+ * Please note that all the following flags are only applicable to sleepable
+ * allocations (e.g. %GFP_NOWAIT and %GFP_ATOMIC will ignore them).
  *
  * %__GFP_IO can start physical IO.
  *
-- 
2.25.1

