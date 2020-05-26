Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A8D1D875A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgERSfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 14:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgERSfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:35:15 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC7F20715;
        Mon, 18 May 2020 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589826914;
        bh=qpFj/IU4wuDcuYitZ7k/iIOn5mCOFViF3iOMVluoe3E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d9ReQy532V1ByS7jbX1M2FRCi+eBfQh+ll1kQUTltJhbdpqA2uk0RQcuoPhGeKu4U
         GjZ4QkgBP1Q5rlEOXKlEmjo23pLrhB3G+DoRvu74exDsRxnknZgos8BtrZQOy6j9iz
         8q+zt+HNGJZVJ8wcTQjkqo7yJhUa/HiMjZQJAgNo=
Message-ID: <4404e7631ba832d2090cf154e81fe290022c5c5d.camel@kernel.org>
Subject: Re: [PATCH 0/3] tracing: histogram internals doc, hist_debug, and
 misc
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 May 2020 13:35:13 -0500
In-Reply-To: <cover.1585941485.git.zanussi@kernel.org>
References: <cover.1585941485.git.zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Thanks,

Tom

On Fri, 2020-04-03 at 14:31 -0500, Tom Zanussi wrote:
> Hi Steve,
> 
> Here's the histogram internals documentation I promised awhile back
> (second patch).
> 
> Accompanying it is a new config option that enables a new hist_debug
> event file, which is used by the examples in the doc to display
> some of the histogram internals (third patch).
> 
> The first patch is just a cleanup suggested by Masami that I
> previously missed.
> 
> Thanks,
> 
> Tom
> 
> The following changes since commit
> 8e99cf91b99bb30e16727f10ad6828741c0e992f:
> 
>   tracing: Do not allocate buffer in trace_find_next_entry() in
> atomic (2020-04-03 11:30:50 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-
> trace.git ftrace/hist-design-doc-v1
> 
> Tom Zanussi (3):
>   tracing: Check state.disabled in synth event trace functions
>   tracing: Add histogram-design document
>   tracing: Add hist_debug trace event files for histogram debugging
> 
>  Documentation/trace/histogram-design.rst | 2115
> ++++++++++++++++++++++
>  kernel/trace/Kconfig                     |   23 +
>  kernel/trace/trace.h                     |    1 +
>  kernel/trace/trace_events.c              |    4 +
>  kernel/trace/trace_events_hist.c         |  292 ++-
>  5 files changed, 2419 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/trace/histogram-design.rst
> 

