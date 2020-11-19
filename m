Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBCB2B9C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgKSVBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgKSVBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:01:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:01:04 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605819662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M4FLMJAfT7rzxFEGo9W4VWVDKp3gYsmZQ2etIBAJk+E=;
        b=dTNzyZQN2DTlDYTke/KZeFvdiXdpktntXm6/nMzucEfk9MbYec/ZwpntuaAJsuEX8y0EdP
        bl+M9fovhzxHsvpPNnoE5tVKBytIpnr5bPrDnfyq6tZXj6zjXLRIipTDeurWIOxbUZXYcS
        ie/3AhhfrNe5MCZGUqIEiI3Vl/Hs+1B3gZOEPqOhOcujMuacRzsqo2Ei4T6p00K8TJnt3/
        LNLx+YBBoHSN5HSE/vYOwBkV30A6aIFehlq+5wHyqEOv9Wi4+v1GxeKott7IHIpm8z4yWm
        WphFUzuDjQIcAW0vM3RZUMGBbbA5BU16LbYtfPoAoAwsPqyWuNeqE5euHdei9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605819662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M4FLMJAfT7rzxFEGo9W4VWVDKp3gYsmZQ2etIBAJk+E=;
        b=rSH85lXCV+xlwUkxHno1s4mD8QBIYKLO74vdaghRoy1U8BgxqgdhlGMNWKhfdGAibSGw1V
        gfQ/jrctio/b/WCA==
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: restore the write back cache of reserved RAM in iounmap()
In-Reply-To: <20201119175902.17394-2-aarcange@redhat.com>
References: <20201119175902.17394-1-aarcange@redhat.com> <20201119175902.17394-2-aarcange@redhat.com>
Date:   Thu, 19 Nov 2020 22:01:02 +0100
Message-ID: <875z61oycx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19 2020 at 12:59, Andrea Arcangeli wrote:
> If reserved memory is mapped with ioremap_noncache() or ioremap_wc(),
> the kernel correctly splits the direct mapping and marks the PAGE_SIZE
> granular region uncached, so both the virtual direct mapping and the
> second virtual mapping in vmap space will be both marked uncached or
> write through (i.e.  _PAGE_PCD/PWT set on the pagetable).
>
> However when iounmap is called later, nothing restores the direct
> mapping write back memtype.

Darn. This was discussed in 2008 already and survived that long?

  https://lore.kernel.org/lkml/20080205011357.GA14712@linux-os.sc.intel.com/

No idea how that happened to slip through...

Thanks,

        tglx

