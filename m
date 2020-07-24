Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A522CC4B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGXRkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXRkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:40:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18702065F;
        Fri, 24 Jul 2020 17:40:21 +0000 (UTC)
Date:   Fri, 24 Jul 2020 13:40:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200724134020.3160dc7c@oasis.local.home>
In-Reply-To: <20200724133656.76c75629@oasis.local.home>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
        <20200719155033.24201-3-oscar.carter@gmx.com>
        <20200721140545.445f0258@oasis.local.home>
        <20200724161921.GA3123@ubuntu>
        <20200724123528.36ea9c9e@oasis.local.home>
        <20200724171418.GB3123@ubuntu>
        <20200724133656.76c75629@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 13:36:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Which BTW, is supported by the following architectures:
> 
>   arm
>   arm64
>   csky
>   parisc
>   powerpc
>   riscv
>   s390
>   x86

And here's a list of architectures that have function tracing but need
to be updated:

  ia64
  microblaze
  mips
  nds32
  sh
  sparc
  xtensa

> 
> All of the above architectures should not even be hitting the code
> that does the function cast. What architecture are you doing all this
> for?

Which one of the above is this patch set for?

-- Steve
