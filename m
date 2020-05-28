Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939031E6A39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406242AbgE1TRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405596AbgE1TRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:17:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9603C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:17:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeO1g-00H4yB-J6; Thu, 28 May 2020 19:17:12 +0000
Date:   Thu, 28 May 2020 20:17:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200528191712.GP23230@ZenIV.linux.org.uk>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <CAHk-=wgXqVTGA-HrzJZ_yboLrtQ4rK-qoz8AfwLV=PT7ke4fbA@mail.gmail.com>
 <20200528190555.GO23230@ZenIV.linux.org.uk>
 <CAHk-=wi3dVgSn8xMC2Uqs8aahFfeqO0Wue2KqxnDYrbBM+6uZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3dVgSn8xMC2Uqs8aahFfeqO0Wue2KqxnDYrbBM+6uZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:09:48PM -0700, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 12:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > It doesn't fix all problems, though - you don't get an infoleak, but
> > you do get incorrect data...
> 
> Oh, I'm not saying it should replace any fix to regset->get(). I'm
> just saying it is in addition to.
> 
> So if a regset has a reason to return less than the asked-for data, it
> can do so and there's no leak.

Might make sense to change the summary of that pull request to something
like
	make sure we don't forget to report the xstate components that happen
to be in init state - both for coredump and for PTRACE_GETREGSET
