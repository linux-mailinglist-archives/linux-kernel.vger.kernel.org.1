Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6B1A4284
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 08:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgDJGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 02:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgDJGeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:34:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66322063A;
        Fri, 10 Apr 2020 06:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586500440;
        bh=6lpC17I3KvsLc42BG+8xBz/FpBHY18/cuI7lKohqF0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVJpEUf2dmj1U+FoKnQprZCN7o+0Eg3s6vfs+kDLEDmz7fBRKsljdBjOPNayNUYSj
         PwNjyZCE5XRLDxUHJm6jtpIweB252cw+dw9lYbjmV0iw0NRCiLCL3WYvSh5wQCv6YB
         vKBV0xx+XxtWBAxIe/o+XZmXgfS2Hs2oRFaLejCI=
Date:   Fri, 10 Apr 2020 08:33:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 8/9] block: genhd: export-GPL generic disk device type
Message-ID: <20200410063357.GA1663942@kroah.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
 <20200409193543.18115-9-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409193543.18115-9-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 03:35:42PM -0400, Mathieu Desnoyers wrote:
> Iteration on class devices is exported for use by GPL modules, but
> there is no exported function for getting the generic disk device type
> which is required to perform iteration on the generic disks.
> 
> Export a new getter for disk device type for use by GPL modules. This is
> useful for tracing a meaningful list of block devices from tracers
> implemented as GPL modules.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  block/genhd.c         | 9 +++++++++
>  include/linux/genhd.h | 2 ++
>  2 files changed, 11 insertions(+)

I understand your need here, however we do not export things for
modules, when there are no in-kernel module users, sorry.

I have your last thread somewhere in my todo pile, to try to respond as
to how to make this not be an issue for you, sorry I haven't gotten to
it.

Why can't you just add a tracepoint instead of having to dig through
this mess?  Wouldn't that solve a lot of these issues for block devices?

thanks,

greg k-h
