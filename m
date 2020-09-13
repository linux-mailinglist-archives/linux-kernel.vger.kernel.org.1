Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115722680DE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 20:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIMSsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMSsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 14:48:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6436EC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:48:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so11862110qtn.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bnrnz0wLHPS+ADEtoROH+0raPS2mbY3JQqic/8V4qFo=;
        b=HDAIpXCMHOFDC/TpLEJiFG4ZzYm5vEKTKfZaloG6KNfmGivbxDD8VDVgfVWEdD3Hjy
         sZZlREk0j2MyhC9csJj6NwTs/RuREkjExKMcMqZfcGrE7RGz9DdpIvWJkygUOnU4wSVP
         Yj2KpfQZZlMTpl+J6uFPoSuFeF01RVsToRDkBqAeoMGURddwAGweepoM7LwH1fNp0A/6
         Q2UWsov5E6hcUP8nqkfOFmUTeSo9UWjPBs+nIKMk8YvH7u85UVQ4+J09UJgDE2wyu41P
         HwBe+14vl214W4nYtfInZHSnwgXmief0yXCsHeJKg1XWf0Sh6XpgYVNuUtsIPBpJROJ7
         TKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bnrnz0wLHPS+ADEtoROH+0raPS2mbY3JQqic/8V4qFo=;
        b=W3Ll3KPoqJyNjR/jiJwBcIBNDlFtOC1Qef//z70ohTXzaYz+7kXHhboGgX5jygN6Iy
         pUZTIG2JPPuxb56zkjcUGY3ApS3TAm0D3nqrVVd1d2vgxNq/xTkv6kQn+gVe9YzbmAfE
         f2U/72b+w1mNJoCHqsHsFis/1LOmyymRdfZJDt99bAkf6USY0SlgwVneER4NC2i9VKw6
         driTKX8CNOs10dHE3aj8ePiyPI/d6/H+wcK85iFIfSDSM7vphVsC5NJLky8P9G5jM9yZ
         D7vjoCFXTrjw5KK68DMXk+1BxKWf80Q3MB32JfECkx1UDoB55p457sL1NYxF3qS8u7OT
         3Ajw==
X-Gm-Message-State: AOAM5309eUlGV5kFuDZTB9Mlp8sc5EEZ2R3cS9g1/wBpZqbamBNonGp5
        8pBEKuzgDgcNfAf6rXEMJDR8FdVyhysTQJ/yyBoyM5PJHN0=
X-Google-Smtp-Source: ABdhPJyGVtyaUYumPq8Vt3gwM5wnfDJyWmR9RfgKELlSyeLh3U3wsnMZozD6DFwDRZs7ozO3N4VJ41fA+oM8CO3L/vk=
X-Received: by 2002:ac8:fa4:: with SMTP id b33mr10813208qtk.13.1600022924801;
 Sun, 13 Sep 2020 11:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
 <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com> <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
 <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com> <CAFLxGvycs7DNu5o5QY1WwTPfS6cTTykTh-91n9TQZ7yP_ADr4A@mail.gmail.com>
 <2086f822-e67a-43e4-76d8-5339eaccd3ac@huawei.com> <CAFLxGvzwoC1GcjJOfwpc8V5LD79=8XiJaNV2HjOm8EdQcCbp+w@mail.gmail.com>
 <5f7ae548-350b-cedf-3c8e-25fea06a8377@huawei.com> <CAFLxGvy-RRksDvPcB6z8GQUoMFZ_NRGxk9aM2FuTZ22UWU6Knw@mail.gmail.com>
 <56435b1e-ffdf-9d4a-5865-f2ce3b36644f@huawei.com>
In-Reply-To: <56435b1e-ffdf-9d4a-5865-f2ce3b36644f@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 13 Sep 2020 20:48:33 +0200
Message-ID: <CAFLxGvxdXOg7aHeHH0t8sZGvsTkY9QeN8RK8iRL7x7ge=MqFSw@mail.gmail.com>
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 5:26 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote=
:
> =E5=9C=A8 2020/8/8 3:29, Richard Weinberger =E5=86=99=E9=81=93:
> > On Fri, Aug 7, 2020 at 4:18 AM Zhihao Cheng <chengzhihao1@huawei.com> w=
rote:
>
> > Maybe it's just me being dense and in need for a vacation. ;-)

Applied to fixes. :-)

--=20
Thanks,
//richard
