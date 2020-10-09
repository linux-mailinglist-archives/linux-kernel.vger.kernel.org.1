Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD532881EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbgJIGEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:04:06 -0400
Received: from ozlabs.org ([203.11.71.1]:38467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJIGEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:04:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4C6yFD4wxNz9sTK; Fri,  9 Oct 2020 17:04:00 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3c9a6eb0fc040868ac59be66f338d08fd017668d.1601549945.git.christophe.leroy@csgroup.eu>
References: <3c9a6eb0fc040868ac59be66f338d08fd017668d.1601549945.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/time: Remove ifdef in get_dec() and set_dec()
Message-Id: <160222339270.867048.7781470173395952813.b4-ty@ellerman.id.au>
Date:   Fri,  9 Oct 2020 17:04:00 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 10:59:19 +0000 (UTC), Christophe Leroy wrote:
> Move SPRN_PIT definition in reg.h.
> 
> This allows to remove ifdef in get_dec() and set_dec() and
> makes them more readable.

Applied to powerpc/next.

[1/1] powerpc/time: Remove ifdef in get_dec() and set_dec()
      https://git.kernel.org/powerpc/c/63f9d9df5ed0d4f3a2c0cd08730e1cae1edd11bf

cheers
