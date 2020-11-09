Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237442AC942
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgKIXX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:23:55 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32B5C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 15:23:54 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id q68so3354135uaq.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hy7TKyZHJ9No+mZr0hZGFgrb+eb/SGeHukhYIRcpwYY=;
        b=C8uFCOCzFxzBNdhRn2r0/WGEaDr91GKtja37pCqNfRzs7gofDM8nLziq7NcH6XJEdK
         Z0XpCRpRfgNrcTRcRItT7T+T0Y1+3eyHQnRZotb0nqCFPzxdX7dARuwD7pD7obkBx/AJ
         Y6fPPiUgJILhKaBMArkw81gVYyYF4TanXNUlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hy7TKyZHJ9No+mZr0hZGFgrb+eb/SGeHukhYIRcpwYY=;
        b=l91oxFLKrixDd80xdlmhEbNdxe1icDWk0mpwbNgaBY/NvfY6lCNPj7oYBztQuzatUu
         jmDj5+B195LlJBVQ0rU2DGk68BAOjQcRpFNArTxFn81OLOmf8MQ5BHS6dGuJstWKSiub
         hV29A0CB+TrvINqqwO/CC7D72GPo/653cFJUtypAMKdxZN8+be1Bb3QLVRHKl3ascXfu
         699gdx1wZgBFkM88yjaF2bBmZlrqs+0wDWG1dE0uPmQ1Dq1ZcqfH2choe/2n0T0k/Qji
         pfinhqr0pO66ArXBZS6EC3ZZSJbVK7SeSbXIhSHoVv0h1V7Gd/pn+6MrlAmb3056pAq6
         FqGQ==
X-Gm-Message-State: AOAM530POUQVkTw8q1Mu7BiXY26dLXlWcMmFoSbR1gUfKKaDA7BwOgzb
        3jxSm9ATcMBBwDOj7GUu+TIKoSlDyTfEyQ==
X-Google-Smtp-Source: ABdhPJzh4YxDqhxgM2fG/GSNvKO7c/DhmvL6cC/5EzsniPxS1BIFM3D+QuBNblj2F4UbFrsv07HqWA==
X-Received: by 2002:a9f:264a:: with SMTP id 68mr8515733uag.0.1604964233867;
        Mon, 09 Nov 2020 15:23:53 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id m9sm700254vke.10.2020.11.09.15.23.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 15:23:52 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id d191so2285959vka.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 15:23:51 -0800 (PST)
X-Received: by 2002:ac5:cd58:: with SMTP id n24mr6279742vkm.17.1604964231319;
 Mon, 09 Nov 2020 15:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20201109213636.1267536-1-dianders@chromium.org> <20201109133526.v5.1.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid>
In-Reply-To: <20201109133526.v5.1.Ied4ce10d229cd7c69abf13a0361ba0b8d82eb9c4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Nov 2020 15:23:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UUS1U5YmOFjioU12o3ayb8W2rFh9bPTfaeGiBxZ0cXHg@mail.gmail.com>
Message-ID: <CAD=FV=UUS1U5YmOFjioU12o3ayb8W2rFh9bPTfaeGiBxZ0cXHg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] HID: i2c-hid: Reorganize so ACPI and OF are
 separate modules
To:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Jiri Kosina <jikos@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pavel Balan <admin@kryma.net>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 9, 2020 at 1:37 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> +int i2c_hid_acpi_probe(struct i2c_client *client,
> +                      const struct i2c_device_id *dev_id)
> +{
> +       struct device *dev = &client->dev;
> +       struct i2c_hid_acpi *ihid_acpi;
> +       u16 hid_descriptor_address;
> +       int ret;
> +
> +       ihid_acpi = devm_kzalloc(&client->dev, sizeof(*ihid_acpi), GFP_KERNEL);
> +       if (!ihid_acpi)
> +               return -ENOMEM;
> +

Turns out one way to find some folks to help me test this code is to
break them.  Maybe not a good way, but a way.  :(

There should have been a:

ihid_acpi->client = client;

...here.  If you're willing to look at Chrome OS gerrit pages, you can
find the fix at <https://crrev.com/c/2527946>.

If everything about this patch looks good, I'm OK w/ a maintainer
fixing this when applying.  I'm also happy to send out a v6, but I'll
wait a little bit in case there are other comments.


-Doug
