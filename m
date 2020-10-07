Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5926D286028
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgJGNaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGNaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:30:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24859206DD;
        Wed,  7 Oct 2020 13:30:38 +0000 (UTC)
Date:   Wed, 7 Oct 2020 09:30:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: tracing: Add support for dynamic strings to synthetic events
Message-ID: <20201007093036.423a1b72@gandalf.local.home>
In-Reply-To: <d34dccd5-96ba-a2d9-46ea-de8807525deb@canonical.com>
References: <d34dccd5-96ba-a2d9-46ea-de8807525deb@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Oct 2020 14:08:38 +0100
Colin Ian King <colin.king@canonical.com> wrote:

> Hi,
> 
> Static analysis with Coverity has detected a duplicated condition in an
> if statement in the following commit in source
> kernel/trace/trace_events_synth.c
> 
> commit bd82631d7ccdc894af2738e47abcba2cb6e7dea9
> Author: Tom Zanussi <zanussi@kernel.org>
> Date:   Sun Oct 4 17:14:06 2020 -0500
> 
>     tracing: Add support for dynamic strings to synthetic events
> 
> Analysis is as follows:
> 
> 493        for (i = 0; i < event->n_fields; i++) {
> 
> Same on both sides (CONSTANT_EXPRESSION_RESULT)
> pointless_expression: The expression event->fields[i]->is_dynamic &&
> event->fields[i]->is_dynamic does not accomplish anything because it
> evaluates to either of its identical operands, event->fields[i]->is_dynamic.
> 
>    Did you intend the operands to be different?
> 
> 494                if (event->fields[i]->is_dynamic &&
> 495                    event->fields[i]->is_dynamic)

Bah, I believe that was suppose to be:

		if (event->fields[i]->is_string &&
		    event->fields[i]->is_dynamic)

I'll go and fix that.

-- Steve

> 496                        pos += snprintf(buf + pos, LEN_OR_ZERO,
> 497                                ", __get_str(%s)",
> event->fields[i]->name);
> 498                else
> 499                        pos += snprintf(buf + pos, LEN_OR_ZERO,
> 500                                        ", REC->%s",
> event->fields[i]->name);
> 501        }
> 
> Colin

