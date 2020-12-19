Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0528F2DEE2A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 11:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgLSK2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 05:28:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:46007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgLSK2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 05:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608373622;
        bh=Uup18DtdpxUG00UIwFBlOlG16e821LeWTjq7JYouQ0U=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=XGI0ANM6WR6I821FwRSA+h3NYTbXQHEax6Q9cDbjN4T3N4UiWbw2wDb6f9gEyUE7e
         VjEA9EIsYGluSifzqTYVyiZvirxO0DEe8mFFGP78ITS55uf8v52EDSdsBWx+/5+mXC
         wDJhR4RpMiv5KqwqImAHqLMlv7tgVirFdLjdDMqQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNNy-1kds6m0q6k-00VQED; Sat, 19
 Dec 2020 11:27:02 +0100
Message-ID: <6946d6e798866276f0d635f219cdd4ad05156351.camel@gmx.de>
Subject: Re: [patch] zswap: fix zswap_frontswap_load() vs
 zsmalloc::map/unmap() might_sleep() splat
From:   Mike Galbraith <efault@gmx.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 19 Dec 2020 11:27:00 +0100
In-Reply-To: <CAM4kBBJYZzbXAixrKvy9MeO2eUsVVi8=iUBUc+pbSMXudy7hkw@mail.gmail.com>
References: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de>
         <aa9be27f0d247db1b25da55901b975d78537db3d.camel@gmx.de>
         <CAM4kBBJYZzbXAixrKvy9MeO2eUsVVi8=iUBUc+pbSMXudy7hkw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j0AiefRXZcSVfA5RaK4B6RVZ3hsyTiR/pq1/qisinIm89qxRA6f
 ozeYbohZaEne2CMg3bzBMta6UL08iHoLaro8yQQ9DzHxJeekckFHJ5yNN6bIOVuVjCKv093
 x1fAPRB0mX8IrEbntvft5gwHK40h2dHpwWndU/bdOhXOQfeUNEDShFMUDidEJmHFrfQBdOS
 852nTxpStHw479ISvvsyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Bzr+CNfzpI=:BUvt7sW0s8jkhE2IABLZCm
 lR3jrnlA2VCjw58KKPJNrGkgzfGYCUeSY+K0/nU7+MpFlm/Fwrqw2ZPMVjbpHxQXZzPeF1CyB
 hs6VYBJK3BmPubt+iE0CYb+2Z/rhGc9vdBeWZU/CFpTHwzV437FkkOec4M/w6hQdO5w3M63G5
 alJGbso0vAumRIbZuva/8PSPwNJWgDnJGkU4duV/FCkhM/CQOmLgEFKg7EfwXO73SkIwduU+l
 eu7S6iSNEehd67N+meHSGE/LmfKAkhBYfXDwDX8OI/5Ot+IbXrpK6WWnUn8u/6ARPSCIA7f87
 TJIoSCY28Ucan9Pmuua9WG+lr7+vaMlNlq6whhuQfi3OK08mNfAyoTgsyHyf7FTsx+MopZNw+
 9LESQzcB1K3rdrei5ygd2yLXVpYgjwhDmmtrMITQtH/nEcD0jb+wCkZAf6C2qwMCH+Dp43utx
 EMi4VQQFNy9TKsPeQhAJJiwscTsZ/htwqteDZS556gnrkvsOkL3CbQoGidnM6fDEpX/rv+KKg
 wmu4LMU4Licb1gmig0PSYSVs0P57kDH9ySfeiZ0tfNAQH49+N19PA7kTvDLAEviVxb0GJ7d87
 N2o9lCMgEnUlTtXhFhPlAmssOpYKWA2sIC8HAVE7DVNL0tv8U1WSvqbed3DcUrojr+ThztRpe
 vahmyKzceEMKG4CZ6sR4BTYRewQI5yQVOWrp3BtkGjaJSweexR+Q1iqRZ66wNMMtGbnMYolrK
 EtvBlxcJh4bHre6gYWXxx6fEHjlQQBEPoL5YXS6btfjaGd2StkL2TjlSJIUirmuVWk29cxi7H
 +fT+YYulT4CQSZ+sFkbB7ACT4UlH9oBPPSNNL+dR5ZRA2GLxz3FZ559/6yO9HLPY26oGWPgbU
 w5zVodvWWoLJoCQbsdvQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-12-19 at 11:20 +0100, Vitaly Wool wrote:
> Hi Mike,
>
> On Sat, Dec 19, 2020 at 11:12 AM Mike Galbraith <efault@gmx.de> wrote:
> >
> > (mailer partially munged formatting? resend)
> >
> > mm/zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap() might_sl=
eep() splat
> >
> > zsmalloc map/unmap methods use preemption disabling bit spinlocks.  Ta=
ke the
> > mutex outside of pool map/unmap methods in zswap_frontswap_load() as i=
s done
> > in zswap_frontswap_store().
>
> oh wait... So is zsmalloc taking a spin lock in its map callback and
> releasing it only in unmap? In this case, I would rather keep zswap as
> is, mark zsmalloc as RT unsafe and have zsmalloc maintainer fix it.

The kernel that generated that splat was NOT an RT kernel, it was plain
master.today with a PREEMPT config.

	-Mike

