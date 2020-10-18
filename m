Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6771291FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgJRUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgJRUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:06:52 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B58C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:06:52 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j17so8391654ilr.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Q+QZmJpwsedrOmuOwexAkyOHh5e+Tpl5OUShy/OlPs=;
        b=xySt+MvjPglENyFuBRQOnmr66cLHBJ5yfRSQr6vuGJpUvrkhwagNaKMZSGEaWgpwCR
         TlIDLVuq4NeZri0lInLdrSe8sUAbMSOwwXMdIUTfmI8INr/IyJxXLNDMgNhw2wo4c0kF
         YdKhs19l/95pP0J1kzkDdnHdh5aJ5nri8gaxhdIbQ/7xGltX3jK4gbiI9XoE0GPYgLrX
         65Aji9GQyWyOpJoyVqzRRcJoCgv8ImBdIX1zlZvT8fiQ97XuAzsx9tQEZmqk+/YhCwvL
         YalbdVBMG/b9oKiyPrzhs2jaQ4D35C1w1VZgOguLoa8vSfoRe/DNJ5/J1gLSeINnAS+f
         QftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Q+QZmJpwsedrOmuOwexAkyOHh5e+Tpl5OUShy/OlPs=;
        b=hpi5v4toZkMjjnayvV/J0eZ3zD6XhyjgIxMsScP9KbdiltCRzqXibe0j7+Zt6o7rFw
         iAuXhritF5v16uPB+aEzDuQlcc0R6Zwib2dImQYJwJiTA7BqUXkHknv9chSbZi9WakpX
         Qb8oFja3KTmIToGzta3jtz0DRsDnKMD6YPs2QlGZVGImX9LpoJD2iR3TWiKAEbvrJvoI
         1A/tPhcr0QYzgap89uPOkuvJZiJLtigfs2F0SMxc3TC3MT5PX8dasZ26KQxqiyCpH/DX
         ZR+U7fZTolVntO0Q+dquXS33/UAw4DYPT/p6Trh8pOy25YvTzF5Jm26ypy3915rzs63p
         NtRA==
X-Gm-Message-State: AOAM533Ikn510pDVQf/JgI3pMjart5mYwC4ZkPjbWuMFrtk1HaDObEFL
        hJCSFoJiS77rNWTkQPIag9a7ofpKS7RL2PbQh/YW
X-Google-Smtp-Source: ABdhPJxCFuvH10WfEmecxe7UGnx4FnMZQgVztmoxowtLqJh6PgpDRXAhi6Pco+Y6CSNr0Ukm72MpdMb5vWfahn2TaX8=
X-Received: by 2002:a92:9a8c:: with SMTP id c12mr8811075ill.186.1603051611520;
 Sun, 18 Oct 2020 13:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201018151726.GA219649@ubuntu> <CAHp75Vdk4J5t3A6b+w2-7M1zfeA2wkaf_QH_HYWZ2TY4xaKmrw@mail.gmail.com>
In-Reply-To: <CAHp75Vdk4J5t3A6b+w2-7M1zfeA2wkaf_QH_HYWZ2TY4xaKmrw@mail.gmail.com>
From:   Vaishnav M A <vaishnav@beagleboard.org>
Date:   Mon, 19 Oct 2020 01:36:40 +0530
Message-ID: <CALudOK7hTQ3BZEm7mXWMrP1N_VHQoJh3+LucHfrNYB-0BGO_Ag@mail.gmail.com>
Subject: Re: [PATCH v3] iio: proximity: vl53l0x-i2c add i2c_device_id
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 12:00 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Oct 18, 2020 at 6:53 PM Vaishnav M A <vaishnav@beagleboard.org> wrote:
> >
> > Add i2c_device_id table for the vl53l0x-i2c driver,
> > helps in device instantiation using i2c_new_client_device
> > or from userspace in cases where device-tree based description
> > is not possible now (Example: device on a gbphy i2c adapter
> > created by greybus)
>
> Same comments as per v1.
>
> --
> With Best Regards,
> Andy Shevchenko

Thank you Andy for your review, I have updated v4 patch with your
suggestions : https://lore.kernel.org/patchwork/patch/1322218/

Thanks,
Vaishnav
