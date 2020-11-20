Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7F2BB38D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbgKTSgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbgKTSgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:36:04 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABD924124;
        Fri, 20 Nov 2020 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897363;
        bh=b5KGbksfKRxah8MT1+zAgnk8fagKGQux2CL9t6Taa2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZn3kQP8dTT2Hf3tMTjBzmSLw0nGOFdir+q4J0RvcSTD3wdq0lmmcI3WTRulVcCz7
         noQYjSFLXZR8qJgcf3biys5V9y7n98I/cSElK7/yrHKye0m4qFepUxU4NlmWYt9ium
         IjLNsa+ZXlz9dqISeOJ9GlFd3bleNFGXX1Dcj/ts=
Date:   Fri, 20 Nov 2020 12:36:09 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 087/141] hwmon: (max6621) Fix fall-through warnings for Clang
Message-ID: <e59b39ab11a5d8c2a2ec86c15eabc00b5a056c15.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/hwmon/max6621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
index 367855d5edae..7821132e17fa 100644
--- a/drivers/hwmon/max6621.c
+++ b/drivers/hwmon/max6621.c
@@ -156,7 +156,7 @@ max6621_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
 		default:
 			break;
 		}
-
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

