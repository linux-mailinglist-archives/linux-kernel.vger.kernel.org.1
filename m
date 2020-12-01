Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D046F2CA6DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbgLAPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:20:50 -0500
Received: from meesny.iki.fi ([195.140.195.201]:43216 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387678AbgLAPUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:20:50 -0500
Received: from [10.32.112.20] (unknown [85.134.33.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tmb)
        by meesny.iki.fi (Postfix) with ESMTPSA id 35CDF205A6;
        Tue,  1 Dec 2020 17:20:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1606836007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q14FNmAeDp4Ro+7AHoPqgM/pFoG0Bl0GKr6ZP04YkI=;
        b=wS+vgeOL8qjYiN/RryToKSzPyCaHi0o7Oj8LIlhIdf51Pn4amtJT2CSPQBGmLlaG5hRSIT
        bCcxt1TwqKn6iNg7GQ7ESyzcBWmsKE7LEzkDiOLLOU0LY3ri+1Zk2UBPqxX7az4AqZuHPL
        aTWdMysIGZoMSbPh0gnw12SjqbohHGQ=
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Backlund Thomas <tmb@iki.fi>
Cc:     Jonas Malaco <jonas@protocubo.io>, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
 <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
 <20201128113524.24f4f56f@monster.powergraphx.local>
 <4917cc59-aa35-7fb1-d2d0-75039523816f@iki.fi>
 <s7R3iA2S9eDO5XZ9rdqzYCvN9eu2DaNKUQCmSn_4XxsrxD-93-gtY9DFGxbthP9CVsquOXoocwbZfwNKo7XLaQ==@protonmail.internalid>
 <20201130154915.760923fd@monster.powergraphx.local>
 <6185cc04-da71-5b68-0bc8-931af6fa2dc9@iki.fi>
 <-je9uwScwR9_PkQlpZgHYO98IHe2gIxkIcGfmhyqk72ZxZkU5E8T_G9YKmPPXTQXDOTnQD5Dah5cAwJnbkqWbA==@protonmail.internalid>
 <20201201082438.515bb23f@monster.powergraphx.local>
From:   Thomas Backlund <tmb@iki.fi>
Message-ID: <05ef2c7d-1deb-12a3-65d4-f5585a3a9670@iki.fi>
Date:   Tue, 1 Dec 2020 17:20:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201082438.515bb23f@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: sv
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1606836007; a=rsa-sha256; cv=none;
        b=xMbyXlSZh0bPLrt47w32jz+mQGkokyg2TIDGMIunjYcvJ8NYoazrCzBSsSWYDoxa9lA96h
        whXRkOXZFZvCjzsxTYysa8Yu8gSXtVw940pjynrrWLToH4xwR6redqBSzsrmyVuJGtUDuW
        gGZouwd29A4MVuZhq7L2mYgQRr+aAJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1606836007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q14FNmAeDp4Ro+7AHoPqgM/pFoG0Bl0GKr6ZP04YkI=;
        b=ZmFDlPq2BlaHedqaWVv3Z7XRSw6adlSSYyueFXG9YsfQlfkmj15PSYQQS9gGg06Ma25HnN
        cSbvzmmBKL6ePlE3a3+u8Zc4i1LLbpvQJEotQnRfI8dS5bc53zS7pZgZgPK4Uf25NWI+om
        BOpWg9A9ANgzY35evi5/qNDK09r5iKY=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tmb smtp.mailfrom=tmb@iki.fi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den 01.12.2020 kl. 09:24, skrev Wilken Gottwalt:

> Thank you. Hmm yeah, this dongle has no usb hid part. So this driver will not
> work with this dongle for sure. I already have an idea how to support all 3
> series, though it involves a lot of testing. I would provide a github repo
> with tools and test kernel modules if you are interested. But I don't know
> yet how long it will take, I work on other stuff which has a higher prio.
>

Yes, I'm interested...

Just drop me a note when you have something to test.


--

Thomas


