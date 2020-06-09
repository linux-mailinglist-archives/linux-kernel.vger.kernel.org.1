Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40A71F3360
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 07:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgFIF2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 01:28:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50689 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgFIF2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDj5Vtzz9sTG; Tue,  9 Jun 2020 15:28:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <57425c33dd72f292b1a23570244b81419072a7aa.1586945153.git.christophe.leroy@c-s.fr>
References: <57425c33dd72f292b1a23570244b81419072a7aa.1586945153.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/8xx: Reduce time spent in allow_user_access() and friends
Message-Id: <159168035023.1381411.13094899246116193614.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 10:06:09 +0000 (UTC), Christophe Leroy wrote:
> To enable/disable kernel access to user space, the 8xx has to
> modify the properties of access group 1. This is done by writing
> predefined values into SPRN_Mx_AP registers.
> 
> As of today, a __put_user() gives:
> 
> 00000d64 <my_test>:
>  d64:	3d 20 4f ff 	lis     r9,20479
>  d68:	61 29 ff ff 	ori     r9,r9,65535
>  d6c:	7d 3a c3 a6 	mtspr   794,r9
>  d70:	39 20 00 00 	li      r9,0
>  d74:	90 83 00 00 	stw     r4,0(r3)
>  d78:	3d 20 6f ff 	lis     r9,28671
>  d7c:	61 29 ff ff 	ori     r9,r9,65535
>  d80:	7d 3a c3 a6 	mtspr   794,r9
>  d84:	4e 80 00 20 	blr
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Reduce time spent in allow_user_access() and friends
      https://git.kernel.org/powerpc/c/332ce969b763553e9c4d55069e1e15aba4ea560f

cheers
