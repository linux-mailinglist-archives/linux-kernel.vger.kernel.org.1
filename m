Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8782E0D51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgLVQXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:23:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37667 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728090AbgLVQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:23:33 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 27A265C00AB;
        Tue, 22 Dec 2020 11:22:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 22 Dec 2020 11:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7l9FwVWMt0lhChPES7y4KGsYeP9
        QeYxFohpctDuoPzk=; b=fow6qqKZCy1e29PzP504o/np8ROIMv4EF4lHHVCVwsz
        /qk7EpjYDDqlFrvg8vaAF9HqdF2v6xuGZ0/HBIDEvZ0A9vkLCaHlCnEOXyZ14ezZ
        oVPugSt2xgph7SKV7EEdxqciMUsPC+WZi2evB5DE3dt2lasulz4NrH4imVZs6/Ca
        d6Ef9vBgUlRihSNKoR3j5c2w88a47sGFf9zhjpqAGdiWzWU+OiAs/CTKO4+6oLY8
        VYcq95+HQpwDy3ORiT+z4dI68VsI0uxTWDvbtlr4NI/hqHTEdVmxA+Vs9EOqaxzM
        XoiDTo943YbB9pypXMgtQCt05a9BHmcjkNZP3esGpWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7l9FwV
        WMt0lhChPES7y4KGsYeP9QeYxFohpctDuoPzk=; b=TzkByXBZ3GEBX8ayZGFwnL
        N6YbXfMQrtJqwjWg/0dUeKtGpCP6z8OkKHwEQaaposdBq9RwC3rL64RoXFvE8PsZ
        4pXneKsNBMgUrmFVv54DgrQ3zHyUO2gQImLAp70vOEOJX3b6SFXQ0ms6gh4Ltqeg
        hw8hln6myiq5cpCGry/vf0/aA4A1MQfzNwlGDHJgzYvjcYexEuICwyivDgf933q2
        e87+TVbHXnjykhgAqAgriPLoPD55bCgzOjp8D/h7S/TgmU9S4Tfg00mAZftwz56s
        dmxgHnqM0IAO30a2RJfPiuX+wGanwj9aXZRxrRGYt1/bDl/gzOcrwM+HNgVAqdPQ
        ==
X-ME-Sender: <xms:PR3iX0jEM967jLgkEUHQtbI2LwNdmxX9fTDKqR4fkfgQsAu3d25gzg>
    <xme:PR3iX9Beucht2bvRUu7XD440tECQaqwKl0y0J2P-EB73IRh1-BlUw2l_UrGi_WAQt
    WIshBWJ7DNkE661oUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtgedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeifffffeekkeeifffhteekleejhfetledvvdeileefheffveduveevleef
    lefgtdenucffohhmrghinhepvghnthhrhidrshgsnecukfhppeejuddrheeirdduleefrd
    duieeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    thihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:PR3iX8GWPMEW-3g-kbyF-1R548MJZpw2b6HtzLN4puV1zrUKFlB2Mw>
    <xmx:PR3iX1QCDVN2j9xFtkf-8ztoE4CgNb9Yfa7RDjBD5c_61N1cR4EA0A>
    <xmx:PR3iXxw6VUbMqa8fwgUiKxxbD_Ivdm7Gua8IQJ80ZSRNDGMllrB_6g>
    <xmx:Ph3iX5-xaDy9hnWKVY75VZU4TyqXyFL4k0KwZbJNXarSmpOlrM47MQ>
Received: from cisco (unknown [71.56.193.168])
        by mail.messagingengine.com (Postfix) with ESMTPA id C466A108005B;
        Tue, 22 Dec 2020 11:22:20 -0500 (EST)
Date:   Tue, 22 Dec 2020 09:22:19 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Andreas Schwab <schwab@suse.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH] riscv: return -ENOSYS for syscall -1
Message-ID: <20201222162219.GA710211@cisco>
References: <mvma6u6vkkv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvma6u6vkkv.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:52:00PM +0100, Andreas Schwab wrote:
> Properly return -ENOSYS for syscall -1 instead of leaving the return value
> uninitialized.  This fixes the strace teststuite.
> 
> Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/kernel/entry.S | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 524d918f3601..d07763001eb0 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -186,14 +186,7 @@ check_syscall_nr:
>  	 * Syscall number held in a7.
>  	 * If syscall number is above allowed value, redirect to ni_syscall.
>  	 */
> -	bge a7, t0, 1f
> -	/*
> -	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
> -	 * If yes, we pretend it was executed.
> -	 */
> -	li t1, -1
> -	beq a7, t1, ret_from_syscall_rejected
> -	blt a7, t1, 1f
> +	bgeu a7, t0, 1f

IIUC, this is all dead code anyway for the path where seccomp actually
rejects the syscall, since it should do the rejection directly in
handle_syscall_trace_enter(), which is called above this hunk. So it
seems good to me.

Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
