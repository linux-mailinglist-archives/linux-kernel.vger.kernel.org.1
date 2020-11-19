Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0892B8CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgKSH4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgKSH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:56:00 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CEFC0613CF;
        Wed, 18 Nov 2020 23:56:00 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id x17so4331850ybr.8;
        Wed, 18 Nov 2020 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OiHRsGcZg1w0E5ZjU76Blkh6IvdY56ulMPtY4im3OCw=;
        b=m69mxgT4zcQ1qpqO96S3lNt2gfYYwTzUyT+1dXwdMX10Y+LAAdK9ZFTi2hk4uoHsJa
         8OcA1PP2NjpGkH0eRLwB9xctSoj0vyFOMYY/RGpZjduXkvyVKI3+8ew8Gh4bYVHK6naD
         tACWA8SBJluD9pSqddkWPEhe/9V8XV/uxkzlIpKfYevTGk58pjv21ilyVfPKh716C1SW
         vc7fl2V1jNZ35dAWPTKrvk5ah3K9PauFpTkwwQIdVJXxfek1NDKxx4tToDd9OlT/Wc4O
         NN9hOtwzUyC7JNxbSFpXki9GvNIDFXOy3Xx7wen+U5iIRweQsxaCcTaSI68hnoPMn9R3
         uu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OiHRsGcZg1w0E5ZjU76Blkh6IvdY56ulMPtY4im3OCw=;
        b=tb8c9N5Vs4lFh7pt2Rip0EoT/Yr4KHY/dXpqMAW1F+XR0G2prRoxHoUz/7kGEbr5D/
         WMyNfwXEzxEdBHDE88+adpTYKxp7OOxdWlaGRD4Knt87OZHhwGoWFa837eltApdFsuBo
         yPK5xYrDFlGzpmkaijhnB92xZuqo8LbJFROmqQZ+kBnufqz36/Uvo7AvtRWP7X3uu7KO
         fMn0QXcT9rLKijnf4Qb+wqvdnRFMAWlznnnsl8Os2cnUsPnTlKTkQsNyeuswy6st3hF8
         f6zLDmbq7N5AKkaSXizUeZcpqY2VAgkkL7cGQbY0XOgxaOvLqPR1dT0TBUDdCD0Q0qYP
         fvtg==
X-Gm-Message-State: AOAM533mW2wPR8tjmSl+KEKrBvycCzHcnk8n1vhfYlWOxRQBg2YtyNcx
        HFNVqwAMJau/OBNPi8VMGHyrd66VuGnj9RBtlcw=
X-Google-Smtp-Source: ABdhPJwlInwKifhXedN+JA79ksUpobBcF81Kk9oujdzZ4rqQzXymVQ9bdU214fdCje+S4aS2jnVr/CN9QkewmNCTq7U=
X-Received: by 2002:a25:7711:: with SMTP id s17mr14202248ybc.240.1605772559987;
 Wed, 18 Nov 2020 23:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20201113113423.9466-1-zajec5@gmail.com> <20201119062720.GE50232@vkoul-mobl>
In-Reply-To: <20201119062720.GE50232@vkoul-mobl>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 19 Nov 2020 08:55:48 +0100
Message-ID: <CACna6ryH6Ptdbs25Uv_ySYRXTaWsG4+dz2LD-5=By1_31VWEyQ@mail.gmail.com>
Subject: Re: [PATCH] phy: phy-bcm-ns-usb3: drop support for deprecated DT binding
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 07:27, Vinod Koul <vkoul@kernel.org> wrote:
> On 13-11-20, 12:34, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > Initially this PHY driver was implementing MDIO access on its own. It
> > was caused by lack of proper hardware design understanding.
> >
> > It has been changed back in 2017. DT bindings were changed and driver
> > was updated to use MDIO layer.
> >
> > It should be really safe now to drop the old deprecated code. All Linux
> > stored DT files don't use it for 3,5 year. There is close to 0 chance
> > there is any bootloader with its own DTB using old the binding.
>
> Applied, thanks
>
> While applying, it gave me a minor conflict, please do check the
> resolution

Oops, I used your master branch instead of next. Waiting for your push :)

--=20
Rafa=C5=82
