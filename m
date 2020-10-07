Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9132867C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJGSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJGSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:54:10 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BA5C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:54:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z26so3535745oih.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4If+TCyiw9yiNk5xVyk9qCMBHV8IsTz4Qj42igWU3E=;
        b=dsV+Y50FgwarfakCN8ShfjweD0Be9WxVU2H4i1/Bxw2OqJstl+dB01hatMej0NMEkn
         gwQQy5niBpeLEhlPRoTcm1EWWQHmUN+94i5tFZHjdDRKhVI9moPj1xuAZG+dUA+A2xiF
         Qac63cFL1O2lih18X5ANKMI52BUKOrv30FtpZw/jRJz60qwreULbtOh4Qt0mwuL66pvD
         QY6ih1LxWdtG1cOAraQO10kRZN3s505iy8oi3MWe5aB6/dgx3J6JEe7UNBJYqw/xkxpK
         cgQRhkW0dld9bkCGh9PRoetporVnU5sz6Y8TikjJet87rGnB0qLk7y9Lu71IgUmhn9Ck
         jkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4If+TCyiw9yiNk5xVyk9qCMBHV8IsTz4Qj42igWU3E=;
        b=XtmHR+kx5//28MZxQscRSbCdEdIKMM+Y+wdACaZYNrq+Ho3XDfIufFXCuA+JyAtEpQ
         w1NhVt0AiEVqKVmxsuKphrgACLAgZv0Pms1AQYXbBjIK8AXs6oIQdObpM2JxpAoDyrM8
         LHkMwZ0WvxY875jknVp9u/ZdeyG12+RrBNKzq7EPYdX1Cmc+d6PiZaoA76pwriS0r71U
         7FIr4EkWj3YwtEQ84g7jsy9SyQ7Im8AxulfERipouf4g7yhbKDbWpETB9NbLMn5Z0OU2
         d5/THFOjNXvAINSN4GYoUMR+RCkYD6B5CXuIp59fifQaYTYNg2DMq1MRy6DqaH0STWmY
         RHZw==
X-Gm-Message-State: AOAM530jQ1N4wpIJwiSfFaB1u+w1knx4fLUhtupLah9/stm2nLI0yUNT
        9EJ15J7pPWKVJEUM6y99V3H/AXU8MYjW3EjQlhM=
X-Google-Smtp-Source: ABdhPJxzkA7qPxjE2iqnVluFz/QMlydOFlVvP64bYz4mDnKBkl5ODKeVE6cAcInl1wxe/xQPaZUs64lunnOV6wUSDIo=
X-Received: by 2002:aca:b2d7:: with SMTP id b206mr2934781oif.110.1602096848117;
 Wed, 07 Oct 2020 11:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201007063315.41585-1-dwaipayanray1@gmail.com>
 <CABJPP5AEELQz0t2+34xYQOJ5e5nQzTUUU6UT8ZH0fqm-tacOmg@mail.gmail.com>
 <a2db6d34e964bd5ca65f59d1a536a61df71fc955.camel@perches.com>
 <CABJPP5B_nscUwm4m+PySN67Cp=i1aR8KXKRuAf2YdAj_950j2Q@mail.gmail.com> <b1f15283f770c71923920fef8fc6c643433d1ef9.camel@perches.com>
In-Reply-To: <b1f15283f770c71923920fef8fc6c643433d1ef9.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 8 Oct 2020 00:23:45 +0530
Message-ID: <CABJPP5CwuV8mKZzZqg3AjHubTqE3QzZC1zQyf+U+-Q=kRxKh9A@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 12:14 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-08 at 00:08 +0530, Dwaipayan Ray wrote:
> > On Wed, Oct 7, 2020 at 11:48 PM Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2020-10-07 at 12:08 +0530, Dwaipayan Ray wrote:
> > > > On Wed, Oct 7, 2020 at 12:03 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > > > > The author signed-off-by checks are currently very vague.
> > > > > Cases like same name or same address are not handled separately.
> > >
> > > Likely now, the type should be changed from NO_AUTHOR_SIGN_OFF
> > > to a single something else for all the other types of messages.
> > >
> > >
> > Since BAD_SIGNOFF is being used for a different context, then
> > probably BAD_AUTHOR_SIGNOFF.
> >
> > Should this work or anything else you have in mind?
>
> That may be a bit too strong a wording as these aren't
> significant/bad defects.
>
> Maybe something like FROM_SIGNOFF_MISMATCH.
>
> It's not anything that would reject the patch.
>
> It's a pity type uses both SIGNOFF and SIGN_OFF.
>
Oh right sorry, It was a "visual mistake" on my part, it's SIGN_OFF
indeed and not SIGNOFF.

And I agree with the strong wording. So I will probably make it
FROM_SIGN_OFF_MISMATCH. And after that send in a
v6. (If I run out of single digit version numbers after this, it will
be embarrassing :(  ).

Thanks,
Dwaipayan.
