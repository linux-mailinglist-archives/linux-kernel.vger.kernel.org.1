Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766862312F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbgG1TnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgG1TnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:43:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A27C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:43:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so11550183pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vnxwi5iPCJkQKF4flCKDFiMcmGVkTk/FZPhjrVn7vQ8=;
        b=lGILnOI2EA2ePNYpXzRAJhVcrhFB5Z+3mS7RTR0wzoPvklGepKua58mr9TZ3zuL0VU
         dYg64ioAyhPP6TnZY+ZxqgWDb5liZYowK2t4+fhaQCN+o5WeoEU0z4A6AXz1+4TQ3fnr
         Zbge8OACGr5Fj8DXtHimT1BBBOOPSv4jI1IKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vnxwi5iPCJkQKF4flCKDFiMcmGVkTk/FZPhjrVn7vQ8=;
        b=FkjU1jANG+er3qh50O/g6ktNKOqzLIlGXvAA8cQZtsnGxSQnqj1XGU+O6uzMXNMDH6
         WuJFwTNJwoilMjAKNX9t1jNf21AY7yA6Bub17lW93NrNlDP1GFLx72XMpSl0YNIM2JF1
         pbhUAnW+/G2qm6hqCt9NUXNXRjhkiltQR9tdccj7Xs7cSrYvUW7+EAl/slHPnm2FPTJ8
         VpQQpUjoS6TrBmzmUSwOcSrsnGZ0tJEoUjSGzZIrObejJxkaum4LLpBYry9CmefpkRp6
         Q9hy9G9sV0kN4JG9AHUaB72a8TciPaIcAvpOq3vfjUYYZbmdaaJlnGeQqz66MqQgVktX
         /Ykg==
X-Gm-Message-State: AOAM530xX34BVYmM3hyYvqHc1ulMElbWKU75Mf2KtnMBmuyaK9UJRLpF
        /UKE0iOBqMta4CG3pFu8+iVf9w==
X-Google-Smtp-Source: ABdhPJx/Gpp+X34yyUGrc2pTEF69GOO3vQr5iwhFpQeyJ7MgTI61ZKxOdL1srQX1mC2VDW9ZhI+mXQ==
X-Received: by 2002:a62:2e45:: with SMTP id u66mr1993692pfu.121.1595965380254;
        Tue, 28 Jul 2020 12:43:00 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id o11sm19315046pfp.88.2020.07.28.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:42:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.2.Idb6af9292f18f54be0b62cede52b481063738707@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.2.Idb6af9292f18f54be0b62cede52b481063738707@changeid>
Subject: Re: [PATCH 02/15] iio: sx9310: Update macros declarations
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:42:58 -0700
Message-ID: <159596537832.1360974.10421899531703700889@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:45)
> Follows spec sheet for macro declarations.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
