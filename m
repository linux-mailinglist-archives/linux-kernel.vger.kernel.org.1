Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBD1D62EC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgEPRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 13:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgEPRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 13:15:24 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047F1206D8;
        Sat, 16 May 2020 17:15:23 +0000 (UTC)
Date:   Sat, 16 May 2020 13:15:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: do not create option file latency-format
Message-ID: <20200516131521.02005210@oasis.local.home>
In-Reply-To: <20200516161017.155791-1-changbin.du@gmail.com>
References: <20200516161017.155791-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 00:10:17 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The flag LATENCY_FMT actually is usually set by latency tracers internally.
> So I think we should not export it to userspace. This patch removes the
> option file 'latency-format' but keep the flag defined as usual.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---

Sorry, I actually do sometimes use that option for things other than
latency tracers. So NACK.

-- Steve
