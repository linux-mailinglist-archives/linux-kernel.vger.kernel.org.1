Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1627A693
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1Ehu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 00:37:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38511 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgI1Ehu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:37:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id y11so9514279lfl.5;
        Sun, 27 Sep 2020 21:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PmQd7B2UV3XNWq1r+fcYwXvafyTylCt2+L6Qyv0W31k=;
        b=FO5aZmNBk+cQ1mGYNq/3guE0HdnXaiCEXbQb2eUH9KJ0i5JNwFJZYNy6TtR9ShcB2H
         XErXACZ1AVBTagobY8sd0WR4aTcgWPJeqtrJOlPmpVkHQt0IpsA2ALJFZMJGHUFefHWg
         /rkCyDLBs5qt6UDFBjsTcGJmX6jC9SddOqZOSD26yN/WMihR8k/QIhyA3k6iYzpfQI5n
         e326fcd2PhTpUfKa+t5Kaok21EwgZ/i5CMQEtRJhFusQeMWtAPkelIEvhp91RsY0Zp74
         s0XQsOTr9QkQy/PRK3EU6iGMelRuGcxBMO40eCn0KUomjbG+cWPxO3t3UsaZckWLdegN
         LX/g==
X-Gm-Message-State: AOAM532jSEXdXIUVD4XaMeJbfxJ9a/HLajomxQZVc8iP7UJqeeV5GNp0
        pzq+kUOygj/C5q6S//LiCF26jD1ZLokrQw==
X-Google-Smtp-Source: ABdhPJxsLcHNSGciOvIzLRl3ERq/ZW8D/V72dTOa0WLNO6ijKJNtqp3iDfGBoKx8WwqLjPY2HM9lOQ==
X-Received: by 2002:a19:942:: with SMTP id 63mr3493556lfj.23.1601267867358;
        Sun, 27 Sep 2020 21:37:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id y5sm2713160lff.60.2020.09.27.21.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 21:37:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id q8so9504709lfb.6;
        Sun, 27 Sep 2020 21:37:46 -0700 (PDT)
X-Received: by 2002:a19:c6c8:: with SMTP id w191mr2875289lff.348.1601267866731;
 Sun, 27 Sep 2020 21:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com> <20200927192912.46323-4-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-4-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 28 Sep 2020 12:37:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v67gFTrGVs3pw5ospdSoogaA15cbuWjPQK=-Z2f4nMd9Rw@mail.gmail.com>
Message-ID: <CAGb2v67gFTrGVs3pw5ospdSoogaA15cbuWjPQK=-Z2f4nMd9Rw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 03/20] ASoC: sun4i-i2s: Change get_sr()
 and get_wss() to be more explicit
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:29 AM Clément Péron <peron.clem@gmail.com> wrote:
>
> We are actually using a complex formula to just return a bunch of
> simple values. Also this formula is wrong for sun4i when calling
> get_wss() the function return 4 instead of 3.
>
> Replace this with a simpler switch case.
>
> Also drop the i2s params which is unused and return a simple int as
> returning an error code could be out of range for an s8 and there is
> no optim to return a s8 here.
>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>

Fixes: 619c15f7fac9 ("ASoC: sun4i-i2s: Change SR and WSS computation")

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
