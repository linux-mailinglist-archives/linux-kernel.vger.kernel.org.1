Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D329E169
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgJ2CA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:00:58 -0400
Received: from casper.infradead.org ([90.155.50.34]:44160 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgJ1Vva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Mpdng4RuQf44ddf01qH6mfLCaTFkE0g2Rcb1wOeeIHU=; b=NRwfifkpHQUhXnJUZdVgLlXfe5
        oqxhKZfB0LwJepg2if6yYDdgaYZASU0OTKfn4JrhHIoo4AYBREMWR6myzHL8ALDeB3MpPEnVwSoJ7
        o9OWFc9bQPK+zxwyMKxaX+9xnLPLJ1vsEGFSKz9G2JWUylMgEdSP9y+Gmpq2Jos5CMWzqJ8vhfr/Z
        wmuNY17B+3VK9A0jsdCTpATdZ8vIxMWj3uvcr63CrUOt6ytUM5yeFnGLbs4zdlEKLbS1VRyFoBTig
        1+Lma9fmaD5IhjsksDHTfy8sq54IW7HJ7/RNpLgn6h6vXahj+1rLPuxgzufPu9Hof3IKGJzePqnui
        FrQT3fzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXjOO-0000QB-Qz; Wed, 28 Oct 2020 11:13:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B3823070F9;
        Wed, 28 Oct 2020 12:13:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C577820B285A1; Wed, 28 Oct 2020 12:13:21 +0100 (CET)
Message-ID: <20201028110707.971887448@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 12:07:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [PATCH v3 0/6] smp: irq_work / smp_call_function rework
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are the non-controversial irq_work / smp_call_function integration /
cleanup patches.

There's one RFC patch to use the new irq_work_queue_remote() which seems to
survive rcutorture.

Please consider.

