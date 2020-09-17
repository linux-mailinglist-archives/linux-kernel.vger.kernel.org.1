Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA3A26DACE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIQLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgIQL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:48 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F01C061356
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:30 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSb6Xtrz9sTQ; Thu, 17 Sep 2020 21:27:27 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200914061411.3356-1-miaoqinglang@huawei.com>
References: <20200914061411.3356-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] macintosh: windfarm: use for_each_child_of_node() macro
Message-Id: <160034201750.3339803.14711940264922779536.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:27 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 14:14:11 +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() macro instead of open coding it.

Applied to powerpc/next.

[1/1] macintosh: windfarm: use for_each_child_of_node() macro
      https://git.kernel.org/powerpc/c/8f7e57e8e29c4fc788811dd4db96126272b8df91

cheers
