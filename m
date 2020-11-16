Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5512B5254
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbgKPUSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbgKPUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:16:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:16:36 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605557794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VkNULh6T8WGzhvvLk7gt6UgWlaPp9scoTi7y2EvfOrw=;
        b=KoYgKlnsSI3ZVU0QCsl7GYWhd59PSz3fuP3NRLjGhrJcGZnQBvCxA8J5fh/I25gsJ527g3
        PJFz+kB6UToF+2Al6TKqhjXBOoNnRUa8itFmGWM8G/L2ucx8EG607kO37YpFdR1PLx3L8p
        ohaXv8fAsfTXukEbM/Dq8nKsYQmfQS4DvgRcUpOeOFGmysRSGCIj+9hEnLAPllmDpFl2vv
        TY1CoSkLLjqUAmZlWHJ0Rzdz9K0yXpAb4Sg/6LjZr7Q6b2WaIEZ++PngpRlkV8/txPujf7
        XQuolQbr6A1TGUxjlie4Etwr8ez4lKE/DaIauxU7jyaGg4XNtm7gFFZ79QYwWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605557794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VkNULh6T8WGzhvvLk7gt6UgWlaPp9scoTi7y2EvfOrw=;
        b=hg2rHj8mxp/rZKBA6gpK7SViC925O4JtN1IYdBpjroSdDPS8U+QQSzX/0DE2WPLpd3Mwu1
        POSkX6rjSxf8TjBA==
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2] xtensa/mm/highmem: Make generic kmap_atomic() work correctly
In-Reply-To: <20201116193253.23875-1-jcmvbkbc@gmail.com>
References: <20201116193253.23875-1-jcmvbkbc@gmail.com>
Date:   Mon, 16 Nov 2020 21:16:34 +0100
Message-ID: <87pn4dxdjx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 11:32, Max Filippov wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The conversion to the generic kmap_atomic() implementation missed the fact
> that xtensa's fixmap works bottom up while all other implementations work
> top down. There is no real reason why xtensa needs to work that way.
>
> Cure it by:
>
>   - Using the generic fix_to_virt()/virt_to_fix() functions which work top
>     down
>   - Adjusting the mapping defines
>   - Using the generic index calculation for the non cache aliasing case
>   - Making the cache colour offset reverse so the effective index is correct
>
> While at it, remove the outdated and misleading comment above the fixmap
> enum which originates from the initial copy&pasta of this code from i386.
>
> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
> Fixes: 629ed3f7dad2 ("xtensa/mm/highmem: Switch to generic kmap atomic")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> Tested-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - fix off-by-one error in kmap_idx calculation

Duh. Indeed.

Thanks for following up and helping with this. Much appreciated!

     tglx
