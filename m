Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44878222302
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGPMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:55:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:55:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPg1xcLz9sTk; Thu, 16 Jul 2020 22:55:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        corbet@lwn.net, Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <261923c075d1cb49d02493685e8585d4ea2a5197.1593698951.git.christophe.leroy@csgroup.eu>
References: <261923c075d1cb49d02493685e8585d4ea2a5197.1593698951.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] docs: powerpc: Clarify book3s/32 MMU families
Message-Id: <159490400710.3805857.5851125255446308712.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:50 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 14:09:21 +0000 (UTC), Christophe Leroy wrote:
> Documentation wrongly tells that book3s/32 CPU have hash MMU.
> 
> 603 and e300 core only have software loaded TLB.
> 
> 755, 7450 family and e600 core have both hash MMU and software loaded
> TLB. This can be selected by setting a bit in HID2 (755) or
> HID0 (others). At the time being this is not supported by the kernel.
> 
> [...]

Applied to powerpc/next.

[1/1] docs: powerpc: Clarify book3s/32 MMU families
      https://git.kernel.org/powerpc/c/7d38f089731fe129a49e254028caec6f05420f18

cheers
