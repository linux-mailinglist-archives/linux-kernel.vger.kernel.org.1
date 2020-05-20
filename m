Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5081DB73E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgETOkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 10:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgETOkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:40:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 943E0207C4;
        Wed, 20 May 2020 14:40:06 +0000 (UTC)
Date:   Wed, 20 May 2020 10:40:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] tracing/kprobes: Fix event generation API etc.
Message-ID: <20200520104005.3c525969@gandalf.local.home>
In-Reply-To: <20200520103346.53dcad9b@gandalf.local.home>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
        <20200520232220.ec89497aab17d7e6507b9886@kernel.org>
        <20200520103346.53dcad9b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 10:33:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 May 2020 23:22:20 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > It seems this fixes are not picked up yet.
> > Would you have any consideration?
> >   
> 
> 
> Ah, I missed your reply to my comment :-/
> 
> Yeah, I'll pull that in now and start testing it.
> 
> Thanks for the reminder.

No, it's already in mainline:

Merged: 192ffb7515839b1cc8457e0a8c1e09783de019d3

With commits:

 dcbd21c9fca5e954fd4e3d91884907eb6d47187e
 da0f1f4167e3af69e1d8b32d6d65195ddd2bfb64
 5b4dcd2d201a395ad4054067bfae4a07554fbd65

-- Steve

 
