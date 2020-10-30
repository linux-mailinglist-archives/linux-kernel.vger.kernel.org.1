Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4B2A063C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJ3NIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:08:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42376 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgJ3NIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:08:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604063328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCaYMdTrl3RnP9DiH91VC3uvp6vlZ27bXHklu69/ezs=;
        b=3ow5LXhQS3wYOfqUW6gcHW9UDA0t4QduDNbdJXHWUuCAalcVAQJ7/Am1xpy9SBMTBYGAKU
        Ithm5j3jPDk5BKmVKm/88+Z+X3Iasi1ms5VQY57UFRNMxxl6g0swnXHWK8ztKs0N/GSdnT
        /UxLVweNxE1enula+FbXnzHUc1brhvZpSoc/dSiz83oxwP4yu8/6Eenpw9jJGp817EDk0k
        PP/swJmL5EYOG9f/fRj2bvJJvJ9Dr/NTAY69BsJFu0nRmWYOTC1NCekACn06yoOQVxfTwH
        XruxyZxExREl00yVFVxsIF+zahjdQ8Ztla3bXTQVvc0sOs62q2cYojzarAoZ6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604063328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCaYMdTrl3RnP9DiH91VC3uvp6vlZ27bXHklu69/ezs=;
        b=hDdBeq3Hs6KfDQHzUMktWKE/YmSvKFFMVM8anc5fZJzJCW2ZKAj+noHlhL538R/RjgaGTe
        gdaDRqGepZubRnBQ==
To:     Lukasz Majewski <lukma@denx.de>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Cc:     GNU C Library <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support plans in Linux time namespaces
In-Reply-To: <20201030110229.43f0773b@jawa>
References: <20201030110229.43f0773b@jawa>
Date:   Fri, 30 Oct 2020 14:08:48 +0100
Message-ID: <871rhfoo7z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz,

On Fri, Oct 30 2020 at 11:02, Lukasz Majewski wrote:
> I do have a question regarding the Linux time namespaces in respect of
> adding support for virtualizing the CLOCK_REALTIME.
>
> According to patch description [1] and time_namespaces documentation
> [2] the CLOCK_REALTIME is not supported (for now?) to avoid complexity
> and overhead in the kernel.
>
> Is there any plan to add support for it in a near future?

Not really. Just having an offset on clock realtime would be incorrect
in a number of ways. Doing it correct is a massive trainwreck.

For a debug aid, which is what you are looking for, the correctness
would not really matter, but providing that is a really slippery
slope.

If at all we could hide it under a debug option which depends on
CONFIG_BROKEN and emitting a big fat warning in dmesg with a clear
statement that it _is_ broken, stays so forever and any attempt to "fix"
it results in a permanent ban from all kernel lists.

Preferrably we don't go there.

Thanks,

        tglx


