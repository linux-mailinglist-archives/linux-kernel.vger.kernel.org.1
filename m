Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11192D4C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgLIVE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:04:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgLIVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:04:28 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607547826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vH7YX6Q8hF6owa+mw8R0RFamxdvfP3I6NKP6vgDZYXk=;
        b=4dfcI2KN69tAMiPB1RlzL+VJZBM9MiERByCXwyO77yIXJSfgKBurVkcVv/1WUd35OqMzx6
        +pOlgB5wRy4xEGOOepk2c4S5oXiKY4juJE+1UQWI7G8pNUuIxv/ltZSAGNiWUOg7wJVXYy
        IcofZHjaAmAOrUcOjze6mBHLF7ALWMq+hQSJxRIdd1OSbrQr+zkX8EBI3vkbyBshl6Gf7w
        zOgK8/ZzJx5gNn58BdUxsRBZ5Or3fntZgYXFITjFwuzr22F9yJiJeJ/hDn0aGoIqvBSc78
        wrVSsSrY2OzpSbZyaCZiiiIIJkxyrAFDFPgcPIaJ/TUYnfLbVTP9HTN0ylNqAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607547826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vH7YX6Q8hF6owa+mw8R0RFamxdvfP3I6NKP6vgDZYXk=;
        b=Y/yO9t+Cv1wex1RlcyfpDs0lGoIkdsSOId+znpJt0SIpjdwY4lFZTBM1lsCIKwK1UJn79A
        foY/KqON7X1HpbBQ==
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, luto@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 02/12] x86/xen: use specific Xen pv interrupt entry for DF
In-Reply-To: <20201120114630.13552-3-jgross@suse.com>
References: <20201120114630.13552-1-jgross@suse.com> <20201120114630.13552-3-jgross@suse.com>
Date:   Wed, 09 Dec 2020 22:03:45 +0100
Message-ID: <874kkulmj2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20 2020 at 12:46, Juergen Gross wrote:
> Xen PV guests don't use IST. For double fault interrupts switch to
> the same model as NMI.
>
> Correct a typo in a comment while copying it.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
