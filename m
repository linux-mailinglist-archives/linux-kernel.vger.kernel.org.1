Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3541F2F1C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbhAKRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389495AbhAKRgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:36:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68140225AB;
        Mon, 11 Jan 2021 17:35:27 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:35:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Trace cbs accelerated without leaf rnp node lock
 held
Message-ID: <20210111123525.0e4de7e0@gandalf.local.home>
In-Reply-To: <1610365543-7669-1-git-send-email-neeraju@codeaurora.org>
References: <1610365543-7669-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 17:15:43 +0530
Neeraj Upadhyay <neeraju@codeaurora.org> wrote:

> Trace cbs which are accelerated without rnp lock help in
> rcu_accelerate_cbs_unlocked().

The above sentence does not make sense.

-- Steve

> 
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
