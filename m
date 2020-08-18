Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9058B248C55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgHRRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgHRRAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:00:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD352067C;
        Tue, 18 Aug 2020 17:00:46 +0000 (UTC)
Date:   Tue, 18 Aug 2020 13:00:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kprobes: Use module_name() macro
Message-ID: <20200818130045.7bb13992@oasis.local.home>
In-Reply-To: <20200818163356.GG137138@linux.intel.com>
References: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
        <20200818234956.c616371d8766e74aef5e7bd2@kernel.org>
        <20200818163356.GG137138@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 19:33:56 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>  
> 
> Great, thank you.
> 
> When this might get included to a PR, or at minimum land to linux-next?
> 
> Just thinking what to use as the baseline for the next version of my
> main series.

I can apply this to my tree along with Masami's latest bootconfig
patches. This will be for linux-next. I don't usually push to
linux-next until around -rc3. Would that be too late?

-- Steve
