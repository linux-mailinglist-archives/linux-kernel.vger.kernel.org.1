Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FAF2A2F88
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKBQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:19:01 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C3C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:19:01 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id w25so7746017vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ucUZbGTTJZ2A+pmmh62lxQnSfQrQByyqZCyVaS0GnE=;
        b=nS+eIPFzs8lalHYmoDlSPmIimpnifAzfi+4EBIILxr4b0LU/HWYjA/0P/PZ15lFWF+
         1rpF35AW43xqYxc4dIdl8bDaBRcrGYzgOCOZ1SnUBZVePCe38dZHgiJ+ww7nIZwdVh2v
         2NWHhkzk5YC9dM6gXQvbBQeu7AVVzv8/SoLyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ucUZbGTTJZ2A+pmmh62lxQnSfQrQByyqZCyVaS0GnE=;
        b=hK36TSZKeIo7IKWKVyXnyNOkBwmm+FftgLKmaZ+xOddB139VqgyxPiRVHpETEaAbGu
         bZsCXmWxCMwXNpPIIgJCwaRNCxK3k0rZEUlzaAJCJCdcyscF4+AoFTbrbG/96ddWeJn2
         njnpQ1WHq/VcfQSAKvNQgCh1XD6EFtK/HKv31MgYlGTaLAGHMnMqqwlwqlUBIJu/35Hk
         cIxFn0deZyBrmnxXLigcTozvwjEm7V4rKxbT2M8+Fr/RSHuMtLEggbBbzyF2NFCeqvss
         DLmAJjE3SFnGawyYHGCAKhxBpdN+t+tmJNxywFAvmF1/H8JCA6MldSdhlXP5dkK+O/ts
         oLAw==
X-Gm-Message-State: AOAM531XRBHCR42fkBRuFu6lZitIaN7OYfwlqzItm93FTs7z5FnFYDao
        wDkhU+2MtJ0ix6nYwPdOVJmm9zoIb2dqbw==
X-Google-Smtp-Source: ABdhPJwY4LVqfHKEHY1yWhF4KMsq0EGK6w5lf2vExz65Kcj0w33hgU+U65KMPqXwYB9HLXaG436Sag==
X-Received: by 2002:a67:f716:: with SMTP id m22mr15880070vso.12.1604333939946;
        Mon, 02 Nov 2020 08:18:59 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id z200sm1872402vkd.52.2020.11.02.08.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:18:59 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id e3so7759603vsr.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:18:58 -0800 (PST)
X-Received: by 2002:a67:ef98:: with SMTP id r24mr1060059vsp.37.1604333938604;
 Mon, 02 Nov 2020 08:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201030011738.2028313-2-swboyd@chromium.org>
In-Reply-To: <20201030011738.2028313-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Nov 2020 08:18:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHvL4A3U==CECbgkfvRcy51v4cSBjodvRGA2463L+CZQ@mail.gmail.com>
Message-ID: <CAD=FV=VHvL4A3U==CECbgkfvRcy51v4cSBjodvRGA2463L+CZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: ti-sn65dsi86: Combine register
 accesses in ti_sn_aux_transfer()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 29, 2020 at 6:17 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> These register reads and writes are sometimes directly next to each
> other in the register address space. Let's use regmap bulk read/write
> APIs to get the data with one transfer instead of multiple i2c
> transfers. This helps cut down on the number of transfers in the case of
> something like reading an EDID where we read in blocks of 16 bytes at a
> time and the last for loop here is sending an i2c transfer for each of
> those 16 bytes, one at a time. Ouch!
>
> Changes in v2:
>  - Combined AUX_CMD register write

The change from v1 to v2 makes me slightly nervous, though I guess
it's fine.  Specifically, all the examples in the datasheet show
programming the CMD before the ADDR and LEN.  This change will make it
programmed after.  Since there's a separate START bit I guess it's OK,
though.  Nothing in the datasheet explicitly says that the order in
the examples is the only order that will work...

Reviewed-by: Douglas Anderson <dianders@chromium.org>
