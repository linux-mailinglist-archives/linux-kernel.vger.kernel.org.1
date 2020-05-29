Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B01E80FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgE2OxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 10:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2OxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:53:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF52C2077D;
        Fri, 29 May 2020 14:53:22 +0000 (UTC)
Date:   Fri, 29 May 2020 10:53:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/ftrace: Distinguish between hist and
 synthetic event checks
Message-ID: <20200529105321.0bcf3219@oasis.local.home>
In-Reply-To: <20200529233845.25d975c6b23d62da1dfb75cb@kernel.org>
References: <cover.1590693308.git.zanussi@kernel.org>
        <af36c539006ef2768114b4ed38e6b054f7c7a3bd.1590693308.git.zanussi@kernel.org>
        <20200529233845.25d975c6b23d62da1dfb75cb@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 23:38:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Tom,
> 
> On Thu, 28 May 2020 14:32:38 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > With synthetic events now a separate config item as a result of
> > 'tracing: Move synthetic events to a separate file', tests that use
> > both need to explicitly check for hist trigger support rather than
> > relying on hist triggers to pull in synthetic events.
> > 
> > Add an additional hist trigger check to all the trigger tests that now
> > require it, otherwise they'll fail if synthetic events but not hist
> > triggers are enabled.  
> 
> OK, this looks good to me. And if you don't want to repeat it,
> you can also put the check function into the test.d/functions.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Tom and Masami. I'm running tests on these now.

-- Steve

