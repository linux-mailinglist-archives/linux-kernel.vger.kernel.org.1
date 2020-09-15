Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1DD26A5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIONBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:01:25 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgIOMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:46:03 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MgNMV-1kzjck38yF-00hyh2 for <linux-kernel@vger.kernel.org>; Tue, 15 Sep
 2020 14:45:37 +0200
Received: by mail-qk1-f171.google.com with SMTP id o5so3946355qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:45:37 -0700 (PDT)
X-Gm-Message-State: AOAM530fM/aodTMMpDvjoUAOO3lPZL9YAtJ28XuypScHPxMzIi7V81QE
        L2I8YCuOxXyFc7E6vuqQ4BDQIFRPwlMH0Vrt1fU=
X-Google-Smtp-Source: ABdhPJxGGGo9u+Zvj7Qe5hvDC63hTak7VLouMck5k7v+rUEma8x2eR7Ys9Aw/WYT4Y0hl86F4GeVAByJlY7JEboXQys=
X-Received: by 2002:a37:a495:: with SMTP id n143mr17332931qke.394.1600173936682;
 Tue, 15 Sep 2020 05:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <1598952616-6416-1-git-send-email-prime.zeng@hisilicon.com>
 <CAK8P3a1SJEEJ_U9Vai1jCyXYEH=qcsk+zaeo9sjzbB5qByPKDA@mail.gmail.com> <678F3D1BB717D949B966B68EAEB446ED4827837E@dggemm526-mbx.china.huawei.com>
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED4827837E@dggemm526-mbx.china.huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Sep 2020 14:45:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2WG0DvTyrTkiLg3GW1x2s-oo8BgAyvp7uHvzXhJCiHmQ@mail.gmail.com>
Message-ID: <CAK8P3a2WG0DvTyrTkiLg3GW1x2s-oo8BgAyvp7uHvzXhJCiHmQ@mail.gmail.com>
Subject: Re: [PATCH] time: Avoid undefined behaviour in timespec64_to_ns
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:enuIEG/kwRYymIw3cZHkRlYb5AK4wRS+rhS8lqGdwojZRfIq205
 6dYpc+IW3cJ6qZNyYH5JqRprTvU/56g1PCvKx3STmoGF19TCVG7O2WMnucU1pYHSSXwie38
 gLePHDWe+hQciUVzccncTQSZ9ASKgkY0K3zYHXvYm+E19xwCzh6rhRb6sqZ+lY63dx4aisY
 WC3azLwljmPNq3GLwJzgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8gYpla1nGFw=:679h6qUu6d/cdhQXR5tRGG
 X5/GulBi4Finl3xwlY0wf23yJbckvad0SszKhvDDq3eY5qpnoF2D5/UiTTJyX8LYDlqLTcTK6
 6aaWGplDA98cZv38EJW5TQqb9Wi5xULGHeoNbxjpr92Kx5CM3V33ayDQkDlzH0q50NGFoBmhT
 dPPo+WbtIHkyDlUNeOE+4LQpdo3FbCxVKILcUtgtBl5t+Qbt2Pu8LjeBfkUPM6zlKUBJh1QHw
 AM8QH0PVBiZsa+rsjynvBysHCz7yuEwNaxdd6VAm+63SjLXP09wWHwOLzwfJRS3ymTlLe2F0f
 j29wceEwumMCgIetewVHL3cfKAcWqjx3ueK9yzCy/iJOuY5C6fzn5r6hyD2+mb+U2DiV3rPc1
 SJHX/EjbWTBVi7r6tBB7mpMr/PQGhmu7XfSMRFTpBl7Wwhrnyo3jKyGZGEzdD4V6PK8dpUAi5
 TL4hFNG7nxYuB66TT/6HV10R/L2nsblMoVT2oDHRNF2AAwqRU2Lln1jYuWt19v3H9O7+fdwoz
 9G6XU+X/FkkWjxly2qYvRzuf5JT1TRxGiROZV0t4Asb9eZpHptImhGlOm3uen4vN5XDSV9q+A
 Wy+Kl980Y5YafDCWOVj+je64+bbJiTb5TxTnbJD7qSgCQ8Iqy8Vru5jVLy/Q3FdRjgPAXU03x
 dXyE7dFOPprUVN0Teu+DolQjg51eQWuN1TM0DQ+So7vjij3th3TvnYkszb/6rCcBztPeSvoQj
 27+INA57vFwZAz4/WqpVKRkomEKkTe0fYt94yBVvCX8z1GvzhXHg9UvfJZ6hb1+3YtUMSJeOz
 XjaK8n6J4aItfFuBdIJUjiJDaxKYDV239adNm4/wJaBtEY8/y4OEgzFwg9ypkk7OTLcuOiP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 2:20 PM Zengtao (B) <prime.zeng@hisilicon.com> wrote:

> > > Fixes: bd40a175769d ("y2038: itimer: change implementation to
> > timespec64")
> >
> > This one caused the regression, but if we add the check here, it
> > may be best to also add it in prior kernels that may have the same
> > bug in other callers of the same function. Maybe backport all the
> > way to stable kernels that first added timespec64?
> >
>
> I think we need to do the backport, but not sure about the start point
> Thanks for your review.

I would suggest

Cc: <stable@vger.kernel.org> # v3.17+
Fixes: 361a3bf00582 ("time64: Add time64.h header and define struct timespec64")

       Arnd
