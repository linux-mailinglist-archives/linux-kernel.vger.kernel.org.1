Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFD2C6400
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgK0Lhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgK0Lhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:37:54 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C879C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 03:37:54 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id o71so4293406ybc.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6B8NPunQT5707oaQWx7fM09dlp83Ezr/+K9wt5+S6bk=;
        b=jO3NJroWOzkT+ZdeeSR4hhZ1ELoaJ8Y4FuYOv4A7uhuvoxpIyjDT3ufElhac30w6e4
         oGAB31JwCWo3rgn5cA0+3u5xifgvzOLgLgLdsAOyVEfMWx3D2iiCLDuWd0S2Z0cm7gUP
         jR3tLTroGTMrJ0/hn/CdD/g993I6oNJu87UV5WFqWHTLqdVYfevt9Te4Kwi0IPmvvwCa
         N/gxOTnbbO5xOWf8EwpQxf1hNIioeYhdgriTu7SG1BurOh8gaCteJ/PzHLOI1YeYTGj+
         iC+X2T+GgUsIwooem57ilkrEzyoJu9l1VSXoA9z54h7rqqtsDT/065ixIpeeHTfcRfx1
         UeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6B8NPunQT5707oaQWx7fM09dlp83Ezr/+K9wt5+S6bk=;
        b=jx+Aneq7E5owq+2T5q4tiLrXSxciHcapZ0hWnLxIAd3dX2wCVoL0Y/5i5U+jpvgsns
         M/pTBLeq3XU49xAu44mKdAWUJPjpljBt1/qqwE0Pm9OaPSJtahMhLDmgLTvaR03hvc1Z
         eRE+PLCOzj2OOTT3uqG35oug0Rolm8SNS7yjyxUiO1oSFyNRdVD/YwC0mewrAXe/KO65
         /77HLK/0JKIdcEFSDYB6YGpYvXayZnYbXky7IaErrlIUmoMpxgPeRQhfYX6BYuEHSudi
         6JU1ntQWPuk55UKobfLK5E3dKBz+ZsIwGT19KIbCEUgQd9+VFeTO7akR95OCexZaLZwX
         2jCQ==
X-Gm-Message-State: AOAM530TxazZFd/MuNZE9yfkEJ2FqmvHKp6WX23CTTP7r8/AkIVusUNF
        WHLJHPGIdeJflJuBBFhUzz+NlJlCLVObG8t2N9o=
X-Google-Smtp-Source: ABdhPJw0rSfQZ+QoeMa3FKkafcv7uQCdETciwIwxMAYgKQSmOVeW5+3GvsrXxx032jNLU32rSz7PXgS8QrQZ8hEGrMI=
X-Received: by 2002:a25:2e0d:: with SMTP id u13mr8669349ybu.247.1606477073623;
 Fri, 27 Nov 2020 03:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20201120162133.472938-1-krzk@kernel.org> <20201127080619.GJ2455276@dell>
 <CAJKOXPfdEbax7Z4xpu2QcLSND6fvWK__5hTKOESaO0n2pBMhtA@mail.gmail.com> <20201127091759.GM2455276@dell>
In-Reply-To: <20201127091759.GM2455276@dell>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 27 Nov 2020 12:37:42 +0100
Message-ID: <CANiq72nVBUHU=3qBoWsk4r1L2W1Xuu05y=WXrQoWcSQiscerCw@mail.gmail.com>
Subject: Re: [PATCH 01/16] mfd: bcm590xx: drop of_match_ptr from of_device_id table
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 10:21 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> It's a per-subsystem convention thing.

I think some allow both, too. For people that send tree-wide patches,
it would be if we agreed on the convention...

Cheers,
Miguel
