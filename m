Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FD920E8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 01:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgF2WQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 18:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgF2WQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:16:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8AD920656;
        Mon, 29 Jun 2020 22:16:26 +0000 (UTC)
Date:   Mon, 29 Jun 2020 18:16:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paul McKenney <paulmck@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: speed up buffer resets by avoiding
 synchronize_rcu for each CPU
Message-ID: <20200629181625.4b87a63a@oasis.local.home>
In-Reply-To: <20200625053403.2386972-1-npiggin@gmail.com>
References: <20200625053403.2386972-1-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 15:34:03 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Batch these up so we disable all the per-cpu buffers first, then
> synchronize_rcu() once, then reset each of the buffers. This brings
> the time down to about 0.5s.

After applying this patch, running tools/testing/selftests/ftracetest
went from 5 minutes and 35 seconds to 5 minutes 5 seconds to complete
on my 4 core (8 with hyperthreading) machine! That's almost a 10% drop!

Thanks, I'm definitely applying this for the next merge window.

-- Steve
