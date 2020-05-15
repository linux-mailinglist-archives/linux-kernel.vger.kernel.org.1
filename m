Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAACE1D4EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgEONPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 09:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEONPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:15:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053BF206D4;
        Fri, 15 May 2020 13:15:14 +0000 (UTC)
Date:   Fri, 15 May 2020 09:15:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <bobo.shaobowang@huawei.com>, <huawei.libin@huawei.com>,
        <chenwandun@huawei.com>, <mingo@redhat.com>
Subject: Re: [PATCH] ftrace: show debugging information when panic_on_warn
 set
Message-ID: <20200515091513.4947ff02@gandalf.local.home>
In-Reply-To: <20200515100828.7091-1-cj.chengjian@huawei.com>
References: <20200515100828.7091-1-cj.chengjian@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 10:08:28 +0000
Cheng Jian <cj.chengjian@huawei.com> wrote:

> When an anomaly is detected in the function call modification
> code, ftrace_bug() is called to disable function tracing as well
> as give some warn and information that may help debug the problem.
> 
> But currently, we call FTRACE_WARN_ON_ONCE() first in ftrace_bug(),
> so when panic_on_warn is set, we can't see the debugging information
> here. Call FTRACE_WARN_ON_ONCE() at the end of ftrace_bug() to ensure
> that the debugging information is displayed first.
> 
> after this patch, the dmesg looks like:
> 

Thanks, I'll add this to my queue.

-- Steve
