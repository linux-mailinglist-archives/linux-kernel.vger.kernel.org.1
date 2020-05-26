Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E181D8A02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgERVZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 17:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgERVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:25:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDA1205CB;
        Mon, 18 May 2020 21:25:31 +0000 (UTC)
Date:   Mon, 18 May 2020 17:25:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] function_graph: apply tracing option 'irq-info'
Message-ID: <20200518172529.35ec248e@gandalf.local.home>
In-Reply-To: <20200516160953.155630-1-changbin.du@gmail.com>
References: <20200516160953.155630-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 00:09:53 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The tracing option 'irq-info' is only used by function tracer by far. This
> patch makes it also against function graph tracer. Then the two tracers
> have consistent behavior of this option.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---

Sorry, the function graph tracer is unique, and yes, you need to enable
latency_format.

Note, irq_info is meaning less with the function_graph tracer, as it
doesn't change the latency_format with or without it.

This patch basically just makes the latency_format default for the
function_graph tracer, and changes default settings for no real advantage.
It will cause regressions.

-- Steve
