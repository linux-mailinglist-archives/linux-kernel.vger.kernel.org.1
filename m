Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0527C29EEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgJ2O41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgJ2O40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E0C0613CF;
        Thu, 29 Oct 2020 07:56:26 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:56:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603983385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ppJelXitr+gl2oZ8i2m3v3k6fNoZDDu0mMJEWxPaA9g=;
        b=R3B+yhJsl4kVrj+NRIoVOC6qm8HDHh9+JlmNjMWLRzVcxLOmM2vcX/h3Uh0LCAUZRJ+zb0
        G8schHrKCns30OQ++yJblTjmGKJmb3t9WZq4lNgJu79S6C35MetpAbEDZcPNXqUy9sC1Te
        avwvRhl2x5fLbsgIqzGSKb8EWx94jgmH0LEzOhA3qNJEbmLwWx1jvNFxVuLTk+ef71RihR
        p8HEdXiq4HNC1+TQVWQsAVc62R9TpwMdGFNWobMNnmhkdOEaYp/W08H6sYWnkx64IKQEoo
        AOoRvp0oRqYJqiQyuk1qzcR7jSiV7/Xr8nIQq1D42x6/WJUIImVECkWgk9GSIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603983385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ppJelXitr+gl2oZ8i2m3v3k6fNoZDDu0mMJEWxPaA9g=;
        b=c0OiIKIV3inkPlqsAHgJAM+6KyYlRUlT2t3Zsl2Gs1aI+yrJvQIX+0H94jbOPibFqe+dzL
        oDD/O8kJGNKi3KAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201029140536.GA6376@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-29 14:05:36 [+0000], Christoph Hellwig wrote:
> Well, usb-storage obviously seems to do it, and the block layer
> does not prohibit it.

Also loop, nvme-tcp and then I stopped looking.
Any objections about adding local_bh_disable() around it?

Sebastian
