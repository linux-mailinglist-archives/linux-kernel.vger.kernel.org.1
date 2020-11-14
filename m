Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DC2B2C19
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 09:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKNIQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 03:16:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgKNIQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 03:16:05 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23FEF22252;
        Sat, 14 Nov 2020 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605341765;
        bh=7hOub0yazTr6Px83JNj/g8Kapi5LIIcw6G2uy0NHj1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Ke4EHpi1BKQIgItvXRVOKk0k2B7twapucLg5TuXjZJs/IOhmtWIBVBqulpNn9M94
         37Zx0EvU0cLC/f3HbMivXs3l/toQXJm2vau/kdymaAt8C3wD2gciIK5hWd9xzvNNT5
         0lwq9Om/xo0l2CbWWJxuH2CyGpC+HM2oXppGddRw=
Date:   Sat, 14 Nov 2020 09:15:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Roman Kiryanov <rkir@google.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
Message-ID: <X6+SP0RGUUAL40ty@kroah.com>
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

And more importantly, if you rely on this, are you willing to maintain
it?

thanks,

gre gk-h
