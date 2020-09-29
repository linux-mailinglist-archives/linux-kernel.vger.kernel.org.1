Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2968527D91D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgI2UmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgI2UmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:42:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AAEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:42:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b19so5138867lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3Ga+GXaHWqM1SSiAmGnTzDtW87dgB5SS1X2AtSoYXA=;
        b=w3/iDm2PFW3fbDKMGpQOBaH2T4oOcHIPglQUCvY49mVadEh7l3xX9LxvvAFVgEbOfx
         A/kw9hjH+4pwryFRBXDgHY4DXDO9nhVP5elFWl0TfKEeKKVDHGWDq8kbQKE5wljX+UAx
         6SfF5PQgc/mvTGmOBg91VkdgfSIbFeCaPJV4WqQsJx1gaCsghyMjXhgiZq7/eAyDdZhi
         qw/zGDx4zcThur7wlLxbfu6xPVryI3FdgeQJR27f+4K+jbdA2RozGLBwkWdTysKYFREg
         vD2SoT9tR2TqsDJ/6+fMt9Zq8drS387LO+OGB2nAifcaRoZs6Eps6nMM3Z15k92WetkA
         6siA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3Ga+GXaHWqM1SSiAmGnTzDtW87dgB5SS1X2AtSoYXA=;
        b=OQoZY4uXdlZJ4H/Jv/0okY4hoUfw/TMExOuOQdk6nNsYTI4yYa5Y7MGX1Ldn1sFuaf
         FrP1XB2PlKITD3pJ6W4iWuvh9gvSp2+1SV8ZIsiaKUOCYgNZBZl3VmiViQMdnhITYPIy
         SJ1aHKIm0uKsYIFBqesEVrKWPyxYkEHKNpku0CJr+MetPd++F4XO4UpAZQKj+bTL6bA2
         HD5aWLEt05jBb/eDEC/tj8zq3v5V35g02M9b0u3rEvnQm+3iWJWaDjsgI0yr70QPCFeB
         mhTjOMTYRWoQieK2mCIgIqHh8YBEBfayKn6XRGPG7x0dXU1hE/TyAlE0RAuAb/9IC+fB
         6Fhg==
X-Gm-Message-State: AOAM5318e89/h8MYpGBSziwQZ/I4lq887U2Ebw1R1tLXFwzN45znJkN1
        RBFIH+4AXsmUrOoRcTfhhN1ZM9ktK4zCin1jK9/PKw==
X-Google-Smtp-Source: ABdhPJxlHO8fgKKXLbQPn+RNsP1AA22vJBqXR27uo8CmPTrI41l9k6j6HehIx/C6LRgRROAFD9skpfhD5m7ty2v4URw=
X-Received: by 2002:a2e:9b15:: with SMTP id u21mr1839815lji.283.1601412124938;
 Tue, 29 Sep 2020 13:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200917131257.273882-1-eugen.hristev@microchip.com>
In-Reply-To: <20200917131257.273882-1-eugen.hristev@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 22:41:53 +0200
Message-ID: <CACRpkdYuCtS-M3LXOL3u3T1faH0-G5gHyjHVbeXPrhvFYX6Y_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: at91-pio4: add microchip,sama7g5
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 3:13 PM Eugen Hristev
<eugen.hristev@microchip.com> wrote:

> Add compatible string for microchip sama7g5 SoC.
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Patch applied.

Yours,
Linus Walleij
