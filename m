Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEA3034E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbhAZF3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbhAYKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:16:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D92C06178B;
        Mon, 25 Jan 2021 02:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=EpzAO0iqhpxUKy/j0uXljmV9Rd
        S3sNnn6W3uVI7/1+e/09WTq70rb3FrVXj2HHhc3kJ0tG68btenp6UffDhhZf4lY5wCpvgQIvY643W
        /lZWh+Ks+fxaHW1C5o6mEcPlAlO7Y2fGZcgSrJ5ap8qbEwzqJn7T/0UriZZtPcvA0kDJx8FOKGAT+
        UhyLRQKKP6SV3N6AeGfwWVIAScZReNTgR+7YO7PLBN1wARN6P5kf16Rd2aOzP/rN6frSZSRrxNco2
        alIP035p63YPXOaRDRjx1c9PAaab+Wkq4ARc9xvSxVPTDFvLE14cDeWA2L0u1sIHroGbybgqnFAYx
        5X8J53Eg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3ytI-00448g-22; Mon, 25 Jan 2021 10:14:43 +0000
Date:   Mon, 25 Jan 2021 10:14:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3 v2] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20210125101436.GB967667@infradead.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-4-bigeasy@linutronix.de>
 <20210125083012.GD942655@infradead.org>
 <20210125083204.ahddujk5m6njwbju@linutronix.de>
 <20210125083903.GB945284@infradead.org>
 <20210125095412.qxknd2vbsmgtrhqb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125095412.qxknd2vbsmgtrhqb@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
