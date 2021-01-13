Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AA2F57E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbhANCLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbhAMWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:17:24 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE1EC0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:16:02 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id w79so4403503qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTq9BZuyc2JWWvpzIlfxUaiFdXiEl1WBgsmk8mSJEMM=;
        b=PWBTvEa5NbYEJopVdcXuVqQf/JjG5gACNCIYDMJBf9E0arp6TfC5oz66n3H0qWPk5Y
         eIFJiuMlFk4kkQDNxi4FbKZIBmN3DV9l7kKrgeNB7g19C34zVdKIAEakRSerhIZjMkpI
         MnK1rqQpnSHAYo7efBOciJbXp2r+lUNczmriQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTq9BZuyc2JWWvpzIlfxUaiFdXiEl1WBgsmk8mSJEMM=;
        b=WLsB/gxmjGZM5c+IBUb9ghoFr1i7amCLDQzLGIhWy71qvmFQhn+6g8PUtksc0pSG+X
         11iFBk+6omAflC8pKFETO0Xtsdz5+sNQ2tnA5U81SEAN1V3I12IfizLQ0XlqX7AcaqcC
         Mx7bpfVfmbk2eqwUGF1LQomfT756ALbk6jgAWHbaMmbAYiDOlZuefw43SXn4pMhITAEo
         Z0pO9VnYQQMO8A+8rvoJBxKzZi4z9r5ao8fx0sjmUKmjdgEdSaDSYhXpaEKLv/YsUkCJ
         VO3nDsVSb8xxgqrzPJpq3oEGmMcLJ+EWmP9BdGAWu5YXto0iGVnw85mpSQMA3C8ZYRCx
         9fAA==
X-Gm-Message-State: AOAM533H3MA9mii8kWOUQJ36tdXDj+O+mkvuv8goQdUBPvIX9B0udbao
        IuVmQDjUxT9dreHxWnI9kgVSv29d5wO7f4HSVQc3eA==
X-Google-Smtp-Source: ABdhPJzvis3PmTgmiOX/slOAg9ePoXvVTAv2KB7aJml+JJUsZOkm0hVZBZSipGRrgHGHDf7EXVffIzsQRCNvzhvzvVw=
X-Received: by 2002:a25:3d47:: with SMTP id k68mr6375160yba.415.1610576161387;
 Wed, 13 Jan 2021 14:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20210108172316.v4.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
 <20210108172316.v4.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid> <161041725044.3661239.4848052699046966461@swboyd.mtv.corp.google.com>
In-Reply-To: <161041725044.3661239.4848052699046966461@swboyd.mtv.corp.google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Wed, 13 Jan 2021 14:15:50 -0800
Message-ID: <CA+cxXhk-CKC-GguQEyYA-8Fnhdo98D8wvRrJKXvjmuisC1knkw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: cros-ec-keyboard: Use keymap marcos
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 6:07 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> BTW, subject says 'marcos' when it should say 'macros'
Thanks - I fixed it in v5.
>
> Quoting Philip Chen (2021-01-08 17:23:32)
> > The common cros-ec keymap has been defined as macros. This patch uses
> > the macros to simply linux,keymap in cros-ec-keyboard.dtsi file.
> >
> > This patch also creates an alias for keyboard-controller to make it
> > easier to override the keymap in board-specific dts later.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
