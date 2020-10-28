Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF929D6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbgJ1WSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731693AbgJ1WRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:41 -0400
Received: from localhost (i15-lef02-th2-89-83-213-3.ft.lns.abo.bbox.fr [89.83.213.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45C7246EB;
        Wed, 28 Oct 2020 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603886798;
        bh=cUaUuJXGh7EolBVDtFKCLkraxV7NQqcJe3KPtKeMEMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOb7ZSvjVlQhAACtodXfbFOGUyx7deMYgCWzP3XOa+/wJC4Dnh05zAg/166AQIM66
         zc+MYjYeNdpoive65ht6y/EvGtc5Yqk/NKSP0jfjf/coaBzAxKgnKzblEBZXksSLdQ
         6qISdtsLOqk9I5gWmUnD6/v8f6QDlTmojylc2R7M=
Date:   Wed, 28 Oct 2020 13:06:35 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 3/6] irq_work: Optimize irq_work_single()
Message-ID: <20201028120635.GA229044@lothringen>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.405177398@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028111221.405177398@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:07:10PM +0100, Peter Zijlstra wrote:
> Trade one atomic op for a full memory barrier.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
