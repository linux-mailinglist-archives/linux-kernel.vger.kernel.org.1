Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D080C274749
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIVRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVRMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:12:52 -0400
Received: from X1 (unknown [216.241.194.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8112084C;
        Tue, 22 Sep 2020 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600794771;
        bh=eZGm04xbBcFoJWyknH6yEKYWUp0W5WKKh0BhzYdfN0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ujHrSPNvT6frdqxXRUSFbCDbEYWHSgeXd4mZCrAJvOCqgPy/ok+gMbPdYsEjcfUGs
         AR9vOobIPlXSLaoqmovvp/dzRoLVkrf2N+YcCn2NzjzI2ikqYOc5ZqZHdnRrnn4d4A
         oU6P2HWdSHPr2a8GIdPHU37i5rnOgDvSqZQvT8Q8=
Date:   Tue, 22 Sep 2020 10:12:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, niketa@fb.com, sjenning@redhat.com,
        ddstreet@ieee.org, konrad.wilk@oracle.com, hannes@cmpxchg.org
Subject: Re: [PATCH 0/2] mm,swap: skip swap readahead for instant IO (like
 zswap)
Message-Id: <20200922101250.527d9e676fefbb4c8d0cd5b9@linux-foundation.org>
In-Reply-To: <20200922020148.3261797-1-riel@surriel.com>
References: <20200922020148.3261797-1-riel@surriel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 22:01:46 -0400 Rik van Riel <riel@surriel.com> wrote:

> Both with frontswap/zswap, and with some extremely fast IO devices,
> swap IO will be done before the "asynchronous" swap_readpage() call
> has returned.
> 
> In that case, doing swap readahead only wastes memory, increases
> latency, and increases the chances of needing to evict something more
> useful from memory. In that case, just skip swap readahead.

Any quantitative testing results?
