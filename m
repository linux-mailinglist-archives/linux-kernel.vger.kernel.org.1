Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA62D5949
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389551AbgLJLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389530AbgLJLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:31:09 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35525C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:30:01 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXl0M35z9sXV; Thu, 10 Dec 2020 22:29:58 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <4fc9e30b2b09933c8dfd7a50924dfbdf9ea6a80f.1602587470.git.christophe.leroy@csgroup.eu>
References: <4fc9e30b2b09933c8dfd7a50924dfbdf9ea6a80f.1602587470.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/feature: Fix CPU_FTRS_ALWAYS by removing CPU_FTRS_GENERIC_32
Message-Id: <160756607118.1313423.13202054747271223838.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:58 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 11:11:20 +0000 (UTC), Christophe Leroy wrote:
> On 8xx, we get the following features:
> 
> [    0.000000] cpu_features      = 0x0000000000000100
> [    0.000000]   possible        = 0x0000000000000120
> [    0.000000]   always          = 0x0000000000000000
> 
> This is not correct. As CONFIG_PPC_8xx is mutually exclusive with all
> other configurations, the three lines should be equal.
> 
> [...]

Patch 2 applied to powerpc/next.

[2/2] powerpc/feature: Remove CPU_FTR_NODSISRALIGN
      https://git.kernel.org/powerpc/c/7d47034551687eb6c15e8431d897a3758fc5f83e

cheers
