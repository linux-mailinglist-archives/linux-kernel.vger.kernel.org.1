Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3452AF7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKKSb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgKKSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:31:27 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:31:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u2so1400391pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=wD0jJ9X64mmDYkYQXCPtOUmFoXPMN4LsIkpG0z5TLc4=;
        b=XNGMe8UIGU4UjjWGJfO7UCoPXJ/HXS48uim2rwQL/5T5pZKMxDtsYw5UhdBzAsuzga
         hcXUEg5BuNcET3U8EHMparmQNn5KFUqSYuMDc1A4PXs0JlhU00TdoW4BTQAQ3/TzPV3r
         lFzbnk1EO2Hs3WEaDfpSjwnjXjwAYz6U2lXUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=wD0jJ9X64mmDYkYQXCPtOUmFoXPMN4LsIkpG0z5TLc4=;
        b=ppudSpWl2K2AM97x4CTWI0XKLuJm/gBVyLtRo50MbgEQjYl6taq/qdOxtxzPgg5gfy
         GevdQct72CLT77cT5XEJp0sZ6x81XcJ4s19J8AUMgKNnYef9+Ko0TWuH1TV2I1CwiUWT
         NZVi6fFMdAhBh82CQCKnYUvx+42oN3s6NOZdjSFkTJhstec6eBPsGCnQ9vy2T7LV7im+
         XNFWbf9VI2tvm42+vtbysl6N4C4iFAy9VWEy/xW4LkcslnLETqtEp3pAo5eYL+RAtTah
         hsAn2Zs+P7f7F6zgDKa17BFkXxpxrucdQSSs8BnlWcKsFm1Mhm9/g7XMB+FjKaDwk2z9
         GAAg==
X-Gm-Message-State: AOAM533EEKY9YgIN+E+TKA1Rsq0WJGOyJMZ9y7tCdGoW6g2nL8h4QRzl
        X0IXAUUac+nbWTNOfPStC04UZ6KG8DuA3Q==
X-Google-Smtp-Source: ABdhPJy09cg46m0g6zOTsBCTeks5xXNo/nK4uXKQMsNVoEVAyVBE7tfR8Q5SwMX43YYdwEDvK5ynlQ==
X-Received: by 2002:a17:90a:4dc3:: with SMTP id r3mr5029168pjl.155.1605119485287;
        Wed, 11 Nov 2020 10:31:25 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id h16sm3018890pjz.10.2020.11.11.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:31:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605081476-27098-1-git-send-email-tiantao6@hisilicon.com>
References: <1605081476-27098-1-git-send-email-tiantao6@hisilicon.com>
Subject: Re: [PATCH] drm/msm/dp: remove duplicate include statement
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     khsieh@codeaurora.org, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, chandanu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Tian Tao <tiantao6@hisilicon.com>, airlied@linux.ie,
        daniel@ffwll.ch, robdclark@gmail.com, sean@poorly.run
Date:   Wed, 11 Nov 2020 10:31:22 -0800
Message-ID: <160511948264.60232.638230439536068079@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tian Tao (2020-11-10 23:57:56)
> linux/rational.h is included more than once, Remove the one that isn't
> necessary.
>=20
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
