Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806EE2F9A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbhARH2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:28:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59961 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbhARH1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:27:52 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1OwP-00068Y-Ko
        for linux-kernel@vger.kernel.org; Mon, 18 Jan 2021 07:27:09 +0000
Received: by mail-lf1-f71.google.com with SMTP id k7so5257029lfu.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fyt5t8P5kkC0piJibcvWgRnEeFXJryejXs+iDoShEgk=;
        b=p866/aLadm0kYU0iSu9J/BaDQs9YmPwFVbKuIeEoE3wOlgyCo+KAMfv8Cq5snT37/W
         7BXXW5fFtDHIuyZoD4XzgaOFfDBBN94699MlEHtVllZtYo/iUFz7TygyhAmc3LN/T64a
         DIuRs5om5ID5Rp3WHh92724OQtZ7daBeLMrnGb6PY0jykJne1zpPK1vfIDZ92+9fjTbj
         8OeH4zCeQM+RcTpOC81lTXAnvgiltHsmubmvTtNSZ87LUvpfwtWDlJlHrp8tL6ksgq+5
         4btcEFkRDI4VSAPsnfw28RKLRPAIpyF/LklgOlA9mjUv8PUj7tIqAvCvyR7mq7Pxrtbh
         y8eg==
X-Gm-Message-State: AOAM532JVrLV7ctWS4AfD9vw4/qgyBZPvV4Q8HlD0Or/19tw6BUG/Rgd
        ZmXWEZJLYNB6uXczm72V1zpKx62uizcqJ138TPvYia1NQwSKW7ATCZWYbWUIydhA7kIrilZVTPS
        4qsyRikVXhVrya7TD3B0xjC2tBiVFT/oAGKe57mqVJ/s1LJBHnAVF2xpUaQ==
X-Received: by 2002:a19:848f:: with SMTP id g137mr10560407lfd.622.1610954829138;
        Sun, 17 Jan 2021 23:27:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynsiXaKjwq4+uqzX5fA/LlL7e2HPdYoQqN2xQuWJ59xDPDoQGa4IwaLPfZdoWeKvPb9J3Lg1gNDedlDwAU5Bc=
X-Received: by 2002:a19:848f:: with SMTP id g137mr10560395lfd.622.1610954828725;
 Sun, 17 Jan 2021 23:27:08 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
In-Reply-To: <CAAd53p6aURhfFp1RFQxEPtGfzSdUfe4=N=P2rP27ULxp-D4GCg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 18 Jan 2021 15:26:57 +0800
Message-ID: <CAAd53p45q+Jigje0FcWAERiBUGfJhR8nTYNh7SFxBpajAe4=oA@mail.gmail.com>
Subject: Re: Multiple MODALIAS= in uevent file confuses userspace
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lennart@poettering.net,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 12:25 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit 8765c5ba19490 ("ACPI / scan: Rework modalias creation when
> "compatible" is present") creates two modaliases for certain ACPI
> devices. However userspace (systemd-udevd in this case) assumes uevent
> file doesn't have duplicated keys, so two "MODALIAS=" breaks the
> assumption.
>
> Based on the assumption, systemd-udevd internally uses hashmap to
> store each line of uevent file, so the second modalias always replaces
> the first modalias.
>
> My attempt [1] is to add a new key, "MODALIAS1" for the second
> modalias. This brings up the question of whether each key in uevent
> file is unique. If it's no unique, this may break may userspace.

Does anyone know if there's any user of the second modalias?
If there's no user of the second one, can we change it to OF_MODALIAS
or COMPAT_MODALIAS?

Kai-Heng

>
> [1] https://github.com/systemd/systemd/pull/18163
>
> Kai-Heng
