Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD932F9F27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbhARMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391315AbhARMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:02:49 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:02:07 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 15so10799364pgx.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7HW5Fn5HqLLSx1V6tfhUzIQT3KvnzKSP/Tp5i7ao8Q=;
        b=foMgbK9+xSCa7cPcjEBKOC32mrd3JFNOSTTijm0db1uK1Tj7O387n4xTOTjMeKaSLy
         3/ksApl3DqGDdbVwb2jLAYVLWj1czd6rEhuhQefabMWbjJNqF8pWqyAJQZwu5DszdFHU
         1TGnqUK4Ay7sOUJIXTpxaxB4xn+0x8gaWhun6WTYth7Gtc7p6Fcm4edEjci/sSBI8rIi
         qRrn4ThVdmkMxop8ZJc6IYPE7/6gG9wsvniiRvbtVc8pS+vfHeaHF1sLOXHLNIhAE5qf
         T28ekBadRD0epMZc1WRDbXHzvMxBnF/2RsA9IOQDJlUXKikZB1PVvjfJgMas2SSUhTRz
         oxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7HW5Fn5HqLLSx1V6tfhUzIQT3KvnzKSP/Tp5i7ao8Q=;
        b=Su6GgJAlNNg1wqDciAXiw91K7o5Z1Pc8Ab1b/9/ZG3TG3IcixOA4jf9c9gYzUMcQvB
         3BDRJcQQ8sVsluuhkcj6TgDKrCISjKL1de4yV0vWnH2JGls5U6qk111JYrv3lqxVOEzW
         ug4Xq4n/XiSnLFKt5Ec294JEk2NhlIxUQBktFYbxEKHM7EwfC+i9NON9LIl9WKKZ0nh5
         9ifhotgrU5p/hGC5XTOKZfq3Fbj5Qq99TlJiI4G6Xv7ru799OW3QFG37hmjj02YwXGiE
         djVAaHZb9H3N2pwqn8E1SnlmRFYaS0tnevwAcP2Wo9KctMU+1eWemnPMJmQTImQUJ0yc
         J3zw==
X-Gm-Message-State: AOAM531CgzaQkhh0O1LKu+z2tdHREhql2/zuKv6W5NqvTaH1adOVrPdc
        qsx/hzBY3u1gv9Yo9hXlr+Pba9Ts4x0vRTt3/n8=
X-Google-Smtp-Source: ABdhPJwIpGgRaQ5jpp/Lql9aNM1L2bu9IsIaQARThbryiR57zrZbo5CMa5Ay7ikc17JjghePtBgVTKA4qzZSDocr+HI=
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id
 66-20020a6204450000b029019c162bbbefmr25981538pfe.40.1610971327005; Mon, 18
 Jan 2021 04:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com> <20210117160555.78376-8-hdegoede@redhat.com>
In-Reply-To: <20210117160555.78376-8-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jan 2021 14:02:56 +0200
Message-ID: <CAHp75Vc92WoJm5T1jbF7UUjCNrVZr2as8ccEWxCZ9aP7z+ZyLA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] ASoC: arizona-jack: Use arizona->dev for runtime-pm
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Use arizona->dev for runtime-pm as the main shared/libray code from
> sound/soc/codecs/arizona.c does.

Can you elaborate switchings from get() to get_sync() in few places
along with moving disable()?


-- 
With Best Regards,
Andy Shevchenko
