Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4311D22CB28
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGXQfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 12:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgGXQfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:35:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CCFA20674;
        Fri, 24 Jul 2020 16:35:30 +0000 (UTC)
Date:   Fri, 24 Jul 2020 12:35:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200724123528.36ea9c9e@oasis.local.home>
In-Reply-To: <20200724161921.GA3123@ubuntu>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
        <20200719155033.24201-3-oscar.carter@gmx.com>
        <20200721140545.445f0258@oasis.local.home>
        <20200724161921.GA3123@ubuntu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 18:19:21 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

> > The linker trick is far less intrusive, and I believe less error prone.  
> 
> If we use the linker trick, the warning -Wcast-function-type dissapears,
> but in a way that makes impossible to the compiler to get the necessary
> info about function prototypes to insert the commented check. As far I
> know, this linker trick (redirection of a function) is hidden for the
> CFI build.
> 
> So, in my opinion, the linker trick is not suitable if we want to protect
> the function pointers of the ftrace subsystem against an attack that
> modifiy the normal flow of the kernel.

The linker trick should only affect architectures that don't implement
the needed features. I can make it so the linker trick is only applied
to those archs, and other archs that want more protection only need to
add these features to their architectures.

It's much less intrusive than this patch.

-- Steve
