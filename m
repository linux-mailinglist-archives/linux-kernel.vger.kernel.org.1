Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4BB26DA41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIQLc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIQL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F0EC06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:42 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSn4Bj0z9sVK; Thu, 17 Sep 2020 21:27:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Wang Wensheng <wangwensheng4@huawei.com>, gustavoars@kernel.org,
        linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200914122615.65669-1-wangwensheng4@huawei.com>
References: <20200914122615.65669-1-wangwensheng4@huawei.com>
Subject: Re: [PATCH -next] drivers/macintosh/smu.c: Fix undeclared symbol warning
Message-Id: <160034201787.3339803.8589404521263533861.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:36 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 12:26:15 +0000, Wang Wensheng wrote:
> Make kernel with `C=2`:
> drivers/macintosh/smu.c:1018:30: warning: symbol
> '__smu_get_sdb_partition' was not declared. Should it be static?

Applied to powerpc/next.

[1/1] drivers/macintosh/smu.c: Fix undeclared symbol warning
      https://git.kernel.org/powerpc/c/3db8715ec9dc1d32ecafc67af9fb96508c98efe5

cheers
