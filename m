Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39141292F70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgJSUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:30:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:40215 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgJSUaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:30:02 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09JKOgDo021151;
        Mon, 19 Oct 2020 15:24:42 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09JKOfT6021149;
        Mon, 19 Oct 2020 15:24:41 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 19 Oct 2020 15:24:41 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc: Fix pre-update addressing in inline assembly
Message-ID: <20201019202441.GU2672@gate.crashing.org>
References: <5ffcb064f695d5285bf1faab91bffa3f9245fc26.1603109522.git.christophe.leroy@csgroup.eu> <fbcdb173cc42da62f00285dfef8c2f7d4960b5c7.1603109522.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcdb173cc42da62f00285dfef8c2f7d4960b5c7.1603109522.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:12:48PM +0000, Christophe Leroy wrote:
> In several places, inline assembly uses the "%Un" modifier
> to enable the use of instruction with pre-update addressing,

Calling this "pre-update" is misleading: the register is not updated
before the address is generated (or the memory access done!), and the
addressing is exactly the same as the "non-u" insn would use.  It is
called an "update form" instruction, because (at the same time as doing
the memory access, logically anyway) it writes back the address used to
the base register.

> but the associated "<>" constraint is missing.

But that is just fine.  Pointless, sure, but not a bug.

> Use UPD_CONSTR macro everywhere %Un modifier is used.

Eww.  My poor stomach.

Have you verified that update form is *correct* in all these, and that
we even *want* this there?


Segher
