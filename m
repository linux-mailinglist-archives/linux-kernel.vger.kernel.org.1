Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5E2C3F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgKYL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:57:57 -0500
Received: from ozlabs.org ([203.11.71.1]:44437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgKYL55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:57:57 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsp6Xgnz9sVf; Wed, 25 Nov 2020 22:57:50 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20201028091551.136400-1-miaoqinglang@huawei.com>
References: <20201028091551.136400-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH] powerpc: sysdev: add missing iounmap() on error in mpic_msgr_probe()
Message-Id: <160630540026.2174375.17196584614414099920.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:50 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 17:15:51 +0800, Qinglang Miao wrote:
> I noticed that iounmap() of msgr_block_addr before return from
> mpic_msgr_probe() in the error handling case is missing. So use
> devm_ioremap() instead of just ioremap() when remapping the message
> register block, so the mapping will be automatically released on
> probe failure.

Applied to powerpc/next.

[1/1] powerpc: sysdev: add missing iounmap() on error in mpic_msgr_probe()
      https://git.kernel.org/powerpc/c/ffa1797040c5da391859a9556be7b735acbe1242

cheers
