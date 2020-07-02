Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4261C212586
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgGBOEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 10:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGBOEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:04:36 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D82720890;
        Thu,  2 Jul 2020 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593698676;
        bh=4dtI/+UyfHWtbn+yCFkWBn+lf1R0YXQA7EgPiYXs/Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Isuce4zweOA2duZoLej12P4QilA6zm5/U1JYvVzXT1daNsLUkg0dlsxFHdSpU4jKp
         SQyRJycpnhQmCIcp3W0u6YeEaJxZn9FtR84JJbLMc3aNn5GA43rgF2iC5ye+qN3rOh
         PzCCSpDDMf1T3Xz9a8UNiPz8O+bGR0Hj/7ZbNLhs=
Date:   Thu, 2 Jul 2020 16:04:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
Message-ID: <20200702140432.GB27417@lenoir>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-2-frederic@kernel.org>
 <20200701163504.GD9670@localhost.localdomain>
 <20200701232045.GA17670@lenoir>
 <20200702095959.GG9670@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702095959.GG9670@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:59:59AM +0200, Juri Lelli wrote:
> On 02/07/20 01:20, Frederic Weisbecker wrote:
> > On Wed, Jul 01, 2020 at 06:35:04PM +0200, Juri Lelli wrote:
> > > Guess you might be faster to understand what I'm missing. :-)
> > 
> > So, did you port only this patch or the whole set in order to
> > trigger this?
> > 
> > If it was the whole set, can you try this patch alone?
> 
> Whole set. And I can't reproduce if I try with this patch alone.

Ok I can reproduce with the whole series upstream with threadirqs.
Investigating...
