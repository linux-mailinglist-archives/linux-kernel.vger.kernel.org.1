Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E91F303D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbhAZMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404028AbhAZKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:36:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28178C061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ZILNUMQYhjI5ZvuWMR1TJyaymk/UehpyHbNsinJtCA=; b=Z7as2SVEGI3WeWY4Igr7Ce6CNS
        Tp10ipVqbslayAFfdU9fmPtts1ibiD3rfb9dzgdzGGjK2LlFa2osD/S+54DfzAMrXDKWH4rproYrt
        /j2/ueA+XqbIQHmaeI6+uYwSBzwT8380UX6LZX3V2lfCEwR5ByjL+9ovbt1h+qtwoTuKFpuQB8yQ3
        tcMaWYm3WAfHXxI2f+COA5xXrdjGw7fFyMejCa+vxLRyFMfGwpXyyzsfHZrQkD9GvqkoAemISLRYc
        A5okcYChV/XVdiNw1h3XrStD8hHxSLmVJ+4gnNrVRgQ/ruPRRn1idruOuMgprSOg7VYmqF4WW94dK
        tvsq1EPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4LgZ-005Rey-3J; Tue, 26 Jan 2021 10:35:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F61E300DB4;
        Tue, 26 Jan 2021 11:34:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16B7E207CB5F8; Tue, 26 Jan 2021 11:34:58 +0100 (CET)
Date:   Tue, 26 Jan 2021 11:34:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH v2] locking/rwsem: Remove empty rwsem.h
Message-ID: <YA/wUuRWtB/uunth@hirez.programming.kicks-ass.net>
References: <20210126101721.976027-1-nborisov@suse.com>
 <20210126102014.GB29204@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126102014.GB29204@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:20:14AM +0000, Will Deacon wrote:
> On Tue, Jan 26, 2021 at 12:17:21PM +0200, Nikolay Borisov wrote:
> > This is a leftover from 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> > V2:
> >  * Add reference to commit which made the file useless.
> > 
> >  kernel/locking/rwsem.h | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  delete mode 100644 kernel/locking/rwsem.h
> > 
> > diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> > deleted file mode 100644
> > index e69de29bb2d1..000000000000
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!
