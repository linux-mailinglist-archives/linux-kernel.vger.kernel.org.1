Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7766D2113F7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 21:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgGAT7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 15:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGAT7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:59:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20938C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:59:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqit0-003XsD-Up; Wed, 01 Jul 2020 19:59:15 +0000
Date:   Wed, 1 Jul 2020 20:59:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200701195914.GK2786714@ZenIV.linux.org.uk>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 12:04:36PM -0700, Linus Torvalds wrote:
> On Wed, Jul 1, 2020 at 11:41 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Rather nasty for ppc; they have separate user_read_access_end() and
> > user_write_access_end().
> 
> That's actually for the access granting. Shutting the access down ends
> up always doing the same thing anyway..

#define user_read_access_end            prevent_current_read_from_user
#define user_write_access_end           prevent_current_write_to_user
static inline void prevent_current_read_from_user(void)
{
        prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
}

static inline void prevent_current_write_to_user(void)
{
        prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
}

and prevent_user_access() has instances that do care about the direction...
