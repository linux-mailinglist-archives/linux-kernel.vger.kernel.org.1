Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0082C3F69
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgKYL5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:57:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgKYL5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:57:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsh1mWhz9sVH; Wed, 25 Nov 2020 22:57:44 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <7719261b0a0d2787772339484c33eb809723bca7.1604854583.git.christophe.leroy@csgroup.eu>
References: <7719261b0a0d2787772339484c33eb809723bca7.1604854583.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/3] powerpc/64s: Replace RFI by RFI_TO_KERNEL and remove RFI
Message-Id: <160630540395.2174375.17643495756840274633.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:44 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Nov 2020 16:57:35 +0000 (UTC), Christophe Leroy wrote:
> In head_64.S, we have two places using RFI to return to
> kernel. Use RFI_TO_KERNEL instead.
> 
> They are the two only places using RFI on book3s/64, so
> the RFI macro can go away.

Applied to powerpc/next.

[1/3] powerpc/64s: Replace RFI by RFI_TO_KERNEL and remove RFI
      https://git.kernel.org/powerpc/c/879add7720172ffd2986c44587510fabb7af52f5
[2/3] powerpc: Replace RFI by rfi on book3s/32 and booke
      https://git.kernel.org/powerpc/c/120c0518ec321f33cdc4670059fb76e96ceb56eb
[3/3] powerpc: Remove RFI macro
      https://git.kernel.org/powerpc/c/62182e6c0faf75117f8d1719c118bb5fc8574012

cheers
