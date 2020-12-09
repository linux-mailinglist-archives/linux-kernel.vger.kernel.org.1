Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A7A2D4C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgLIVEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLIVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:04:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E52EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 13:03:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607547796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=hNj079rC8GX5zfhsejFcRe+fUy18shN+tw2tIy22n68=;
        b=tfGrf6ucHKdubpqgU5nra0rYDWqvB0mIeri1Uqo1FyyEnFIEhEUNXO3+Lnc8bnkJsA4eHL
        0fin5E7QTBnkNC/ygxpJIkzt+GIBeW/S4NBuYI36+B+5Siq0tkX5m9ALwNh2W+2jjnvSyM
        00GfY+TQDq4Z5KL+4g03Ix2//g6i/0Ets34gKCx3ppzQ0g5RXVawvo++SF/MdNVoWrQfzZ
        8Gf3dYxdP1/07TJ0hldpbe0xmrWvZIPsXQaOFBbf6i/QhlWbqeRJc7Gjvfh4swJhUTeEzR
        iYnzzG7c+XHDEGxMxATdw20P+08Ot/jlViISPGpc6V3AgSlZwK53m1G3URv3eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607547796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=hNj079rC8GX5zfhsejFcRe+fUy18shN+tw2tIy22n68=;
        b=RhXZJZRElncI738YJE3Yz7QMi9kllsKSf21gQ7U6c7lGF3UGbJIOoJN6RM8ni0BsqF6DzW
        qQfu/RWtRA5lKeBw==
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, luto@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 01/12] x86/xen: use specific Xen pv interrupt entry for MCE
In-Reply-To: <20201120114630.13552-2-jgross@suse.com>
Date:   Wed, 09 Dec 2020 22:03:15 +0100
Message-ID: <877dpqlmjw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20 2020 at 12:46, Juergen Gross wrote:

> Xen PV guests don't use IST. For machine check interrupts switch to
> the same model as debug interrupts.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
