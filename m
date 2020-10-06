Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5CE28438E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJFAxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:53:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6EBC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:53:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gm14so722811pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 17:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=VpS7X6EIHmnMVFG8t95f4eTiEJylc/0BC3yBDzUejrM=;
        b=lOpQopCjyEt4Ltl65nTh/NLJY26jMqDTYMrllPZw2VWtPaPoICadSHYsF7DO7J7F63
         oWM0C2zCCdV1kRPg20jntFj067/ze5WrdoZLZYQqkxwFqFL9fv8stApj7Hy9NxIstieO
         31uV38KLejd1JrJdu7x4DYuyK04uTmGBfbLuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=VpS7X6EIHmnMVFG8t95f4eTiEJylc/0BC3yBDzUejrM=;
        b=cY1ZoZmOQN49Cm0hfIoVOHoF0wPEzWwQkqIvIHKr6uZdffudB57Gci6VUJSRizNNKW
         yQQvR6T/3hjuy/wNSR/SeL9Ld34qZTRIJckIBnqVuiFKA0nqp9vuUDJb0xeq1kTAQhuT
         sk0KspkChFpb44cK/4gSfoTI+wIlAor6IjUi4EQAE6WPnLoR64epeizAnB4+X+qu/wzq
         J6Nn3hrrakWO1jDrwOUApB4R1weUFaz0mVtxzHWhzUjomQV2Fz425Pklx82jRAA6BCwI
         gIih4GjA5s3KjlSjohsCKxwGq2yLJE1vAtW84nxRh47SI6HYQQJKtG93bN1vIHA51dpg
         5iIA==
X-Gm-Message-State: AOAM532FM+onBk2GiC8WnZD4mJShUcbTtcWq8oTvO+aFmeoUgD01VYZt
        GjjveNh74dhEDsdT5iNsR3jy5nWjbEj0ng==
X-Google-Smtp-Source: ABdhPJwcHOjVjxdDby4/cVjBb9nbVM6zGtxqizkwy+3JzYP2vBMd0N90sEUJqcd/RzTbya7as0iiVA==
X-Received: by 2002:a17:90a:c302:: with SMTP id g2mr1996266pjt.173.1601945588397;
        Mon, 05 Oct 2020 17:53:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b22sm806470pjz.27.2020.10.05.17.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 17:53:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0de13a805820e4d73b8f906682386845@codeaurora.org>
References: <20201002220919.17245-1-khsieh@codeaurora.org> <160169114309.310579.5033839844955785761@swboyd.mtv.corp.google.com> <0de13a805820e4d73b8f906682386845@codeaurora.org>
Subject: Re: [PATCH] drm/msm/dp: fixes wrong connection state caused by failure of link train
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@gmail.com, sean@poorly.run, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     khsieh@codeaurora.org
Date:   Mon, 05 Oct 2020 17:53:06 -0700
Message-ID: <160194558634.310579.5267169787902306024@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2020-10-05 11:02:10)
> >> +       dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
> >> +
> >>         dp_display_disable(dp_display, 0);
> >>=20
> >>         rc =3D dp_display_unprepare(dp);
> >>         if (rc)
> >>                 DRM_ERROR("DP display unprepare failed, rc=3D%d\n", rc=
);
> >>=20
> >> -       dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
> >> -
> >>         state =3D  atomic_read(&dp_display->hpd_state);
> >>         if (state =3D=3D ST_DISCONNECT_PENDING) {
> >=20
> > I don't understand the atomic nature of this hpd_state variable. Why is
> > it an atomic variable? Is taking a spinlock bad? What is to prevent the
> > atomic read here to not be interrupted and then this if condition check
> > be invalid because the variable has been updated somewhere else?
> hpd_state variable updated by multiple threads. however it was protected =

> by mutex.
> in theory, it should also work as u32. since it was declared as atomic=20
> from beginning
> and it does not cause any negative effects, can we keep it as it is?
>=20

It does cause negative effects by generating worse code for something
that is already protected from concurrency by a mutex. Can we make it an
enum and name the enum and then add a comment indicating that the
'event_mutex' lock protects this variable?
