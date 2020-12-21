Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC22DFF38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgLUSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUSF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:05:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3114BC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:04:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f14so6576534pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/uAxBrvdDC73TZp+IQZEOJGWsfHQdihTLi9dAWQtrSE=;
        b=mkLMg3gaqGSEPm5adLDLrlCFvaVoR/w6A23AMV3Z5AX6e/ysILXx6OHMWwUga/vLU8
         HnbVnuqeyEsBfK9rFIzMUzDw1fCgWczOJ2P3bEk9L3Kdqb7DZiOt/hJYY+pRTH5P3DnT
         OgatzO7l7YH+PIotdA1nfWUoStjda9g7Qiyic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/uAxBrvdDC73TZp+IQZEOJGWsfHQdihTLi9dAWQtrSE=;
        b=hUT55RASQ77Ui3zmekefwsHiwIMvshF8fnAoIxnVxbIuxDkBjPWFCrKqK2qCtjljYy
         sh+X+/p1P7pLkrXyKSzP9UezTSFDjIDgdRd6wunphP5NU69BHOYyFKETEWVh1hMuhpqa
         NgRx7bLf94+ZXUXGzWFV+H8vmy+jvODSb8RIeuoXRmTmgw+mRQ3gBQR8aGmCFU9zpBoN
         CWAU8O9avwTRIcEaRSAc64clOT2lrVVHHGu5q6WDRVRo21s6SKfjbQFlJycRDRWDPs55
         O+W+U4XCD8MnW33uevn8lSp6y3kLlT+wKZvnmbiP6KpjvJpW+zhYTd0VjO27yV/lkpC+
         Vk1g==
X-Gm-Message-State: AOAM530XtOuAxtK+NA1MFh3CMUl3S3xWsrLPuWgCidHOePGz9WBv8Gq9
        7QWZO3AGDbepXNxugQZylf+WC1zhjR7jMzZmo9UMcBuoo1Qajg==
X-Google-Smtp-Source: ABdhPJyV0goa8SGmlmymnQKepQstMMHuhDMRNmJgzQdCMoAr+K8sd66iCURLhWXfRpoINdcwNfpYX6V8wLVS0SVk9rc=
X-Received: by 2002:a67:c983:: with SMTP id y3mr13124134vsk.59.1608573510353;
 Mon, 21 Dec 2020 09:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20201204111038.v1.1.I4557a89427f61427e65d85bc51cca9e65607488e@changeid>
 <ec27a562-d53b-a947-1a93-bd55a2dfcc91@gmail.com>
In-Reply-To: <ec27a562-d53b-a947-1a93-bd55a2dfcc91@gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 21 Dec 2020 09:58:18 -0800
Message-ID: <CANFp7mXdz8jYB0=tkj-mzWETo+M-Tx9ecTwEquh-JoDXRT54qw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Set missing suspend task bits
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Howard Chung <howardchung@google.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>, apusaka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D295fa2a5647b13681594bb1bcc76c74619035218
should fix this issue.

Your issue seems the same as the one I encountered -- the
SUSPEND_DISABLE bit (0x4) wasn't being cleared by the request
completion handler.

Thanks,
Abhishek

On Mon, Dec 21, 2020 at 6:35 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 04.12.2020 06:14, Howard Chung =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > When suspending, mark SUSPEND_SCAN_ENABLE and SUSPEND_SCAN_DISABLE task=
s
> > correctly when either classic or le scanning is modified.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Signed-off-by: Howard Chung <howardchung@google.com>
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> >  net/bluetooth/hci_request.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 80dc451d6e124..71bffd7454720 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -707,6 +707,9 @@ void hci_req_add_le_scan_disable(struct hci_request=
 *req, bool rpa_le_conn)
> >               return;
> >       }
> >
> > +     if (hdev->suspended)
> > +             set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
> > +
> >       if (use_ext_scan(hdev)) {
> >               struct hci_cp_le_set_ext_scan_enable cp;
> >
> > @@ -1159,6 +1162,11 @@ static void hci_req_set_event_filter(struct hci_=
request *req)
> >               scan =3D SCAN_PAGE;
> >       }
> >
> > +     if (scan)
> > +             set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
> > +     else
> > +             set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
> > +
> >       hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
> >  }
> >
> >
>
> Hi,
>
> This commit caused a regression on entering into suspend for Broadcom
> Bluetooth 4330 on Nexus 7:
>
>  Bluetooth: hci0: Timed out waiting for suspend events
>  Bluetooth: hci0: Suspend timeout bit: 4
>  Bluetooth: hci0: Suspend notifier action (3) failed: -110
>
> I don't see this problem using BCM4329 chip on another device.
>
> Please fix, thanks in advance.
