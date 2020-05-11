Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228EF1CDAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgEKNDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:03:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NVFPoYCOPVuNwGv4Kd6ZOECGcFIViWvwBz6rpxtoosA=; b=kUOElQ0gcThxgLNFIT3z1JstO+
        YngNZrhmRWzVOFu1kgfqTOc7iCH6T3aG8d6UY4W2/5QL9FUlEtI8DFyNjvic8D5kuBKbL2TLV08RP
        BFwyQQbrH8qWsB1wn5PmR83P6eg/avQc8I4VHLwAA3dbJQ8D2mfQmt6qlmTkgAM+dLDhUh71Q1Y68
        +7wQSBhkhnTVwxdZJ0ecSC4Qh3rDRmSIjKyqj+Xe+qUOXTmYr8pemyEbAdlARj9YrPmM+j538Dr2u
        Q5BfoShvxJbbHUDFHlJS8ppfRc72o+cIG8OFOdVCUp/A04Fqwvn6dpN4tfOuCh4zRq/TIIXQX0fC8
        EP/M7mcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY85j-0006iX-1Z; Mon, 11 May 2020 13:03:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED02C301A80;
        Mon, 11 May 2020 15:03:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEB0E2006F9F5; Mon, 11 May 2020 15:03:27 +0200 (CEST)
Date:   Mon, 11 May 2020 15:03:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bsegall@google.com
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        chiluk+linux@indeed.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pauld@redhead.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched: Defend cfs and rt bandwidth quota against
 overflow
Message-ID: <20200511130327.GA2978@hirez.programming.kicks-ass.net>
References: <xm26k126kkma.fsf@google.com>
 <20200425105248.60093-1-changhuaixin@linux.alibaba.com>
 <xm26ftcolr3p.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26ftcolr3p.fsf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:29:30AM -0700, bsegall@google.com wrote:
> Huaixin Chang <changhuaixin@linux.alibaba.com> writes:
> 
> > When users write some huge number into cpu.cfs_quota_us or
> > cpu.rt_runtime_us, overflow might happen during to_ratio() shifts of
> > schedulable checks.
> >
> > to_ratio() could be altered to avoid unnecessary internal overflow, but
> > min_cfs_quota_period is less than 1 << BW_SHIFT, so a cutoff would still
> > be needed. Set a cap MAX_BW for cfs_quota_us and rt_runtime_us to
> > prevent overflow.
> 
> Reviewed-by: Ben Segall <bsegall@google.com>

Thanks!
