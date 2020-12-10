Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1C2D6376
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392544AbgLJRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391317AbgLJRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:25:10 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88A9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:24:55 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id d8so5599224otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFQckzUxker7hD4gEVPk8FIb33ZU0VYEtCHChGBdgHo=;
        b=TOG920h10dQaSs1Q198SciJA7oznw7oR34uKYF5py3DQuEjyYTON9+z1HjOnjjjlvx
         JXrgnkCecWzR+8rvOo/d6rjtWTapmCrFezHhoy5XAK4fAWCx+fbc1ww+ua29g7QLGuGE
         KK5Zm3uIJiZrSF0Qx606sq+DZUECSFH1Bk+hBJ4dC+s8BuQm/z40aDRibum/3JtzT0Un
         sAlIIFRX39vUFtEeYkO+Pxy3Dk5vBzVh0Ibx6JOtD+u448UzRrzKusHOz87Ppeq7P4Fb
         sgp+H+hLlFfleb51uqa7uE07Rl6UVe8smo5VvvAfD/yo+6CptPnfM8Hg6SXxOtAoxd7N
         6aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFQckzUxker7hD4gEVPk8FIb33ZU0VYEtCHChGBdgHo=;
        b=iOrZPxyLR8mQhuEXtoK3pyeiqUE/zomC75gg3RrTIg8x47STkKViaFGIqy/H0NR+BJ
         GR4nMAzkBzI1S4dkVXMn6TWcDmDLADFWarUx2hIl9lQTX97MpQPEf1BueZ+Del6bClPS
         t965StoFOpj7w9oAUoX6Ok4eu2NPUdMgi0BtXnCq8PhKEwIW2dyJPlllfTSK+Y14F5S3
         NQUHDNva7aEVDRE/TjNFR2O4krXGvaBGhJX/97h4Tc4Gj8sj4lI58oyt9BGMCyDH1mU5
         JtNpkHnnCX0jXU66WBSz/Ri5l5l8XW2grgzyviudEitm9a5axjwUngNHs1t2AcekVqlG
         SSFw==
X-Gm-Message-State: AOAM532Nk5n6xxujAoktxsPQXorurOnXke0FQbT/A+sQmf359VoNyqW7
        RIUU5laXYA004guupJ+6JvxojsZoNxqmyL31EG+AGHbY
X-Google-Smtp-Source: ABdhPJxOMhMACKGCkVgQUS9xHAEg0wochoEtFLfmyVRzXWlQkk1BKLm6ABpG4Wh5IMW+NWtCuDnAA9jEuaSihXQOe50=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr6900148ote.132.1607621095196;
 Thu, 10 Dec 2020 09:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20201208195223.424753-1-conmanx360@gmail.com> <20201208195223.424753-3-conmanx360@gmail.com>
 <CAM8Agx3ttO_RDgjQAxLYpVMVRhz+xgmg80f4iefXZNVrGcd0-g@mail.gmail.com> <s5hczzhr2xy.wl-tiwai@suse.de>
In-Reply-To: <s5hczzhr2xy.wl-tiwai@suse.de>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Thu, 10 Dec 2020 12:24:44 -0500
Message-ID: <CAM8Agx1+FiaqoR7jG5uD-XQkwzu2YiVOZTAEy8JuKLjC3XCU6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda/ca0132 - Unmute surround when speaker
 output is selected.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     stable@kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will do. Sorry about that.

On Thu, Dec 10, 2020 at 12:22 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 10 Dec 2020 18:16:00 +0100,
> Connor McAdams wrote:
> >
> > Woops, sent previous email on the first version of this patch.
> >
> > This patch is a mistake. Not sure why I did this.
>
> OK, then could you resubmit v3?  Now I reverted the v2 patches.
>
>
> Takashi
