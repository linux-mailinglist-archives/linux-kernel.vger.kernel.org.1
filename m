Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC482864B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgJGQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJGQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:41:35 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2219DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 09:41:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ly6so3900241ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GI1cAXOsE/t15KcnaAvc99/boMACDyRO8mYHOjldBQ=;
        b=Fb0CA1opaStf4yD/GtbTBkGbV8KPVG9Vt5D94aNDICjpGtULc+if9DJEOOffn+6/T/
         suWooJsbNutRfoDr7jPZprctLnTwix/oWr9PyrLJQeYY8a/Uy9ZLXqXdGMRozJ0Bwn2M
         WQOQJgVMgVOuWxgJLJxS6OkS3G3EMbEJBCdrigEdKJtZDCGvG6SwU1f4CYIX+nF2Kj4c
         kJsMaYdeGK85CdLtJWtWG2u4A+06myFGVoAMGlzwilkzfuitSppMq4hUm6tfqtTkvtHR
         xNiPKGpFTH61g/84xOcSVtWIETZfk1fOOi6FhL/FOwzjh9e6PMr3cGrIMVnOnFAveDkq
         aqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GI1cAXOsE/t15KcnaAvc99/boMACDyRO8mYHOjldBQ=;
        b=J7qvokc4Fe4seNZf6Gkz+S+HUqv8exsPWBYSczx72zr5VSPJEKcQ4jdWnR7H8vzI61
         3grpoQFLBhfBuJB4WAT0+WaOtcZBn+KPN9VRgoIy44QJ3o7A/3jhTk2zWfNFTti/Me+M
         UidAq5hieLvLilqFddy5WS2XTq0q9Hjms/WWXqiV0EKomKyKD4Z2FuP35dt4n+nc1EkG
         /uo2oWsu0vy3BG+712wToBTg051ltN8d7ZO/soW0XPVHFjDHV26QaRDHOW/Aq39r0Od0
         aoltv23ySY+/hp6sVyCjwb+V2ZaZpeRgE2W6utrZtB+H6QJ4hCs/lCEhcLHg1dtDnEMw
         96Rg==
X-Gm-Message-State: AOAM531nTZRePRjUYctDMikADw3Se+nkbUKmV9hlIQclTvg9oIze0gcE
        toMXNjSCoF7Gdmkl9nxxWvLlyFtI1WA+3yroNQImol5zIgM=
X-Google-Smtp-Source: ABdhPJxo7VsTqVy+f1GtVsMNXbTKtiLeQ7gqxRAS6kOTIGFebJi9aONr/qTzDqut6RjVJhM2H0MjLjPoN2Fhpk6+DMU=
X-Received: by 2002:a17:906:5247:: with SMTP id y7mr4095745ejm.503.1602088893698;
 Wed, 07 Oct 2020 09:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201007161912.28399-1-steve.wahl@hpe.com>
In-Reply-To: <20201007161912.28399-1-steve.wahl@hpe.com>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Wed, 7 Oct 2020 11:41:21 -0500
Message-ID: <CAPp3RGrmuBbbSf8rgv-vLvW7im2sKgorj5K4behRaSJH4D7bPg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Some SGI-related cleanup
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Robin Holt <robinmholt@gmail.com>
