Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB162D719B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405536AbgLKIX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392379AbgLKIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:23:00 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61BAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:22:20 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id u4so4209058plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6Vk9PEhckIFeJeV3T2csVzC/4hZ5Nm6hYZgtfaICDA=;
        b=NZoHGBfFZCPH+tloYAYuUqfKxLylb5zcBYvO4jT0Pi22BR+CcJQbe+NdTXADIwVpCn
         blOOkLG4rbh/EKYZ3Stzr1/L1bWKABCl3GeQqgK/wVyrSz1yfD8pdQjKG9YCLYzFmCIO
         0VVfHPpyeel5qsGGJgG1Zg2mnyZA4IPoMcKlcnD6F9ac0GQhS6iWMZXQlq0a+HJGUoeU
         iM2nN2EvzBnXPfbHbuHpBwgmjwUgVJwDAKSjdPrXjjJM1Vcs28aBtuTnJ4PA5vULu3Vr
         hJkuf3KSYFHqRNTghIlnnWIxCqgNq1YDvd7VedryIUsiY7V/ySieflo9yVml95dyS1aR
         kItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6Vk9PEhckIFeJeV3T2csVzC/4hZ5Nm6hYZgtfaICDA=;
        b=lwEEpnYOANWItfcZdMMECXll7zPeGhW+8LhFy+RINzLsTOfX2R4Vb1XldGWEZIG5ZB
         J9Hxv+fohRkGuW9/00dPVrFfik63hR6s9TRoEzovsfk89fRJg5O5JfyCm5DG3oSINMLW
         b60uWhZwPVTFLfSvp+odM4W70iOu5l1gCE9FSPhVXMVtqIoRvyY6ya35q7U7cSqn4BX4
         iQCi7LozoaGp5mG/m4gsocKHBkDIVY4KT4sCaearojdWN0tDrNsboL3Q31tvkPOBs/HS
         3z1tspPav8/cuM1XyjN7rnUQZ4H+ccd24SPcl7hjui0a/1qx1shTD/0n3kCz2FF7TwmU
         temQ==
X-Gm-Message-State: AOAM5317E7SepuWOmaauPsm8N5utoLXN2MLA/u9rC/c7fpxT4J/1lGB8
        l2me4yEZbDorsqvs2yhXs+7GmN+kD/Q=
X-Google-Smtp-Source: ABdhPJz0OXsY4hWNp6vWnwtFjLTRqbpWYWPLOu9jsX+FaH4/yqzwKP3ntketS8LXpKGVpJcKO/RT6w==
X-Received: by 2002:a17:90a:fc8e:: with SMTP id ci14mr12264927pjb.181.1607674940239;
        Fri, 11 Dec 2020 00:22:20 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s17sm9135453pge.37.2020.12.11.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:22:19 -0800 (PST)
Date:   Fri, 11 Dec 2020 00:22:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND PATCH V20 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
Message-ID: <X9MsOOX8Tq8hchRS@google.com>
References: <cover.1606320459.git.Roy.Im@diasemi.com>
 <e2a01173699486519f8da85b9283c6af8481fbdb.1606320459.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a01173699486519f8da85b9283c6af8481fbdb.1606320459.git.Roy.Im@diasemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 01:07:39AM +0900, Roy Im wrote:
> This patch adds the da7280 bindings doc and driver to the Dialog
> Semiconductor support list.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 

Applied, thank you.

-- 
Dmitry
