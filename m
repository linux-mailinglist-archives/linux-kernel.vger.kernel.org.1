Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C612BB0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgKTQlf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Nov 2020 11:41:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35793 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbgKTQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:41:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id 11so10709142ljf.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FYUJrt/cdoLWfO/PR6fRIZ6/TTxRx6cD8lQN9Lmf82w=;
        b=o1A6GAYHi4D2l6Nyg3DqHsZWs1gwCa6OjjjTZh9WQ5PZOjDe3rdngAbQAWUje9KIGl
         VxAX9GY2DuQRtob8te50ZSpKLKxWQxqdmBLafdVC+OPtuJ/wM0SEFh2lLYrbgWb2/IFy
         26qe/Sw7fGLx+HKt2PXH02L1VNPLTlnR1xBgu1S/FbnmbMOPLdIWYrE07VKrxodNexQn
         cUggyR0Mhp/o9czURepmr/Q3jfwzDM9W4u1OcRhr+if27CCrVyJGPwOztGKqH5E/0/y7
         +WF06uh2Ze6+d85ZGqN0hKTArFDuscN4OvMIFRYESrcnquyBm0es6WMtQABYFKcu0yFa
         m2Qg==
X-Gm-Message-State: AOAM533BljxIMjf64jEuZSCV30XjuUtgmUuwFZfI8iC/QLI+GlK9nU/E
        8DETNw4Ro3Dp7QBv5Mie+pwbqVzifRfs4A==
X-Google-Smtp-Source: ABdhPJxOWiFPuvIFGIm4KREwQFkERDoSONvJD4ERxepQDqkUK+bwUJhWF5KYooxFA2uDuYFoQXUGTA==
X-Received: by 2002:a2e:3210:: with SMTP id y16mr8715669ljy.395.1605890493088;
        Fri, 20 Nov 2020 08:41:33 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f27sm330070ljo.34.2020.11.20.08.41.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 08:41:32 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id d17so14312103lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:41:32 -0800 (PST)
X-Received: by 2002:a19:8605:: with SMTP id i5mr8803997lfd.356.1605890492518;
 Fri, 20 Nov 2020 08:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20201120162133.472938-1-krzk@kernel.org> <20201120162133.472938-15-krzk@kernel.org>
In-Reply-To: <20201120162133.472938-15-krzk@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 21 Nov 2020 00:41:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v67yrstBoMjHuCnVPvTdBDUXW3ML39839nDC7hoG9WuaGQ@mail.gmail.com>
Message-ID: <CAGb2v67yrstBoMjHuCnVPvTdBDUXW3ML39839nDC7hoG9WuaGQ@mail.gmail.com>
Subject: Re: [PATCH 15/16] mfd: axp20x: skip of_device_id table when !CONFIG_OF
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 12:22 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The driver can match either via ACPI or OF.  Its of_device_id table is
> referenced via of_match_ptr() so it will be unused for !CONFIG_OF
> builds:
>
>   drivers/mfd/axp20x-i2c.c:60:34: warning: ‘axp20x_i2c_of_match’ defined but not used [-Wunused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
