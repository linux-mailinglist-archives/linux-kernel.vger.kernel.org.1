Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4209225280
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgGSPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 11:34:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgGSPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595172897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=hg0lbQ+8VwQQXpzy5TW+xgK9mc47o+v0BPDpQo4cPu8=;
        b=jQ2EAcDMPUSVW9cOTb8B0UgQmHftt/Y+HojVw4jdBMOITOymCmGb4eulFbJFxEXASj6g59
        SwW1D7SnpUFVsMJxgvq+KBZXsWThO8aLWasyCT6wU0h7eyQoQjelxCbsikq3lakKgQh4tR
        n/fBiWiAmlLz++FJLjow2C66Ay3Sxfo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-ROdIjxLxMJWzYmVQo1jufw-1; Sun, 19 Jul 2020 11:34:54 -0400
X-MC-Unique: ROdIjxLxMJWzYmVQo1jufw-1
Received: by mail-qt1-f198.google.com with SMTP id h10so10264498qtc.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 08:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hg0lbQ+8VwQQXpzy5TW+xgK9mc47o+v0BPDpQo4cPu8=;
        b=o21kiHEWi/u1XvbQ18VcT6bLcU7byuYC+lP9jTTsOm2LxEl+/ZYKvhzM/VKsYLBNbU
         5M2u29iq9oZMaAt8/zeWpS5odaJ7YjfPYe2xnTqx0el1fUFblfJe+NJdGXOFKc0TJ4WR
         jEKtx0OGLZEQ+fi9ngJN0XDCY4CF0qWZ8uxhe0mDhknN9yInlM8W8W697YstCN07S6i1
         aXDFdb8inuVHhXqWg6kqWk9NiF8yeg4F6YcaP38ClrqBwGPIN7iIisglE01MFfUj/U/G
         UZaiSRKtLG0NwdSVUz85Ybkk5GxSJdyo6kJcrw7Ldt/JqKROFTp/8XG7IxczaggCk120
         KJAA==
X-Gm-Message-State: AOAM530opBjGleA+aeAfZAnG/iAEnLdOTWiaRpLxCa07VbTspPbyHuKK
        xLFnHudUzKu7SJbvb70eJBFO9qI//QBxyjRVzVxTZB6oVwyo4Xl8YsxU8aQU/EYPVr6Ukfhz7U+
        J3AhBrSgZpeH2nbH+uVFoDqAB
X-Received: by 2002:a37:c41:: with SMTP id 62mr1987980qkm.189.1595172893435;
        Sun, 19 Jul 2020 08:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd0wlLchxDWkT1Yrjr6nyemXEfsQcDGUHLhm0O1Jt4XLIvOQ22rvO90Nx2qRedFDcV14D1Qg==
X-Received: by 2002:a37:c41:: with SMTP id 62mr1987953qkm.189.1595172893175;
        Sun, 19 Jul 2020 08:34:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p63sm15410662qkc.80.2020.07.19.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 08:34:52 -0700 (PDT)
From:   trix@redhat.com
To:     kyungmin.park@samsung.com, riverful.kim@samsung.com,
        mchehab@kernel.org, s.nawrocki@samsung.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: m5mols: Check function pointer in m5mols_sensor_power
Date:   Sun, 19 Jul 2020 08:34:47 -0700
Message-Id: <20200719153447.4380-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this error

m5mols_core.c:767:4: warning: Called function pointer
  is null (null dereference) [core.CallAndMessage]
    info->set_power(&client->dev, 0);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In other places, the set_power ptr is checked.
So add a check.

Fixes: bc125106f8af ("[media] Add support for M-5MOLS 8 Mega Pixel camera ISP")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/i2c/m5mols/m5mols_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/m5mols/m5mols_core.c b/drivers/media/i2c/m5mols/m5mols_core.c
index de295114ca48..21666d705e37 100644
--- a/drivers/media/i2c/m5mols/m5mols_core.c
+++ b/drivers/media/i2c/m5mols/m5mols_core.c
@@ -764,7 +764,8 @@ static int m5mols_sensor_power(struct m5mols_info *info, bool enable)
 
 		ret = regulator_bulk_enable(ARRAY_SIZE(supplies), supplies);
 		if (ret) {
-			info->set_power(&client->dev, 0);
+			if (info->set_power)
+				info->set_power(&client->dev, 0);
 			return ret;
 		}
 
-- 
2.18.1

