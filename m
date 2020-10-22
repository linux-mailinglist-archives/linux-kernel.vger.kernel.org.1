Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18B2962F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897712AbgJVQnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:43:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:45828 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503628AbgJVQnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:43:13 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 09MGbfEF008755;
        Thu, 22 Oct 2020 11:37:41 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 09MGbdTR008754;
        Thu, 22 Oct 2020 11:37:39 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 22 Oct 2020 11:37:39 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jakub@redhat.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/bitops: Fix possible undefined behaviour with fls() and fls64()
Message-ID: <20201022163739.GU2672@gate.crashing.org>
References: <348c2d3f19ffcff8abe50d52513f989c4581d000.1603375524.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348c2d3f19ffcff8abe50d52513f989c4581d000.1603375524.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 02:05:46PM +0000, Christophe Leroy wrote:
> fls() and fls64() are using __builtin_ctz() and _builtin_ctzll().
> On powerpc, those builtins trivially use ctlzw and ctlzd power
> instructions.
> 
> Allthough those instructions provide the expected result with
> input argument 0, __builtin_ctz() and __builtin_ctzll() are
> documented as undefined for value 0.

> When the input of fls(x) is a constant, just check x for nullity and
> return either 0 or __builtin_clz(x). Otherwise, use cntlzw instruction
> directly.

That looks good :-)

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
