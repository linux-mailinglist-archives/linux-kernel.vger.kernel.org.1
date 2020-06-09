Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068A11F3366
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 07:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgFIF3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 01:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFIF3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:29:06 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC4C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:29:06 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzF70kkGz9sTH; Tue,  9 Jun 2020 15:28:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Enrico Weigelt <info@metux.net>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200512214533.93878-1-leobras.c@gmail.com>
References: <20200512214533.93878-1-leobras.c@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/crash: Use NMI context for printk when starting to crash
Message-Id: <159168034498.1381411.5705399954174028060.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:58 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 18:45:35 -0300, Leonardo Bras wrote:
> Currently, if printk lock (logbuf_lock) is held by other thread during
> crash, there is a chance of deadlocking the crash on next printk, and
> blocking a possibly desired kdump.
> 
> At the start of default_machine_crash_shutdown, make printk enter
> NMI context, as it will use per-cpu buffers to store the message,
> and avoid locking logbuf_lock.

Applied to powerpc/next.

[1/1] powerpc/crash: Use NMI context for printk when starting to crash
      https://git.kernel.org/powerpc/c/af2876b501e42c3fb5174cac9dd02598436f0fdf

cheers
