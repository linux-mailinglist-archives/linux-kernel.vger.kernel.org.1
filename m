Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D212245D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 23:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGQVXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 17:23:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQVXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:23:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595020985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqtI6EiB7mOcwCfFO3WPvl/6fIqVgqNmA2OgwcZSNYc=;
        b=yXJCCWg8jvuJZrMpaIjHQIA2BrZJXbSgP18sKOH5fl5gzOlTdfW5KzimvrBAkyVIKIhNIc
        Qc7MuIzXfrl0aYXfI+sJZS9mPrbjIst0BRwLTmNKknFUV1AsjMI4cSc2FaEz4evUk0EguZ
        prTJe8+kHpYwKoQNxWU0cCkWOWG9ZZe9MOFgHx1qgB91x8CPmX10bC0kOZdWUtBBuJesbP
        u28gXjOvOlbmnafZY6K1N6wEbc7TPu4mLUfwBoCjHaCFp+p+L2dv1EAxxuQ/kVzfDFwp0n
        ikCByET1uw2+RngYkxy3q6pDv/PZoq4Mahlzj/kySbhh151IGyCgyqAVFEoWOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595020985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqtI6EiB7mOcwCfFO3WPvl/6fIqVgqNmA2OgwcZSNYc=;
        b=X0rLa96XsNFR77q+6j/HTaBVRRklQwEX1WKTYRLZbt2VUufCvmNPcUl2/hQEHNtuIxpoaQ
        /T7ssvPWsbaGoNCQ==
To:     "Saidi\, Ali" <alisaidi@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86\@kernel.org" <x86@kernel.org>,
        "Herrenschmidt\, Benjamin" <benh@amazon.com>,
        Ali Saidi <aliaidi@amazon.com>, Marc Zyngier <maz@kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] genirq/affinity: Handle affinity setting on inactive interrupts correctly
In-Reply-To: <BBA90891-8A4A-4A39-BF51-13EECDE414F1@amazon.com>
References: <BBA90891-8A4A-4A39-BF51-13EECDE414F1@amazon.com>
Date:   Fri, 17 Jul 2020 23:23:04 +0200
Message-ID: <87blkdrg3r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ali,

"Saidi, Ali" <alisaidi@amazon.com> writes:

can you pretty please fix your mail setup. Your replies lack the
following headers:

  In-Reply-To:
  References:

but carry some useless Microsoft gunk instead:

  Thread-Topic: [PATCH] genirq/affinity: Handle affinity setting on inactive
    interrupts correctly
  Thread-Index: AQHWXE5yOF+Kj67jZUWJl7gBhLLD9A==

which is non RFC and not documented. Evolution has some magic hack to
decode this mess, but all mail readers which rely on the documented RFC
fields including archives:

  https://lore.kernel.org/lkml/BBA90891-8A4A-4A39-BF51-13EECDE414F1@amazon.com/

fail to properly thread your mails. That sucks.

> Tested on an arm64 system that originally experienced the issue and couldn't reproduce it with this patch.
> Tested-by: Ali Saidi <alisaidi@amazon.com>

Nevertheless, thanks for confirming that it solves the problem :)

       tglx
