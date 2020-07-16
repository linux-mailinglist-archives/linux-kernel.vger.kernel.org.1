Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8ED222314
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgGPM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgGPMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:55:56 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:55:56 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPb2Lb8z9sTg; Thu, 16 Jul 2020 22:55:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Bin Meng <bmeng.cn@gmail.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Bin Meng <bin.meng@windriver.com>
In-Reply-To: <1588394694-517-1-git-send-email-bmeng.cn@gmail.com>
References: <1588394694-517-1-git-send-email-bmeng.cn@gmail.com>
Subject: Re: [PATCH v2] powerpc: Drop CONFIG_MTD_M25P80 in 85xx-hw.config
Message-Id: <159490400462.3805857.10443151945400247524.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:46 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 21:44:54 -0700, Bin Meng wrote:
> Drop CONFIG_MTD_M25P80 that was removed in
> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")

Applied to powerpc/next.

[1/1] powerpc: Drop CONFIG_MTD_M25P80 in 85xx-hw.config
      https://git.kernel.org/powerpc/c/76f09371bc05d6eb8d5a01823c9eaab768d6e934

cheers
