Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85C2449CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgHNMia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 08:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgHNMia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:38:30 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8256A20866;
        Fri, 14 Aug 2020 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408709;
        bh=0gEuAbA7LGQra2UQlGQT0N95zldCnrwRgJMkV7BVvj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0DUIdELL/bJx0/ZT+IqUeVos0XlFUxiB2XDX09sWyZwZ6ZSB4qGOtG2f3n9M4H2MB
         D2Gpzfxk9VeMNeLe7Kj0YdXMnGjdXfMerXw/X+Gi59aHWnorE0CcR8DcPjUb5Ti6h4
         5EtWRzX0CcUQBZ3FDm8AU2aivkrlbKpGxs2O698s=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7989340D3D; Fri, 14 Aug 2020 09:38:27 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:38:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/18] [PATCH v7 00/18] perf: ftrace enhancement
Message-ID: <20200814123827.GD13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 08, 2020 at 10:31:23AM +0800, Changbin Du escreveu:
> The perf has basic kernel ftrace support but lack support of most tracing
> options. This serias is target to enhance the perf ftrace functionality so
> that we can make full use of kernel ftrace with perf.
> 
> In general, this serias be cataloged into two main changes:
>   1) Improve usability of existing functions. For example, we don't need to type
>      extra option to select the tracer.
>   2) Add new options to support all other ftrace functions.

Applied, sent review comments for further work, thanks!

Now it will go together with other changes to extensive build testing
and then to Linus,

- Arnaldo
