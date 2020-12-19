Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368642DEE56
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgLSLBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 06:01:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:50979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgLSLBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 06:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608375575;
        bh=Sm0KEeivfCSGkhYBFSQzrl+3S9zeurR5ZEKJwy/t8Ko=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IEubuhqKOH9ZJITg1BsZEBkQ3DH0ICHmRQv+6p06lbFPWYmbQ3GaZ0cKMtJz2g0jI
         akc0o/o7AsX9zEHsXB4LJOPOhvRb1cd5s/ICsTSr5teEADXMfFOwj96NZFVk3xPCrD
         eBP8qF9wYx6C0w3f9r/5r6JBNPXXHNyeeLxMkUl0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1kqr4e08ix-000pe6; Sat, 19
 Dec 2020 11:59:35 +0100
Message-ID: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
Subject: Re: [patch] zswap: fix zswap_frontswap_load() vs
 zsmalloc::map/unmap() might_sleep() splat
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 19 Dec 2020 11:59:33 +0100
In-Reply-To: <CAM4kBBJZDqZfk+w5Wv4Ye7JythQ-Sr5-==zxeq8M5WCnHpFtEA@mail.gmail.com>
References: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de>
         <aa9be27f0d247db1b25da55901b975d78537db3d.camel@gmx.de>
         <CAM4kBBJYZzbXAixrKvy9MeO2eUsVVi8=iUBUc+pbSMXudy7hkw@mail.gmail.com>
         <6946d6e798866276f0d635f219cdd4ad05156351.camel@gmx.de>
         <CAM4kBBJZDqZfk+w5Wv4Ye7JythQ-Sr5-==zxeq8M5WCnHpFtEA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H1qM+XieyYJ5XxGNZGXLrMgGY6KxifsgBXFl13LTsezN16W1G3D
 LVcrl/BpSxi4JEgkgWsF2tX8Q4LuuQhaP1jFMDz9XgaoaRcafM/8aA8k0U7140dA/Vuz9ED
 w2RN4bUCqyAY5xG0q5RFYwt+g5SMQyFvfJ26wyxb//+/90kfvVr1dwAb22OgtNeNFtJvmMb
 5lYm6sRNCewl2mZEDGCjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u0vBkrP4qEM=:l/AkobQXgw0LIW6hNsnSp0
 JgODlteCnls/7zCxzc3+Dvc1kugVRFV4TqUCAjDPRGSz7mivIQKpUtN9PmTp2OPzveHA8G7uK
 zO2dQalru9WE+8EdAbBczE7GuMu/5JoMez40nh8bV31fmrsbM4XpzLdhcG47gpKuD315f2ig0
 3t6p0E42/LW93isf3RFfbuXUhbVyB9Fq9VrhgAwMr3yqDPtUFJsWd35e0ehdfhhZBsjiBEqWF
 wKpxblRtwjkvtKbY3+OzkS975boj15vCe/KZVaf9d4sjUr2MQbJ6AbHQS2SS9UttJy7xAo/yi
 IJ1X7p2EL9SeyFWm4z6Uw59+Klh9f7NhjX+wBIBfs9/BnBfkx2oY0EjwanhhaEOrsV12aYSXE
 mBCPIsIsir2l9A3E5Ke8xipMXPHlQbtEeEMRk6QXF3D5qA8hC2WV63aZdH74CJnLw3JPXKbix
 7NjBLXD7LzwdaRm5J/M+zcjGw3cswVMJEqftew9KLtTyv1iCbDiyBtXnVdyhg2bPDcBQzea8C
 g4UWIaqlItyW2aKamtj7LDlNu5x7JdNfWtpM/U2IRSlOskqCcRuYJc6H1SwU54kxwAWXPHJCV
 il4gRD2nyR9EcVmRp2GzG1u+gJqbKgTx5e+ziU327uh+wo6dStjK/jy2dvYVpqcabH+HXB9Pw
 iZ4cLFfs8zGbWWVDsfgVxKwabhMIFkpY8QnzRAMC+dFHs1f2dYYL4yAayLG6hDbhfKFwzZJjJ
 0g+QzXc44if5hju/tMvCriIKltGbzdAAXxRgelhYpSnpTH438ecT3QjXum9WGebLVZaYJNkMY
 KYJK12rkyhl+vXvmsW2S7MTLYgug7ZQnhbNJFb1i1pQmbJUDAedR5FIVzQdfdZsk7TVerh+rA
 TUwfJituVrZnruO+84yA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-12-19 at 11:46 +0100, Vitaly Wool wrote:
> On Sat, 19 Dec 2020, 11:27 Mike Galbraith, <efault@gmx.de> wrote:
>
> > The kernel that generated that splat was NOT an RT kernel, it was plai=
n
> > master.today with a PREEMPT config.
>
>
> I see, thanks. I don't think it makes things better for zsmalloc
> though. From what I can see, the offending code is this:
>
> >        /* From now on, migration cannot move the object */
> >        pin_tag(handle);
>
> Bit spinlock is taken in pin_tag(). I find the comment above somewhat
> misleading, why is it necessary to take a spinlock to prevent
> migration? I would guess an atomic flag should normally be enough.
>
> zswap is not broken here, it is zsmalloc that needs to be fixed.

Cool, those damn bit spinlocks going away would be a case of happiness
for RT as well :)

	-Mike

