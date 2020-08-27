Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D69253F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgH0HrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgH0Hq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:46:58 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570BC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:46:58 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BcZYq2qrBz9sTS; Thu, 27 Aug 2020 17:46:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     pratik.r.sampat@gmail.com, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, mikey@neuling.org, svaidy@linux.ibm.com,
        ego@linux.vnet.ibm.com, npiggin@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200826082918.89306-1-psampat@linux.ibm.com>
References: <20200826082918.89306-1-psampat@linux.ibm.com>
Subject: Re: [PATCH] Revert "powerpc/powernv/idle: Replace CPU feature check with PVR check"
Message-Id: <159851436179.52163.400542101081853718.b4-ty@ellerman.id.au>
Date:   Thu, 27 Aug 2020 17:46:54 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 13:59:18 +0530, Pratik Rajesh Sampat wrote:
> Cpuidle stop state implementation has minor optimizations for P10
> where hardware preserves more SPR registers compared to P9.
> The current P9 driver works for P10, although does few extra
> save-restores. P9 driver can provide the required power management
> features like SMT thread folding and core level power savings
> on a P10 platform.
> 
> [...]

Applied to powerpc/fixes.

[1/1] Revert "powerpc/powernv/idle: Replace CPU feature check with PVR check"
      https://git.kernel.org/powerpc/c/16d83a540ca4e7f1ebb2b3756869b77451d31414

cheers
