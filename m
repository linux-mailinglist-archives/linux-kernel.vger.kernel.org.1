Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4791029DEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403956AbgJ2A62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731572AbgJ1WRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:32 -0400
Received: from localhost (i15-lef02-th2-89-83-213-3.ft.lns.abo.bbox.fr [89.83.213.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675952474A;
        Wed, 28 Oct 2020 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603891526;
        bh=VsgUHqBCAAG2JyBmbc+2/kr04wv2zjAypOoFY9wl+FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2TafEOmkZKvt2UA8Cau4p+PHiL02Ox5h1Yz6UHB9qO9kaMw2aChW1scOfWudSOtr
         xGlRgeDBBV1zUvxmINUBCMvkcNgMmWaagpegAES2TWkM2ML5Dq6FE7s44uZmfzbwk2
         BztN2/+uyO44GQFE5Q3GDbi5VwAprQmv5l+DDklQ=
Date:   Wed, 28 Oct 2020 14:25:22 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, g@lothringen
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 2/6] smp: Cleanup smp_call_function*()
Message-ID: <20201028132522.GC229044@lothringen>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.344544557@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111221.344544557@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:07:09PM +0100, Peter Zijlstra wrote:
> Get rid of the __call_single_node union and cleanup the API a little
> to avoid external code relying on the structure layout as much.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
