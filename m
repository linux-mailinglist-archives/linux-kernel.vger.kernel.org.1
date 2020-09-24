Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5A277A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIXUTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25629C0613CE;
        Thu, 24 Sep 2020 13:19:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600978743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3Ao4b3S2fuWHiT8hpHEfpFg0aMIND0J6gnDyFzzIBY=;
        b=GWue+NIuBy3soO1ehVcKQ0rhV7iiszDX+YP1KJTAEHVSQgmEr0exmzz2J4MqZGx4Tot8v8
        8C99zKaMGY8rEap5ElRRH/06ZSQjK6d6vwbjOJqJfeehwbYfmX7IpWovnqQcgtcbvYgKPg
        2k6LtR9J88o8a248c1eTOqHQxUs1RZEC6bGhNNrfLzWQ9Kb25k8rCNLH5rZ0/DxA/klLMX
        dq38wVBZLcSs/SJ60pToFbYt22R/DQI37BaLdTWyJrdrXTUiUf9BTY3WEruM2pFuU4d2D9
        4MZLzbhGq3AIgEh22Y3zH3CDM0C2rd84Obf+bamKY7UiKUjRnb5PV+TvZ0ZhEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600978743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3Ao4b3S2fuWHiT8hpHEfpFg0aMIND0J6gnDyFzzIBY=;
        b=hlFfk2k9cjx+noi/lmUByUkYc4oJUkZkwXH/rwvb2cEdWBlfBMkm9XXGEhDEwmjZrwUf/E
        JrImDs46jCfPfLCQ==
To:     Julia Lawall <julia.lawall@inria.fr>, Joe Perches <joe@perches.com>
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
In-Reply-To: <alpine.DEB.2.22.394.2008220905460.3150@hadrien>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org> <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com> <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com> <alpine.DEB.2.22.394.2008201021400.2524@hadrien> <a5713d8597065ef986f780499428fcc4cd31c003.camel@perches.com> <alpine.DEB.2.22.394.2008201856110.2524@hadrien> <744af177c09f8ce22c99d6e1df458bced558518b.camel@perches.com> <162653.1598067338@turing-police> <3836b482434bd0b9a609959d3696cc6113a93f2f.camel@perches.com> <alpine.DEB.2.22.394.2008220905460.3150@hadrien>
Date:   Thu, 24 Sep 2020 22:19:03 +0200
Message-ID: <87tuvn6i88.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22 2020 at 09:07, Julia Lawall wrote:
> On Fri, 21 Aug 2020, Joe Perches wrote:
>> True enough for a general statement, though the coccinelle
>> script Julia provided does not change a single instance of
>> for loop expressions with commas.
>>
>> As far as I can tell, no logic defect is introduced by the
>> script at all.
>
> The script has a rule to ensure that what is changed is part of a top
> level statement that has the form e1, e2;.  I put that in to avoid
> transforming cases where the comma is the body of a macro, but it protects
> against for loop headers as well.

Right. I went through the lot and did not find something dodgy. Except
for two hunks this still applies. Can someone please send a proper patch
with changelog/SOB etc. for this?

And of course that script really wants to be part of the kernel cocci
checks to catch further instances.

Thanks,

        tglx
