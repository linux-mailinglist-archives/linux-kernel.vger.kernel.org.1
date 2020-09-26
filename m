Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51F3279790
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgIZHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 03:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZHkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:40:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F89C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 00:40:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bb1so511257plb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 00:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=qRaxhiyZE90m+amIVHIeCMA0LL3BWUXSOy1qHRMz/HE=;
        b=REsQD2UwdR9mJ2mZr8Lka7ng3h1M5e4t5YBSNhbSVEe4dBJq1XzPkdnga8WsA4blA7
         enldgWNaqTvjHUwuEuZ8zTdyodiiex2GstukHEm8QqFfnaUL5b2Qp+86p01XKfBONkbv
         94+OWFKFNefSgIloF+EIod5O3TihXi4rkG8pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=qRaxhiyZE90m+amIVHIeCMA0LL3BWUXSOy1qHRMz/HE=;
        b=ciNyvgQ4VyLc9eYQXAc3MwZraxD+SIWPZUCmPbrO8dHmCNtj7THPiZfhk1EEgRz9K4
         bp+jxnwWzTEl11W21BO1aWhNIt2fderetA6OBXga4D6PULbq4kB+zptOG8Jlf3wTAv5U
         zHOiENUDcgrsxZRAdujAe4e/DpZITe4C9k5DwE+PiabVYQTFOVbunku7iSbk51bC7Lel
         ix6qX38DqRJbxh4wKX1ze6rxyRFBmSNexLgfwCJ1dM8rh9ODlHp4ytHz4q7N8xzsk2Jy
         qbD8P++Jp39i4mUXhQZpdJf2bIAUDuadZEP6YwSpWx4cMMdhsdom1YZncKdv5Q+44goA
         TqVg==
X-Gm-Message-State: AOAM530UtpprvMqs7NjXrzl8LvBmO5uzZg46RrRhJAOeHNCViSQuBzZu
        4dQJ5ostFCTFTnUzYfyaPpniJQ==
X-Google-Smtp-Source: ABdhPJx66j3Z3S4vye5sgwXdj+nfn5Pw1dqJE3BCIxshfgN+WI4IsNFGybEL3NUhX6uz2b9yZrS6uw==
X-Received: by 2002:a17:90a:69e3:: with SMTP id s90mr1129884pjj.130.1601106003310;
        Sat, 26 Sep 2020 00:40:03 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c12sm4540274pfj.164.2020.09.26.00.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 00:40:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200926045048.16175-1-tanmay@codeaurora.org>
References: <20200926045048.16175-1-tanmay@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: DisplayPort PHY compliance tests fixup
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, seanpaul@chromium.org,
        daniel@ffwll.ch, airlied@linux.ie, aravindh@codeaurora.org,
        abhinavk@codeaurora.org, khsieh@codeaurora.org,
        Tanmay Shah <tanmay@codeaurora.org>
To:     Tanmay Shah <tanmay@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Date:   Sat, 26 Sep 2020 00:40:01 -0700
Message-ID: <160110600102.310579.8458722739510072790@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tanmay Shah (2020-09-25 21:50:48)
> Bandwidth code was being used as test link rate. Fix this by converting
> bandwidth code to test link rate
>=20
> Do not reset voltage and pre-emphasis level during IRQ HPD attention
> interrupt. Also fix pre-emphasis parsing during test link status process
>=20
> Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
> ---

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chi=
psets")
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
