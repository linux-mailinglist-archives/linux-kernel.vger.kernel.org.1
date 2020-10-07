Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23FD286135
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgJGO1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgJGO1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:27:41 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57B12076C;
        Wed,  7 Oct 2020 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602080861;
        bh=8z6QdvP0rN7EuzDy+NiuR8Fqj4BMkmiL3zk2HD4xKv0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g2NTYLGsRPvX5KG91knYvl87qiskCJOKBQ6hDXmYKsp3UyzlsXS/dXeYzqwrwQSw8
         TNVmgLdrvdGxEe27jjRqO8QzRZlxkyXxhg32yLUrViTpB2MywZ1yCH4Epii8unbjfE
         XuisOgERJVllFo0781mLgBQU/qC4NfdNdo7R2eL4=
Message-ID: <004cd4075f81c092a72a201da9b9170ccf6ff94a.camel@kernel.org>
Subject: Re: tracing: Add support for dynamic strings to synthetic events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 07 Oct 2020 09:27:39 -0500
In-Reply-To: <20201007093036.423a1b72@gandalf.local.home>
References: <d34dccd5-96ba-a2d9-46ea-de8807525deb@canonical.com>
         <20201007093036.423a1b72@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 09:30 -0400, Steven Rostedt wrote:
> On Wed, 7 Oct 2020 14:08:38 +0100
> Colin Ian King <colin.king@canonical.com> wrote:
> 
> > Hi,
> > 
> > Static analysis with Coverity has detected a duplicated condition
> > in an
> > if statement in the following commit in source
> > kernel/trace/trace_events_synth.c
> > 
> > commit bd82631d7ccdc894af2738e47abcba2cb6e7dea9
> > Author: Tom Zanussi <zanussi@kernel.org>
> > Date:   Sun Oct 4 17:14:06 2020 -0500
> > 
> >     tracing: Add support for dynamic strings to synthetic events
> > 
> > Analysis is as follows:
> > 
> > 493        for (i = 0; i < event->n_fields; i++) {
> > 
> > Same on both sides (CONSTANT_EXPRESSION_RESULT)
> > pointless_expression: The expression event->fields[i]->is_dynamic
> > &&
> > event->fields[i]->is_dynamic does not accomplish anything because
> > it
> > evaluates to either of its identical operands, event->fields[i]-
> > >is_dynamic.
> > 
> >    Did you intend the operands to be different?
> > 
> > 494                if (event->fields[i]->is_dynamic &&
> > 495                    event->fields[i]->is_dynamic)
> 
> Bah, I believe that was suppose to be:
> 
> 		if (event->fields[i]->is_string &&
> 		    event->fields[i]->is_dynamic)
> 
> I'll go and fix that.
> 

Yep, thanks for fixing that.

Acked-by: Tom Zanussi <zanussi@kernel.org>


Tom

> -- Steve
> 
> > 496                        pos += snprintf(buf + pos, LEN_OR_ZERO,
> > 497                                ", __get_str(%s)",
> > event->fields[i]->name);
> > 498                else
> > 499                        pos += snprintf(buf + pos, LEN_OR_ZERO,
> > 500                                        ", REC->%s",
> > event->fields[i]->name);
> > 501        }
> > 
> > Colin
> 
> 

