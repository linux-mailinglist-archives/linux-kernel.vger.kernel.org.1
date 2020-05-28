Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC591E6336
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbgE1OEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390644AbgE1OEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:04:43 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720BC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:04:43 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49XqFj0Wktz9sRY; Fri, 29 May 2020 00:04:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b34706f8de87f84d135abb5f3ede6b6f16fb1f41.1589969799.git.christophe.leroy@csgroup.eu>
References: <b34706f8de87f84d135abb5f3ede6b6f16fb1f41.1589969799.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] Revert "powerpc/32s: reorder Linux PTE bits to better match Hash PTE bits."
Message-Id: <159067441582.2990081.4426286987662980016.b4-ty@ellerman.id.au>
Date:   Fri, 29 May 2020 00:04:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 10:23:45 +0000 (UTC), Christophe Leroy wrote:
> This reverts commit 697ece78f8f749aeea40f2711389901f0974017a.
> 
> The implementation of SWAP on powerpc requires page protection
> bits to not be one of the least significant PTE bits.
> 
> Until the SWAP implementation is changed and this requirement voids,
> we have to keep at least _PAGE_RW outside of the 3 last bits.
> 
> [...]

Applied to powerpc/fixes.

[1/1] Revert "powerpc/32s: reorder Linux PTE bits to better match Hash PTE bits."
      https://git.kernel.org/powerpc/c/40bb0e904212cf7d6f041a98c58c8341b2016670

cheers
