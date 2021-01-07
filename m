Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D802EE9B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbhAGXUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbhAGXUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:20:55 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FFC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:20:14 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y4so7731663ybn.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vTAVi1NrXCtfDc2o7sfhxwMEmVikIUUFAGvTgz60tk=;
        b=F8kvPuGD9yuG4ygpLAPYHw7LSzXT5UHuv7/FxJXKw4Rx5geavZ0LVjj43zIbjls1Hh
         sYKyqqj5uhiNse+c15SZouxHlBTP7CJtwBk2c9Krk9KWZqAPzOBYuRhODr4cFejG1g11
         gjsLZysPsSK5VWlc7pROH4/spukO6RW1FR8r/Oq1ALLJlvohJg2KFjStYwy+iH3xNpnN
         jXQ3Dg6vloH8dE8hkdtwJl9+hlGRMAoS8zRmVXw5NZHkmbXWgSA2mYjB6uL5DOi9GSqu
         50gqkuSUBWb3DVXLhAwDqNnKWuU4kk5ehzBvuCqLR9g/tk5ECiTOmpH9ZajeQKWNhkOs
         cgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vTAVi1NrXCtfDc2o7sfhxwMEmVikIUUFAGvTgz60tk=;
        b=cP09nfKplSiB4bOgGa68TKUls9yE5k9rqQn6dYmOPqRpVg5RmIrbLeBaFddwedLygR
         ZPKr7aKrEQQ19L9T20AqDoRKwkIQwEavBFX4qRdDKLeTApVBzdc7633x5ATdddKuNvDv
         NzZlktZ/Ryt37UXSTNhHjBFY8kH2XjYY0hkH37+nR7FxSEKXv17+WqcF+gutTfa9ZcKu
         O7aFx4/r6/yGhZvrn1lkwPD9vj294UhKuk042+DDgYk7Mp03MTjglX+0V1HO+aIh8nlB
         k5IAnwSSYKWBdfqdc9+dxZwZs6KlOgdTPnvjvzUkNRbWX4Mw3D6fgKTdXxAljjL5wlwV
         3Dtg==
X-Gm-Message-State: AOAM53007WKl7mI9Ii1uBk7idsOCXq9tmnPfuEY4cjAKpTpQzTQWVvpA
        fhczXljuLObSKgRjkSSENsiq2B3ayXVZK44rJ/0utg==
X-Google-Smtp-Source: ABdhPJwMwjRibWguJxEmGRAeLrBm2ahU+k/ZBkrsVSuQtbI7inzI8oNP4keSLvQiPhQ/1x3bZ32VW6uRfWTBsdIbfeg=
X-Received: by 2002:a5b:b49:: with SMTP id b9mr1647580ybr.310.1610061613994;
 Thu, 07 Jan 2021 15:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20210106232641.459081-1-saravanak@google.com> <X/bNxMPWKq2nbqS4@kroah.com>
 <CAGETcx9NzCBGO4=Xo4h_BbbmxGr+VBoMvqFHkYKiQyCYNtBYGQ@mail.gmail.com>
In-Reply-To: <CAGETcx9NzCBGO4=Xo4h_BbbmxGr+VBoMvqFHkYKiQyCYNtBYGQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 15:19:38 -0800
Message-ID: <CAGETcx87ck19S0UQwdzLPBxGFns6hJbUX4HbfcOkA_MJy=t-8Q@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix device link device name collision
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 3:17 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jan 7, 2021 at 12:59 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 06, 2021 at 03:26:41PM -0800, Saravana Kannan wrote:
> > > The device link device's name was of the form:
> > > <supplier-dev-name>--<consumer-dev-name>
> > >
> > > This can cause name collision as reported here [1] as device names are
> > > not globally unique. Since device names have to be unique within the
> > > bus/class, add the bus/class name as a prefix to the device names used to
> > > construct the device link device name.
> > >
> > > So the devuce link device's name will be of the form:
> > > <supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name><consumer-dev-name>
> >
> > Minor nit, you forgot a ':' in the consumer side of the link here.  The
> > code is correct.
>
> Greg,
>
> Do you want me to send a v2 to fix this and add "fixes"? Or will you
> just fix it up when picking it up?
>

Actually, let me send a v2. There's another collision in the symlink's name.

-Saravana
