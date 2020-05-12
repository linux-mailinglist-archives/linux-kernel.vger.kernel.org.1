Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662D61CEEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgELIGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgELIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:06:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69AEC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jFjmQB/e5ull+EX7VgANDeJmrTn3Cb5FCF3znqfS04U=; b=m++CIU811ROxlube8cGsyphiDO
        6FULcavmEm2bABBHthZtt1HPM8C+17/xhUVNZNi6W0WIfVTtmpsP8BVbfMpadCBSZFTWt87e0RuCy
        D3uC4+xp88wRiBJQ3m1JzqSEjbr/iNLskORb2jBzUYOwNx/FXT3QLAqI6quoAWAGM2Vo3ScMt7X5T
        Unf32M/lYu6UysSFTf/CrB2wHMMYEoNZuAl4RTYbh0+/Yl4l7KxSjrxREPvTjxXS8rFeKYA/MkvVW
        qNq8nbe7fMYM6h0ZGFbiKnaiMrKPrl8vG90g4Wot6xup5xROWayyiU8rjMIMJ1U9jd8vI3wPGg2wB
        Si5Gd62A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYPvV-0002mm-OB; Tue, 12 May 2020 08:06:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 402E7305EEF;
        Tue, 12 May 2020 10:06:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25F6F2096103E; Tue, 12 May 2020 10:06:07 +0200 (CEST)
Date:   Tue, 12 May 2020 10:06:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arnaldo Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] perf tools: Replace zero-length array with flexible-array
Message-ID: <20200512080607.GD2978@hirez.programming.kicks-ass.net>
References: <20200511195643.GA9850@embeddedor>
 <0C076F02-CEB7-4DBC-8337-CCEBC0870E44@gmail.com>
 <20200512000404.GA4897@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512000404.GA4897@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:04:04PM -0500, Gustavo A. R. Silva wrote:
> On Mon, May 11, 2020 at 05:20:08PM -0300, Arnaldo Melo wrote:
> > 
> > Thanks, applied
> > 
> 
> Thanks, Arnaldo. 
> 
> I wonder if could also take the other two:
> 
> https://lore.kernel.org/lkml/20200511200911.GA13149@embeddedor/
> https://lore.kernel.org/lkml/20200511201227.GA14041@embeddedor/

I think I have those, but let me make sure.
