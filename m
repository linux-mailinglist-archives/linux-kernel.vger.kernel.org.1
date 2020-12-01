Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5AA2CA527
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391609AbgLAOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391602AbgLAOJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:09:16 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:08:29 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id y9so1797256ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ejKqQ0vym6GF9ncfzmdmAootAcWNMggjwsqgg5x200=;
        b=pgCmQm0vjoZ09UaxCjAtKMjsBzJsuCXFT9k1SlstEGel9UZAcJ1oQnrs35CftrD4g/
         3iEgIZbyqZBjY94sbbIKs802wKLHKg/hEBWzJ/gTN31vcc+LnL+YGcF9uwkGjdg3FWF5
         5KCCaykKIpcPJdNCp+2OYICRB8cFfUvpOYu6YLBPXXs9qlycir7A1rEolXTR2ygHZMTm
         4ACiWW/Zoc559P3LcVheA53o4o+E0H4UYMmQRTWDQ6pzuJswAaMJwxmYXj2ykyVzYIQ7
         9CgEL8UYJy4cl0XVr7ZYeV8OJ+eaxFOK4nuw2gSAlI2Rnlbe8MwU7CEpQ7qbdufDERuA
         H+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ejKqQ0vym6GF9ncfzmdmAootAcWNMggjwsqgg5x200=;
        b=Uxbwq/N+7WHPeBiaRCV5kngNKPBlySTORJ0AZpMmdeM/pNN2feBJBaekpFCunr20kL
         jVNvSKqMFELDCvu4+7jfM8vr1+byh1++GvXPDpLhLMmCduBuhDThcfLRr5Dz24MpUyUs
         BzU5xDoQi7Fzl7CmkFbDaWE60r/pPaSOgWdy0o761tzyD/0ue8+jsXCmUSJevjzAVfUK
         6o9B1Z0fRKksKNk1xpV0hvygjHXi5g8hI8YBulsz/EDyfeBXqetE/1V/4rWnL0KZsjCB
         OVizOwRQ6KYvF4i74sHmj6So+SWNoiL+PLyCyGcl8f/kXCIi0CdHruGdIUHFUwP9H/QW
         bOHw==
X-Gm-Message-State: AOAM533l9RWB3fqouu553HjT86JqiwzdEB5/25lFpVBntsJmoAaPUfHN
        Yhc2B3gkb7VmF7Hz9WERYm4olsDH8XraFtqK0OLrPQ==
X-Google-Smtp-Source: ABdhPJyzAkLCs0G7NVlLosvrguBE5juNevbmMq+XkHE/qr2CGZxNSd1y2NQYiF347w7X6XEDZ6j4n/l7Ra+x8S5wXDk=
X-Received: by 2002:a92:dc07:: with SMTP id t7mr2653018iln.189.1606831709397;
 Tue, 01 Dec 2020 06:08:29 -0800 (PST)
MIME-Version: 1.0
References: <20201130164704.22991-1-brgl@bgdev.pl> <20201130164704.22991-3-brgl@bgdev.pl>
 <20201201112215.GA31985@lst.de>
In-Reply-To: <20201201112215.GA31985@lst.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 1 Dec 2020 15:08:18 +0100
Message-ID: <CAMRc=Mcj8LDOigVB76b1w_R-5QTMKgB4xxhbqk_zDuPyMi-oWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] configfs: use BIT() for internal flags
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 12:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Nov 30, 2020 at 05:47:02PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > For better readability and maintenance: use the BIT() macro for flag
> > definitions.
>
> This does not improve readability, as I now need to look up a macro,
> one that doesn't make any sense at all.  If you really prefer bit based
> numbering just use the totally obvious (1 << bit) syntax.

(1 << bit) is better than a number in hex but BIT() has been in the
kernel for so long that I doubt anyone needs to look it up.

Anyway, it's your call, it'll be (1 << bit) in v3.

Bartosz
