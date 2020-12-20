Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA22DF456
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 08:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgLTHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 02:49:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:46695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgLTHt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 02:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608450459;
        bh=hC9mkbhkVbkM2JfCnZeNhXgWTKs8omxwsyFa6gq/fVo=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=kAj4f1KmW28vhJCmT1tc6U9DRRCqnGNZC/aNTI2jQ5u/sVhm4KCHmyREBfag45Ijs
         gW3FaX5o2m8ivGl/aZgZhRG67/5uEBNjW+k8adjk9pdpr1I2RW0b4rjEanduUx5fqZ
         dDZ0aqlIzOKwLKbpDzSM03mHceFcq9693PnXaDGk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1kBWwO0Gkp-00fgCC; Sun, 20
 Dec 2020 08:47:39 +0100
Message-ID: <80d3be3d47356bf0bd6c5a9d9dc658ca3da292be.camel@gmx.de>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Date:   Sun, 20 Dec 2020 08:47:36 +0100
In-Reply-To: <c9c97ae293f5d7321ff30ac6ead49751560dd354.camel@gmx.de>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
         <20201220002228.38697-1-vitaly.wool@konsulko.com>
         <c9c97ae293f5d7321ff30ac6ead49751560dd354.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BEWUdf9ul6EOKr9afLfEzREe+fgorRGni7ZtyFo1O7O0xftClFM
 cJp58ggnNkYcFI7D2MyrVEtAagEP9lNO5O9MPdkclzr8f1bMG4zisBFioRzyCxpDrfKqlk5
 CuK3INdE+jdnxj6HrN6UmGFx3B6I7NWlZpRV4kiNopHjryejuq1wF6hDAOXGZy9rAOjoBcx
 Lb1U0Mo/KpzWytH68a+pQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:klTbygR4sAg=:gJ8fQ+VTkcrSWzunc63eJY
 8EVSuhQkDunPNgxN+aw9YaC/ofWLGHK5ztsKfpOu6xv6pHEGSsF42Ql2McqiqMJfRe8BMZP0e
 +qb5fTbdPJuMotuJN156A2Go7C3892Luw8H5Kr3JfZcBvgQsDyEb+Gaftzq/F6ddU3NctPAzO
 6QChU4VIDaKixgxpowW79zccaNvjuDCgqeamMTsK5Qk/e4BlTP4RSLY/6ULKjQ0t2Bk8Ik0WO
 kxTS1uZbYQBdk5G2HpyEaH+GGcpdsDmxJjXP/X22HqWrL0FWXWEe+7fzo1Q3E1+2LsRsr64We
 guH1gvFq45wc8wNIR6BF3fpL3v4zib9t0WSb0PntjVLI2ji2Tsx3do8jnPBsgFjskoemCG7xY
 WjAO6RHzw8SSoDzKklLyLnIFrRRC8BBHz0yIBEZECOJFm75WIkYeRdjHyCKC3seYSBeWVVaQt
 Kfd+SFJEas97DNn1/Glv6IdZE0DIrU77r5yCqTEfsA68881rKHdWMlsyNtIZ3dm795/yKp2IY
 yt8hvJXlRZ6pDh12vv7uwHHTHl+KUkyZ/FkGMSlUOJ2ESsFDS75sGZ+Xe2qjY4pBnOzRSqPZk
 0M05jxhjkffuNZ9YjzZa3L3LFAV9rfPweo0C7S7ke2H7WsPiVMSQ42XEcaMBa9C1LwIqaOKGV
 zcRwIk0VtoU/JkuiiPeympWKv0BIo8CnbQsuvAkfr9uMx4x+ZtJqJcO29oBgYnV0Tts1JOGvB
 bAaWetmmCNNCxz56nVAs+uQJ50YlaF65KDnCGNN56jdxgU3I0tzxwlCnfpe1vM7hiRQ8otRs3
 iQcL56HELkvSjzPhGjzEtZM1I+9Eop+H1/elbsYm2pUHXx5DeSLC8BF2ODtht8otZofEq/yNa
 ItQWm8lVbuWU9c0lAJag==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-12-20 at 02:23 +0100, Mike Galbraith wrote:
> On Sun, 2020-12-20 at 02:22 +0200, Vitaly Wool wrote:
> > zsmalloc takes bit spinlock in its _map() callback and releases it
> > only in unmap() which is unsafe and leads to zswap complaining
> > about scheduling in atomic context.
> >
> > To fix that and to improve RT properties of zsmalloc, remove that
> > bit spinlock completely and use a bit flag instead.
>
> It also does get_cpu_var() in map(), put_cpu_var() in unmap().

That aside, the bit spinlock removal seems to hold up to beating in RT.
I stripped out the RT changes to replace the bit spinlocks, applied the
still needed atm might_sleep() fix, and ltp zram and zswap test are
running in a loop with no signs that it's a bad idea, so I hope that
makes it in (minus the preempt disabled spin which I whacked), as it
makes zsmalloc markedly more RT friendly.

RT changes go from:
 1 file changed, 79 insertions(+), 6 deletions(-)
to:
 1 file changed, 8 insertions(+), 3 deletions(-)

	-Mike

