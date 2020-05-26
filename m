Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE581C71CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgEFNiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 09:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgEFNiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:38:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B556C20575;
        Wed,  6 May 2020 13:38:06 +0000 (UTC)
Date:   Wed, 6 May 2020 09:38:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
Message-ID: <20200506093805.1f86f3f0@gandalf.local.home>
In-Reply-To: <20200429191224.GA75562@google.com>
References: <20200424223630.224895-1-joel@joelfernandes.org>
        <5EA80319.7080005@cn.fujitsu.com>
        <20200428104409.0995ceb0@gandalf.local.home>
        <20200428104543.3926eaaf@gandalf.local.home>
        <5EA96AE8.6000707@cn.fujitsu.com>
        <20200429123141.580f89ce@gandalf.local.home>
        <20200429191224.GA75562@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 15:12:24 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > Mine ;-)
> > 
> > The "kthread_should_stop()" is the normal way to end kernel threads. Using
> > get/put is not the orthodox way.  
> 
> Agreed :-) thanks.

And while I'm working on getting a new "urgent" branch out, I found this
code is buggier than I thought. I'll have a new patch soon.

-- Steve
