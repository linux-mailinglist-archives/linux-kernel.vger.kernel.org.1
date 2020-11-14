Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1922B2C18
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 09:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKNIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 03:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgKNIPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 03:15:42 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31AA22252;
        Sat, 14 Nov 2020 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605341741;
        bh=rFDP3dW8r35IKw7G2fLETvckJc+HD/T2KUPXqQq2/dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtANlCUjAlXTpbF2vVDabCdLmT9zYHbPEHcj1DrsS869mp7qBRuT7JBMMYtZ/0Qa7
         ks2dvrUH0iEYYeD2eGPhxLSDujgv6b4xRoiqocC90YGYrbkW09gVgREk2IH6nomcPB
         A2QPGXrP/q4lU4nck+PjQWj0KZNqJDxCVRVmhARY=
Date:   Sat, 14 Nov 2020 09:15:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Roman Kiryanov <rkir@google.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
Message-ID: <X6+SKQS6QJr25kF0@kroah.com>
References: <20201113205233.827493-1-rkir@google.com>
 <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
 <X68aZ/Dgm7CObQmH@kroah.com>
 <tencent_3801BEAE39670E174105E007@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_3801BEAE39670E174105E007@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 04:06:24PM +0800, 陈华才 wrote:
> Hi, All,
> 
> Goldfish RTC works well on MIPS, and QEMU RISC-V emulator use Goldfish
> as well, so I think  we should keep it in kernel.

But does anyone actually use it for anything?  Having something in qemu
is nice, but not required if it doesn't provide something that is
already there for other virtual devices, right?

thanks,

greg k-h
