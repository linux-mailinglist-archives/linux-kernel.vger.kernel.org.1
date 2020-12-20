Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8002DF2AE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 03:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgLTB6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 20:58:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:53835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbgLTB6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 20:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608429380;
        bh=vXUawh3kPUtcXgR/FybC5uzJbN+zai3TrH7SO3d14Is=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=FfTBJHB83Yn9N/NPeJ6Mm7Cpa80BgLt/qZjztz4UZd06McV1++e4xqp0y8Mr1iw+C
         NDRnvFjYJjJV5bWllZgHNMZ0y1IInbjVmsCeOyJwOZoFMAxV7F/UP0IeNRFeSLpVdy
         +hJCwipa1TIZY2sh8ayvBFdO1Aml5CxlXN2aonbM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1ktFkL0NFx-00FgeW; Sun, 20
 Dec 2020 02:56:20 +0100
Message-ID: <53dd6a82bbb2a9a102b420899281633a3e1b37a8.camel@gmx.de>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Date:   Sun, 20 Dec 2020 02:56:18 +0100
In-Reply-To: <20201220002228.38697-1-vitaly.wool@konsulko.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
         <20201220002228.38697-1-vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VGiNPUjzT+E+GM6QKupqdR66ABAQZq/3HoCKx4v30GHTPaPvsFP
 +5vRKde64mKEUlumbSbzH5aYBuuTHgqGC6VPqZUpQ+av4KNyoCh/w5xt4XJGuLeocrNpN71
 1XttEmGwlpKHWTXpjYpCkjbCP46dcKYveW/WMaBKhRFf1z1m4IF0U8y0HuGmrDsPmlw6OoG
 7GbDYrs1pFw3QpYEP+K2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HyBZqduQu1Y=:ONBy/YVfBUPMs+eb+D58Cx
 RBBiazb/NqBC4wgVA8oj+MI07e4a7YvQA1E9fpxHGdXYgaMmQjeLg6iaO3/0B4pIN8rfKXs2y
 rEs4FeHkMX1HSNYW5Ilz4i27X9lTNnwPPWjy/pK8sx7eRTBHzloz6b3HTbY6mV7596F4xWqG3
 aDAGOfdjBzt3fvhSwIi9whddOCgVTfSZm0uz4I5bXc7iGPjLWKW/+N4SNzl9oRbx6/rKzfl3y
 5V2jcGTGlmnYzNCLg+ZViTorMVCfKQXEPzjX3L4Bo622k0VJ/PpfisvoEVy179dJNhPWZn/wz
 8/CGdpkcHpCvKrwm8Xsumbvkta3vPBSg+ul2emxuZfkOWYsFrOJz/FgQl/UrkaE+uEj5ddqRR
 yl8XlvGj4y3BtUF9UbOyDZr7CMaiJY8fyTpzZdDJ2k2OSKFybn2PVUuR33YZQyzh/Gvm441V0
 VDDb71AWVyginlL4GVU7Q5X2SpZcz+LAWGADrSV/747/TUw/AmXcgmCjYLbYyKbpgr9jvqiLh
 eXcMdcxnveUGfxPTEKmIQsNHbNSQ5NtjTHuxOpyUuJ97mq1Cl2LcHTxiOi2evQDymZhe3RaTe
 Org470QE1cBEvY5uoUvchbNMCTNa0TsB5wh3vioA9Uk3eeNbt01o0FKjpYqaG8XlylEPcPsZM
 VXC/0Me/BC+rKzyt8xeqc/MAFjjh52QfsSaeBblP7CZYAFgLLiYuSGexu3hgdSLyd/qOo53nL
 tlzlzu4Uxxl8HT8Jla2HDLpJcBlhBnrMdwm1/HQqx+a+0pXBhcQJ/Udc5rOkGqdJX1uN2axDY
 CZezCObgCJXu3Adh8hdiz3b7L+ZrMXG9BjIcKC2j5vFPvEKtA0aYHzR1zJ4LCD1uT4NCuefe+
 nOxCYvyGKlno4xxdbi0Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-12-20 at 02:22 +0200, Vitaly Wool wrote:
> zsmalloc takes bit spinlock in its _map() callback and releases it
> only in unmap() which is unsafe and leads to zswap complaining
> about scheduling in atomic context.
>
> To fix that and to improve RT properties of zsmalloc, remove that
> bit spinlock completely and use a bit flag instead.


> -static void pin_tag(unsigned long handle) __acquires(bitlock)
> +static void pin_tag(unsigned long handle)
>  {
> -	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
> +	preempt_disable();
> +	while(test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle))
> +		cpu_relax();
> +	preempt_enable();
>  }

If try doesn't need to disable preemption, neither does pin.

	-Mike


