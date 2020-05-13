Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C919E1D1AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbgEMQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 12:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbgEMQZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:25:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB972064E;
        Wed, 13 May 2020 16:25:26 +0000 (UTC)
Date:   Wed, 13 May 2020 12:25:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [tracing] 06e0a548ba:
 WARNING:at_kernel/trace/ring_buffer.c:#ring_buffer_iter_peek
Message-ID: <20200513122524.2352c105@gandalf.local.home>
In-Reply-To: <20200513161557.GA73453@tuxmaker.boeblingen.de.ibm.com>
References: <20200429090508.GG5770@shao2-debian>
        <20200513091906.GA12720@tuxmaker.boeblingen.de.ibm.com>
        <20200513092922.6d79f6ee@gandalf.local.home>
        <20200513161557.GA73453@tuxmaker.boeblingen.de.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 18:15:57 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Thanks for looking into this. I've attached my /proc/config.gz to this Mail.
> The x86 system is my Laptop which is a Thinkpad X280 with 4 HT CPUs (so 8 cpus
> in total). I've tried disabling preemption, but this didn't help.
> 
> It's always this check that causes the loop:
> 
> if (iter->head >= rb_page_size(iter->head_page)) {
> 	rb_inc_iter(iter);
> 	goto again;
> }
> 
> On the first loop iter->head is some value > 0 and rb_page_size returns
> 0, afterwards it gets twice to this check with both values 0. The third
> time the warning is triggered. Maybe that information helps.

Letting it run long enough, I was able to trigger it.

I think I know what's wrong with it. I'll put in some debugging to see if
my thoughts are accurate.

Thanks for bringing this back to my attention.

-- Steve
