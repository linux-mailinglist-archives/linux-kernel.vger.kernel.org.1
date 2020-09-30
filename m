Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAC327EF50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgI3QfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3QfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:35:24 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A63C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:35:23 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l17so2534653edq.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+misetaEJ1mwAT301R0A9ZIkFxdOGA996KoWa9fftk=;
        b=Sh6cwwahX+/y+BSWSCbArvYObCc1HWuntrcLxuME+7ufy6lS8eVNK//JaRPTKxHkMW
         /vI8TjEolAzzydnudtc2FOmU3njVteq6rwfp7z26pcwIJ/RgtV+gmPoQq2+bX1bE0ivo
         27/jAYWu30gafN/4p4RpUq/aWe96VB6akyMRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+misetaEJ1mwAT301R0A9ZIkFxdOGA996KoWa9fftk=;
        b=g1CkSeTl8gWBTKYi7p25vzOGrpBVLIlL/E7YOHT5UYyqxUeMQjrFWn5bhG19b5d5/K
         zd8mUJsX+ImYd9LS7AlRZXkpUlJHpynVs5r9KR+KeLq7yarGpcsMZbu3WWWYiNCB68y6
         FLuoyXWej0n5pOLIyAd4M3o3pwAQbijO0xXH/q6sgRiHWv8sZKsvQfwGA6AJj11DGJ3o
         z1utvfFnamVOY6iaCBlINcKif3BQz4OVoZcalxTaDtRw4oESBXP/G2PCY56yd1qjgEbT
         yUzI5+H5u0FzQTUk8lM92k0Qx6x962qNM1A9il9pgtLFSNmGl82+9hAUg8pjjTSqulxP
         7SPw==
X-Gm-Message-State: AOAM531e2QXXGbaLEhXxlvPxY+Mw2M6oOafuiyc3wIxyMl2it3aLANcW
        Y89WaoiKFSHGDclAIKsUJHVsa4AHbWfQ7w==
X-Google-Smtp-Source: ABdhPJy4jVa3kHhMwjqQDc52xlVNCNwbj+D0m5TpzrxI0KRR+LIx5/vzVodvy+t4qqu9FQuuj4m+Fg==
X-Received: by 2002:a50:f1cd:: with SMTP id y13mr3696177edl.358.1601483722083;
        Wed, 30 Sep 2020 09:35:22 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id j14sm1942989edr.91.2020.09.30.09.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 09:35:21 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id m6so2550757wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 09:35:21 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1237100lfg.344.1601483329141;
 Wed, 30 Sep 2020 09:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <160087928642.3520.17063139768910633998.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4iPuRWSv_do_h8stU0-SiWxtKkQWvzBEU+78fDE6VffmA@mail.gmail.com>
 <20200930050455.GA6810@zn.tnic> <CAPcyv4j=eyVMbcnrGDGaPe4AVXy5pJwa6EapH3ePh+JdF6zxnQ@mail.gmail.com>
 <20200930162403.GI6810@zn.tnic>
In-Reply-To: <20200930162403.GI6810@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Sep 2020 09:28:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmtMDW2oUfGrXTKcESqEHx1vWCqO65o051UNL-cX9AAg@mail.gmail.com>
Message-ID: <CAHk-=wjmtMDW2oUfGrXTKcESqEHx1vWCqO65o051UNL-cX9AAg@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] Renovate memcpy_mcsafe with copy_mc_to_{user, kernel}
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        0day robot <lkp@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 9:24 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok, I'll try to queue them but pls respin soonish. That is, if Linus
> cuts -rc8 we have plenty of time but he didn't sound 100% on the -rc8
> thing.

Oh, it's pretty much 100%.

I can't imagine what would make me skip an rc8 at this point.
Everything looks good right now (but not rc7, we had a stupid bug),
but I'd rather wait a week than fins another silly bug the day after
release (like happened in rc7)..

We're talking literal "biblical burning bushes telling me to do a
release" kind of events to skip rc8 by now.

           Linus
