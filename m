Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A433526DA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgIQLdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgIQL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:53 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A741C061797
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:51 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSp1r5Dz9sV6; Thu, 17 Sep 2020 21:27:38 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Jason Yan <yanaijie@huawei.com>, geoff@infradead.org,
        mpe@ellerman.id.au, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
In-Reply-To: <20200911020121.1464585-1-yanaijie@huawei.com>
References: <20200911020121.1464585-1-yanaijie@huawei.com>
Subject: Re: [PATCH] powerpc/ps3: make two symbols static
Message-Id: <160034201679.3339803.12983868854288470547.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:37 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 10:01:21 +0800, Jason Yan wrote:
> This addresses the following sparse warning:
> 
> arch/powerpc/platforms/ps3/spu.c:451:33: warning: symbol
> 'spu_management_ps3_ops' was not declared. Should it be static?
> arch/powerpc/platforms/ps3/spu.c:592:28: warning: symbol
> 'spu_priv1_ps3_ops' was not declared. Should it be static?

Applied to powerpc/next.

[1/1] powerpc/ps3: make two symbols static
      https://git.kernel.org/powerpc/c/bbc4f40b5322b3e0b8678619f1c613dadc811669

cheers
