Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D5302C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbhAYUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbhAYUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:30:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:29:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id w14so9074408pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=DCEP4gnVGuX122R3MmiG4Mh/J3FSnjqd1Q2nTdmlp1A=;
        b=czO9lF4xQAIchrxIYbplkf7nO7CKPxP42s+chuaVhLevnBowti/kngBiCN3dHGZNMo
         EPwcaCxAeCPYb6HjKn+SA+aqJnxOE4xGXRzTL5iCSSmkVbW8qZtKFtX/nQXl0qED0Huf
         lFUH1SxNF/RYJrbSxmYPLfRwv2m8dICrDWmCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=DCEP4gnVGuX122R3MmiG4Mh/J3FSnjqd1Q2nTdmlp1A=;
        b=s3NRgseD1VThFKO4vpIsS+69pUHHR3EgpXrjJ1rCyh5ArzHklLQlDSPu+9w6j6QPE7
         5NZ0Jh9s1dFwkEo3MN77mis83nYa3RfNr3ve62c6mpNQLZbRk3ZGBDVswhyGM57IYkIR
         bhhRISIS5vdN818m31tJaAuBtq1mKXUF6fC0zMcUrRxAAsTMS1Y9dPcSO34/Hm6YwK8R
         q8J9FOI4sqiKemKY85uAmmecuCBjX8qbt81RCludYB+Skog6Le5xqfNyNqjAhLnFm1iL
         MH5NOPzgsHg70Jqcy6k6JEPNU/HYyL7WLyx+ANB4YGumAof0pD+eA3GNOTPQmxU84a+7
         GipA==
X-Gm-Message-State: AOAM533G3vVWSLyeVVEtMwfWItO5d5CfaGNunjIPxTGGWhIiMf1Q7n/M
        4iuhhnpqbxqKgtcRhBRS41u+5g==
X-Google-Smtp-Source: ABdhPJypmTAXXNM6u+Jcdgi8ZKzmQ99oJF1tF2CC/PL6E54yVkqgPThSD13OYhBvfX4XNr3XcchQSA==
X-Received: by 2002:a62:36c4:0:b029:1b9:7ca6:5d6b with SMTP id d187-20020a6236c40000b02901b97ca65d6bmr1913863pfa.43.1611606569745;
        Mon, 25 Jan 2021 12:29:29 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id t206sm17377408pgb.84.2021.01.25.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:29:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115144345.v2.5.I3c01f3aab8335cb509da7009d8938c1a27a266dc@changeid>
References: <20210115224420.1635017-1-dianders@chromium.org> <20210115144345.v2.5.I3c01f3aab8335cb509da7009d8938c1a27a266dc@changeid>
Subject: Re: [PATCH v2 5/5] drm/panel-simple: Add N116BCA-EA1
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Mon, 25 Jan 2021 12:29:27 -0800
Message-ID: <161160656766.76967.8403671583757705105@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-01-15 14:44:20)
> This panel is quite similar to the similarly named N116BGE panel (the
> nominal timings are, in fact identical).  However, let's add a new
> entry because the full range of clocks listed for N116BGE aren't
> supported for N116BCA-EA1, at least according to the datasheet.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
