Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044952DEE61
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 12:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLSLFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 06:05:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:45037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgLSLFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 06:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608375795;
        bh=uaTSZXPs8mGAHc0wJE1STHCcZRQ5t+E6vV+WWhZAebk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=cR7nkKavwmijyx4BJ00vCGzigaiElKbB9pE2DcPw5pb3JBESgItQvky0atF1g0Bbp
         XYhqAxQaEohmH7IAjf8ABIzmg5uGMqQsRC1DOg/NO1z6bWsNISmLRi1lusbicu0c9D
         eSobqJtJNZHsW5FSEg0BjSx3mOmmsVctAS4MjlzA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1k9Eqc25u9-00hKm1; Sat, 19
 Dec 2020 12:03:15 +0100
Message-ID: <a8e616b333a85606c0da24465c9d7209b6991eba.camel@gmx.de>
Subject: Re: [patch] zswap: fix zswap_frontswap_load() vs
 zsmalloc::map/unmap() might_sleep() splat
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Date:   Sat, 19 Dec 2020 12:03:14 +0100
In-Reply-To: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
References: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de>
         <aa9be27f0d247db1b25da55901b975d78537db3d.camel@gmx.de>
         <CAM4kBBJYZzbXAixrKvy9MeO2eUsVVi8=iUBUc+pbSMXudy7hkw@mail.gmail.com>
         <6946d6e798866276f0d635f219cdd4ad05156351.camel@gmx.de>
         <CAM4kBBJZDqZfk+w5Wv4Ye7JythQ-Sr5-==zxeq8M5WCnHpFtEA@mail.gmail.com>
         <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YhFvjMraDVR9ltDT5vH8xP9kyiH2f5djoWRLwx0aZLWhutvbmOJ
 eX/GE67Yh+19DccKxUs7hUcgmDiFuj7NCkTlL9uIoUUyM71cXn8zTPlplsuX6koG305W1/z
 nb1zCDejpZX1ZtFJoA/+DQhX+7gzCHjK4TRvXqhiw3r4ds9WtmgN2ng99vNzKOHbC5EdE6I
 L2weALDg4e58oQnBMw4dQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:irEI8XB0D0Q=:/ndnBO/AGzTxrD7dvbvWdz
 5KIdCI8nmZSmbclLJnU2wmF43788flc5nN+klDluzIwinZoQz92ZQN7k/9yddV2ylRuPMf00i
 z3VJqW7+fRrAo1vmPn9hIHJe2v+LKhOuCKTantFnGRAY63wjmqv/nT1iI1HNxQLiCN/EZzOfV
 7/lnVOnP5Ww8BTKiWHt61Rc61ih2OP+XeCGH3gu7e4ez7MdyeyPqtglXEs+zX8ruF/ELrH/Ux
 wrcKWEfMFU8zfNiE5Ui2Z07YEbzlcKpDFnjSZ1wbB//rCc9u9ScGppO0HabxjSEu8d8cVH3SH
 yZ520CdRn+uY/9wlKrYw2ZhAsFp3ZrlfYnmIAnBMiY/OWWreCn1KZLk9u6F7KxbFtiHZzCFMY
 CZq5QEohpzvYUwxupJ7oZ2NbkAquY41Ek+/pC7QemqEM38thIfuFZFrcOqEfHRhxSaEI4Z1sG
 n7e5lyzEpBsQewQ/oiOpjyEZzUwiyJlaZzxQTaGmKfUhcus0/URf4JpGbsHNFy0pJ5s083Dpl
 7nuSEHZ+VjtF2HtwTg0XQkbDBAguJ2nu/BPFOjII6bPQAUAFM6Py3S9/r4wlBQ4YD6g8eFbUu
 MjdIA2U7VPK3wsV4ZGYDy0uxFG5MYpjwrZq71lBrRXOxcHroNQkYwIcDuNd1r1WkOtpVyPVOA
 3pMbWlvFO3JQpokLX8efLiyt9w8WT/hRkNuiDdyG4RBz6aSEWssd1YZKHc1LAJZ+YleVWL0Mj
 jemy0jqlhNSElW3kQkpn+TFm8czyUrnlhgEP9mPVtRn3k85RDUdpsabQ9sa7/4wuirEERdF9H
 WFyT0G5Tnhwzg7LFfBdOcbwCw979YzGJ3922C+rRNXougs6jsezMW7uxG9XrZJSBN+jLkEZ+e
 X/htdilUflyIi/5rd2YA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(CC zsmalloc maintainers)

On Sat, 2020-12-19 at 11:59 +0100, Mike Galbraith wrote:
> On Sat, 2020-12-19 at 11:46 +0100, Vitaly Wool wrote:
> > On Sat, 19 Dec 2020, 11:27 Mike Galbraith, <efault@gmx.de> wrote:
> >
> > > The kernel that generated that splat was NOT an RT kernel, it was pl=
ain
> > > master.today with a PREEMPT config.
> >
> >
> > I see, thanks. I don't think it makes things better for zsmalloc
> > though. From what I can see, the offending code is this:
> >
> > >        /* From now on, migration cannot move the object */
> > >        pin_tag(handle);
> >
> > Bit spinlock is taken in pin_tag(). I find the comment above somewhat
> > misleading, why is it necessary to take a spinlock to prevent
> > migration? I would guess an atomic flag should normally be enough.
> >
> > zswap is not broken here, it is zsmalloc that needs to be fixed.
>
> Cool, those damn bit spinlocks going away would be a case of happiness
> for RT as well :)
>
> 	-Mike

