Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C360280DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJBGwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBGwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:52:32 -0400
Received: from coco.lan (ip5f5ad59f.dynamic.kabel-deutschland.de [95.90.213.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A60C206DD;
        Fri,  2 Oct 2020 06:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601621551;
        bh=OYE4neEmcnDmyK0VSWrSOAouZXEMA5Ng0ApSlAHl+SQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jRTCA2oiVlRpgfLrF8PgSaYm7SfTC1PK70AhjNNIepjudU16iU2YZgmC/4ozp+eIk
         abFcod0sjoqspKH0DNl9ZkEhNnddW8nFc+9W0WytHKwhJRMfQhxhFYSxzv+lk/E857
         09oyOEyQRPGqAXzzQ5FtmcrcOOhX2F6zMGjpbMFU=
Date:   Fri, 2 Oct 2020 08:52:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jakub Kicinski <kuba@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Wessel <jason.wessel@windriver.com>,
        Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Sean Young <sean@mess.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Takashi Iwai <tiwai@suse.com>, Tejun Heo <tj@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 00/52] Fix html build with Sphinx  3.1 and above
Message-ID: <20201002085222.41543304@coco.lan>
In-Reply-To: <20201001154854.4311d46a@lwn.net>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
        <20201001154854.4311d46a@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 1 Oct 2020 15:48:54 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 30 Sep 2020 15:24:23 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > This series add proper support for Sphinx 3.1 and above for building the html docs.
> > 
> > This series comes after the one I wrote fixing the warnings. 
> > 
> > With this series applied on the top of next-20200922, there are just 12
> > warnings:
> > 	- 2 of them happens also on Sphinx 2.4.4
> > 	 (both seem easy to fix: I'll send later fixes for those);
> > 	- 10 happens only on Sphinx 3.2.1.
> > 
> > The new warnings are all due to duplicated C domain cross-reference symbols. 
> > 
> > Basically, the C domain on Sphinx doesn't allow to have an struct and
> > a function with the same name. I opened an issue on Sphinx.:
> > 
> >     https://github.com/sphinx-doc/sphinx/issues/8241
> > 
> > Hopefully, some newer version may have it fixed.
> > 
> > There is still one thing that requires a fix: the automarkup.py. The
> > way cross-references are stored with Sphinx 3 are different.
> > I didn't try yet to address it, but I suspect that it shouldn't be
> > hard to address it.  
> 
> Modulo my comment on part 4, I think this is what we want.  It's kind of
> unfortunate that it's all necessary, but that's the way things are these
> days, I guess.

Yes, it is unfortunate. Yet, my feeling is that this approach provides
us a good way to transition to the new C domain parser, which has some
advantages over the older code.

> This part is a bit intimidating, though:
> 
> >  288 files changed, 1709 insertions(+), 2183 deletions(-)  

Yes. Yet, the media userspace API is responsible for most of it:

 224 files changed, 1076 insertions(+), 1716 deletions(-)

As most of the uAPI documentation doesn't rely on kernel-doc
(mostly due to historic reasons).

To be fair, most of the other changes outside the building system
are due to already-existing issues at the documentation. There are
several kernel-doc tags creating duplicated C references.

While Sphinx < 3 C domain parser were able to detect them, such
warnings are disabled by default.

> Should we maybe position this as an end-of-merge-window blast, once other
> stuff has hopefully mostly settled?  I can certainly warn Linus that it's
> coming when I send the main docs pull.

Yeah, adding this series, together with the remaining patches fixing
all warnings with Sphinx < 3 at the end of the merge window seems
the right thing to do, IMO.

> I wonder how soon we could pull our minimum version forward to 3.1 and
> drop a bunch of stuff?  I fear it may not be for a while, alas...

I guess it may take some time. In any case, for the next minimal
version, I would set for the upcoming one that will fix those
issue reported here:

	https://github.com/sphinx-doc/sphinx/issues/7819
	https://github.com/sphinx-doc/sphinx/issues/8241

One such example is this warning:

	.../Documentation/driver-api/miscellaneous:48: ../drivers/pwm/core.c:669: WARNING: Duplicate C declaration, also defined in 'driver-api/miscellaneous'.
	Declaration is 'int pwm_capture (struct pwm_device *pwm, struct pwm_capture *result, unsigned long timeout)'.

	(See: we have a function pwm_capture and a struct with the
	 same name. Both have kernel-doc tags at drivers/pwm/core.c)

Without fixing it, there's no way to produce a zero-warning
docs building[1] with Sphinx versions above 2.4.x.

[1] Well, it could be possible to rename such kAPI symbols to
    make Sphinx happy, but IMO, the C domain there should be able
    to fully support the C language.

> Thanks for doing all this work,

Anytime.

Thanks,
Mauro
