Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96D29AC95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900368AbgJ0M5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:57:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43828 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900360AbgJ0M5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:57:37 -0400
Received: by mail-io1-f68.google.com with SMTP id h21so1369135iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFiKV/id+bhp/OGyzJyPrVgrZf8FoY0fdLp5S5yqHuk=;
        b=we/SNQIky5YrQh0PzXP6Tgc1eIaMm9E+w9wS9WP1wIMyhXLi3Qc00UqUJ/rWulxl4X
         S0JMd/4I7MEy/gjBu/RmJEcSkF2lNMRaW5JzUPodhWNlaZb0uE9J8JtBsqctVxmW9IVO
         U2xNQ12PzyVLQYGwQ/dPySIq6lOjMsSQZpy1iMxR7rqztopW9wJvIZTcihhNHq7gUD4Z
         PB8BoQcOle680zaF9ywOl0YyvTcQoThDF7oTv0LWEsxHIb3q3cKxsT97yu5gM8Jcnt49
         ALDxk41xIvjj9e5eSaDMrHteCxC8C1h8wF9vVBR+H/FbrvTnfX5bU9Sfn2K9m9x+Alx1
         vHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFiKV/id+bhp/OGyzJyPrVgrZf8FoY0fdLp5S5yqHuk=;
        b=RoLAiq1u4rx41iGddtIVaFMgqw1SoDoIQcbCmVMbkXKiAcBVyOBNa1qNBpLwIVE7Ez
         E6b/x0VUfmQBOfmRzPFMksBWpfKCEQo0Jzn+rnYOR5PSlpBs9KwkwSbSOtED1+VOoWQq
         uZRO5QaZ/Urat7JAnAKtLObqlbtgJxHpEQ6jecHmsbG1tidtxn20oDh8j9svkckmLb6S
         +b4c0MMGTBxr6tpSONwHZ9C4nEMvjbS4l8a/v7k8tXqWYUNTCFKjHiWnyfkbHfW8rLZQ
         5N0r8DWoLbpHN6eTtAXpWIAHQzjHlonmpqrz49hHVCwEffRYmoCvqAXFd6SQgC41MveP
         pYVw==
X-Gm-Message-State: AOAM533LN5WI9uOO4afSES+km8CuX/qcCPtJrUK9FbeQdfGH6hWM9Yr1
        rJu+pI3Jv35Jzk/NRG4XsxnoLSiKGM1qxKpBHLaTCg==
X-Google-Smtp-Source: ABdhPJw80+MpzHK/ilur7RHbshltPyxr4dvaxh10InBIwhnvQNFGY94xAJejcWr/D8nBiTS/x4L28Z23strGJkwwj8s=
X-Received: by 2002:a02:b812:: with SMTP id o18mr2137454jam.55.1603803456107;
 Tue, 27 Oct 2020 05:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175526.2915399-1-enric.balletbo@collabora.com> <20201026175526.2915399-6-enric.balletbo@collabora.com>
In-Reply-To: <20201026175526.2915399-6-enric.balletbo@collabora.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Tue, 27 Oct 2020 13:57:25 +0100
Message-ID: <CAOwMV_xJez8WB=XjBSWfRmQ7x6265+2iJ+nLN4BR5YjoQzingQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] soc: mediatek: pm_domains: Make bus protection generic
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Miles Chen <miles.chen@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -               ret = mtk_infracfg_set_bus_protection(pd->infracfg,
> -                                                     bpd[i].bus_prot_mask,
> -                                                     bpd[i].bus_prot_reg_update);

[snip]

> -               ret = mtk_infracfg_clear_bus_protection(pd->infracfg,
> -                                                       bpd[i].bus_prot_mask,
> -                                                       bpd[i].bus_prot_reg_update);

Since you got rid of all the dependencies to mtk-infracfg.c, maybe you
can also remove the "depends on MTK_INFRACFG" in the Kconfig.
