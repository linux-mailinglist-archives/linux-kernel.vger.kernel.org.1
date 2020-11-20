Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE92BB423
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgKTSlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731670AbgKTSkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:53 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C64FD2467D;
        Fri, 20 Nov 2020 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897649;
        bh=b9FdqbhetGxlSrLNwiAqLkeUTdEkk4mAKgqcmtTsp+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hrmt+c+r6d/bWt+4ljBbSgqtFgarptX12kO+U2fLRv5VtqpaFFiUvoqLobkrL44vb
         YzASrHzjRkeEDxzxAjUDereBGScx1uBnMz/YCJDvmwUPgBPkS2EvsTCQpisizSL5Lh
         KeRWZ32/JPMy2/BEohFcbSIzB6HdVvQS5AJDIFaw=
Date:   Fri, 20 Nov 2020 12:40:55 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 138/141] xen/manage: Fix fall-through warnings for Clang
Message-ID: <5cfc00b1d8ed68eb2c2b6317806a0aa7e57d27f1.1605896060.git.gustavoars@kernel.org>
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
 drivers/xen/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index cd046684e0d1..374d36de7f5a 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -179,6 +179,7 @@ static int poweroff_nb(struct notifier_block *cb, unsigned long code, void *unus
 	case SYS_HALT:
 	case SYS_POWER_OFF:
 		shutting_down = SHUTDOWN_POWEROFF;
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

