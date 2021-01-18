Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC18A2FABB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394408AbhARUiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:38:46 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:36705 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394349AbhARUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:38:13 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1bHH-0020q2-SZ; Mon, 18 Jan 2021 21:37:31 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1bHH-001iVL-7y; Mon, 18 Jan 2021 21:37:31 +0100
Subject: Re: [GIT PULL] ia64: fix build regression
To:     Mike Rapoport <rppt@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210118113411.GM1106298@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <388d1fc5-40fa-2f9e-3302-111c618941bd@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 21:37:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118113411.GM1106298@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/21 12:34 PM, Mike Rapoport wrote:
> The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:
> 
>   Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-01-18
> 
> for you to fetch changes up to 32c2bc8f2d855d4415c9a05b727e34649397bfbe:
> 
>   ia64: fix build failure caused by memory model changes (2021-01-17 13:31:09 +0200)
> 
> ----------------------------------------------------------------
> ia64: fix build failure caused by memory model changes
> 
> ----------------------------------------------------------------
> Mike Rapoport (1):
>       ia64: fix build failure caused by memory model changes
> 
>  arch/ia64/include/asm/sparsemem.h | 1 +
>  1 file changed, 1 insertion(+)

Since I just read this sensationalist article on Phoronix [1], I just haven't gotten
around to test 5.11 for ia64 as I was currently busy with testing all pending patches
for SH.

I will be getting around testing the ia64 build and also bisect that one issue with
the hpsa driver which was no longer usable after some change in the mm tree.

Adrian

> [1] https://www.phoronix.com/scan.php?page=news_item&px=Itanium-IA64-Linux-5.11-Broken

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

