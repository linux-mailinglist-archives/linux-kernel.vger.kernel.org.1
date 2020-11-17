Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED62B6954
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgKQQFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:05:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF71C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:05:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h2so3778069wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eeHttLgR79pcdp9MMr/QfOUcrgRAzex1AqWx+Q75Fcw=;
        b=o+0axMYg87OlMQK+SQlz3DpQV+Qp9LXbvtweaiFGcpijjHCCKCsOFpS7Dx9iByn18w
         FvCU2w472NopCnEBQhJP3Yydj2MryLjNEMjsJN+G3M6nYKVL0VlfONdGhJHTSDl7HfiK
         b8Y3lGQH5o6lj1l6QlK4TnS4wEwZUWEXMqYHNMUeZykbwyDV8TdI0NfAlllJKUCBR77h
         srXwXLiClYt4JDSLC2TVDSOT+EILrvx448BjfHP6rJOvEpx4YJ22oL7kNSA65+6iF3C/
         N+4hKyKAdAoxVucdcSnWAE4XUnuiTjaHfRiKT0P6oA3kSDEox7E4zfvvI2jvKF90T30o
         PmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eeHttLgR79pcdp9MMr/QfOUcrgRAzex1AqWx+Q75Fcw=;
        b=Yq9gUegfpGIOutd7hSXRMkYZ5EkiF9az7AKchrQ2qrIhGdzY2f54TFqThoGVm5V/BP
         A7KpwozPyUGm2EpEV++CM8++DQpP/3iDudUgF3iBa/UpVEru5y2+LBdDagw0hFEE7gdD
         GfdOp3HHQJryShFcfzpPzgAOFBrc43UkbCeQgIYXv2HNo+z0yZDkeDh5+hTg03RSxYcF
         sci1U6mBs/AE8ZNReTchVARh9SrcbjRieyLysKNvTSNR5E4lR6ayGFdsK/2EAjeEWivR
         qLomAIakBBMIAQqOcRcH5w0OtJreaqKOhmtimb5Q8d5ZivTpNUAfowtP/i6j35Spn46r
         np5g==
X-Gm-Message-State: AOAM5334FDQCUdHJo/0HydXze/ccS5dtM80R9m6Jvr9g3KZPZ+lpLt5W
        dQMjrYARbY9JpDQlh27++4c2GWqfxiFGAPAH
X-Google-Smtp-Source: ABdhPJzA2XEJXCHJs60/AGk1RiJTwsk0UIn1lA1kBouxOZZHrVZKfqq7z53KJxelcMpjV6tp63fzLQ==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr351246wmj.69.1605629103973;
        Tue, 17 Nov 2020 08:05:03 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id m3sm24339559wrv.6.2020.11.17.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:05:03 -0800 (PST)
Date:   Tue, 17 Nov 2020 16:05:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
Message-ID: <20201117160501.GJ1869941@dell>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
 <20201113101940.GH3718728@dell>
 <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
 <20201117123741.GH1869941@dell>
 <d4424323-25a9-9f70-b2c8-ce464180f788@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4424323-25a9-9f70-b2c8-ce464180f788@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Matthias Brugger wrote:

> 
> 
> On 17/11/2020 13:37, Lee Jones wrote:
> > On Tue, 17 Nov 2020, Matthias Brugger wrote:
> > 
> > > Hi Lee,
> > > 
> > > On 13/11/2020 11:19, Lee Jones wrote:
> > > > On Tue, 10 Nov 2020, Enric Balletbo i Serra wrote:
> > > > 
> > > > > This adds syscon_regmap_lookup_by_phandle_optional() function to get an
> > > > > optional regmap.
> > > > > 
> > > > > It behaves the same as syscon_regmap_lookup_by_phandle() except where
> > > > > there is no regmap phandle. In this case, instead of returning -ENODEV,
> > > > > the function returns NULL. This makes error checking simpler when the
> > > > > regmap phandle is optional.
> > > > > 
> > > > > Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > > > ---
> > > > > 
> > > > > Changes in v2:
> > > > > - Add Matthias r-b tag.
> > > > > - Add the explanation from the patch description to the code.
> > > > > - Return NULL instead of -ENOTSUPP when regmap helpers are not enabled.
> > > > > 
> > > > >    drivers/mfd/syscon.c       | 18 ++++++++++++++++++
> > > > >    include/linux/mfd/syscon.h | 11 +++++++++++
> > > > >    2 files changed, 29 insertions(+)
> > > > 
> > > > Applied, thanks.
> > > > 
> > > 
> > > I've a series [1] that's based on this patch, could you provide a stable
> > > branch for it, so that I can take the series.
> > 
> > Why can't you base it off of for-mfd-next?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next
> > 
> 
> I can do that, if you are willing to not overwrite the commit history. In my
> case it can happen that I drop a patch from my for-next branch as I realize
> that it e.g. breaks something. I think that's the reason why normally a
> stable branch get's created, as the commit ID won't change although you
> change the commit history of your for-mfd-next branch.
> 
> If you want to go the route for me rebasing my tree on top of for-mfd-next
> then I'd like to have at least a stable tag, so that it will be easier to
> provide the pull-request later on. Would that be a compromise?

I don't usually provide immutable branches/tags unless I'm sharing
topic branches for other maintainers to pick-up, in order to avoid
merge conflicts.

It's highly irregular (in fact this is a first for me) for a
contributor to request one to base their work on top of.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
