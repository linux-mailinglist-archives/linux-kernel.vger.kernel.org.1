Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998CE2EFB99
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbhAHXMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbhAHXMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:12:34 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A58BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 15:11:53 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o19so26856171lfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 15:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLt4ztLxzVBHshNZl1/x/vV1CQvxUEjisAgP7AfDZBo=;
        b=XIehVx9ar1bvUZcK9N6s3NjOLf3uSoE6MkC8KWzFKBDSbgSLvAQkiBmrpp2iNPGCf5
         vUcdf0Fh236uTTrTWIV9fUYOOhbi3ClgEeI/M4xmmWYlV1So+s+pfRj3HNU944AGelrC
         ltMwAtMkw4tk+3hYWHD4AeNYY1/ZLuk6SREco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLt4ztLxzVBHshNZl1/x/vV1CQvxUEjisAgP7AfDZBo=;
        b=glTk8v/sHxEYfz0Q79kCzA592wghoGCl2heGbaHrYbHf1+AlEscKg6uAXXazRS0lug
         FSa2DjW4/BZmdvOD2d4L00BugzQqM6pGAhe86gDpLtbNTTRxoh5+VWeFJx6+I8R7hUA8
         0lPtML6zuO/7UXcOFG1L89//1NTHnv9Wre+fX7F9voYPW8IzACHYbvDuXFJKnJQG5mmr
         p9sJXedGhAzL/8Ja5hokn4WfCLNxy4spU75GMRyV/tQ2257FYj2iSEjRS+FmyuJWmlde
         pwsZfWh+yBwF8HffTzyxZE/yxY/aKdMD7nnq+hvq7jjNMJZynV4C/fWUCGuCLBrm83OM
         Frtw==
X-Gm-Message-State: AOAM530cP3wKed1cl7q/uWFRDj1KQxVHIPj1y0YSMidvypj9tVdJaXTU
        30HEHZ9/mbzjGpDS5TWQ3ogr7pG03Ecu8Q==
X-Google-Smtp-Source: ABdhPJxPPO6hLLjwtqf/W/3YOEsvGjhr7o3PIkzVwYnTVraloVNHSJdIX36ytqTmw6ah5ucaRnva0Q==
X-Received: by 2002:a05:6512:3253:: with SMTP id c19mr2450421lfr.631.1610147511591;
        Fri, 08 Jan 2021 15:11:51 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w6sm2177637lfn.222.2021.01.08.15.11.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 15:11:50 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id u25so6050791lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 15:11:50 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr2320850ljj.465.1610147509949;
 Fri, 08 Jan 2021 15:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20200916205434.GA10389@duo.ucw.cz> <87czyf5jjp.fsf@vps.thesusis.net>
In-Reply-To: <87czyf5jjp.fsf@vps.thesusis.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 15:11:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
Message-ID: <CAHk-=wjsjC1h7fskwYaaRLykN1ms6ZtxGvucQgmL-zZTfxPdBA@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Phillip Susi <phill@thesusis.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 11:13 AM Phillip Susi <phill@thesusis.net> wrote:
>
> > Could we pause this madness? Scrollback is still useful. I needed it
> > today... it was too small, so command results I was looking for
> > already scrolled away, but... life will be really painful with 0
> > scrollback.
>
> > You'll need it, too... as soon as you get oops and will want to see
> > errors just prior to that oops.
>
> > If it means I get to maintain it... I'm not happy about it but that's
> > better than no scrollback.
>
> Amen!  What self respecting admin installs a gui on servers?  What do we
> have to do to get this back in?  What was so buggy with this code that
> it needed to be removed?  Why was it such a burden to just leave it be?

It really was buggy, with security implications. And we have no maintainers.

So the scroll-back code can't come back until we have a maintainer and
a cleaner and simpler implementation.

And no, maintaining it really doesn't mean "just get it back to the
old broken state".

So far I haven't actually seen any patches, which means that it's not
coming back.

The good news? If you have an actual text VGA console, that should
still work just fine.

                 Linus
