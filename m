Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D036228F336
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgJONau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:30:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:40932 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgJONat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:30:49 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09FDPETm032241;
        Thu, 15 Oct 2020 08:25:14 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09FDPDfF032230;
        Thu, 15 Oct 2020 08:25:13 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 15 Oct 2020 08:25:12 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: force inlining of csum_partial() to avoid multiple csum_partial() with GCC10
Message-ID: <20201015132512.GG2672@gate.crashing.org>
References: <a1d31f84ddb0926813b17fcd5cc7f3fa7b4deac2.1602759123.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1d31f84ddb0926813b17fcd5cc7f3fa7b4deac2.1602759123.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Oct 15, 2020 at 10:52:20AM +0000, Christophe Leroy wrote:
> With gcc9 I get:

<snip>

> With gcc10 I get:

<snip>

> gcc10 defines multiple versions of csum_partial() which are just
> an unconditionnal branch to __csum_partial().

It doesn't inline it, yes.

Could you open a GCC PR for this please?

> To enforce inlining of that branch to __csum_partial(),
> mark csum_partial() as __always_inline.

That should be fine of course, but it would be good if we could fix this
in the compiler :-)

Reviewed-by: Segher Boessenkool  <segher@kernel.crashing.org>


Segher
