Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDE22C656
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGXNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgGXNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:25:28 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAEEC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:25:27 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqh066PPz9sSt; Fri, 24 Jul 2020 23:25:20 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, haren@linux.ibm.com, paulus@samba.org,
        dave.hansen@linux.intel.com, benh@kernel.crashing.org,
        YueHaibing <yuehaibing@huawei.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200717112714.19304-1-yuehaibing@huawei.com>
References: <20200715031939.31968-1-yuehaibing@huawei.com> <20200717112714.19304-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] powerpc: Remove unneeded inline functions
Message-Id: <159559696842.1657499.8881605373645357480.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:25:20 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 19:27:14 +0800, YueHaibing wrote:
> Both of those functions are only called from 64-bit only code, so the
> stubs should not be needed at all.

Applied to powerpc/next.

[1/1] powerpc: Remove unneeded inline functions
      https://git.kernel.org/powerpc/c/a3f3f8aa1f72dafe1450ccf8cbdfb1d12d42853a

cheers
