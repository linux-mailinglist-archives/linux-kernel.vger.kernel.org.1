Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF4280263
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbgJAPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732346AbgJAPSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:18:15 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC743208B6;
        Thu,  1 Oct 2020 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601565495;
        bh=C1g2lbWgPruQ9q68vkl9h0FKVYg6uIHEENbJQbM+XYs=;
        h=Date:From:To:Cc:Subject:From;
        b=u5dzNynD+rMiVUnmOdaakt5UV4WBYYwCqBuZONYU1XHpdfTZuNRtN5xUeuU5bZVab
         SgWaecBsDRWXsAA99uE+OpNDqFUAKYXFzlrojnIiiP6crnmdt3HVUzfYPcHtikXy6I
         u/TdXOikyKvu1ZYTUQJKlP8sxgGMsIrpjxb208cg=
Date:   Thu, 1 Oct 2020 10:24:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/3][next] lib/stackdepot.c: Replace one-element array with
 flexible-array member
Message-ID: <cover.1601565471.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aim to replace a one-element array with a flexible-array
member. Also, make use of the struct_size(), flexible_array_size()
and array_size() helpers.

Thanks
--
Gustavo

Gustavo A. R. Silva (3):
  lib/stackdepot.c: Replace one-element array with flexible-array member
  lib/stackdepot.c: Use flex_array_size() helper in memcpy()
  lib/stackdepot.c: Use array_size() helper in jhash2()

 lib/stackdepot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.27.0

