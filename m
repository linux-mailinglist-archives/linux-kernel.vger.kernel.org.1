Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D72C93E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbgLAA1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbgLAA1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:27:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:26:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 64so18827258wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=nMn+2Vd7dQcjrIkLd6jblJNyNbACa1twjNZ31rwGz34=;
        b=1qfhS2qaDYP1b60lVNudKuwYRgqPRyHMCZy3jdSOyElU7QGfmgPPJ2Pr2qTh7aixra
         eiJhEG5ffbaC1LjXRpe5sxpj+Xm2UGv24GbsR8bTgQK5QigGQD9QoOmbEAcDs88GQ786
         R1uYvuV2xgV1SZN3z0oBpgzvKI5t0H8NWsHp4vjYGYnjfB5q44dJsQNud8IW3CTn25JY
         FlDbzMBl7wW2z9OIFaeBzpUFFpUsP74r5ZDnFXnYJAbPKbKo5s50MD7tkqJMfTJAaqpO
         Om7NwQBbC/4LwNtkkHzCVOG2Ien0gfriP5s4ZlbKTDny5BufefxpUHK8IufnLpPZ7nGn
         kyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nMn+2Vd7dQcjrIkLd6jblJNyNbACa1twjNZ31rwGz34=;
        b=c1vS++d8mxblq8/3Bx+0sJ9B4QRxr8sfib8qIdevpnJ8BNh8H+9u6/fG9GW6XLxYUG
         gpsNV0HEEi6wiVXtFy7kZnI6AAy52ZE3SSHpwx2LPAIXgSMSOnKRkUNogCMPiPs+XoHP
         shEL9BmxlNrjTf8fNGHh2SFFCCxVdRLSdyj9mXEtAD6UVQNkU4YwYSbnwYWsBymRP5Q7
         BmORKkcnGdYU4Zfs3lxSIc6v6l9qOvPZP4Zhi9rOtAnyntRJHJ/Q4HVX3RAdXm1fMMgN
         Vkd6L+UxTW8DGkEf7xdQ9XDTbTNmueLTP9V+jt7B1RjU/PgKQBv63DtYKps+9u5HvRgf
         uZkA==
X-Gm-Message-State: AOAM531Rj+3lW2u7c/ehX+BWRjyAsVt2xIH3HjJODCq5OuHzxAz00mVJ
        yCF5FyvHTvxXCR/QTTuqelQeg5sF1ulXVMl+0/s=
X-Google-Smtp-Source: ABdhPJzaVC8NXzM0/ZC4iyiTvLhVp4eg06QkIsRTlCbvS05JMJQnOVu7/y0JJ0krbVCIaLrzcvoecA==
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr102256wrr.357.1606782365968;
        Mon, 30 Nov 2020 16:26:05 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y18sm30432998wrr.67.2020.11.30.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:26:05 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Carlo Caione <carlo@caione.org>
Cc:     Yu Kuai <yukuai3@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the amlogic tree
In-Reply-To: <20201201100751.6cdf5ec8@canb.auug.org.au>
References: <20201201100751.6cdf5ec8@canb.auug.org.au>
Date:   Mon, 30 Nov 2020 16:26:01 -0800
Message-ID: <7hv9dmtlra.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> In commit
>
>   9d822ed94237 ("soc: amlogic: canvas: add missing put_device() call in meson_canvas_get()")
>
> Fixes tag
>
>   Fixes: commit 382f8be04551 ("soc: amlogic: canvas: Fix meson_canvas_get when probe failed")
>
> has these problem(s):
>
>   - leading word 'commit' unexpected

Thanks for the report, I've fixed this commit message.

Kevin
