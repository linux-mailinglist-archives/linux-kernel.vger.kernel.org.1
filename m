Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A2C2F3D42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393024AbhALVfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437118AbhALVMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:12:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB91E23120;
        Tue, 12 Jan 2021 21:11:25 +0000 (UTC)
Date:   Tue, 12 Jan 2021 16:11:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Liu Peibao <liupeibao@163.com>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] init/main.c: fix strings split across lines
Message-ID: <20210112161124.2789c67e@gandalf.local.home>
In-Reply-To: <7a7886b2-c3bd-5adc-5d94-67343e554759@163.com>
References: <20201230060424.29097-1-liupeibao@163.com>
        <20201230060424.29097-2-liupeibao@163.com>
        <20210111190235.3e81770f@gandalf.local.home>
        <7a7886b2-c3bd-5adc-5d94-67343e554759@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 22:26:21 +0800
Liu Peibao <liupeibao@163.com> wrote:

> Thanks for your replay! I get it.
> But I still feel a little confused that we use different standard to 
> measure the existing code and the new code. I also checked some commits, 
> there are similar patches too.

For the reason of different standards for existing code to new code. Think
of it as a "grandfather clause". Where rules change for new instantiations,
but if you already have something, you can still use the old rules. Hmm,
it's kind of like how RCU works!

As for some commits getting it. They sometimes get pulled in by various
maintainers, and also may happen if you are changing the code around
something. With the "one commit does one thing", you can have a "clean up
code" patch followed by a "change the code" patch. matters what the context
is.

-- Steve
