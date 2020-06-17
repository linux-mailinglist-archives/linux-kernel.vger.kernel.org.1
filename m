Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499D71FD185
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQQGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 12:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgFQQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:06:24 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8506F2065F;
        Wed, 17 Jun 2020 16:06:23 +0000 (UTC)
Date:   Wed, 17 Jun 2020 12:06:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Maximilian Werner <maximilian.werner96@gmail.com>
Cc:     Sascha Ortmann <sascha.ortmann@stud.uni-hannover.de>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing/boottime: Fix kprobe multiple events
Message-ID: <20200617120621.652864d9@oasis.local.home>
In-Reply-To: <3e6495df-065f-34c5-8e21-65764c79d6ca@gmail.com>
References: <20200617140817.17161-1-sascha.ortmann@stud.uni-hannover.de>
        <20200617110521.7ed41fdd@oasis.local.home>
        <20200617110617.2a06c143@oasis.local.home>
        <3e6495df-065f-34c5-8e21-65764c79d6ca@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 17:57:13 +0200
Maximilian Werner <maximilian.werner96@gmail.com> wrote:

> We are a group of students from Leibniz University Hannover and
> this patch is part of a project of ours. That's why both of us
> signed this off.

Usually, if there's two people signed off, there's a comment in the
change log that states the other person worked on the patch as well.

> 
> Should we have added Masami to Cc? He didn't appear in the
> get_maintainer script.
> 

Yeah, we need to update the MAINTAINER's file to fix that. Not your
fault.

-- Steve
