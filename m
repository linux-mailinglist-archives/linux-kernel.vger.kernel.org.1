Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12CC2F888D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbhAOWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbhAOWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:39:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607AC061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:38:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y12so5887470pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vzqinN2+UhVFxQp7UQhMoz+Hz7a/jxePWrrSbiXEW1Q=;
        b=SUJkDbkeqFa0niCmchghzTPcQISva7+HwlO0JDlJ3g+Xo6ppx1eA7gMlxtQC+qbJCr
         /Fu5llikLVPkimI3NGMVYk/1NPGfbEZmGvMIoW+B8Q5vBjeQUoJdiC+r23szudiG81jn
         AcNVZIp7x0NuyJgyfxbuva5b8eViIWiFY7gQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vzqinN2+UhVFxQp7UQhMoz+Hz7a/jxePWrrSbiXEW1Q=;
        b=dPSVb/rs77LBC8yrZtYISvKv2KjAtUzVP2yZgFuFeFutZELiOPpfsNZE0ifI08v7QS
         O6tyktsfcwYM4qhDHkOMu9JyIggXmpX7lmsWZNOw7q2OtfoMLgA23cvrvWbS4NrFyc1B
         sILvJoLVPxDwx0mc2gU4O0gSVN/Qbq10+ZSOWiZBeKVNHBZ0DntINtnOKNR2fu3dFdGd
         gQvMIbyC/e8PxZrvnYO/HdDJi/KbBE2WmyO/e7zWF04MCzSh6bIEFh8SF9/03W/rBnN9
         uzFJV5lTbEDkhY8RxbU5EliORhkoEH3FO+J4hgaG3HZfX9XDjDmcURaHYkQEAn7/fWOg
         vWVA==
X-Gm-Message-State: AOAM532n3mNIJWRMuOCzyr8Slw02ISrFlOE06ijRm5p/TOPJPdaHrhsI
        k7nUx5w9DmKXKLXv0n+pGFqyUQ==
X-Google-Smtp-Source: ABdhPJzutLbitTSWzkEsDp6ySaoZVq3QJzhDCKX0WAWNMrBkne9/L167nB5ZFL0lsuvZCgBeXyEAkQ==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr5548341pjb.116.1610750319851;
        Fri, 15 Jan 2021 14:38:39 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id t15sm9303405pfc.12.2021.01.15.14.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:38:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115143555.v6.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid> <20210115143555.v6.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid>
Subject: Re: [PATCH v6 2/3] ARM: dts: cros-ec-keyboard: Use keymap macros
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Fri, 15 Jan 2021 14:38:37 -0800
Message-ID: <161075031796.3661239.5637804199088801218@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-15 14:36:16)
> The common cros-ec keymap has been defined as macros. This patch uses
> the macros to simply linux,keymap in cros-ec-keyboard.dtsi file.
>=20
> This patch also creates an alias for keyboard-controller to make it
> easier to override the keymap in board-specific dts later.
>=20
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
