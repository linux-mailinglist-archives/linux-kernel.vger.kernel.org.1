Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7223D2DFB51
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgLULER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLULEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:04:12 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88692C061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:03:32 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CzxR61Qksz9sW0; Mon, 21 Dec 2020 22:03:29 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, nathanl@linux.ibm.com,
        cheloha@linux.ibm.com, paulus@samba.org
In-Reply-To: <20201211145954.90143-1-ldufour@linux.ibm.com>
References: <20201211145954.90143-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH] powerpc/memhotplug: quieting some DLPAR operations
Message-Id: <160854857884.1696279.4074633690507075582.b4-ty@ellerman.id.au>
Date:   Mon, 21 Dec 2020 22:03:29 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 15:59:54 +0100, Laurent Dufour wrote:
> When attempting to remove by index a set of LMB a lot of messages are
> displayed on the console, even when everything goes fine:
> 
>  pseries-hotplug-mem: Attempting to hot-remove LMB, drc index 8000002d
>  Offlined Pages 4096
>  pseries-hotplug-mem: Memory at 2d0000000 was hot-removed
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/memhotplug: Quieten some DLPAR operations
      https://git.kernel.org/powerpc/c/20e9de85edae3a5866f29b6cce87c9ec66d62a1b

cheers
