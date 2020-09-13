Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFE267F99
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgIMNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgIMNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 09:01:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C0CC061573;
        Sun, 13 Sep 2020 06:01:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b19so16223358lji.11;
        Sun, 13 Sep 2020 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pPCmjlTrAmfqJleeRYsacvC5WOPQ/sV/9CQBQ+8u+kU=;
        b=U6zE07o780EAOLjlGW1oq7Cy8bRqvryTPnit0wgmyG3Yv+v6Ui5vGcIN9cqNo2tUa1
         SY3RtJFeefEVvZmhhdzeSvDeD/QMSNGgHh7fiLc9IT2wgBTi3N6c4gxqKHVAtaoz1hNH
         xcNQuYc56ibDCJqP3r8Z4hNsPrIeriDyrMdcoAtjCQiSBzBpGijJLzLvmgj5haHnYwj6
         HyRZTUnfWvYR6KqM2BMGATdGK5UBDb8xChfBT7PhITekQzlnV4wSuFjJzXUmsBt+jh6a
         OmW5XaT8vp8v0nlf/qEBLN3xCr4wNqx/JusRkwvihD4Ir9aqEmZaFYFXv3WHiMgA4gDi
         /kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pPCmjlTrAmfqJleeRYsacvC5WOPQ/sV/9CQBQ+8u+kU=;
        b=e4Ur6HdYglFX+A41TNA/SyvzgSC3S+etE0P/MafLtfSefYnSCyf9VfRY9YL3VCRxJF
         3vXp6jZfS7AknTYTBQoqgw1QWZoOw/OPVxURS7XJSMhiu/hjQCsM3OT5W47qh0vTdOrY
         c2AQauXinbClP5yYDV93qDmlULuU5U8CjjEv9scmzV5E6tsBuykBNlXgAVQYx88+PuSO
         gQDve+sn8OdLkmD4XTnDj+A1kfOwb8zdb/nhX6WkiC7VqC1cTe57EmwXVlVPeqN5Udng
         t+zD9VePT6hw9AqiwZmipeWRl3nHEMkhbiIZzkMLXDE4hzs5/aFdgpo5AQigfF/h0XXA
         UV8w==
X-Gm-Message-State: AOAM5309ty1zPKAspZLIZ/LxluLq1B5ECJdVdXEUoUdta4NksL7xuV6u
        U4qlQURGf3SfqvQsoG+/tQI52TIc5j3K5eKQ847TiMBBPwU=
X-Google-Smtp-Source: ABdhPJxtcS0zuYBGhcNSeg7Jb61875RnS1WA/gwxBi7KM7yl6LgvZYjjU8Var5PK4WqMhIXxjYOCRceevRMvKGtNGGM=
X-Received: by 2002:a2e:a16c:: with SMTP id u12mr3468462ljl.266.1600002081028;
 Sun, 13 Sep 2020 06:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <641dfe3b-1de8-97ea-eac7-89d81846eab3@web.de>
In-Reply-To: <641dfe3b-1de8-97ea-eac7-89d81846eab3@web.de>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 13 Sep 2020 18:31:08 +0530
Message-ID: <CAFqt6zYA4srnsGx+OzrzVuzasOvUQR+dN0nmVZcv1zVeotxKUA@mail.gmail.com>
Subject: Re: [PATCH] tee/tee_shm.c: Fix error handling path
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 2:00 PM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> > When shm->num_pages <=3D 0, we should avoid calling
> > release_registered_pages() in error handling path.
>
> * Would an imperative wording become helpful for the change description?
>
> * I suggest to add the tag =E2=80=9CFixes=E2=80=9D to the commit message.

Sure. Will address both in v2.
>
> Regards,
> Markus
