Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACD32BB3A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgKTSgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731066AbgKTSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:36:35 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5686E24178;
        Fri, 20 Nov 2020 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897394;
        bh=QvTdWsyEWNwiEFozRZ7h6dPDYFbpYH5Fk87FBAkBFqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiWaCkpcZdojuHqXDs5Sy83qa3vXfAJqXjKdHBjQKmEV53ZsJGkbj3hbEchpZHnT+
         axsY882jTaCe9NVgRgU8z7Uk/rVPrLbXzyFrenwq6tXEuHgjcvOShT9rJzheC3niWX
         AhyQGOsPA/G2cUKYB9GkP769nU9z9QviVn3lGVNs=
Date:   Fri, 20 Nov 2020 12:36:40 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 092/141] libata: Fix fall-through warnings for Clang
Message-ID: <e3498b34cae37d0f93db5824e5f61b183a7293f1.1605896060.git.gustavoars@kernel.org>
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
 drivers/ata/libata-eh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b6f92050e60c..2db1e9c66088 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2613,6 +2613,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			switch (tmp) {
 			case -EAGAIN:
 				rc = -EAGAIN;
+				break;
 			case 0:
 				break;
 			default:
-- 
2.27.0

