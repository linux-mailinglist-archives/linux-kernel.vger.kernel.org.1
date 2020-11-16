Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB012B4A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbgKPQRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbgKPQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:17:20 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96645C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:17:18 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so7260743ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfMGBZE7z85lbUaeNNJmQZfi+sNA7mNJwV+OyH/GI9g=;
        b=Ooe4WoFYkrQmfYFrj2bCrfE5vxFIweuSLSSE0nTMoRVFoE0+OuswAgTxdkTixIl94M
         FtNZTFbFrdV5S2OanmcSJPBulunHG3q+UcsHnRsMauVxlQS4BfRkrLuevImbnhgIA2ip
         2rId5EglaNg3LrVaTPpPOuwy6Ih6hEnMv8ShGRELzuPUc5YqWC3z5B3oWDiSBi7PxjzQ
         t6R6eJPUVebeQox/+fo4JHOjaeayY6zsM3tTQk8QKE9bfq0JTfnlkvgDLW2o3d7e7jzq
         0Vy6GjEvqqOVyQ2NnvD9s1hTiHpcm+5J+3NSjdrLOmNeTvhdpSPGlrcoHQ8kHbAm4j+e
         7y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfMGBZE7z85lbUaeNNJmQZfi+sNA7mNJwV+OyH/GI9g=;
        b=KlfG3mruk1Ipq2hrKBV8ssHlSFIL3it4A0yFt1G/rp14RuLBwimSVr/3vrPQ0LeJRC
         tiCHvvjYdFnku4JAiT4soPzkgFWtwnZS3q65uaMoO31A7hVWYZrjx8WNUzKQjSDiBePD
         b6RDO3OHJ0yKT42DkgrJFBq85aUsAJjqlMg334P1RlLnWT9GLEd/LajMBYoX8azOsUpU
         q7Ic8fuBwXHeihXI2V+DYAhHZEa15qRF3Q4mFKB0XbLgif3PGfRAIKDO+So4wj71dtzN
         gltnarwC1bqXLXezCyjo+W7Ey5xAMqLSaOX3OGm8xAQe8yBIbAB+e0UUJw8kWRKE7jqH
         HxQQ==
X-Gm-Message-State: AOAM532XdkvfTJxr2wVs2MC+16l3J//QBtbq/+F0QtZ62uOLJIUPQeOv
        e38P55vVmirRye/JdJWk6jM2+jdI8KW9sJ7FiSA=
X-Google-Smtp-Source: ABdhPJxzwZNx9nx6gDwrNLsljCWMiZgL4N8OxJdUSv2UeNWffDpweGDMIoVSMbe6lXA+zCLMZBkdqWXCFlF27aj9mRg=
X-Received: by 2002:a25:2e0d:: with SMTP id u13mr13339063ybu.247.1605543437943;
 Mon, 16 Nov 2020 08:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20201116134121.587563-1-poeschel@lemonage.de>
In-Reply-To: <20201116134121.587563-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Nov 2020 17:17:07 +0100
Message-ID: <CANiq72=fvLe25_a2jHxg1R60ixkT09+Xqwo9b3WL1FY+qb4EYw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: panel: Remove redundant charlcd_ops structures
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 2:41 PM <poeschel@lemonage.de> wrote:
>
> From: Lars Poeschel <poeschel@lemonage.de>
>
> The three struct charlcd_ops contain the same data, so we only need one
> of this structures. The other two are removed.
>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Thanks Lars, picking this up.

Cheers,
Miguel
