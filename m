Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB73F2D30DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgLHRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgLHRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:21:53 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF80C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:21:13 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2CE572AE;
        Tue,  8 Dec 2020 17:21:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2CE572AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607448073; bh=390xVW35NUxIwledR4CcKZWnzOPfOJL72HXy7aRYR08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VjeIGrl8J8sIlbjM70+3msIbT+yQm/8CrrMrhln0zIH2X4nOLP4g/C6qe53da7QqC
         JCCMEfGeUwYT5oIqUfpUTbrB2fA9ddqZYzI7i9WZdxr95z8v/HmOC4R6Jfr+Va04rV
         3/yssfFobkIpUL6TM64yKkbP4EUocP7+JW4gl6bIUYk0a9Qn6R4ADqC2+eGaZRxGNz
         e6xtoL/jAAXaM7vweWam7TK0GMf2YUlEHqNQYrbtkVBGKY+Cl07tzizO6M5F3wsnPM
         Epcy2ItmY5gpPUdjS+sQCwEti5jp4bpJB1+vn2WaMPN6v2rVS4RrafSQUlrymC3vIM
         C5C1qWLLPZCuw==
Date:   Tue, 8 Dec 2020 10:21:12 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: trace: fix event state structure name
Message-ID: <20201208102112.2f0dccf9@lwn.net>
In-Reply-To: <20201207181914.370d4016@gandalf.local.home>
References: <20201104122113.322452-1-dedekind1@gmail.com>
        <96720ed0aac00653f9359679665d0ed4b2cc346d.camel@kernel.org>
        <20201207181914.370d4016@gandalf.local.home>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 18:19:14 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 06 Nov 2020 14:47:46 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Artem,
> > 
> > On Wed, 2020-11-04 at 14:21 +0200, Artem Bityutskiy wrote:  
> > > From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > > 
> > > The documentation refers to a non-existent 'struct synth_trace_state'
> > > structure. The correct name is 'struct synth_event_trace_state'.
> > > 
> > > In other words, this patch is a mechanical substitution:
> > > s/synth_trace_state/synth_event_trace_state/g
> > > 
> > > Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>    
> > 
> > Thanks for fixing this!
> > 
> > Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> >   
> 
> Jon,
> 
> Can you take this patch?
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This wasn't sent to me, of course, so I was about to go digging into the
archive...until I realized I could just feed this email to b4 and
everything just happens by magic.  How did we ever get by before b4?

Anyway...applied :)

Thanks,

jon
