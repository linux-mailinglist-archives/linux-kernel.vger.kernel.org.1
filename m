Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B127271A65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIUFbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUFbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:31:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287932075E;
        Mon, 21 Sep 2020 05:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600666268;
        bh=4iKPFsAEFvL8184M1uQ2hq7reNmA00dZc5hxwfKmN2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TUrfhhxtsl7CnJSbwtd4BKb6SqK55htmY4jK97AslVVA8seNWxD+1R5qL+56F7Ptz
         6t+Fa6zOdhWDWLoAz5mZcsiDFPpyrbexv/d7asFZhpQPw7NKUFRl7Rtkr+ec4AGH55
         J6E36LCZaZTnK6BF2f72ERyYMgcctFzUNeWr52go=
Date:   Mon, 21 Sep 2020 14:31:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 0/6] tools/bootconfig: Add boot-time tracing script
Message-Id: <20200921143104.d8a4716c69e507f19edba2e3@kernel.org>
In-Reply-To: <159750006069.202708.12439674123720173666.stgit@devnote2>
References: <159750006069.202708.12439674123720173666.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Can you also merge this series to tracing tree?

Thank you,

On Sat, 15 Aug 2020 23:01:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This is the 2nd version of the series to introduce scripts for the
> boot-time tracing. In this version, I just updated 4/6 according to
> Steve's comment.
> 
> Previous series is here:
>  https://lkml.kernel.org/r/159704847064.175360.3292152056631660862.stgit@devnote2
> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (6):
>       tools/bootconfig: Show bootconfig compact tree from bootconfig file
>       tools/bootconfig: Add list option
>       tools/bootconfig: Make all functions static
>       tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig
>       tools/bootconfig: Add a script to generates bootconfig from ftrace
>       tools/bootconfig: Add --init option for bconf2ftrace.sh
> 
> 
>  MAINTAINERS                              |    1 
>  tools/bootconfig/main.c                  |  147 +++++++++++++-----
>  tools/bootconfig/scripts/bconf2ftrace.sh |  199 ++++++++++++++++++++++++
>  tools/bootconfig/scripts/ftrace.sh       |  109 +++++++++++++
>  tools/bootconfig/scripts/ftrace2bconf.sh |  244 ++++++++++++++++++++++++++++++
>  tools/bootconfig/scripts/xbc.sh          |   57 +++++++
>  6 files changed, 715 insertions(+), 42 deletions(-)
>  create mode 100755 tools/bootconfig/scripts/bconf2ftrace.sh
>  create mode 100644 tools/bootconfig/scripts/ftrace.sh
>  create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh
>  create mode 100644 tools/bootconfig/scripts/xbc.sh
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
