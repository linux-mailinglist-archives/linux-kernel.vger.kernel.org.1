Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3D24E470
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 03:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHVBUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 21:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHVBUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:20:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631A4C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:20:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v15so1795793pgh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+grt2lq7z6Xfwjj3obNToZK2iikIyYEevhepcH8Y3zA=;
        b=K5ahScP0ndnTcA/McyN9stxj4UZT171xHGRjMWbB5W8cDeTg/1iLTqmTGsaqDu0fiK
         rfF4DBi8OBRUiMAZBtP8Qx8amcB9RrJEwsC86I3XR89LNYY/IO64eHSPHRS+LFrZIFcj
         HxA4U4qMiFI5/bRQZbT4d6+Ss8gvk4W2oqZeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+grt2lq7z6Xfwjj3obNToZK2iikIyYEevhepcH8Y3zA=;
        b=cGPT09tzQWSuRFGSUnxoRRComdgNyy/gHD6hzA4dSeK6Y0CpgfLO/UL/JU2c9wy3hR
         aoQZbvLQgdsesDCTrEOhupzLhJmo5E1RnAnIPOcnahXsBAeyWOF2u+I0L5QikLP+aTGp
         BzJlh39jxQSnvGyEj7oFsESb/QgSYTLOXK9JGOTI0ealV0JACAbsKrLlWPtpHKhUiesF
         3sTlo3T4WqhE6LxPF3zB24MSYHDa0hGnFqAKXKpaZ8vAnqaZZJU5oIaYBHkJ0By32PhY
         GIdbKCp4lGx8Ob7CKSuAruthte+cMvDzgZh/tgM/WYxSPLABveSfqI5F6H7/YYWaOmAA
         Ojbg==
X-Gm-Message-State: AOAM531hdvo2MKQFHm3FcLsFS4faPo2jnekCS9ezscc9kDkez8kuVrkj
        CDQL95s9kaI9DNE4mzwBzBCWZg==
X-Google-Smtp-Source: ABdhPJyy/NybCCraoY2LInilmxjLXa17wS6eM5dZSb+zo1iqkBgmWudnyHSBaYln4qN66CDjiBjOJA==
X-Received: by 2002:a63:4b10:: with SMTP id y16mr4067214pga.93.1598059220930;
        Fri, 21 Aug 2020 18:20:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u8sm2912191pjy.35.2020.08.21.18.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 18:20:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200818163119.715410-1-robdclark@gmail.com>
References: <20200818163119.715410-1-robdclark@gmail.com>
Subject: Re: [PATCH] drm/msm: enable vblank during atomic commits
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Date:   Fri, 21 Aug 2020 18:20:18 -0700
Message-ID: <159805921877.334488.15322995741035336582@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2020-08-18 09:31:19)
> From: Rob Clark <robdclark@chromium.org>
>=20
> This has roughly the same effect as drm_atomic_helper_wait_for_vblanks(),
> basically just ensuring that vblank accounting is enabled so that we get
> valid timestamp/seqn on pageflip events.
>=20
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org>
