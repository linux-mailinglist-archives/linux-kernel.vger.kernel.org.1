Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B54301052
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbhAVWuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbhAVWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:47:37 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F603C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:46:57 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a31so2339416uae.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJKac0a7OSKp1f0kvUdgdMfcoqobY0w2Qi4X2IElxuc=;
        b=AnFnMxm7WfC1rua1IAn/BS6BSjggXvQNEVtQhO35dCfNT1aEkmSRuUWxnRufpUz/Ob
         ceKZJdL20R0z6pVacalU66DpQmGxYUqfmTfdUH7WgYKoXccDChPAt9AdVvWrn77Y9uft
         3Mn5lWJ4Ql3DMS65MwjK0+bqUMxoc7aEiGo7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJKac0a7OSKp1f0kvUdgdMfcoqobY0w2Qi4X2IElxuc=;
        b=QIvVZCSXtx8m4Auktze+Bdel3vvWahFVhXDr1QzU/3HdaZ2NvFfCiukR9sypAlPmCv
         aCDvtfN2G8cHq47jTULY4dikg0BXYcokISpfd9gthXLCY6c/Ql47tt8W7+UcJ1moSNs/
         wAeZCyJNj3dpZ+O5f56747qNxqkMqMMMI0eAV9QGAaHHUt03W1dhnBpJ+q+igGHDQVOx
         eSc8H1dwx7UX8XqFqqvWF0PAo/ZQrijelY5KblkCtgiIXdAXkSypIEFh69MJAcZbUoJJ
         BV1/DfN5li6nH55t1zlumMqrG4CmT0VBOaYJDiwx5e3IbdBKh0H73f/9aUwZ6v9e6gBr
         M2ng==
X-Gm-Message-State: AOAM533jXytaKDGoTDYdrw659o3IthLJSULwckGOTMbplJWBZ5CDdC0C
        EChAwtjboIgoPKMQnGlCi1LKi1ado1qNDw==
X-Google-Smtp-Source: ABdhPJw7FXkdmJrpcW02NKPnlNRHO8n30Vb8MAbYrvn+72D4FUl0l+j0agUMWthjXMAV2cgJbiMaKA==
X-Received: by 2002:ab0:36a8:: with SMTP id v8mr350118uat.107.1611355615559;
        Fri, 22 Jan 2021 14:46:55 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id x67sm1405916vkx.10.2021.01.22.14.46.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 14:46:54 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id h11so3919831vsa.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:46:54 -0800 (PST)
X-Received: by 2002:a67:2ac6:: with SMTP id q189mr1198085vsq.49.1611355613860;
 Fri, 22 Jan 2021 14:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20210122215900.1168610-1-dnojiri@chromium.org>
In-Reply-To: <20210122215900.1168610-1-dnojiri@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jan 2021 14:46:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XW5rodt0LdmzVwnzUgBgxe98zh1PshHa1G5=oUcg6aAA@mail.gmail.com>
Message-ID: <CAD=FV=XW5rodt0LdmzVwnzUgBgxe98zh1PshHa1G5=oUcg6aAA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] power: supply: PCHG: Peripheral device charger
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     Vincent Palatin <vpalatin@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 22, 2021 at 2:07 PM Daisuke Nojiri <dnojiri@chromium.org> wrote:
>
> +static int cros_ec_notify(struct notifier_block *nb,
> +                         unsigned long queued_during_suspend,
> +                         void *data)
> +{
> +       struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> +       u32 host_event = cros_ec_get_host_event(ec_dev);
> +       struct charger_data *charger =
> +                       container_of(nb, struct charger_data, notifier);
> +       u32 device_event_mask;
> +
> +       if (!host_event)
> +               return NOTIFY_BAD;

Drive-by bug report: the above should be NOTIFY_DONE.  By returning
NOTIFY_BAD you're preventing other people on the call chain that come
after you from receiving any events that aren't "host events".
Specifically this includes keyboard events, switch events, etc.

The patch <https://crrev.com/c/2645556> contains the fix.

-Doug
