Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7E726A045
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIOH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:56:19 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:30126 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIOHz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:55:26 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 08F7subX002194
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:54:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 08F7subX002194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600156497;
        bh=BhfWwazkZ1UsFBNj+9aaT/huN8kz/KDvrP+OO7+KrWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ypalhw62Odfca9wEPDZAzBU1805133jvCJAhjJBGqtfVLGtAma/ywpE5MTpcA5ggQ
         tjOqvYGENXGLo5sr5MqesWDkFet8vq/jhOcMd5RxaqeBv1ZfKymEMETXOVGONR0+Vf
         I/Wt0oMrzbhPxDhtH6kqG0LbReGm4MJzUyJrcbPOw4hGx/TakAHF5SX1z9JIjECx1s
         GQ8/g/up8jQdNkXh2vio3GwZ5y/Zzpw/1CAR1n/6G7s2rOZ4efYuTx5yn+3rDyZNfl
         rVBsQ5F9hb81ANR7bslT7zMdxVwaRuTaLs78aZmQcyN/1xvK94GTXbzJF9XHt7Tv6B
         ReugZ6U0Dg0GQ==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id k13so915742plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:54:57 -0700 (PDT)
X-Gm-Message-State: AOAM5301pZ0lBCJPCfW1wJcQ4uDPEpqUUto7nHYhOIfGMtwbXiTadUM7
        79eWwtuozEVm1gKAPJCzjTp2+l/fJzXWiNKDRgM=
X-Google-Smtp-Source: ABdhPJznRg6GUsPNSEIniwqHb2obJCKed8uo83LNBqf3Sy+gF9YULaCo8vNBUeIDLkwYU6Q7ToNTB3TMCA97Ya6y22g=
X-Received: by 2002:a17:90b:208:: with SMTP id fy8mr3069316pjb.153.1600156496355;
 Tue, 15 Sep 2020 00:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-9cd01270-7c54-4bf5-810d-e1b7de352e11-1600106229398@3c-app-gmx-bs03>
 <CAK7LNARw0aRmKLb+8mxZbzxvB0YQ2_ak5LpcpQy+=3HrtiFA1g@mail.gmail.com> <27B16959-58F6-4190-8A65-88FFD2A49452@public-files.de>
In-Reply-To: <27B16959-58F6-4190-8A65-88FFD2A49452@public-files.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Sep 2020 16:54:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATk0=gLquyX3W90xcX60O++fhrhjTHJv0k-=vuhGVg5AQ@mail.gmail.com>
Message-ID: <CAK7LNATk0=gLquyX3W90xcX60O++fhrhjTHJv0k-=vuhGVg5AQ@mail.gmail.com>
Subject: Re: [question] KBUILD_OUTPUT and modules install (with INSTALL_MOD_PATH)
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 2:42 PM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Am 15. September 2020 04:56:55 MESZ schrieb Masahiro Yamada <masahiroy@kernel.org>:
> >On Tue, Sep 15, 2020 at 2:57 AM Frank Wunderlich
>
> >> i try to use modules_install target after building kernel with
> >KBUILD_OUTPUT set
> >>
> >> KBUILD_OUTPUT: /media/data_nvme/git/kernel/build #kernel source is in
> >/media/data_nvme/git/kernel/BPI-R2-4.14
> >>
> >> kernel is build successfully, but i fail on running the make
> >modules_install target
> >>
> >>   ERROR: Kernel configuration is invalid.
> >>          include/generated/autoconf.h or include/config/auto.conf are
> >missing.
> >>          Run 'make oldconfig && make prepare' on kernel src to fix
> >it.
> >>
> >> Makefile:648: include/config/auto.conf: No such file or directory
> >> make: *** [Makefile:719: include/config/auto.conf] Error 1
> >>
> >> it looks it is ignoring the KBUILD_OUTPUT variable, as both files are
> >present
> >
> >
> >KBUILD_OUTPUT is an environment variable.
> >
> >Did you set (export) it
> >before doing 'make modules_install'?
>
> Yes i exported it before use at beginning of my script [1] and modules_install used inside install function [2]. It works with build-function [3].
> As the script is big i linked the relevant parts...i checked KBUILD_OUTPUT at beginning of install function so i'm sure it was set
>
> >> $ ls /media/data_nvme/git/kernel/build/include/config/auto.conf
> >> /media/data_nvme/git/kernel/build/include/config/auto.conf
> >> $ ls /media/data_nvme/git/kernel/build/include/generated/autoconf.h
> >> /media/data_nvme/git/kernel/build/include/generated/autoconf.h
>
>
> [1] https://github.com/frank-w/BPI-R2-4.14/blob/5.9-rc/build.sh#L75
> [2] https://github.com/frank-w/BPI-R2-4.14/blob/5.9-rc/build.sh#L368
> [3] https://github.com/frank-w/BPI-R2-4.14/blob/5.9-rc/build.sh#L578
> regards Frank


[3] is unrelated since
"#&& make modules_install 2>&3" is commented out.


In [1], you export KBUILD_OUTPUT as a normal user,
then in [2], you run the commands with 'sudo'.

That is why KBUILD_OUTPUT was not passed.


-- 
Best Regards
Masahiro Yamada
