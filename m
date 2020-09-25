Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD48927862A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIYLnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:43:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYLnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:43:05 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N17gw-1kSl6T1KJ8-012YOU for <linux-kernel@vger.kernel.org>; Fri, 25 Sep
 2020 13:43:03 +0200
Received: by mail-qk1-f170.google.com with SMTP id w12so2413009qki.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:43:03 -0700 (PDT)
X-Gm-Message-State: AOAM531NaU9cXLDXzaCnwTYFq7cJwMHATvitceR8yBK5zu3tMnImCmV1
        bwbr18FqgMiPACXOll8i1StWknm6ZKPKeQc0SqE=
X-Google-Smtp-Source: ABdhPJxwy6CLQ+3z9ls6t+I4y0zYbeMKdRiXGVftoa5NoJuLU2aRCidwAqxez624CRsRpyfFFmcB359CShOmCNqj0Lc=
X-Received: by 2002:a37:5d8:: with SMTP id 207mr3738577qkf.352.1601034182156;
 Fri, 25 Sep 2020 04:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200922202208.1861595-1-arnd@arndb.de> <20200923054440.GA2619878@kroah.com>
In-Reply-To: <20200923054440.GA2619878@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Sep 2020 13:42:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a19dDzW2gm-bC9PqVZ+sV+FJ7qdvzrSFrwd=XAdRcvLWA@mail.gmail.com>
Message-ID: <CAK8P3a19dDzW2gm-bC9PqVZ+sV+FJ7qdvzrSFrwd=XAdRcvLWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: vchiq: fix __user annotations
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        driverdevel <devel@driverdev.osuosl.org>,
        Marcelo Diop-Gonzalez <marcgonzalez@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nachammai Karuppiah <nachukannan@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jamal Shareef <jamal.k.shareef@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:V0FVmJazE8lZV4J7fbLc8COxuEYEhcTD32qHonrB824cb4eReAr
 T7+fX4DR1bhXxlNHXZZ/YCwpgUBtkZcrp2hyr1bHoJ1DgvhHpB74fuxpEy3nItvrbv59LQn
 4G54UVHe0PjQvzfClFJiqyoj4t4EcDmyGm5jzdVslgQ/ep5pzFIfT47pRRkhkcEnuSLAqsD
 0edHitRAjYiZ8bs612Wnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+NIJgbFrmlw=:v6hAAbagFlDEzMDl897VsV
 NYpQrq0clwjnJBRPMrjJM2qN89aNWyNQ94vv6mZ9a5ZDx0AgYnVEnOh2lUavOaa1SEdmHbr+a
 YfAKnd+SkhLHUXy2u+j52LC38cDbvcxWxK0JdDQE/Y1l6eC5dYNPpTYF4dPPUF8tipsYbgg7r
 o5YUzSs7pbj1g8QQMDrdM70hhNgcL4R8Shjrln+fJcY/crlyO9EDihj0XAgZ56l5T63uH1R/k
 LAYa80iExhvyflEG2YqSlElLPpZc8qWfFAU5K0AXklFXXbuUsXyk2CjdMrtjyGaVbhJHlMolA
 0K0jXIFZECMD+we6jWzvKS6bEkUDNiWl75j6T9Yl8C3HXVr7oh9ZJ0WXSPA8555xVU79mMJxK
 2VDXIKNbgZiiqJBMyCr+iKo0ZSPJ9LQAJX9tVVO/55gVTX7NPdHKaF0Eaz65V2A+l0KU2yFQ6
 wyDBnA5IWDojkYsyjAVj6ZZF/nxaxwKVFCC1eIWAunfL6Md6hNMiV6QJU4cCvKlZ7psbR62jX
 ES46qTIVkjUEEEHLhHHA8iQcB2NHYk6doDlZaZAT83q48AW3wz0539OMUxyz0F2ChMSNvbhBT
 po/T05fg9aC4MoOGmfchqZ5zLDE7KF/byvK0bworTF/n61PbZKZ3oSDeiawoS8Rcq2npZxCoz
 4kzUulBD/OGxeu4OvMbRjTc8Sqot7tVSaTZlQ/dxJ81BjPzGYJHUD9hDhlAuRp5qtteV0JhGO
 HRfGc9v9nBYg3aR16eJ9RE9l7XPlW+vb9VFz7wJXkgNn2JaEDWSZXTLuGtb3DO9UkvhCshWeL
 Jfz7kP0O3zyVffkjZnzREJM8CP68ns46ae1CQQ6/pHZkbLROzxqU/oZBLIQf+UdWVYXTdIcmv
 G0lGbIb/CadMO/xq8jVFaRTAs9YTpqYQOrny2pgnO4aj75ubLvpScPBG4RyfnF6dmMq3mhDhp
 6Wj/LOjct5G2YCHKdcRReyXU8LIDbjihJevrCXrukkSO+6vq5uFpp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 7:44 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> and so on...
>
> Care to try a v2?

I had a look now and found the problem, as there are two drivers that I did not
have enabled but that need a trivial change to match my other modifications.

I'll send the new version in a bit, changes below for reference.

    Arnd

index 292fcee9d6f2..d567a2e3f70c 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -122,7 +122,7 @@ static int
 vc_vchi_audio_init(struct vchiq_instance *vchiq_instance,
                   struct bcm2835_audio_instance *instance)
 {
-       struct vchiq_service_params params = {
+       struct vchiq_service_params_kernel params = {
                .version                = VC_AUDIOSERV_VER,
                .version_min            = VC_AUDIOSERV_MIN_VER,
                .fourcc                 = VCHIQ_MAKE_FOURCC('A', 'U', 'D', 'S'),
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index e798d494f00f..3a4202551cfc 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1858,7 +1858,7 @@ int vchiq_mmal_init(struct vchiq_mmal_instance
**out_instance)
        int status;
        struct vchiq_mmal_instance *instance;
        static struct vchiq_instance *vchiq_instance;
-       struct vchiq_service_params params = {
+       struct vchiq_service_params_kernel params = {
                .version                = VC_MMAL_VER,
                .version_min            = VC_MMAL_MIN_VER,
                .fourcc                 = VCHIQ_MAKE_FOURCC('m', 'm', 'a', 'l'),
