Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D11281A79
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbgJBSGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgJBSGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:06:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20E5E206DD;
        Fri,  2 Oct 2020 18:06:16 +0000 (UTC)
Date:   Fri, 2 Oct 2020 14:06:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix some typos in comment
Message-ID: <20201002140614.1f54c705@gandalf.local.home>
In-Reply-To: <20201002143126.2890-1-hqjagain@gmail.com>
References: <20201002143126.2890-1-hqjagain@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Oct 2020 22:31:26 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> s/coorditate/coordinate/
> s/emty/empty/
> s/preeptive/preemptive/
> s/succes/success/
> s/carefule/careful/
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  kernel/trace/ftrace.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied. Thanks,

-- Steve
