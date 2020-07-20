Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B72256C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 06:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGTEmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 00:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgGTEmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:42:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7653C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:42:15 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so16213861iob.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bkk/PTl6Edd5uWa4MDn2h0LsBH3/u5/awkqHptUfLTs=;
        b=NGk6786F0du0Khi3xX7Tyn1w794dWXHYdDW0QpelBX6k30qkThm11AQhix5kpK6Dl+
         0mC7sBqhuIzkdkE9y9dSRXlEiChU6Bn6Krc4dZy/TN/ppaZ+O8sRjNBvt9TW/0aDsXEm
         Z4mnDzCBdO9Y01kWQyAA7Ipzj6YnA6Egg2iEBadbkxLh0RAjeU9hSLOhZr3jF7IGTmaU
         WoZNh5X6A5xFgROIWFSoniofNvGOBpWcfuxM+yYQZKFu2vVH+hyUA0CixQjhhZv5BPKe
         RGi5+1d4eNeDQ1Z85NidLwhuZS0J3GiDv2/WjMS+d86sRAUxZB3TfA1IcSnuuB2h+x9a
         l0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bkk/PTl6Edd5uWa4MDn2h0LsBH3/u5/awkqHptUfLTs=;
        b=btF6yjW7o8T0P8itghSe1xThaISKzaoJ2OrPHqG0/Q5Z7rFlINdPahAHecqs2Q8Zw3
         BKXNDc6el3AGu8rdIK9Lj/viZ8Kn10tOQiwJI5ohpehIvMxKsmK1dDPG02JAX1+0I0t6
         AnUE8DQuGL18PmmcI+aAv1nXYsBNam8/lFEftXqDyRuosDer8G2kt9sGodtNGln77p0Q
         ybRzYs2IC3swIAHZJOtSgeL+dUru5OMU1zZYZaFP2bBS1flCwsdOXKo+mGqolFNMMhNF
         +y0wsInxLj+IscKDeWKsdLbJHM+tEZurRs2+nXF8IQxQqTYN4IuwzB6ih2yakPI6L7WV
         Kp2g==
X-Gm-Message-State: AOAM533z7JYm1dKPIF+oV6qf81KcbnLqh2bIcI2PgfqSU/QGbXsT2VcN
        7vs1gC36abuklijr2Ekx87/brOARltGnsHapYiGYAA==
X-Google-Smtp-Source: ABdhPJyIpCNIYwtc1m5xXY4J//YPn7R5QgnEum8te2p3ibejJMk4WAs2W2Bk6wwwW33g+OK3Jhn9+wRALwUhk2FwmBM=
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr21395061iok.169.1595220134744;
 Sun, 19 Jul 2020 21:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200719003053.20899-1-rdunlap@infradead.org>
In-Reply-To: <20200719003053.20899-1-rdunlap@infradead.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 20 Jul 2020 12:42:03 +0800
Message-ID: <CA+Px+wVL09UepuyfXrdGiesJb=Bn0S_TuYS3oX52DWBK-QVnMQ@mail.gmail.com>
Subject: Re: [PATCH] platform_data: cros_ec_commands.h: drop a duplicated word
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 8:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop the repeated word "using" in a comment.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tzung-Bi Shih <tzungbi@google.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---

I guess you didn't include the maintainers:
Benson Leung <bleung@chromium.org> (maintainer:CHROMEOS EC SUBDRIVERS)
Enric Balletbo i Serra <enric.balletbo@collabora.com>
(maintainer:CHROMEOS EC SUBDRIVERS)
Guenter Roeck <groeck@chromium.org> (reviewer:CHROMEOS EC SUBDRIVERS)
