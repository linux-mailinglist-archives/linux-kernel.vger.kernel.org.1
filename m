Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D591F3371
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 07:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgFIF3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 01:29:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgFIF2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:48 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDv2CZyz9sTV; Tue,  9 Jun 2020 15:28:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <b459e1600b969047a74e34251a84a3d6fdf1f312.1590858925.git.christophe.leroy@csgroup.eu>
References: <b459e1600b969047a74e34251a84a3d6fdf1f312.1590858925.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Fix another build failure with CONFIG_PPC_KUAP_DEBUG
Message-Id: <159168035275.1381411.17956354294019347730.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:46 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 17:16:33 +0000 (UTC), Christophe Leroy wrote:
> 'thread' doesn't exist in kuap_check() macro.
> 
> Use 'current' instead.

Applied to powerpc/next.

[1/1] powerpc/32s: Fix another build failure with CONFIG_PPC_KUAP_DEBUG
      https://git.kernel.org/powerpc/c/74016701fe5f873ae23bf02835407227138d874d

cheers
