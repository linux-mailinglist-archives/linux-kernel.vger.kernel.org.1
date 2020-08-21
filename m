Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D724E26B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 23:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHUVKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 17:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHUVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:10:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:10:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so4032020eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1GxeclShnz9s6YooeI4FTefDOr5GR0mdhr3H0v41iq8=;
        b=ULomP/h5zFTlK6svQoBHF/IY5NXh3ZFjFpYZi4r/DmgHSy9n0NMnL40xhDiTVrBqCA
         qWq+MSCwrWNKuOjgEsiabvf3Gkq5kKn/GU9zOfjHzFhZRu7wcZJr3CbM7mf1CYr9PWtI
         Hxybv7hJSJA7mQjOs6K3g0XUi4tYBRPGRhB2BHqpM3IE9Pa2qvTqstR8uBgqbWWhe6HP
         ZbHTHYsvq81ikZ1MGtAcM1fJqcNGeX8z+oxNg5xrrOkXFatp9LK6qEV8ObrLMZiKGmFQ
         4viLkDIN5bTT7Urlk7RA8BbHEH2aAOVvSt8ECoaghv+LdOF8rM2Sb2MwctjeQHrJUCTv
         3WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1GxeclShnz9s6YooeI4FTefDOr5GR0mdhr3H0v41iq8=;
        b=AOhgiDmf4O50JvZa6TZ5coBJfUASH3LqCE94Uht+pIiB0CRegFZvXyGf7iubiKjLhQ
         1/Qp6yC9+ASsqSa4tlleV/MjMi3GENTpY/8Bt4SfAI5uyWERj25FOwptD+0gyk4fXZ1z
         fCI/fE/X827F9pFQrvgolDi+apQ3v2hjJ3JCP9OB4EUs0EzRGu04DuVBqW3SFuizfo6j
         FWteGJxSBQeS891E0mOf5hdLy1ELkNZVovZX5/xtBKhwcQ9E4FR2xwI1+nRd2z+D7m4m
         TJRt8WTg61KhrhXKSoSpaipfBZ/k+XrwJpFds+RhEL315xb/mDr76hftL8u4bnaOANwf
         lOgQ==
X-Gm-Message-State: AOAM531oKaLlKrkwq5Fh2kwRyNVgwUWwgTZn1PwaTT/344wOrb8v4tyY
        6Jdunp+F9L99n7iQna195YhlsOBdflwHK/eWZlsF
X-Google-Smtp-Source: ABdhPJyC10RptEQ9k5GLxJNC51Nlx7LkzAE/O9eV6nL87g4t/8Ya7DkqIpxF9e6v59lZiaYO0q6j+CRyXfS7fsR6qzg=
X-Received: by 2002:a17:906:5205:: with SMTP id g5mr727520ejm.488.1598044199461;
 Fri, 21 Aug 2020 14:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com> <20200821140836.3707282-3-tweek@google.com>
In-Reply-To: <20200821140836.3707282-3-tweek@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 17:09:48 -0400
Message-ID: <CAHC9VhQz+iAvsRoq-Y8Up9W6tUSfnxNva06iK9pFC7wWCTfpUg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selinux: add basic filtering for audit trace events
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:09 AM Thi=C3=A9baud Weksteen <tweek@google.com> =
wrote:
>
> From: Peter Enderborg <peter.enderborg@sony.com>
>
> This patch adds further attributes to the event. These attributes are
> helpful to understand the context of the message and can be used
> to filter the events.
>
> There are three common items. Source context, target context and tclass.
> There are also items from the outcome of operation performed.
>
> An event is similar to:
>            <...>-1309  [002] ....  6346.691689: selinux_audited:
>        requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
>        result=3D-13
>        scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
>        tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
>
> With systems where many denials are occurring, it is useful to apply a
> filter. The filtering is a set of logic that is inserted with
> the filter file. Example:
>  echo "tclass=3D=3D\"file\" " > events/avc/selinux_audited/filter
>
> This adds that we only get tclass=3Dfile.
>
> The trace can also have extra properties. Adding the user stack
> can be done with
>    echo 1 > options/userstacktrace
>
> Now the output will be
>          runcon-1365  [003] ....  6960.955530: selinux_audited:
>      requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
>      result=3D-13
>      scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
>      tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
>           runcon-1365  [003] ....  6960.955560: <user stack trace>
>  =3D>  <00007f325b4ce45b>
>  =3D>  <00005607093efa57>
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  include/trace/events/avc.h | 36 ++++++++++++++++++++++++++----------
>  security/selinux/avc.c     | 28 +++++++++++++++-------------
>  2 files changed, 41 insertions(+), 23 deletions(-)

... also merged into selinux/next, thanks everyone!

--=20
paul moore
www.paul-moore.com
