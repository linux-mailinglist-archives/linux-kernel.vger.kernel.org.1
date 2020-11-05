Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A61B2A7AFE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgKEJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgKEJtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:49:08 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFCD21D46;
        Thu,  5 Nov 2020 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604569747;
        bh=QBR2Tc/9WNzTItkRBAt9IIJdb9EsfXRdlj3TCpicmg4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ux2MHWMezbdTAo81cgm1ldp+hleWgwwW1SttCwLqTfOlLCiDBDKGSSfYGNkaM0b9W
         M2JupBXyoHhxYXzW4mcmGnlFXoLNCg0oyI1Rf3AztWdDhXWtRgPj3RRDyj/cUmewRf
         TSxUIaP7q7NvhBXJ4p1LHOsMpauLbRD8w0dxGTsE=
Received: by mail-wm1-f50.google.com with SMTP id h62so922745wme.3;
        Thu, 05 Nov 2020 01:49:07 -0800 (PST)
X-Gm-Message-State: AOAM5337p3gXvOPcsVILJyqjg8RZoj4NEyC0l6XdqCVSpgGz3Jgoo/A/
        N+cQzK1MgDaFuzNbcl9cHQiJUDxwzuimyi8G/hQ=
X-Google-Smtp-Source: ABdhPJwAVTDv6MUiz/sUTWF6rT7rByTwI3xxgju//qMYNu5dRGzqQlZc8Ge4oUCahSSPXmbn6Zo+Hvxg4DXvv4ReSCQ=
X-Received: by 2002:a1c:b746:: with SMTP id h67mr1726797wmf.43.1604569745838;
 Thu, 05 Nov 2020 01:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20200930105442.3f642f6c@aktux> <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux> <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info> <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com> <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com> <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
In-Reply-To: <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 5 Nov 2020 10:48:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1HtyrkMkbEr+CCbsC0kpTjEfgNZhir2SvG2tR1ORFMow@mail.gmail.com>
Message-ID: <CAK8P3a1HtyrkMkbEr+CCbsC0kpTjEfgNZhir2SvG2tR1ORFMow@mail.gmail.com>
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 6:05 AM Brad Campbell <brad@fnarfbargle.com> wrote:

> Appreciate the feedback.
>
> This would be the bare minimum based on the bits use in the original code. If the original code worked "well enough" then this should be relatively safe.
>
> Tested on both machines I have access to.

For the patch:

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'm glad you figured out something that works. This all looks reasonable and
it makes much more sense than the original version that I tried to clean up
just based on the code comments but without having access to hardware or
documentation.

       Arnd
