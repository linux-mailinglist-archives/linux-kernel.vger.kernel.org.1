Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2F4253F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH0Hq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:46:56 -0400
Received: from ozlabs.org ([203.11.71.1]:48159 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgH0Hqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:46:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BcZYn4Gh6z9sTj; Thu, 27 Aug 2020 17:46:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc:     daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org
In-Reply-To: <20200821104910.3363818-1-mpe@ellerman.id.au>
References: <20200821104910.3363818-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
Message-Id: <159851436069.52163.17558243673000868151.b4-ty@ellerman.id.au>
Date:   Thu, 27 Aug 2020 17:46:53 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 20:49:10 +1000, Michael Ellerman wrote:
> The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:
> 
>   linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
>   linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
>     276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
>         |  ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
      https://git.kernel.org/powerpc/c/4d618b9f3fcab84e9ec28c180de46fb2c929d096

cheers
