Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBE2DF383
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 05:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgLTENw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 23:13:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:48635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgLTENw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 23:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608437511;
        bh=sqqrDsEkHGOfeDhHB51ZzokCNHLsv/ZDYKB2d2VTg9c=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=bjv/5P4ViB7PTrZrqpXc0Rh0Vb8KBqyyY+/vTxTeQJVhNcZKylV2gftnisU30bZEh
         QmzeTtM0Vq4BrAvl3z3OTjRBuwarQUOgtg8Rs7Sm6ACNeVO2zm9Lt0cVmFPf/lHQBn
         ySiFzd4/OQbghRQHkPhdRqoS7S9mE5tdVJ2Fhyk8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1jxLm036eR-00u5qP; Sun, 20
 Dec 2020 05:11:51 +0100
Message-ID: <5f72f88c55e3365883f597c01dc471520281d8d3.camel@gmx.de>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Date:   Sun, 20 Dec 2020 05:11:48 +0100
In-Reply-To: <c9c97ae293f5d7321ff30ac6ead49751560dd354.camel@gmx.de>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
         <20201220002228.38697-1-vitaly.wool@konsulko.com>
         <c9c97ae293f5d7321ff30ac6ead49751560dd354.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HvFhn8s9aIfvYGFUq2WvGBJ9VR+vkLG0luEdCTyl2tq6ZFt0A8/
 wdvUm9CiRPIqGksZPWxfoy3iWa1uBXJKfy6TPcaAQTUohy6m0ZvQzOo/D0JSuvbiiTpJEK5
 CV/mo6A5mNJq7OfLnKOJ10RqEAyArLM5E5ihhvPybBds7h3wBa3g27ZMMtbRWz5yzclvlqk
 ZJR0OV+AICUy1PWa2kgJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x9TJ9pKgYOI=:X8CmEWKbhMHmp50ibfuTJB
 F9DOnxGMtF1BjyvUKljvimL2DgCDO9qUj71M2YTixj/NnFHYhG0P4bbqFLUSMWDE4ckYQ5+ej
 iEj3Pg1pXyR44uamFAkqEg+PY8z/4qKanHziyR5x7QKvoHoPCxHyR9g3QBh8tT3ONUae7v5QF
 +d22ueDya2rlrwEt9Q4BFkqSRaJQK+kV+AjPlfwSxlN/kei1/HNIlP/UAdv/Fdqs4PjJjCQ6x
 +b0hScMwytAFGTbIva6kRCaVGR8tQUDdB8WbnErN/YzkWa9EPBCFns5oq5TJQMV/5i2ICDQmn
 bSFHwDW9MrcHDy7ONarlOakEVPVCZbkUx9D7m54pnzhAuldWbKRMlI3yNcmmGjyYYcJyEZEd6
 vx0f/Aqb+SJcJp6suvBuqZuB0WHFgJaczgaikd4rU6mrqVbMBtUEjkQozfkZa4bfGQXc+e6lB
 k2cq8Gt2rVFmRhTCrM8gda6sJWeeYqCQcaCbaZI9eN86MCOcNJjMUsWaRr+VB3ZdGnTt1JQWm
 TUtxNrir//DjnBNvSubCXil2iIx5Mnyh94CJkIUHfLwQe/wDp8bWh7YnhQVft2Fc3x3enriPe
 KMpB7mZTbb5EMZDhksEt0dYaBiUHHfpD9TErHWqr6ZWrKZnY0LS4OML3rt7Q+fbFcDKqgUNu+
 f2rM9VdkWUhntsBxaMugoZNmhEaznCWNnTLkGOx3oB3In/r6BPHAP0nyEAr6qJsE1L3hsvKjz
 3Ky5GWR+JXON0ADtU1zpIBXVTjEx2u9ep/ba5qn9utm7suujx66gTayJrVSK7mBSmpfxZsls2
 E6hocWf1Ve3lsg5mAudOAy62RcBFyQzQRPsYT911Ps/8n99Jmb6H09OCT8HzQAFHTSSd8DYMd
 vL9zqaY7HJt71uuGRV/Q==
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

Bah, I forgot to mention the config dependent rwlock, it's held across
map()/unmap() as well, so there are two more hurdles, not one.

	-Mike

