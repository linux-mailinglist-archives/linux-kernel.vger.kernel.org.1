Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67123D423
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 01:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHEXWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 19:22:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:50825 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgHEXWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:22:34 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 075NMAtN018390;
        Wed, 5 Aug 2020 18:22:10 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 075NM8hF018389;
        Wed, 5 Aug 2020 18:22:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 5 Aug 2020 18:22:08 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC] saturate check_*_overflow() output?
Message-ID: <20200805232208.GT6753@gate.crashing.org>
References: <202008031118.36756FAD04@keescook> <f177a821-74a3-e868-81d3-55accfb5b161@rasmusvillemoes.dk> <202008041137.02D231B@keescook> <6d190601-68f1-c086-97ac-2ee1c08f5a34@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d190601-68f1-c086-97ac-2ee1c08f5a34@rasmusvillemoes.dk>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Wed, Aug 05, 2020 at 01:38:58PM +0200, Rasmus Villemoes wrote:
> I'm guessing gcc has some internal very early simplification that
> replaces single-expression statement-exprs with just that expression,
> and the warn-unused-result triggers later. But as soon as the
> statement-expr becomes a little non-trivial (e.g. above), my guess is
> that the whole thing gets assigned to some internal "variable"
> representing the result, and that assignment then counts as a use of the
> return value from must_check_overflow() - cc'ing Segher, as he usually
> knows these details.

A statement expression is not a statement (it's an expression), which
turns half of the world upside down.  This GCC extension often has weird
(or at least non-intuitive) side effects, together with other extensions
(like attributes), etc.

This may be a convoluted way of saying "I don't know, look at c/c-decl.c
(and maybe c/c-parser.c) to see if you can find out" ;-)


> Anyway, we don't need to apply it to the last expression inside ({}), we
> can just pass the whole ({}) to must_check_overflow() as in

<snip>

Yes, much nicer :-)  Crisis averted, etc.


Segher
