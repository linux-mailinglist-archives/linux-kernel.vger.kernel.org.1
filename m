Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259932770FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgIXM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgIXM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:28:19 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841DDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:28:19 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BxvTT1jLnz9sTh; Thu, 24 Sep 2020 22:28:12 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yang Yingliang <yangyingliang@huawei.com>
In-Reply-To: <20200917020643.90375-1-yangyingliang@huawei.com>
References: <20200917020643.90375-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next v2] powerpc/book3s64: fix link error with CONFIG_PPC_RADIX_MMU=n
Message-Id: <160094999549.26280.7851538426572891757.b4-ty@ellerman.id.au>
Date:   Thu, 24 Sep 2020 22:28:12 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 10:06:43 +0800, Yang Yingliang wrote:
> Fix link error when CONFIG_PPC_RADIX_MMU is disabled:
> powerpc64-linux-gnu-ld: arch/powerpc/platforms/pseries/lpar.o:(.toc+0x0): undefined reference to `mmu_pid_bits'

Applied to powerpc/next.

[1/1] powerpc/book3s64: fix link error with CONFIG_PPC_RADIX_MMU=n
      https://git.kernel.org/powerpc/c/bda7673d64b6c2e92423363a756caa657464e096

cheers
