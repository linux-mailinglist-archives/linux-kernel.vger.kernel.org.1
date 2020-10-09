Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74489288946
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgJIMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbgJIMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:51:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251DC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p2lGP8as6+oi46c/cXhYYdtN0xZ6+KPcjTRWmlDOxLs=; b=txajdJgAN4/5NHPWKuzZQTkgUW
        Z0tJp310qrCeDoZfUlSRslZ0Vr4XLM1KKjlGO5OJzbGndKR/hBVUA4Z68tGhOm1hx7S2A+ccRAPfU
        YCSfEEx/g6pdaTWXKK2vbPwCSajxlueQmDvUDKVameqv70Oyx0AOlIYPHv0zoNTcweeXK5zCN7axz
        tSsjIHW7OX2H2+EK27WKXm8cRGW1og4ywMCf4gkLOCWQbw2m2lvsnpJbMn2ef1CMskgGuTTe63XtT
        EviFtsDhof32yojc/0ubv0Qa/VA6WmtvtBdUE8oY4sjTG0kE0ca900z5kQcdeNkae+nsk/pWCgets
        12BaI7mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQrrS-0008T4-Gs; Fri, 09 Oct 2020 12:51:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D03130008D;
        Fri,  9 Oct 2020 14:50:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3849D2B856EA8; Fri,  9 Oct 2020 14:50:56 +0200 (CEST)
Date:   Fri, 9 Oct 2020 14:50:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/5] allow overriding default preempt mode from
 command line
Message-ID: <20201009125056.GN2628@hirez.programming.kicks-ass.net>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009122926.29962-1-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can you please not thread the new series onto the old one? That's some
seriously annoying behaviour that I see more and more... It makes me
loose whole patch-sets.
