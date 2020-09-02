Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6872825B23C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgIBQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 12:58:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:48253 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgIBQ6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:58:01 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 082GvO7I007572;
        Wed, 2 Sep 2020 11:57:24 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 082GvMJB007567;
        Wed, 2 Sep 2020 11:57:22 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 2 Sep 2020 11:57:22 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/vdso32: link vdso64 with linker
Message-ID: <20200902165722.GW28786@gate.crashing.org>
References: <20200901222523.1941988-1-ndesaulniers@google.com> <20200901222523.1941988-3-ndesaulniers@google.com> <b2066ccd-2b81-6032-08e3-41105b400f75@csgroup.eu> <20200902141431.GV28786@gate.crashing.org> <0c895acf-b6d7-baaf-d613-236f8be8e1fe@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c895acf-b6d7-baaf-d613-236f8be8e1fe@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:43:03PM +0200, Christophe Leroy wrote:
> >Try with a newer ld?  If it still happens with current versions, please
> >open a bug report?  https://sourceware.org/bugzilla
> 
> Yes it works with 2.30 and 2.34

Ah okay, I missed this part.

> But minimum for building kernel is supposed to be 2.23

Sure.  Tthat could be upgraded to 2.24 -- you should use a binutils at
least as new as your GCC, and that requires 4.9 now -- but that
probably doesn't help you here).


Segher
