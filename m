Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3941C75B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgEFQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbgEFQGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:06:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F84208CA;
        Wed,  6 May 2020 16:06:14 +0000 (UTC)
Date:   Wed, 6 May 2020 12:06:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ethon Paul <ethp@qq.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix a typo in comment "fonud"->"found"
Message-ID: <20200506120613.06d91177@gandalf.local.home>
In-Reply-To: <20200417164810.6683-1-ethp@qq.com>
References: <20200417164810.6683-1-ethp@qq.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 00:48:09 +0800
Ethon Paul <ethp@qq.com> wrote:

> +++ b/kernel/trace/trace.c
> @@ -361,7 +361,7 @@ void trace_free_pid_list(struct trace_pid_list *pid_list)
>   * @filtered_pids: The list of pids to check
>   * @search_pid: The PID to find in @filtered_pids
>   *
> - * Returns true if @search_pid is fonud in @filtered_pids, and false otherwis.
> + * Returns true if @search_pid is found in @filtered_pids, and false otherwis.
>   */

You fixed "fonud", but missed "otherwis"?

-- Steve
