Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F1C2D3646
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 23:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgLHW3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbgLHW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:29:05 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DB0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 14:28:24 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so628675lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1flNpuMf3kWpq9CKLXCzBcHoZKv4TnSjzktClhGGDw=;
        b=riwYotL70XKlJLpsfeJKqih+77jDsmT/tNUXLl5B7IPXAMLU/nRsmXJe+sbUqrW8aY
         jYcCb4sWkGXhjLfqNVQ5OYpvMQF4LRXuoYfaPnNFThPJfkXT/AbzYwHmxR+QhqvePhbK
         rYcbQaPcsuY0vCIFj4ANNtRmO248jPqlgyREcdsEYan1DvnSvBvMsO9mPH2dSfJO3jTe
         AD0uOuvZkuPvk7rCTirWcsajQPTUN8fHmQwp44OGBq7xZnYoJwUMG1bVdvK2xNYxckfd
         BEtXgk3oOfDA4xZ8LLLwBJlXfQav/daml21ULtUo5FB1lt+3e5RoSX1Fu/HC4WGAnHbR
         CyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1flNpuMf3kWpq9CKLXCzBcHoZKv4TnSjzktClhGGDw=;
        b=BOIbPC7ZHV+BfrkJV57Yqku/yjilscklTGJzuKXaDGJxjrUMZEgz7Cxy4Vy46a0jww
         k2oB/ULNLwNkeVlZriXFbHlzoFO6vFSoTIENkprTgX5fpadOJ+1wATwExwYaIjedTIVc
         JL098usxjNHlmAB881EjFLHTKpVhQbleAXTp3gzftbn+BIZxEUUmFXxnYT383oE5Fz7G
         MX1D9e4ffXxbNWqjAx1HyQiKOoSJBdDi49/Ilxvn/VfOVc1Tyuv3UcczjhAg4ym03GZ6
         /4NmimGnmlKk8RXeSZ0YvXSgVUPkbbkx01OVEVtby/HptwJVU0tZKbX5RnJHnZXoMWw8
         lL+g==
X-Gm-Message-State: AOAM530JUy7Vlw1iGeIp7A7SpKL/s0Lq7yhanF5tmSW0FVH9VFHTkdVT
        u4dOcoFffLAGhPisIOxT8y3Q2zD6RJiYxHnvc8424A==
X-Google-Smtp-Source: ABdhPJxGCpPC//eZZe1roRUtOxmeOE2ur6lR30dYCQ/57e4kEAtkFqk0+w3Dpi/CKxSPvcALIk9QrCeYoRMeetlPP+g=
X-Received: by 2002:a19:23d3:: with SMTP id j202mr1114346lfj.607.1607466502870;
 Tue, 08 Dec 2020 14:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20201113205233.827493-1-rkir@google.com> <20201113210730.GA1992396@bogus>
 <CAOGAQeq29S06+6M58qF0e4ivjzkZDg4+M7ffSK+FapbgmCBrLQ@mail.gmail.com>
 <CAL_Jsq+QjQxDh3_KDhgE_2A6DjA+gSyvknjrVfRFLMLz-p_M9A@mail.gmail.com>
 <CAOGAQepCsj63yZzJJHKCdHTenkWNLc_v=Ab6PgvS3hzqZMwH8A@mail.gmail.com>
 <CAOGAQepW3pbbjK9KpPZR1BwGY-CGF7V_pTY_9dw98XPgUKYFHg@mail.gmail.com>
 <X68aZ/Dgm7CObQmH@kroah.com> <tencent_3801BEAE39670E174105E007@qq.com>
 <X6+SKQS6QJr25kF0@kroah.com> <d1d47715-482c-f598-a958-499d9fde21e0@flygoat.com>
In-Reply-To: <d1d47715-482c-f598-a958-499d9fde21e0@flygoat.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 8 Dec 2020 14:28:11 -0800
Message-ID: <CAOGAQepV2_uNhWmQUG7pypukDsA5E9Uobv-JrqcQrAtxsHttLg@mail.gmail.com>
Subject: Re: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Huacai Chen <chenhuacai@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>, Rob Herring <robh@kernel.org>,
        anup.patel@wdc.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 1:48 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> Thus I do think it shouldn't be retired as for now. If nobody comes in
> I'd also willing to maintain

Hi Jiaxun and Hancai,

I sent a patch to add you to MAINTAINERS for goldfish-rtc. Could you
please ack there?

Regards,
Roman.
