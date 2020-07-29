Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A87232212
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 18:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgG2QC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 12:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2QC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D392C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z3VrENga61iSKss8Hnh2cQXC/6gF4LpMQJ3oXJgRJSI=; b=m2LnLMUikIopTfPiEjtfM2m3Uc
        VYbz0rODvyZ+8KVBpp3gulUkOZKuVZRS04hJHDG/Ke3fBvFgqcldKTw7laFt9gsftlMMkFZ/5/JX3
        gouLIUQ4zdcYYgGbZtJWu5HCwt/i4vy7YM6xSFU0pPx7EvHkAJqHdZRU4lLV2qwrtH051zx9yBkW2
        7g3F/hoU5+29/gXnJ2DZrX4OeJV0PYdYXi/0gE789Q3nZ3rNZwjZhUcO8VZU1eemxxy/HJo+70Jjc
        UYP5Xg7JhmFlqT3aAooM558i6r1pLQm9Axinhs/2xzetttI2WG4wM+DJnYm01mjcQT1qcz7yMBfsb
        LHC/qC9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0oX6-0007Qy-JT; Wed, 29 Jul 2020 16:02:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27C2E300238;
        Wed, 29 Jul 2020 18:02:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12EAA220F49BE; Wed, 29 Jul 2020 18:02:20 +0200 (CEST)
Date:   Wed, 29 Jul 2020 18:02:20 +0200
From:   peterz@infradead.org
To:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: Should perf version match kernel version?
Message-ID: <20200729160220.GB2655@hirez.programming.kicks-ass.net>
References: <20200729155647.xte33krus3mak3wu@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729155647.xte33krus3mak3wu@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 06:56:47PM +0300, Vitaly Chikunov wrote:
> Hi,
> 
> It seems that most distros try to have perf version to match with
> running kernel version. Is is requirement? Would it be better to have
> single perf from kernel mainline to work with any (older) kernel
> version?
> 
> We have different kernel versions in ALT Linux (stable for 4.19, 5.4,
> and 5.7) and I want to understand if we should have three perfs or
> single package will be enough.

We strive to have it all compatible, older perf should work on newer
kernel and newer perf should work on older kernel.

How well it's all tested is another.

Personally I often use a very old perf.
