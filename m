Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81E72770F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgIXM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgIXM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:27:45 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC5C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:27:44 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BxvSt6PMDz9sTr; Thu, 24 Sep 2020 22:27:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200916062129.190864-1-miaoqinglang@huawei.com>
References: <20200916062129.190864-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] powerpc/powernv: fix wrong warning message in opalcore_config_init()
Message-Id: <160095000251.26280.17374547912907976550.b4-ty@ellerman.id.au>
Date:   Thu, 24 Sep 2020 22:27:42 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 14:21:29 +0800, Qinglang Miao wrote:
> The logic of the warn output is incorrect. The two args should be
> exchanged.

Applied to powerpc/next.

[1/1] powerpc/powernv: fix wrong warning message in opalcore_config_init()
      https://git.kernel.org/powerpc/c/8ec5cb12cd957e59b0470b75d26c901aaf645bc3

cheers
