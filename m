Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FC2F24C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405159AbhALAZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404224AbhALAEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:04:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCCD122CA2;
        Tue, 12 Jan 2021 00:04:06 +0000 (UTC)
Date:   Mon, 11 Jan 2021 19:04:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Liu Peibao <liupeibao@163.com>
Cc:     mhiramat@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] init/main.c: sink the kernel_init to the bottom
Message-ID: <20210111190405.51bf38a6@gandalf.local.home>
In-Reply-To: <20201230060424.29097-3-liupeibao@163.com>
References: <20201230060424.29097-1-liupeibao@163.com>
        <20201230060424.29097-3-liupeibao@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 14:04:24 +0800
Liu Peibao <liupeibao@163.com> wrote:

> Remove the redundant kernel_init_freeable statement.

Why? This change only adds churn to the git history and adds more noise to
git blame. We do not need cosmetic changes like this.

-- Steve


> 
> Signed-off-by: Liu Peibao <liupeibao@163.com>
