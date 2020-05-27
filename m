Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3B1E4A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbgE0Qd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390679AbgE0Qd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:33:57 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61ADC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:33:56 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c21so14847846lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4R64lQECAezSIekk6lfrKMmFFora0mq1CFEKW++lIpo=;
        b=XqQQSknDXgHqnwyIRF1WdjWReCla6ArE+ipVeGU+Y0Fs7zp+DK2ItCI09Dq7gx/Dyj
         hJf8C7JzYXLFFiEFPSIdtpTmPXi2couBReRwKrfpziAgeR25ImfBTsGCqZ0900Sg420V
         z/54ca6O8t7uoH9d/pihKqLAZOuKmtUV7Yi6dH5K8BbubPM8Tvv2W8Pxcgdx5oaFi4dZ
         hDRBsfqV/wQ0coxuFblYgulLkwiWqgTgOJw/n3rvVaXBhvE5H8wI2VlOwvKt27ojlEeO
         vURwwXQwETHDoE/k0iaYAURYW/tVRFO8RSQLJtspA+gHvGUH0NqUsG7wshy4+xfs7f5W
         2WJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4R64lQECAezSIekk6lfrKMmFFora0mq1CFEKW++lIpo=;
        b=BPMLb3iwE4ckCIPO6sGVmbQ5DCSe2nRMZ/3/xHcJzJ2OHLz7oIYvnsVULrSEnJtOGo
         og1XGl5qltihhbDZuE75yTnmDYemrcTfCsXXhscKmJDBU6ufmVvU99wol1oS/ss2AmhG
         AubmHLxQqSbU00W2g7bQMHYK1vCku/QX1Ta2wp+vKwlTVFzOKvYrxiTncAxPpCKm6pXK
         c62HL4ipV+dXMqzY3fecwz8DvkLOJyLfqifib2gGQlHRhjX12+yhzI3mNdxuIFkJ1U/i
         NZR3N7JXxbOjG+7lzJdzNbDhaB8P5vw2toWjoPhxsvnOtOzCH/THkKrlynK+p140hldi
         eAhg==
X-Gm-Message-State: AOAM533Gr7oce6cSCO1FZRKkafqZQL5MaLWiUsaTIvOcJF9C0LBtT+Kt
        bHViI9TiZMAuxAvqrDVSlJr58Gzyc9YDq4VAlrMNfw==
X-Google-Smtp-Source: ABdhPJzJGyZZ6OFZilVkNjwkWI14qi3Sk9vJd3/Q9ngB/1XlT/NI9vsgFlwoXIDHHg0zMevhGY3B/9Qh957nmNFRnN4=
X-Received: by 2002:a19:f813:: with SMTP id a19mr3516133lff.212.1590597235190;
 Wed, 27 May 2020 09:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <1aaadf9a5176591c891622cb00b0c50f42e569dc.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <1aaadf9a5176591c891622cb00b0c50f42e569dc.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 09:33:44 -0700
Message-ID: <CADaigPWQdeTd2CGCK-yxq+TAU6xKMVsdZfhSVptn4RSENxpdxg@mail.gmail.com>
Subject: Re: [PATCH v3 015/105] drm/vc4: hvs: Boost the core clock during modeset
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:49 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> In order to prevent timeouts and stalls in the pipeline, the core clock
> needs to be maxed at 500MHz during a modeset on the BCM2711.

Like, the whole system's core clock?  How is it reasonable for some
device driver to crank the system's core clock up and back down to
some fixed-in-the-driver frequency?  Sounds like you need some sort of
opp thing here.

Patch 13,14 r-b.
