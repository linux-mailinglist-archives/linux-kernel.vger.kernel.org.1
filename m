Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5C1E5C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgE1Jl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 05:41:59 -0400
Received: from foss.arm.com ([217.140.110.172]:50144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgE1Jl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:41:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72C9D6E;
        Thu, 28 May 2020 02:41:58 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DABC3F6C4;
        Thu, 28 May 2020 02:41:56 -0700 (PDT)
Date:   Thu, 28 May 2020 10:41:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Smith <Peter.Smith@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Victor Campos <Victor.Campos@arm.com>,
        "david.spickett@linaro.org" <david.spickett@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
Message-ID: <20200528094154.GB2961@gaia>
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
 <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com>
 <CAKwvOdn1W4C5HRJEch5PS-Atcmysh0UD+VZX_wi8tviGwhmM7Q@mail.gmail.com>
 <CAKwvOd=Zxm9TDPNd4Qvn6Ru==FLasiP1xWXMM7ji08VWRjBu2g@mail.gmail.com>
 <VI1PR08MB319868AFBEDCD0925C53701AF88E0@VI1PR08MB3198.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR08MB319868AFBEDCD0925C53701AF88E0@VI1PR08MB3198.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:05:08AM +0100, Peter Smith wrote:
> I suggest using Arm if you need a frame pointer, and disable the
> frame pointer if you want/need to use Thumb. My understanding is that
> runtime unwinding using the frame pointer in Thumb is already difficult
> due to Arm and Thumb functions using different registers for the frame
> pointer.

IIRC from the Thumb-2 kernel porting days, even in the absence of
ARM/Thumb interworking, the Thumb-2 frame pointer was pretty useless for
unwinding since it points to the bottom of the current stack frame (the
reason I think is that some LDR/STR instructions with negative indexing
are not available). So finding the previous frame pointer was not
possible and had to rely on the exception unwinding information.

-- 
Catalin
