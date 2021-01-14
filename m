Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC82F5D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhANJcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbhANJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:32:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD955C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DhuwWPsY6+AhlZo5544Esn7caYX+tMpt0EnqzeWP13k=; b=mzi4xCHsXEgR0sJg8zpSDVXzS4
        /9R8u6msxOYKolv37cxasOSsAnBj8wy6On56pWlJh3Yi7i8S35y8VEG+G4uvL2SmjsePOcW7ArTnh
        zV1NpzVZXfWsMmKBmTdJPA6lxQS0oCqe1tjSgPsIpWDrIn6NwGfWCpvn2aho4svh8Hi64acolpaJ5
        towb6aioDCAb+U2PDS40NZEHZy/BYQ2Y4Sm9EP/gyMkt8uDaSW3Z09j5GsBzJv1b5KKK3pJgB076w
        BoqjW5S6VmpkzFEEJDCdfoK930qGJHZPm9CecplBLeyZ5/4VBEntuPLMfNpDdXtED1dSg8ncMM8u9
        IsvNHzjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzyyd-00069O-Rg; Thu, 14 Jan 2021 09:31:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94E9E30377D;
        Thu, 14 Jan 2021 10:31:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F98720CC02D4; Thu, 14 Jan 2021 10:31:33 +0100 (CET)
Date:   Thu, 14 Jan 2021 10:31:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hui Su <sh_def@163.com>, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: use task_current() instead of 'rq->curr == p'
Message-ID: <YAAPdUg6CSFh/IDp@hirez.programming.kicks-ass.net>
References: <20201030173223.GA52339@rlk>
 <20210113173843.19227a86@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113173843.19227a86@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 05:38:43PM -0500, Steven Rostedt wrote:
> 
> Peter,
> 
> This is a simple clean up patch that makes sense to me. Want to take it?
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Might as well I suppose.. Thanks!
