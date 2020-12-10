Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DF92D5955
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgLJLgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389450AbgLJLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:30 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430CBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:29:49 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXV5p1rz9sWy; Thu, 10 Dec 2020 22:29:45 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Alastair D'Silva <alastair@d-silva.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <ceede82fadf37f3b8275e61fcf8cf29a3e2ec7fe.1602351011.git.christophe.leroy@csgroup.eu>
References: <ceede82fadf37f3b8275e61fcf8cf29a3e2ec7fe.1602351011.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Fix verification of MMU_FTR_TYPE_44x
Message-Id: <160756607012.1313423.11395822390772039188.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:45 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Oct 2020 17:30:59 +0000 (UTC), Christophe Leroy wrote:
> MMU_FTR_TYPE_44x cannot be checked by cpu_has_feature()
> 
> Use mmu_has_feature() instead

Applied to powerpc/next.

[1/1] powerpc/mm: Fix verification of MMU_FTR_TYPE_44x
      https://git.kernel.org/powerpc/c/17179aeb9d34cc81e1a4ae3f85e5b12b13a1f8d0

cheers
