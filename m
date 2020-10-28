Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA529DD24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgJ2AfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:35:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57532 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgJ1WT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:19:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603876992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5h54ImH6QJnWv+pnH/pUe+ysdZ+UDbypp8NpenJpcY=;
        b=16o2mt58pNs1ppmwKXR6a3Pzo7yfDTy8DtHs4A0bSkAKa6cO/RmW5kdJEMcta7+B9rGN/s
        FnLlr3dgXPGDKKeYL13G+9cyBBgxXoDjwUSlKKLqv+/N3oCQBqXq2G1goEs8ZCF/dyiQzl
        Iq//hFBJe3xdj6LRogwkVt96VDjvjcCiXOlLjqY3pHcUNk+uBOs/oOWjfvOAqVTJgVwIBi
        6972nK/vNP9f4QYz95ZAjB0pTVJVqMUEHlPNMGg22erUzL/uUDg4it0kgMHSekirMZUGnU
        PuibDY8ZDr4lBp4fv7Y6uuMWZwhHu1kvz8wHsBpftDjNwGT0trO+z5NpH+69rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603876992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5h54ImH6QJnWv+pnH/pUe+ysdZ+UDbypp8NpenJpcY=;
        b=Fhnoxf++H5mk/R2NV5enmRaqWm1Gw9+tsy+/X7zfBcXN8GI/DDYnsx/bmVhnnjPC7DaU0g
        Nm4cGzez4TaYjfBA==
To:     "Zhang\, Qiang" <Qiang.Zhang@windriver.com>,
        "pmladek\@suse.com" <pmladek@suse.com>,
        "tj\@kernel.org" <tj@kernel.org>
Cc:     "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [PATCH v2] kthread_worker: re-set CPU
 affinities if CPU come online
In-Reply-To: <BYAPR11MB263255ED056CED38285FC95BFF170@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20201028073031.4536-1-qiang.zhang@windriver.com> <874kme21nv.fsf@nanos.tec.linutronix.de> <BYAPR11MB263255ED056CED38285FC95BFF170@BYAPR11MB2632.namprd11.prod.outlook.com>
Date:   Wed, 28 Oct 2020 10:23:12 +0100
Message-ID: <871rhi1z7j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quiang,

On Wed, Oct 28 2020 at 08:45, Qiang Zhang wrote:
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Thomas Gleixner <tglx@linutronix.de>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B410=E6=9C=8828=E6=97=A5=
 16:30
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zhang, Qiang; pmladek@suse.com; tj@kernel.org
> =E6=8A=84=E9=80=81: akpm@linux-foundation.org; linux-mm@kvack.org; linux-=
kernel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH v2] kthread_worker: re-set CPU affinities =
if CPU come online

Can you please teach your mail client not to copy the mail headers into
the reply?

> [Please note this e-mail is from an EXTERNAL e-mail address]

And delete this non-information please.

> On Wed, Oct 28 2020 at 15:30, qiang zhang wrote:
>
>>How is that addressing any of the comments I made on V1 of this?
>
> Do you mean the following problem:
>=20=20
> "The dynamic hotplug states run late. What's preventing work to be queued
> on such a worker before it is bound to the CPU again?"

This is one problem, but there are more and I explained them in great
length. If there is anything unclear, then please ask.

Thanks,

        tglx
