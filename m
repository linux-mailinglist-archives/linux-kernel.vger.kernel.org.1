Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B797A1E6AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406526AbgE1T2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406311AbgE1T2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:28:37 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9BC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:28:37 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeOCf-00H5MF-4A; Thu, 28 May 2020 19:28:33 +0000
Date:   Thu, 28 May 2020 20:28:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200528192833.GQ23230@ZenIV.linux.org.uk>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
 <20200528190555.GO23230@ZenIV.linux.org.uk>
 <CAHk-=wi3dVgSn8xMC2Uqs8aahFfeqO0Wue2KqxnDYrbBM+6uZQ@mail.gmail.com>
 <20200528191712.GP23230@ZenIV.linux.org.uk>
 <CAHk-=whsZ_en9wEwk+VuAGMXACcSDCYhMD-GmQER0snpp9S6yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whsZ_en9wEwk+VuAGMXACcSDCYhMD-GmQER0snpp9S6yg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:19:32PM -0700, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 12:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Might make sense to change the summary of that pull request to something
> > like
> >         make sure we don't forget to report the xstate components that happen
> > to be in init state - both for coredump and for PTRACE_GETREGSET
> 
> Note that this has nothing to do with x86 per se.
> 
> It's more about ->getregs() being a horrid interface, and being easy
> to get wrong in general. The fact that xstate is complex is just one
> such trigger.

The only one I've ran into so far, fortunately...  Almost all instances
write sequentially; the only exceptions are this one (buggy) and ia64
horrors with unwind.

I certainly agree that ->get() is an atrocity...
