Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF876277B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIXVxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:53:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51554 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgIXVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:53:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600984426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=50ls+vBq+FfTMVSndh/JUjpk9M8gYW0WEmaHS52ov8k=;
        b=BjoKxTy1U6UgZenE4M+pedzTdDBWmjQjQobkRZ5JK4lp1hYD1pfZm3CE/cIgodrnxeCktm
        TdMByqmjJxy4enCTDib0fm6j4Vk6BpKGDfXLwzOeodvasek+5B55/FneJPmWlLppzJ9Mpr
        H1dMhMm9NN4/n+McjtE6vNahwMzEgazKwiuPh5fHdOo2KD98HmawEYn5aLZkQm1EMT3TCa
        D+OmRqgoUd3e43vMDMwycVh/JTdVIWrnY3I440zpS4gzEZXJdiBruez/KOab/1wv7+BhF4
        RT65yv/uHvDsGUuW1DPergoCvEzHnmdO78CKOgwuejWsAfwOMKO9lfNlzG7TSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600984426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=50ls+vBq+FfTMVSndh/JUjpk9M8gYW0WEmaHS52ov8k=;
        b=k3Osk55T4BVLeOs/VuJRBYoV8EVmF++pnR29w1CC/rwV5NEARaHvp4iSy1FBHeDCIevC4W
        /AYlGdBVgp8Vq7Dg==
To:     Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@inria.fr>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH] checkpatch: Add test for comma use that should be semicolon)
In-Reply-To: <6d5383a3ec02d89dd05797c3ae158aebdc0c88ae.camel@perches.com>
Date:   Thu, 24 Sep 2020 23:53:46 +0200
Message-ID: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24 2020 at 13:33, Joe Perches wrote:
> On Thu, 2020-09-24 at 22:19 +0200, Thomas Gleixner wrote:
>> On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
>> > On Fri, 21 Aug 2020, Joe Perches wrote:
>> > > True enough for a general statement, though the coccinelle
>> > > script Julia provided does not change a single instance of
>> > > for loop expressions with commas.
>> > > 
>> > > As far as I can tell, no logic defect is introduced by the
>> > > script at all.
>> > 
>> > The script has a rule to ensure that what is changed is part of a top
>> > level statement that has the form e1, e2;.  I put that in to avoid
>> > transforming cases where the comma is the body of a macro, but it protects
>> > against for loop headers as well.
>> 
>> Right. I went through the lot and did not find something dodgy. Except
>> for two hunks this still applies. Can someone please send a proper patch
>> with changelog/SOB etc. for this?
>
> Treewide?
>
> Somebody no doubt would complain, but there
> _really should_ be some mechanism for these
> trivial and correct treewide changes...

There are lots of mechanisms:

 - Andrew picks such changes up

 - With a few competent eyeballs on it (reviewers) this can go thorugh
   the trivial tree as well. It's more than obvious after all.

 - Send the script to Linus with a proper change log attached and ask
   him to run it.

 - In the worst case if nobody feels responsible, I'll take care.

All of the above is better than trying to get the attention of a
gazillion of maintainters.

Thanks,

        tglx
