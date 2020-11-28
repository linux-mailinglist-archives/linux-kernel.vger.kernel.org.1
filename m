Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7012C7136
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404160AbgK1Vyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbgK1Tbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:31:51 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D85C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 11:31:11 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id r24so12172110lfm.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tZN0NtWG99xz2cGFEET+6Zqc5In7B9EKVSLbky98vs=;
        b=PgDZpl9+r+zQwVkIKFElywI1YbfNTPmooI6cbKuqrMzViupCjpr+OBzPIupxCDuquF
         u8fu3hWcIvwxWwjyv02kq5IsI9yunSYml/Wtpd4YHHHQWYBrlLjS6PwySyQygbc45/AN
         5VNo25DCaVO1sS/jio03W2o4JyphAxb6Hoass=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tZN0NtWG99xz2cGFEET+6Zqc5In7B9EKVSLbky98vs=;
        b=JGcoWueF0Evs5lyu9ewNPyCgwLspX5iZXmgDyWdrEqNcP0Z0jny95WxvEgaep3SpNx
         GOo0y+wIDqlW/aOTwn2oxKtOp1YmZgV4N1EbYPNCdAHxnqx40AuXRD+lc2TJmODiYDrH
         B0TVO7g9IWvokXHY6S5M/mP09+35bWtQsHGEbUYGTYbDUAlkhShjYQ0yQIuchP3ox1c4
         5uZITTIExAPXvWeOMzi0n/X9JBo5JjRxwTEmGmBDr6nrLOsLD69tnPJkJkhdyxbIQjw6
         7DahzZiE0QJZFgDGC+gtPCgt6vqJfM4jZ85clPwG0IQehxpkotfCkKiZjHJZxXcH1QSE
         +4tQ==
X-Gm-Message-State: AOAM5314s5ueu4Yz3b5WMrcGyi7G3kQs7XDdGslSGJEXyYgUlOIWsQMa
        iZxSaVsmKiEVffGjAMgsihTWu/2doT7MXw==
X-Google-Smtp-Source: ABdhPJzTJF+Xq4jLuzpSex5ugMzqJfTUCxQ0IP7kbVSeEkLfgIlBUhlkUVRUX41yVa1c7hVaFVYy4g==
X-Received: by 2002:a19:c8ca:: with SMTP id y193mr5990551lff.150.1606591869166;
        Sat, 28 Nov 2020 11:31:09 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c83sm1158888lfg.35.2020.11.28.11.31.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 11:31:07 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id j205so12177860lfj.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 11:31:07 -0800 (PST)
X-Received: by 2002:ac2:4199:: with SMTP id z25mr6021333lfh.148.1606591867017;
 Sat, 28 Nov 2020 11:31:07 -0800 (PST)
MIME-Version: 1.0
References: <X8JBIBWUEgxr1lSY@kroah.com>
In-Reply-To: <X8JBIBWUEgxr1lSY@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Nov 2020 11:30:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEDfZyekjsHMvxwQGKt7BhjXuX77vaihn6SB59qyW1cg@mail.gmail.com>
Message-ID: <CAHk-=wiEDfZyekjsHMvxwQGKt7BhjXuX77vaihn6SB59qyW1cg@mail.gmail.com>
Subject: Re: [GIT PULL] USB/PHY driver fixes for 5.10-rc6
To:     Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr-tracker-bot seems a bit under the weather.

But this has been pulled.

I'm not sure why pt-tracker-bot did react to the Kbuild one, but not
the ones by Greg and Arnaldo. The pull requests all look good to me,
and seem to have all the required markers..

Konstantin?

          Linus

On Sat, Nov 28, 2020 at 4:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc6
