Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454832770F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgIXM1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:27:40 -0400
Received: from ozlabs.org ([203.11.71.1]:59269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbgIXM1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:27:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BxvSp71PSz9sTm; Thu, 24 Sep 2020 22:27:38 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200916062122.190586-1-miaoqinglang@huawei.com>
References: <20200916062122.190586-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] drivers/macintosh/smu.c: use for_each_child_of_node() macro
Message-Id: <160095000079.26280.3216920184510705261.b4-ty@ellerman.id.au>
Date:   Thu, 24 Sep 2020 22:27:38 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 14:21:22 +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() macro instead of open coding it.

Applied to powerpc/next.

[1/1] drivers/macintosh/smu.c: use for_each_child_of_node() macro
      https://git.kernel.org/powerpc/c/9c826d31a73815464bd3df81e56d39b3d908ac73

cheers
