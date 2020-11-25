Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559232C3F67
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgKYL5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:57:47 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgKYL5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:57:46 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsf37flz9sVD; Wed, 25 Nov 2020 22:57:41 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, jakub@redhat.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <348c2d3f19ffcff8abe50d52513f989c4581d000.1603375524.git.christophe.leroy@csgroup.eu>
References: <348c2d3f19ffcff8abe50d52513f989c4581d000.1603375524.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/bitops: Fix possible undefined behaviour with fls() and fls64()
Message-Id: <160630540248.2174375.3049361746995827520.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:41 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 14:05:46 +0000 (UTC), Christophe Leroy wrote:
> fls() and fls64() are using __builtin_ctz() and _builtin_ctzll().
> On powerpc, those builtins trivially use ctlzw and ctlzd power
> instructions.
> 
> Allthough those instructions provide the expected result with
> input argument 0, __builtin_ctz() and __builtin_ctzll() are
> documented as undefined for value 0.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/bitops: Fix possible undefined behaviour with fls() and fls64()
      https://git.kernel.org/powerpc/c/1891ef21d92c4801ea082ee8ed478e304ddc6749

cheers
