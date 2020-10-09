Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62802887AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbgJILPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730660AbgJILPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:15:30 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BAE8222B8;
        Fri,  9 Oct 2020 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602242129;
        bh=21Or68k0xOY90CRuMzSil8s5pDdqIW0KPCdw39bpRZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UP8w2wmRln1dLhld8xI11lqaWUR6nntdLlW1sDt45nrefcxck1A+5QEV0elRloMTL
         Z/j+M5gaLLciVWXWZNkOtj6BtF/330NFfiyYwh2DBQ6BdEwuqwAag1tu7zV4XpFppY
         1CaoUzadA+PzICVKzqhUIqa5XLKPhXcjwTxmXbkY=
Date:   Fri, 9 Oct 2020 20:15:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] tracing: Add support for dynamic strings to
 synthetic events
Message-Id: <20201009201525.557af02eed5be6315d1c54a8@kernel.org>
In-Reply-To: <20201008152150.7f24dc36@gandalf.local.home>
References: <cover.1601848695.git.zanussi@kernel.org>
        <3ed35b6d0e390f5b94cb4a9ba1cc18f5982ab277.1601848695.git.zanussi@kernel.org>
        <20201008182207.7526e70da842a01e373dd8cd@kernel.org>
        <20201008152150.7f24dc36@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 15:21:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 8 Oct 2020 18:22:07 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Some of those issues are not introduced from this series. I think
> > we'd better fix those before introducing this series so that
> > we can backport it to stable kernels.
> 
> I agree that these should be fixed, but I'm not sure I want to hold off
> this series before they are.

OK, I think the last event-name issue will be separated from this patch,
but others are directly related this patch. So those need to be fixed in
this series.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
