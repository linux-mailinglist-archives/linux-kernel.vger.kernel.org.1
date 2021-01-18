Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA02F9F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403833AbhARMFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391158AbhARL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:57:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5609C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:56:30 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p15so9272501pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+Pp5eL8puRaYSNA/8vnlhxeGQpEnUC4T2Q0i2MvjpM=;
        b=oliayb58Yv5enMZCYENb6Y9eiVTLMOXKygs6mPRopMiZbE/slznkHSI5KbhcUjBtBX
         oR05CQmbKv7/t754Y1Uh4x7DdT7KkPLpavx3jV/TtgSk3kQHdFaYl6qvfzUWayg5a6eG
         MzGh1AYsK5AXV9yUVz6vC6yOZhThV4eECNWtz639DuNZCgq12PUkkr+axOOoEvDPsmnG
         onGCmoagqUkidxq74Jd0O079iFjGqfKnHXOnp1nL3xEJw1ZDl/hNstwej+fyBcowmeLs
         2pnq2kpGRHfIgLjDIQ3LQmVWnbUc+/LK6PkdLqwuypfvgZ6dY0km+pQcKi2lOEVV5WHA
         76cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+Pp5eL8puRaYSNA/8vnlhxeGQpEnUC4T2Q0i2MvjpM=;
        b=W4nKwvQKvaeNasFUAAjk7ZNqx1QBD6Io8Oc+bXgxexmEABnFZL3YISL2IeblnfTYuY
         su+FivlHiT7DoOneYf0N7FQAgWp+PAxdKU1MptRsz1l4YnXqRHqis6qJoPtWZLCMvR9n
         q4HXyxpFYHnAAd0a5bNt4E4O5cX3JUCUBCrPblUhUwUwtC/bFab8YbQYM8yqKXsx5Hhc
         DxIx7S+GTL8lejtY0EuYSRMlMwF5dT8dxiglP3E75Vf5/0V31EEhTvrmiMvu7pOAyCYI
         lFvNt94v9UxbvQCowwvLB4/nO50+yEdIsLnsgwyp+chNTWd1eIi4ipnVmaf1y74INUqM
         5z5g==
X-Gm-Message-State: AOAM533pDLw1e14AhU/LigimDfd0sxjQFh5uXTZ5oH5k0hYcZcPdRYww
        6/uLEIo4GpBqqrEg5JTOtNVMa67rE8aFVTfvcyo=
X-Google-Smtp-Source: ABdhPJyokVKFXyUFIND8V4pfsCfAbi5v5uuzbNGREZh4UGsK1+n22ndvgRqGOFKqvMiROPgNAE+3GYGkF3BK1ZffG/Y=
X-Received: by 2002:a17:90a:6c90:: with SMTP id y16mr26665016pjj.129.1610970990165;
 Mon, 18 Jan 2021 03:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20210117160555.78376-1-hdegoede@redhat.com> <20210117160555.78376-3-hdegoede@redhat.com>
In-Reply-To: <20210117160555.78376-3-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jan 2021 13:57:19 +0200
Message-ID: <CAHp75VePZ1Nj3x_xzbpBU_-h4tmOGtfcOnfqeFBsbWOYEMB7mQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] ASoC: arizona-jack: Add arizona-jack.c
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
> Add an unmodified copy of drivers/extcon/extcon-arizona.c as
> sound/soc/codecs/arizona-jack.c .

Usually adding -M -C to `git format-patch` helps a lot of rename detections.
I think in the next version we easily see the evidence of the above
which makes review by snapping our fingers.

> This is a preparation patch for converting the arizona extcon driver into
> a helper library for letting the arizona codec-drivers directly report jack
> state through the standard sound/soc/soc-jack.c functions.

-- 
With Best Regards,
Andy Shevchenko
