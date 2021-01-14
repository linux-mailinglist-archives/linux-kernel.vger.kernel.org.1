Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94972F56C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbhANBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbhANADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:03:15 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F38C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:01:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q7so2550180pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=j5No6ehFyNUGBGnFH55sTeUTiuMaiV/KCtKu2WjO9nU=;
        b=BnYPoseV9pn2y6AghtZxd/frs7EpZNFmCFHEDX67t/JVVhoevvpnUdohU5tE7xpiZd
         Fv1Ab3khuxM2NPIlCl9pvHHTJ4SWb68d4myh+IYLaSJQOpqGYQLt7gFOEamxL7OVk4Mr
         TGkZrM+SLjNuPSEQi2592Zq/DmrRa8jG1yYS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=j5No6ehFyNUGBGnFH55sTeUTiuMaiV/KCtKu2WjO9nU=;
        b=j2ao0cWTcuNu8N+qvtZhrXr8tWRkCjM8tAL64yQqlrceZY7d/11B19OVNlnNYDfb4R
         NGu8crsduU9UpTTHeN9WxvXPQCtyJwnWQf6MJh3IVhs1++cZlPsNOsFY0tnbxXP67VJo
         MV6PkTMQBismrkoe02BJLfHuaq0yuEQzkCsREi6xYJfKVxJn5ys3P0szs8U7pLi/tG7F
         KIGmnFYcVLnKY2h81sInxlpyMB69AgnmF+q2LrBxZKoCwCXHW/b4JH0bsnGuYw7rYfTZ
         bRoguv105UMvQxQWSwIc3xvQBtfLEaxIDouQtV0SgkVnncM6Xloog/SCSQIFCdjq249S
         3MpA==
X-Gm-Message-State: AOAM532YNiOxZGYZfdCNy6bGcsqPvEGGE5Ldfgg/4lLVU6rbE8rKsPOZ
        pFQP4dROqjRho4zyMN/GYJJRtA==
X-Google-Smtp-Source: ABdhPJz/UNH+WbuQbeTH+zfipea9NQjduVzBRKEt49n5Dikay54BXViatwCIDl+QG7xYHAboFU80fA==
X-Received: by 2002:a63:fe05:: with SMTP id p5mr4473115pgh.161.1610582508970;
        Wed, 13 Jan 2021 16:01:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id gc20sm3675490pjb.49.2021.01.13.16.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 16:01:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5b1c9e0706fdaf4cc1ecbe740b8c916c@codeaurora.org>
References: <1610564400-29788-1-git-send-email-khsieh@codeaurora.org> <161056955435.3661239.1548841852585636847@swboyd.mtv.corp.google.com> <5b1c9e0706fdaf4cc1ecbe740b8c916c@codeaurora.org>
Subject: Re: [PATCH v2 0/2]  fix missing unplug interrupt problem
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     khsieh@codeaurora.org
Date:   Wed, 13 Jan 2021 16:01:46 -0800
Message-ID: <161058250690.3661239.88115129391615310@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-01-13 15:52:37)
> On 2021-01-13 12:25, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2021-01-13 10:59:58)
> >> Both AUX_SW_RESET and DP_SW_RESET clear pending HPD interrupts.
> >> Therefore irq_hpd handler should not issues either aux or sw reset
> >> to avoid following unplug interrupt be cleared accidentally.
> >>=20
> >> Kuogee Hsieh (2):
> >>   drm/msm/dp: return fail when both link lane and rate are 0 at dpcd
> >>     read
> >>   drm/msm/dp: unplug interrupt missed after irq_hpd handler
> >=20
> > It won't apply to the drm msm tree. Please rebase and resend.
> Both V1 two patches are picked by Rob already.
> I will drop V2 patches.

I only see the first patch, not the second one. Rob?
