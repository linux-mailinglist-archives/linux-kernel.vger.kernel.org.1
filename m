Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2297B2EE804
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbhAGVzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbhAGVzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:55:02 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA80C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:54:21 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j17so7514883ybt.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fv7D1a/xgOsadSc1f487VckZIPkz2Yyx+h6GRR5xii4=;
        b=CyTFazwtLcDW3zhdCckDC8mVOx5r1kDT3TvCdynFQ/enyUsfTBTBekvJsyimOwcRVg
         RmVKSv1C/eLVcx4qmqNoTo2uEL+5e0UsC2OF36wTsUx1DN/dCYFwET9fME2WJNdS631w
         tyZqUGL2nR61Tw0KmxYNiCGrVT7w2RI49NJZGVZdCfhZIV4S0HT0gmPpZWUqnYxd4JOu
         GwQR7a/+M03GBy0ZuiSmLhOr/KcsIeQojLOKjLFN+U2nqw/wlVI1uBbFeN6mBN2r4fpN
         GE0Ga2gbMGwSLN24SCzFkeLLel/W67DwVEp+8x3+7NFK8FMYygnjULHYPlzsuyK3fKvS
         ZZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fv7D1a/xgOsadSc1f487VckZIPkz2Yyx+h6GRR5xii4=;
        b=rXJBiLOHPdMH/IXRD0EUjvbJnnw74c9O5Vj0n0YYZrv7TAuRpPtKVsOX7/By6Y4pSX
         BjRb2Sq3DSUgpamd0wZHXSlfpL0qDgKpDixOvACr/u4pN1em5AVcK05xVxU12PuHaLuZ
         LrczoEoo/KqVKIqWG1Fn2Vb90rqaDruDyQRXt/g0YOyBI9M7PXriOSap5coBFSVb9x9A
         CI169w0y4jyOJ/ElVJxi64+3m6gTcu+ItVTxAkP20ClWG2JaO+jGY1BCF2NdGTO8glt0
         HoV8cr2jr6tW+J/sXWND9SarWiAm+H8wMudBW3X0U8fBUK/4BTAq9npSPl5VqeHnoN7x
         HPTA==
X-Gm-Message-State: AOAM531bzB2J2fJ/79PR5cLMBZragOqNG0OAxwDBQZn+lVlqTGeBO0Yv
        hnQehbFegrp77xhfI+sWvfFsNugiAB5U7KwvnrbcNA==
X-Google-Smtp-Source: ABdhPJz4LT5lh3UkKxWGZ6bM4ill/h+88l+ykEwqEwkuux9cnmrPVlN/5UGZfSJlbV840+vS+bp2DKBejyY4pIHneEA=
X-Received: by 2002:a25:6604:: with SMTP id a4mr1450573ybc.412.1610056461120;
 Thu, 07 Jan 2021 13:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com> <X/dpkgTnUk+inKHK@kroah.com>
In-Reply-To: <X/dpkgTnUk+inKHK@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 13:53:45 -0800
Message-ID: <CAGETcx-xMrYE9+9_9+ju0iYumDuX7b9WETK6dD+9YidYsBeUUg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Enable fw_devlink=on by default
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 17, 2020 at 07:16:58PM -0800, Saravana Kannan wrote:
> > As discussed in LPC 2020, cyclic dependencies in firmware that couldn't
> > be broken using logic was one of the last remaining reasons
> > fw_devlink=on couldn't be set by default.
> >
> > This series changes fw_devlink so that when a cyclic dependency is found
> > in firmware, the links between those devices fallback to permissive mode
> > behavior. This way, the rest of the system still benefits from
> > fw_devlink, but the ambiguous cases fallback to permissive mode.
> >
> > Setting fw_devlink=on by default brings a bunch of benefits (currently,
> > only for systems with device tree firmware):
> > * Significantly cuts down deferred probes.
> > * Device probe is effectively attempted in graph order.
> > * Makes it much easier to load drivers as modules without having to
> >   worry about functional dependencies between modules (depmod is still
> >   needed for symbol dependencies).
> >
> > Greg/Rafael,
> >
> > Can we get this pulled into 5.11-rc1 or -rc2 soon please? I expect to
> > see some issues due to device drivers that aren't following best
> > practices (they don't expose the device to driver core). Want to
> > identify those early on and try to have them fixed before 5.11 release.
> > See [1] for an example of such a case.
>
> Now queued up in my tree, will show up in linux-next in a few days,
> let's see what breaks!  :)
>
> And it is scheduled for 5.12-rc1, not 5.11, sorry.

Thanks. Not too worried about the actual version. I just want things
to start breaking as soon as possible if they are going to break.

-Saravana
