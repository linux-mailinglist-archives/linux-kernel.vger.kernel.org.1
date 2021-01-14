Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C52F63D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbhANPKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbhANPKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:10:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33E9E23A80
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610636979;
        bh=8Ytg6rr+vhZOUVZ7YEBZ/tNIoxH6BmhiIZ4QW6uSU6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mPElLYb5hepykdQ/Xo1H+mD6Knr9MAWGDeHJsjGCdHy0nLBB1bucA/BUl1lbldhGM
         yb0C1DFlOnTna9RMU9tAD+Lw82ormFRQoTrckV5nbwuZLeDAQCRAguydFBjQ0wUtWs
         BRklh/cg37QQYHMW06gJO1KBYdb+gvl80iw9OnxazPEunxML1/S5RP0J7tlCM6nH1u
         JM4ocIbKfQBFa1XSZ9tEDjIZL0WQxlsx5VJ/j0pBB72FPpdHo8NXT/cConBnKV7B9Y
         dxLd3PAUhO3935UWV8Uv3WbZZbmNquGR4TojaJ95Tmxgowt+Sgfej/CCE8CpjC7Lym
         x6tNjzdT9NSsA==
Received: by mail-oo1-f48.google.com with SMTP id j21so1422277oou.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:09:39 -0800 (PST)
X-Gm-Message-State: AOAM533+4ztwnKJli8/TAtPf9Gqd69l1YGNYpiB2T5DYsS4+EwRrmf1P
        IgYKxSq2sKxeZFqalMDW+CdPkQ1IK2p7TiL3+MY=
X-Google-Smtp-Source: ABdhPJxy7/gXoT00gpRoe9YxdlRpPkuHIlxwpQreEYKCcKDdViftSZjGKzQ29riPpA+gtnR22JvNi9rxLl7X13N8tbE=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr4951976ooj.15.1610636978562;
 Thu, 14 Jan 2021 07:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20210112203250.2576775-1-arnd@kernel.org>
In-Reply-To: <20210112203250.2576775-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 14 Jan 2021 16:09:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0+YmZTzYYk0D5HpBEB7Kp=ryx1U4KRKCyz4XYM3v9rAQ@mail.gmail.com>
Message-ID: <CAK8P3a0+YmZTzYYk0D5HpBEB7Kp=ryx1U4KRKCyz4XYM3v9rAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [v2] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rander Wang <rander.wang@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:32 PM Arnd Bergmann <arnd@kernel.org> wrote:
>

> ---
> v2: fix various build issues in the first version, now passes
>     all randconfig builds I tried

Please disregard this version, while I have a tree that passes
the randconfig builds now, this was not the patch from it that
I wanted to send...

       Arnd
