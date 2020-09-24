Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BFB2770F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgIXM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgIXM1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:27:41 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88190C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:27:40 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BxvSn1xplz9sTh; Thu, 24 Sep 2020 22:27:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Liu Shixin <liushixin2@huawei.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200916025026.3992835-1-liushixin2@huawei.com>
References: <20200916025026.3992835-1-liushixin2@huawei.com>
Subject: Re: [PATCH -next] powerpc/pseries: convert to use DEFINE_SEQ_ATTRIBUTE macro
Message-Id: <160094999431.26280.10958826031661937871.b4-ty@ellerman.id.au>
Date:   Thu, 24 Sep 2020 22:27:36 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 10:50:26 +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Applied to powerpc/next.

[1/1] powerpc/pseries: convert to use DEFINE_SEQ_ATTRIBUTE macro
      https://git.kernel.org/powerpc/c/96543e7352bded5d6d1a0e0022376ebdd6c1b8ab

cheers
