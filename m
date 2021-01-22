Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC12FFA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAVC16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:27:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbhAVC1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:27:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91D4D22DFA;
        Fri, 22 Jan 2021 02:27:13 +0000 (UTC)
Date:   Thu, 21 Jan 2021 21:27:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?iso-8859-1?Q?Gy=F6rgy?= Andrasek <jurily@gmail.com>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org
Subject: Re: [PATCH] objtool: Don't fail the kernel build on fatal errors
Message-ID: <20210122022706.GA4667@home.goodmis.org>
References: <9ec7a9531e99f461e02adc18a4124c921c0ab777.1610664286.git.jpoimboe@redhat.com>
 <545be952-908a-f125-ebb0-d96ed1e25cd5@linux.vnet.ibm.com>
 <581806c7-091e-b1f0-41f2-b770e8fd7f5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <581806c7-091e-b1f0-41f2-b770e8fd7f5b@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 08:32:35AM +0100, György Andrasek wrote:
> > This is basically a revert of commit 644592d32837 ("objtool: Fail the
> kernel build on fatal errors").
> 
> > That change turned out to be more trouble than it's worth.
> 
> ...I'm sorry, what? Fatal errors are normal for you people? Seriously? I've
> been compiling my own kernel since 2004, I've never seen one. I'd like some
> explanation on this.
>

I'm sorry, who are you? And why are you wasting our time with your drivel?

This mailing list is not a place to work on your anger management issues,
please find a therapist.

Thanks,

-- Steve

