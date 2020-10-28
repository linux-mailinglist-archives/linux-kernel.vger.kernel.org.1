Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B654329DA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbgJ1XQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgJ1XQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:16:21 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1AC206FB;
        Wed, 28 Oct 2020 23:16:18 +0000 (UTC)
Date:   Wed, 28 Oct 2020 19:16:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH 0/2] ftrace: Add access to function arguments for
 all callbacks
Message-ID: <20201028191616.0268d32a@oasis.local.home>
In-Reply-To: <20201028230305.zhtpwektsehh54bv@ast-mbp.dhcp.thefacebook.com>
References: <20201028131542.963014814@goodmis.org>
        <20201028213303.shosfclmhxkai2ir@ast-mbp.dhcp.thefacebook.com>
        <20201028180753.238335d1@oasis.local.home>
        <20201028230305.zhtpwektsehh54bv@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 16:03:05 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> I don't understand what you're trying to say.
> Are we still discussing your patch or something else?
> If your patch then, I said, I'm not against it. I just don't see
> a value in it. Since you're agree that regs_get_kernel_argument()
> is misleading then what's the point of the patch?

I agree that it can be meaningless, but it can also be useful for
debugging purposes. It works just fine on x86_32 (even when you access
4 or more arguments). One just needs to understand the arch (as a long
long will be broken up across "two" arguments). But even that is really
useful for finding out what's going on.

> To make mini-SAVE_REGS version? For what kind of use case?

If the types of the arguments are known, and you have a mini-SAVE_REGS,
can't you still get the true arguments?

-- Steve
