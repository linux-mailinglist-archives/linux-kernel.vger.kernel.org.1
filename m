Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8EF2BB35B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgKTSdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgKTSdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:33:09 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0024722D0A;
        Fri, 20 Nov 2020 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897188;
        bh=2zBJAxLMBH0qmLpvvpq9uOjVcS1vAUEp1vjINhBR5xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWMFWekBJ8fumEyksrUpbT4tIeH4hsXlPlM8WUElazqUbVzdrdrjaa38/R2L2JpO2
         xOeTiN+K4sKb7N0MmQsKXj36rFNzbLRNgvB3RbbY2Kkkbr6l6nLNT696r8/HJM7Ec8
         0rj3PdaMaQjCyC3TDo8fT11MiEd+H8K2odr4WZwc=
Date:   Fri, 20 Nov 2020 12:33:14 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 060/141] habanalabs: Fix fall-through warnings for Clang
Message-ID: <34c177585dfd5c6dc3e101ec8f11e4733b7fd11a.1605896059.git.gustavoars@kernel.org>
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
by explicitly adding a fallthrough pseudo-keyword instead of letting the
code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2519a34e25b7..eab4c0dc65c5 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5436,6 +5436,7 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		params.num_memories = 33;
 		params.derr = true;
 		params.disable_clock_gating = true;
+		fallthrough;
 	default:
 		return;
 	}
-- 
2.27.0

