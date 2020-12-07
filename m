Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC15B2D1E42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgLGXVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLGXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:21:45 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C6C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:21:05 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id x13so6700660oto.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edbZ2+l1MblK0BZAl+T/FCWMuTNbLUVokY+QPVK2mX4=;
        b=Rcly/dyFCNQ4lyyFprCAU/lXdZFd+ySy9hRgc31aa5GMyT/jVNjPuPSHrKnm+aEotO
         sI2FffHUbXZtsPmxRyIVXXQrbpHh3N1DNt67TDAmNWFNVzbdT3I/umQvR5UAZ1kwAEDK
         F3awwK1PlHuovJWeoV1+uMp1n2uEI43X3cC9IQNV1Ul5uB8XI7L3WMjyvnJ8DfxOtl7i
         lmj8t/rykQcp8nB153WWKNt0ybBObvKsxdfx6ZZDmEliJYeJgodIsnTUkI1NBiQRu++b
         4mQulta309fUpSLGoCwj11YXKnOGf2HcF1FCM6W+0c5Kn3qw7KAjG5o+cZqkaMFQGW05
         6eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edbZ2+l1MblK0BZAl+T/FCWMuTNbLUVokY+QPVK2mX4=;
        b=UdXiYam5WmPIDmYF5Z8GVjfgO1RvwxOptfG9FREGNN3XST4j31ILPxHfcGxFka8Ekz
         GCn1XI63NafPi5dg9GmOFYlJQgxOaTi2uOUWaBDiAyl+SWDv4avbOccK6/f/09dg0snS
         lm3oAVfVDYHou12IqcK7D7ZiLCdglHSZph67BmS/TcHqXYPgy+fLB7TfjDfwOXFyb1vS
         8gaOvEpTT9I4pa4feOS5nHrDfZ7lK9ZQwZixUtLBps6opURnHuYHQ8SiGqc4tihqgd6/
         6wxXEPieFNCM1P6RdAmbqMwXh9UUp/UErNPKYE2ocx2yDecXLnsu/lUw7SThyEeO492g
         ssYw==
X-Gm-Message-State: AOAM533N56UIF5tbzKkcMZyic9qXfgtqa01cewan0szm9lf4v4Ap33os
        OwXGIgE14+Stc1tU7KMIuwm+xhzDPD6RwEGw97E=
X-Google-Smtp-Source: ABdhPJz0LTQfzPn68GwM+TvRci1apQbH1YT2kFBQny+zO3s0aS+RV3wXHxfUQHKdy93d8dnZwcppok+nSnLdVnLAvlE=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr12629023ote.132.1607383264756;
 Mon, 07 Dec 2020 15:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20201207084616.411531-1-conmanx360@gmail.com> <s5hzh2q0z8o.wl-tiwai@suse.de>
In-Reply-To: <s5hzh2q0z8o.wl-tiwai@suse.de>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Mon, 7 Dec 2020 18:20:53 -0500
Message-ID: <CAM8Agx0c6xGh4M_j8GHtfZ1MjzyV1dmbh=EWfASL_SBYgR6UVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ALSA: hda/ca0132 - Fix AE-5 rear headphone pincfg.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will do, thanks for the info.

On Mon, Dec 7, 2020 at 3:58 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 07 Dec 2020 09:46:13 +0100,
> Connor McAdams wrote:
> >
> > The Windows driver sets the pincfg for the AE-5's rear-headphone to
> > report as a microphone. This causes issues with Pulseaudio mistakenly
> > believing there is no headphone plugged in. In Linux, we should instead
> > set it to be a headphone.
> >
> > Signed-off-by: Connor McAdams <conmanx360@gmail.com>
>
> Those patches are relevant with your previous patches, right?
> If it's a fix for a specific commit, it'd be appreciated to have a
> "Fixes:" tag with the commit id and "Cc:" tag to stable in the patch.
>
>
> thanks,
>
> Takashi
