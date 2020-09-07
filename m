Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC45B25FC08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgIGO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 10:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgIGOWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:22:08 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4378821481;
        Mon,  7 Sep 2020 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599488527;
        bh=T0OLbhI3b6Sj7Jv2x6WXbH/uamfr/jukm5TLqaMkvf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckECwtrM3NnyvKb9RcZ1ux02kwtc167Z79WuPxdKnxHssx2/1+BjKoTkbZ79ETUQD
         AF79MIo3eY/rPd2Sx3VITyYhAAKu4XnTUkIQEphVwIfXDc3CcmBVNoFEswXaeCpvlR
         kND3li/EzcessCRkdQ4EDUDTI71ug77tl3J4TEvY=
Date:   Mon, 7 Sep 2020 10:22:06 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     David Brazdil <dbrazdil@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [BUG]: KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
Message-ID: <20200907142206.GL8670@sasha-vm>
References: <3750C774-62A4-4D02-8C07-6C98304F32F3@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3750C774-62A4-4D02-8C07-6C98304F32F3@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 03:29:40PM +0200, H. Nikolaus Schaller wrote:
>Hi,
>it seems as if your patch
>
>34f379956e9d7 ("KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe")
>[ Upstream commit b38b298aa4397e2dc74a89b4dd3eac9e59b64c96 ]
>
>fails to compile in v5.8.7 for me (using an aarch64 gcc 4.9 cross-toolchain to try
>to build a kernel for the PinePhone):
>
>  CC      arch/arm64/kvm/hyp/switch.o - due to target missing
>arch/arm64/kvm/hyp/switch.c: In function 'hyp_panic':
>arch/arm64/kvm/hyp/switch.c:904:2: error: impossible constraint in 'asm'
>  asm volatile("ldr %0, =%1" : "=r" (str_va) : "S" (__hyp_panic_string));
>  ^

Does upstream build correctly for you?

>I can find the commit b38b298aa4397e2dc74a89b4dd3eac9e59b64c96 in upstream
>but not the affected file. There is also "KVM: arm64: Split hyp/switch.c to VHE/nVHE"
>which does a cleanup and rename and v5.9-rc4 compiles fine.

Right, it got moved around in upstream.

-- 
Thanks,
Sasha
