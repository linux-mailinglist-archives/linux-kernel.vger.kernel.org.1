Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA420DED4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgF2U3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732150AbgF2TZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8F72538D;
        Mon, 29 Jun 2020 15:40:59 +0000 (UTC)
Date:   Mon, 29 Jun 2020 11:40:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: speed up buffer resets by avoiding
 synchronize_rcu for each CPU
Message-ID: <20200629114057.7a832299@oasis.local.home>
In-Reply-To: <20200629153511.GX9247@paulmck-ThinkPad-P72>
References: <20200625053403.2386972-1-npiggin@gmail.com>
        <20200629153511.GX9247@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 08:35:11 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Looks plausible from an RCU viewpoint:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks Nicholas, Anton and Paul,

I'll pull this in and start testing it.

-- Steve
