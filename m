Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E72F2BB326
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgKTSa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbgKTSa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:30:26 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F9F2224C;
        Fri, 20 Nov 2020 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897025;
        bh=gebyIGXTezq+YZfUPcdCaJWXT2isISFOj3AQGtOCvr8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Zf09tj+o6f6kRkXirktpkqTC0x0ODrs5+sUISJShbM970mfmWgbCafR9mwU6jadQc
         RB56Ce5QPHO2BmaSbuLd///Iv5NL7FIYFMAug947rswXzdx5c3c4jEqs93iqm/sEow
         g3ySqMJMUQHSHEQw7O98qZm9fhl1038DGaURGfP8=
Date:   Fri, 20 Nov 2020 12:30:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 038/141] isofs: Fix fall-through warnings for Clang
Message-ID: <5b7caa73958588065fabc59032c340179b409ef5.1605896059.git.gustavoars@kernel.org>
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
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/isofs/rock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 94ef92fe806c..4880146babaf 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -767,6 +767,7 @@ static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
 			rs.cont_extent = isonum_733(rr->u.CE.extent);
 			rs.cont_offset = isonum_733(rr->u.CE.offset);
 			rs.cont_size = isonum_733(rr->u.CE.size);
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

