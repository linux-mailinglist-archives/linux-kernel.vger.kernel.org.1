Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D439929AC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899957AbgJ0Mbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:31:36 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40040 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899936AbgJ0Mbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:31:35 -0400
Received: by mail-il1-f194.google.com with SMTP id n5so1318512ile.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NX3aMd8nOxmdYv1FMvBjyoMjhVdlhBSOsPMwKR/CR38=;
        b=BNIE5eBYuI7rcpMZ7Fc8fXqliKjnQxcjorZNJL1u/wBpIhZBPNm/oj2C1C6ZdxZGqP
         uAYGC/mtPEyUM4jNLBnAm4jxr4genpcgGd/TQ/ERBwsmskt1N17w//1kmUAuHUDUnICN
         NTh72+99x21FAoc2Rb5wYJc0zP7/BuMc6mdP6YIeVMTXUp09DbbKqxyiR0QbSxt9Uh9M
         PDmkAegg3yxK47MX7sNkSW2kPFFGSzm9nBayI2anXHD4KkqoCRkjPLjI9snUHdRjVihA
         3vXx/MIX6pic4UTKz+mgxXOAbcTQne8C0eTtk/Ce5Xpl2con9KqsduAuDGrmvbvUEpCw
         056w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NX3aMd8nOxmdYv1FMvBjyoMjhVdlhBSOsPMwKR/CR38=;
        b=mZWxgb5Uxh9zPerl9/cTrpTOY7qAHE6YuBKNolcU5/RMMrM9BjoRUrO4SlqSCAEf4a
         6/bYYsrR3WtisD0Vy9fQ68SOx6t+BUY0KPwxNdwwICJjl2lZTSwBuhMm3eJgPshRLacJ
         tMHzX6RkeTAQ2FLY8kqYKj6v1Aa8nm1uzfeOZNHCSV68qyFDeCZkgxcKotCJk77ydxrv
         z4er7mugAyAK5xRSNdNUYTcf/AdFw08LHSzbbiX6lHDjqzRRmjdUjEYYiGaJhn6zbj5T
         w/r/Qy8SrwOgH2tLcg4EQp0JdvPap03CVciLJUcuvMMGSal50xfWWGxPeMUIUVyWTBck
         am2g==
X-Gm-Message-State: AOAM530q3us0Zk8bN9CF+kcaB0S0sq6OYwBTp9IpmfxRh7lIdtQD+IgB
        x/f67TLsUwg4HnWaGwUC7GipgN9ZlZwSHrWkiIhl5Q==
X-Google-Smtp-Source: ABdhPJwb/TNwFu+jrjo/IlYtjsGVcMMEoaPtXivWlxQC5lx3nfvrKZa3AsaqBYz1meb28HW+GVasVy0wuSu9kPRfM0A=
X-Received: by 2002:a92:6504:: with SMTP id z4mr1446561ilb.282.1603801894156;
 Tue, 27 Oct 2020 05:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201026150851.528148-1-aleksandrnogikh@gmail.com>
 <20201026150851.528148-3-aleksandrnogikh@gmail.com> <CA+FuTSeR5n4xSpzMxAYX=kyy0aJYz52FVR=EjqK8_-LVqcqpXA@mail.gmail.com>
In-Reply-To: <CA+FuTSeR5n4xSpzMxAYX=kyy0aJYz52FVR=EjqK8_-LVqcqpXA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 27 Oct 2020 15:31:23 +0300
Message-ID: <CANp29Y7WOFZ-YWV84BucHvFRg628He+NDsGqCZfdsn_crwVW2A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] net: add kcov handle to skb extensions
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 7:57 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
[...]
> If the handle does not need to be set if zero, why then set it if the
> skb has extensions?

The point of that condition is to avoid unnecessary allocations of skb exte=
nsion
objects. At the same time, one would expect skb_get_kcov_handle to return t=
he
latest value that was set via skb_set_kcov_handle. So if a buffer already h=
as a
non-zero kcov_handle and skb_set_kcov_handle is called to set it to zero, i=
t
should be set to zero.

> skb_ext_add and skb_ext_find are not defined unless CONFIG_SKB_EXTENSIONS=
.
>
> Perhaps CONFIG_KCOV should be made to select that?

Yes, thank you for pointing it out. I=E2=80=99ll fix it in the next version=
.
