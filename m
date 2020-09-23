Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C78275BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIWPae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:30:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:30:34 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Ma1D8-1k07xz2jWG-00Vviz; Wed, 23 Sep 2020 17:30:31 +0200
Received: by mail-qt1-f179.google.com with SMTP id n10so213106qtv.3;
        Wed, 23 Sep 2020 08:30:31 -0700 (PDT)
X-Gm-Message-State: AOAM5307kOwsmtZfQPw3FcRZVF6R9vw0L9GcCOy6LgUSOHuw5dyGgvU0
        MjRygTZVbVOkdKQKjboSOZ6llH1lEfK+GAYpFRQ=
X-Google-Smtp-Source: ABdhPJyx3khV9ouMU1lDxgVnLoI4g4YiXmj0IB5rW6IHWN5WF61DmY8GCOsbNySmlU3CqZ9ohZGbz8tecEaKsFKwVrg=
X-Received: by 2002:aed:3825:: with SMTP id j34mr581207qte.7.1600875030304;
 Wed, 23 Sep 2020 08:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Sep 2020 17:30:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
Message-ID: <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8N6geTkfnb188B0H6aGTVMbLl+suW/kEDmJPmYACXe0NZkdkx0T
 0Iv2eSBTrpLTjcbWGFtPZHXyFUfmrt8b0CJkQJF2lY/YoKl0dQNRDrdi90q9vhoJ27ekbYP
 hnW2az5XXGHgmYbfrY84iNXFQOJz+JzUT0qfZRzG4VUP3VKySlOg44mLtJUbKQosYp1iOGO
 3TMl/2A6NXe2AN8sMKM5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YVhJ5zJKHT8=:ZeaLUegZUQCPe3E9MYfpJH
 hz5hTmAoUvpYeEWZQkx2YTYHp4+UxDeI5pYprvthjKEzOdGdYgUKxWeRCJoUk3XbgdIOWxy9e
 rYkGqpOLfTDgk5tGXfOfM42cf6VglVTYrnVBeiUnuP+uFJ+k0wk8JSU44JVLgg39oVIJp/LbU
 9vpizFtKTk/HlaiFq+QJ3NRpHpPVaio2WrDd/b33JlhESWinm1LklG7HK75Obq6/+MECsBJNw
 bz8Mnc6v21RErIX9GnfRnqhreeKm/ve5gy14J+Tl+KSNOgEUJ4TTNTo4P1Ns8CPC8RLhYKlE7
 8Z+DrjdV6fZ9ymexsLynm5cUEFJ+Dl7HmeXDRZ9qFeh6R68kzwUBXttjYjn7TMCywjNdK/Y48
 398NL2dqysIvGLL/Qhp4BF1zPVIaoKjQZhtNkXCyazB4KtZbMaqSA15OB0xtct5hjGNS8mhuq
 gNk0ZjDuaCzEy/ZehIce3bY3FHQa3wVh4g7nhhR/FcBmYvMnilc0NaXrrxmRIHYWPVsFsSR40
 DQOgdBJHSSY1B/o57PXonLsgeGP31HTCkYjsTDg6OapKtE20RO6HODJE06tT1JGs2G1ZL2HvO
 +yWc0B/WrYPuvo1WwMc5fRLzT3ct5fpxg+Rd2gmg2nWswK1rcH/Y14xN0V2ByUiEHtSW6a7a5
 86CbGb/FXY8jpWBPn5TIlV0TGjGh8tDqLzWh79E7+x9iRKOURQjyqGUcjY8s45N0BHQlLG4k+
 gcnU4DVUynTJePKazKsjUa1A0u7aqYDLtqPPqwIKusaWzKkly3jCz7QLPRbEGBS1F4YYarI1E
 DpSINoLwG9P4Hy7d3LFHuK0qLBPU+9emDzGe58h+XzSSIuvbkKv7IwPesU8Yqp3bON+nkk7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Hello,
>
> The Surface System Aggregator Module (we'll refer to it as Surface
> Aggregator or SAM below) is an embedded controller (EC) found on various
> Microsoft Surface devices. Specifically, all 4th and later generation
> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
> exception of the Surface Go series and the Surface Duo. Notably, it
> seems like this EC can also be found on the ARM-based Surface Pro X [1].

I think this should go to drivers/platform/x86 or drivers/platform/surface/
along with other laptop vendor specific code rather than drivers/misc/.

I'll have a look at the code myself, but I'd prefer to have the maintainers
for the other laptop drivers review this properly.

       Arnd
