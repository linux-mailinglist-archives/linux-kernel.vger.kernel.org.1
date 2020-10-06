Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88293284E30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJFOmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgJFOmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:42:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB47320796;
        Tue,  6 Oct 2020 14:42:18 +0000 (UTC)
Date:   Tue, 6 Oct 2020 10:42:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] ftrace: replace do_for_each_ftrace_rec() with
 for_ftrace_rec_iter()
Message-ID: <20201006104217.005cec7c@gandalf.local.home>
In-Reply-To: <20200831031104.23322-6-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
        <20200831031104.23322-6-richard.weiyang@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 11:11:03 +0800
Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> Now we have two similar infrastructure to iterate ftrace_page and
> dyn_ftrace:
> 
>   * do_for_each_ftrace_rec()
>   * for_ftrace_rec_iter()
> 
> The 2nd one, for_ftrace_rec_iter(), looks more generic, so preserve it
> and replace do_for_each_ftrace_rec() with it.
> 

I also didn't pull in this patch. The reason is that the
for_ftrace_rec_iter() is specific for external usage (for archs to use) and
requires two function calls to do the iterations.

The do_for_each_ftrace_rec() is a faster, light weight version, but for
internal use only.

I rather keep both, as each has their own, but slightly different, use
cases.

-- Steve
