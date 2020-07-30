Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E18233268
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgG3Mu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3Mu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:50:27 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4524C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:50:27 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BHVcw3ljxz9sR4; Thu, 30 Jul 2020 22:50:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     dja@axtens.net, linux-kernel@vger.kernel.org
In-Reply-To: <20200724092528.1578671-1-mpe@ellerman.id.au>
References: <20200724092528.1578671-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/5] selftests/powerpc: Add test of stack expansion logic
Message-Id: <159611327263.1601380.4813279952363405661.b4-ty@ellerman.id.au>
Date:   Thu, 30 Jul 2020 22:50:24 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 19:25:24 +1000, Michael Ellerman wrote:
> We have custom stack expansion checks that it turns out are extremely
> badly tested and contain bugs, surprise. So add some tests that
> exercise the code and capture the current boundary conditions.
> 
> The signal test currently fails on 64-bit kernels because the 2048
> byte allowance for the signal frame is too small, we will fix that in
> a subsequent patch.

Applied to powerpc/next.

[1/5] selftests/powerpc: Add test of stack expansion logic
      https://git.kernel.org/powerpc/c/c9938a9dac95be7650218cdd8e9d1f882e7b5691
[2/5] powerpc: Allow 4224 bytes of stack expansion for the signal frame
      https://git.kernel.org/powerpc/c/63dee5df43a31f3844efabc58972f0a206ca4534
[3/5] selftests/powerpc: Update the stack expansion test
      https://git.kernel.org/powerpc/c/9ee571d84bf8cfdd587a1acbf3490ca90fc40c9d
[4/5] powerpc/mm: Remove custom stack expansion checking
      https://git.kernel.org/powerpc/c/773b3e53df5b84e73bf64998e4019f50a6662ad1
[5/5] selftests/powerpc: Remove powerpc special cases from stack expansion test
      https://git.kernel.org/powerpc/c/73da08f6966b81feb429af4fb3229da4cf21d6d9

cheers
