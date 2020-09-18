Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6327726F410
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgIRDLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgIRDL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:11:28 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4779920678;
        Fri, 18 Sep 2020 03:11:26 +0000 (UTC)
Date:   Thu, 17 Sep 2020 23:11:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] kprobes: Do not disarm disabled ftrace kprobe
Message-ID: <20200917231124.53063fa7@rorschach.local.home>
In-Reply-To: <20200918110122.b77b5658bd0ae1e28f03f5af@kernel.org>
References: <20200917191754.0a2f8e46@gandalf.local.home>
        <20200918110122.b77b5658bd0ae1e28f03f5af@kernel.org>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 11:01:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Ah, this seems to fix same issue which I sent.
> 
> https://lkml.kernel.org/r/159888672694.1411785.5987998076694782591.stgit@devnote2
> 
> Could you confirm it?

Ah, OK. I'm going through my backlog (which was created by Linux
Plumbers, and then me going on vacation for 10 days) and I'm only at
Aug 19th :-p

If that patch fixes the issue, I'll drop mine in favor of yours.

Thanks, and sorry for the noise.

-- Steve
