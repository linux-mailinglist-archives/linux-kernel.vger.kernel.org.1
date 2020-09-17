Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921E26DA44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIQLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIQL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:49 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58403C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:46 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSb2cRzz9sTS; Thu, 17 Sep 2020 21:27:27 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1599260540.git.fthain@telegraphics.com.au>
References: <cover.1599260540.git.fthain@telegraphics.com.au>
Subject: Re: [PATCH 0/5] powerpc/tau: TAU driver fixes
Message-Id: <160034201293.3339803.8896975580715975741.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:27 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Sep 2020 09:02:20 +1000, Finn Thain wrote:
> This patch series fixes various bugs in the Thermal Assist Unit driver.
> It was tested on 266 MHz and 292 MHz PowerBook G3 laptops.
> 
> 
> Finn Thain (5):
>   powerpc/tau: Use appropriate temperature sample interval
>   powerpc/tau: Convert from timer to workqueue
>   powerpc/tau: Remove duplicated set_thresholds() call
>   powerpc/tau: Check processor type before enabling TAU interrupt
>   powerpc/tau: Disable TAU between measurements
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/tau: Use appropriate temperature sample interval
      https://git.kernel.org/powerpc/c/66943005cc41f48e4d05614e8f76c0ca1812f0fd
[2/5] powerpc/tau: Convert from timer to workqueue
      https://git.kernel.org/powerpc/c/b1c6a0a10bfaf36ec82fde6f621da72407fa60a1
[3/5] powerpc/tau: Remove duplicated set_thresholds() call
      https://git.kernel.org/powerpc/c/420ab2bc7544d978a5d0762ee736412fe9c796ab
[4/5] powerpc/tau: Check processor type before enabling TAU interrupt
      https://git.kernel.org/powerpc/c/5e3119e15fed5b9a9a7e528665ff098a4a8dbdbc
[5/5] powerpc/tau: Disable TAU between measurements
      https://git.kernel.org/powerpc/c/e63d6fb5637e92725cf143559672a34b706bca4f

cheers
