Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77A6233267
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgG3MuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:50:24 -0400
Received: from ozlabs.org ([203.11.71.1]:39903 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG3MuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:50:23 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BHVct0pG6z9sSt; Thu, 30 Jul 2020 22:50:21 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200728022807.87815-1-miaoqinglang@huawei.com>
References: <20200728022807.87815-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] powerpc: use for_each_child_of_node() macro
Message-Id: <159611328022.1601380.18437120131369236734.b4-ty@ellerman.id.au>
Date:   Thu, 30 Jul 2020 22:50:21 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 10:28:07 +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() macro instead of open coding it.

Applied to powerpc/next.

[1/1] powerpc: use for_each_child_of_node() macro
      https://git.kernel.org/powerpc/c/b6ac59d39a348af29477d7bfdc3ba23526e3f4ea

cheers
