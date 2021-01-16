Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4987F2F8D0E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 11:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAPKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 05:54:13 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42591 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbhAPKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 05:54:12 -0500
Received: by mail-lf1-f47.google.com with SMTP id b26so17019320lff.9;
        Sat, 16 Jan 2021 02:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUqagD8AsdOTxk1lIeGzX7HeG4RIS3c27lj2umCW6WQ=;
        b=ZlgS5c/7PaoDGA0AwQnqKikOcZANqoGsjANwdI96lTtx8fsIVBU5JVYuynxBDGGZIr
         ImFJx9+cv7rJLkj2rhR9omI7xjgm2Hw0bRmLybPZuNFzflPRD7E+f1yX+msN4CDkesZC
         JYO5ozkHhW7QddWC2NMzB/23s41uP2UGalVXjLtzimPTTWv6/LR22/6BQpc5bl4UrLaC
         43s4MIje+It4fAOXg5vjq7LdwIViEXz0vL9vs6cd/b8QUUTBf6DeCKrPUxp1fu0yl4v4
         t01w3z6Ip/heFxZ8BzM+eCkLtXRa2fJR85ZZRDIsffumR3Di4qniPDDImf1v9Lc7RFhm
         ivLg==
X-Gm-Message-State: AOAM530kPYm2jbaPNlgJecBxcADkMqodREApM8ZFVTtSi+eMzNBO9pLo
        OJXjAEb2wjt13iW8THDgeYY0K6F8MgNr6w==
X-Google-Smtp-Source: ABdhPJyNRe5bCfK191uwa6Qhhj1Fx4MNSb2z0EhV33s4noixRnvJrVzskZYUCDcDfBHTP2XJ9xP3sQ==
X-Received: by 2002:a19:d4d:: with SMTP id 74mr7507454lfn.403.1610794410397;
        Sat, 16 Jan 2021 02:53:30 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 186sm1067528ljf.21.2021.01.16.02.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 02:53:30 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id o13so17044555lfr.3;
        Sat, 16 Jan 2021 02:53:30 -0800 (PST)
X-Received: by 2002:a19:c783:: with SMTP id x125mr7286889lff.303.1610794410073;
 Sat, 16 Jan 2021 02:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20210116103710.245617-1-jernej.skrabec@siol.net>
In-Reply-To: <20210116103710.245617-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 16 Jan 2021 18:53:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v66EWp4L_LJM4BdoMrS9G+ef-unZtrJrnHjpe53xK+Dyfw@mail.gmail.com>
Message-ID: <CAGb2v66EWp4L_LJM4BdoMrS9G+ef-unZtrJrnHjpe53xK+Dyfw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i: h2-plus: bananapi-m2-zero: Increase BT
 UART speed
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 6:37 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Bluetooth module on BananaPi M2 Zero can also be used for streaming
> audio. However, for that case higher UART speed is required.
>
> Add a max-speed property.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Chen-Yu Tsai <wens@csie.org>
