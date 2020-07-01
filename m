Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF402111A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 19:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbgGARKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgGARKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:10:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 10:10:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so21281529eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtH/Jv7sDdpzRzs+CoFuf3gWYbwSe6sI81Ru9mCrotc=;
        b=uRjde3MprcOrU2hk9bYrmx3xVkJ6TW29bSUJVter6pe1Sl0JsBDzNQMOyAWcC5dQGI
         9rMWv/JVbOPUgMfIsv0/HOvKXpnMog7lH1K5z8YoHohnsoe42BREuMkTnMT2sIUhprJY
         Btm40Y5CWogn4cDXSpfKPPExvttvMjbuH6J1Udnlfe5A4gmrEP1CNHJy0ATTfNcsUJ3l
         uo1cmtyp2xFyNmTTHwZdrWoVO4vYFX1i75c1FFYcwQxrOmz2TQYwU+wQsK/6neA4IzDw
         JD1WoGhJAaM0xRAaClwTSac8U01gj7rULVg1uvVHGKf7IlrUslCfRIfaZAlVPIOJfjot
         WVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtH/Jv7sDdpzRzs+CoFuf3gWYbwSe6sI81Ru9mCrotc=;
        b=bBgppNKmbLf0H6c3BKttup5YMJKOE2Lp8Eeo17FI7S1HLRaD1na/wx0Z/REZVwQOhS
         LyqJnj7Ic4BP5PLIP/vU2vlNKpdVL+nKcxlWD00cYHSZ038BngRlL/Ve/UkWzj8dt9iy
         i9u8Ok/PNzEyLqPy0omt1EOeEy2OTsJr10eobJwtMVpXdlRfU98iB8snCaCUSBU9WGrv
         88CgiHNUg2QVZGedOkIPeLJ/8zj3P2GBI/m9P77vvY2qpwPqSV801YSHqbj6KxxSPnG3
         8V53LPr6JtxKG5mEdbAOmQ1grvaUJyR9C6wtilveT0mX4GKl+XzMJ4xK6sI8kUpzrF1s
         DMYQ==
X-Gm-Message-State: AOAM532sZEKVOr2nCqk8NjD1mA7KXxz9Lh3SMuyM6S1LkCGPkYJGURmv
        0yVkS+/k1Z3YYKq1vBGINT1iIQa+oXICUVH6ZoI=
X-Google-Smtp-Source: ABdhPJyAVvLmb30TqwEVOx8DOL+CsHb1mv92Hh97/7iBB3OdFxnCwTu1+qTCIlv7PqtL/pFwqoUImwNNflV+aqHBe4I=
X-Received: by 2002:a17:906:6606:: with SMTP id b6mr25089474ejp.102.1593623406457;
 Wed, 01 Jul 2020 10:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200630135110.2236389-1-lee.jones@linaro.org> <20200630135110.2236389-5-lee.jones@linaro.org>
In-Reply-To: <20200630135110.2236389-5-lee.jones@linaro.org>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Wed, 1 Jul 2020 12:09:55 -0500
Message-ID: <CAPp3RGrYFVjrjfdSA7F8vm9J+-0QcSqg=i=Uq5H3Z+fWkzu85g@mail.gmail.com>
Subject: Re: [PATCH 04/30] misc: sgi-xp: xp_main: Staticify local functions
 xp_init() and xp_exit()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Cliff Whickman <cpw@sgi.com>, Dean Nelson <dcn@sgi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:51 AM Lee Jones <lee.jones@linaro.org> wrote:
...
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-By: Robin Holt <robinmholt@gmail.com>
