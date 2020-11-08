Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722DB2AAE25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 00:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgKHXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 18:07:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47710 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKHXHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 18:07:17 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604876836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2GMvMxuw9C07O50HklVxv9DDobdLyUS5hM1A7VEEQM=;
        b=HHy8ULY458RylAle8YXvD/j7zwAqn7icr8I6jVfaHDPCeywD4Uml3UPq0sAKsnNgV+iRZl
        0A4lRPLJ1y5o3yLs0KRQPv40kMD9rGLjz791pa7+jY/tb8L/INs13fGD2gpdzAwXED6UzU
        xGYQHtxBd6T5PGMp7+Cz9DGnbCupFvLBLYH9tMTW1cVOmdF4CbANIrz1r4j7KgdqPGFBUQ
        7yIde0+5JB6jj9udHhahRAz1i7nctrkrIEGSCNrYidNrhXohay4cOyFlnqcWVhUO22NOm+
        BeYhPJj01JaSvLKyX4txkyTgGWbBaOrDXnVd73O7MxdG6wEHUhlCb9QOpQ2fJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604876836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2GMvMxuw9C07O50HklVxv9DDobdLyUS5hM1A7VEEQM=;
        b=xPQeUFysOSPdEsVnhRBtYJntraTrcRN8CLAfjuKRb4sq3UCCJltDeoN3mgc2l+6OOtJ+Cs
        z4/cjwRW2zY3ilDA==
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v2] irq: Add reference counting to IRQ mappings
In-Reply-To: <4ed56f8d-3fe4-2d5d-6ec4-139efc742cb2@ozlabs.ru>
References: <20201029110141.94304-1-aik@ozlabs.ru> <4ed56f8d-3fe4-2d5d-6ec4-139efc742cb2@ozlabs.ru>
Date:   Mon, 09 Nov 2020 00:07:15 +0100
Message-ID: <87blg7jvmk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06 2020 at 14:06, Alexey Kardashevskiy wrote:
> Hi,
>
> This one seems to be broken in the domain associating part so please 
> ignore it, I'll post v3 soon. Thanks,

When you do that please use a proper subject line:

 [ PATCH vN ] $subsystem: Shortlog

and to find the subsystem string just run git log kernel/irq/irqdomain.c
for hints.

Thanks,

        tglx
