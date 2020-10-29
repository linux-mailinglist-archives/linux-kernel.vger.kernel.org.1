Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F158829EDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgJ2OFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgJ2OFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:05:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B2C0613D3;
        Thu, 29 Oct 2020 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QFX/rG1nfZIO6l4gly+0bHosD8oEdLcUGfNyFPDeo2s=; b=b35ci6InfXu1GLmFPpVcMezq0t
        ngEwd6LKqAH04tvmf/uby22B13TxPisuejy+HoRD1GK0154yp/JZnQkum0Qw44N6IapT6WrhngL0E
        fdOHcJfJpb9ea4uvQg3Aggs8s8+6uYSAhBpmNXF+R6+6TTdb/o6ugVie9c/EmBhdetzSAN4BTt+K/
        Ck9fPhw1BiqPr54xjrNlR/msky9ij4cjqUH2Q9LJw4yjVA6eeP0JOvjcxBzBDujEldGcYdYFGfetA
        FafwISEqui2jmvffxC2QshrHbl0fiZkJCzdr0ZekujAxZYQGxXlYBCk1AwL1c931+06NCsxIpS+1H
        E4l+d6oQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY8Ya-0001mV-AN; Thu, 29 Oct 2020 14:05:36 +0000
Date:   Thu, 29 Oct 2020 14:05:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201029140536.GA6376@infradead.org>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029131212.dsulzvsb6pahahbs@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 02:12:12PM +0100, Sebastian Andrzej Siewior wrote:
> Are there many drivers completing the SCSI requests in preemtible
> context? In this case it would be more efficient to complete the request
> directly (usb_stor_control_thread() goes to sleep after that anyway and
> there is only one request at a time).

Well, usb-storage obviously seems to do it, and the block layer
does not prohibit it.
