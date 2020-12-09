Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD42D483A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbgLIRqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbgLIRpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:45:49 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE1CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 09:45:08 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id jx16so3334050ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRUcWLPWD+MQWDys7NMmqsjgoWT2S+ad/7Jyb66SJSU=;
        b=WlF9OJyFh/O8EkJLwzVnnIo9dtTlZZW6GJsxk7N6sKkFt73msw8+tS0wNJe/HyIjv+
         ANpjomLmo8OSqu6uvFvb8UYZ1Otygxl1gpx8wc4hmQMYi3+oX9cgBNUKb4cHItxzuggU
         QNgCoeohSgbajw9jo06JJVcn9B5tGPJNV+mif29nki1tehPOjfrKJTCokdD+WQH+jTRe
         WS7z9tTD7EwbX+GReWZIRttk/Kxm8hcNhjNm1HXVIMQEQUW0hGdY/l3N+Jj1n3WK13OC
         WGpBSgfxHbgIeEnTFLSRt2LwnEchHBYUgyVUaH9/xZLARlXyYw+WNhda+t0sE0qbZ4a3
         o+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRUcWLPWD+MQWDys7NMmqsjgoWT2S+ad/7Jyb66SJSU=;
        b=FXWfteFUTV8TGs1vPGGIkdF+Dcj0ODoX3dHDyL5sf829Jtf9fT4c0K5xJ7RNah1BVU
         8tBKNlAbkktCDE5mydMvDLf9KjHVF3UGvayusykPWAyAPGTFkBrJDOOswmI//TIoTs1B
         D6QMFT4XwtR2mZ5Rnh2spRgs1+/pvbvWgp48h2ooISYREhjiCqfSIKoRzBSSxfRDUeQP
         9EoWe/Y54GPivt4tU9kS6gN829MAawUu2zHcmUt6DBY9vhkDPPp3pe+wE5FPySWr3jdm
         r2UdjdLXn9dMjWiXePIEY/qeZtl9XRacoDTLGBqt7F0E0mVoXipUNCzCfExIN7JNhUgh
         X67Q==
X-Gm-Message-State: AOAM532Zt3aXHhxpkOk535kmUYofxjeTD361VYgY6x2G4oWdqgYMPOLp
        cseHxny3pwYYv6GqBy0WpHKGi/5e6wwoEoi0fIFXbUUFB2E=
X-Google-Smtp-Source: ABdhPJwkh60h0Y+VEqX94NdF9KgKWO30649UcfJJonX8/7IsI98fOi3wQuTBe4X5shmyOI6I2Oz3RKXbVxDLd87ji6g=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr3008666ejz.45.1607535907410;
 Wed, 09 Dec 2020 09:45:07 -0800 (PST)
MIME-Version: 1.0
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz> <CAPcyv4jDHMt4PpR2Htvw27rn5i5sCkwXtoZH-rFbtG8Hj7x1sg@mail.gmail.com>
 <20201203093458.GA16543@unreal> <CAMuHMdVcPELarE=eJEc-=AdyfmhhZQsYtUggWCaetuEdk=VpMQ@mail.gmail.com>
 <20201203104047.GD16543@unreal> <X8ku1MmZeeIaMRF4@kroah.com>
 <202012081619.6593C87D3@keescook> <13d04c4cc769ebd1dd58470f4d22ada5c9cd28e7.camel@perches.com>
 <20201209075849.GD2767@kadam> <42a599d0f5e4c677648b5e6de8083feb8723a558.camel@perches.com>
 <20201209103026.GF2767@kadam>
In-Reply-To: <20201209103026.GF2767@kadam>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 09:45:04 -0800
Message-ID: <CAPcyv4gbgDMGBQ3t4q1EckELbMG5JXi10YuzLsMjFns67od=sw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Joe Perches <joe@perches.com>, Vlastimil Babka <vbabka@suse.cz>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 2:31 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Dec 09, 2020 at 12:54:30AM -0800, Joe Perches wrote:
> > On Wed, 2020-12-09 at 10:58 +0300, Dan Carpenter wrote:
> > > On Tue, Dec 08, 2020 at 09:01:49PM -0800, Joe Perches wrote:
> > > > On Tue, 2020-12-08 at 16:34 -0800, Kees Cook wrote:
> > > >
> > > > > If not "Adjusted-by", what about "Tweaked-by", "Helped-by",
> > > > > "Corrected-by"?
> > > >
> > > > Improved-by: / Enhanced-by: / Revisions-by:
> > > >
> > >
> > > I don't think we should give any credit for improvements or enhancements,
> > > only for fixes.
> >
> > Hey Dan.
> >
> > I do.  If a patch isn't comprehensive and a reviewer notices some
> > missing coverage or algorithmic performance enhancement, I think that
> > should be noted.
> >
> > > Complaining about style is its own reward.
> >
> > <chuckle, maybe so. I view it more like coaching...>
> >
> > I believe I've said multiple times that style changes shouldn't require
> > additional commentary added to a patch.
> >
> > I'm not making any suggestion to comment for style, only logic or defect
> > reduction/improvements as described above.
>
> How about we make the standard, "Would this fix be backported to stable?"
>
> >
> > > Having to redo a patch is already a huge headache.  Normally, I already
> > > considered the reviewer's prefered style and decided I didn't like it.
> >
> > Example please.  We both seem to prefer consistent style.
> >
>
> For example, if you have a signedness bugs:
>
>         ret = frob(unsigned_long_size);
> -       if (ret < unsigned_long_size)
> +       if (ret < 0 || ret < unsigned_long_size)
> vs:
> +       if (ret < (int)unsigned_long_size)
>                 goto whatever;
>
> To me, whoever fixes the bug gets to choose their prefered style but
> maybe some reviewers have strong feelings one way or the other.
>
> > > Then to make me redo the patch in an ugly style and say thank you on
> > > top of that???  Forget about it.
> >
> > Not a thing I've asked for.
> >
> > >  Plus, as a reviewer I hate reviewing patches over and over.
> >
> > interdiff could be improved.
> >
> > > I've argued for years that we should have a Fixes-from: tag.  The zero
> > > day bot is already encouraging people to add Reported-by tags for this
> > > and a lot of people do.
> >
> > It's still a question of what fixes means in any context.
> >
> > https://www.google.com/search?q=%27fixes-from%3A%27%20carpenter%20site%3Alore.kernel.org
> > gives:
> > It looks like there aren't many great matches for your search
> >
>
> No, I mean people add Reported-by tags for fixes to the original commit
> like in commit f026d8ca2904 ("igc: add support to eeprom, registers and
> link self-tests").

For after the fact post-processing of tags to generate summary
reports, is there a significant difference between Reported-by for
"original commit motivation" and Reported-by for "follow-on fixups"?
Especially since this practice of Reported-by for fixups is already
deployed in the tree (at least kbuild-robot credit reports and my
subsystems operate this way).

If the fix is a slightly late and needs to come as a follow-on patch
the tag will be Reported-by on that fix. I fail to perceive a benefit
in augmenting the tag to indicate the resolution of the race condition
of the commit making it upstream.
