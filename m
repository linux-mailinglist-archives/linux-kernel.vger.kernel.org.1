Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9751F7110
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFKXx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 19:53:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:43897 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgFKXxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:53:25 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 05BNqwH1028941;
        Thu, 11 Jun 2020 18:52:58 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 05BNquVt028940;
        Thu, 11 Jun 2020 18:52:56 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 11 Jun 2020 18:52:56 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     patch-notifications@ellerman.id.au, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, paulus@samba.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200611235256.GL31009@gate.crashing.org>
References: <49YBKY13Szz9sT4@ozlabs.org> <20200611224355.71174-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611224355.71174-1-ndesaulniers@google.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:43:55PM -0700, Nick Desaulniers wrote:
> Segher, Cristophe, I suspect Clang is missing support for the %L and %U
> output templates [1].

The arch/powerpc kernel first used the %U output modifier in 0c176fa80fdf
(from 2016), and %L in b8b572e1015f (2008).  include/asm-ppc (and ppc64)
have had %U since 2005 (1da177e4c3f4), and %L as well (0c541b4406a6).

> I've implemented support for some of these before
> in Clang via the documentation at [2], but these seem to be machine
> specific?

Yes, almost all output modifiers are.  Only %l, %a, %n, and part of %c
are generic (and %% and %= and on some targets, %{, %|, %}).

> Can you please point me to documentation/unit tests/source for
> these so that I can figure out what they should be doing, and look into
> implementing them in Clang?

The PowerPC part of
https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
(sorry, no anchor) documents %U.

Traditionally the source code is the documentation for this.  The code
here starts with the comment
      /* Write second word of DImode or DFmode reference.  Works on register
         or non-indexed memory only.  */
(which is very out-of-date itself, it works fine for e.g. TImode as well,
but alas).

Unit tests are completely unsuitable for most compiler things like this.

The source code is gcc/config/rs6000/rs6000.c, easiest is to search for
'L' (with those quotes).  Function print_operand.

HtH,


Segher
