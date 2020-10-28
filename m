Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3729D898
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbgJ1Wer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbgJ1Wc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24860C0613CF;
        Wed, 28 Oct 2020 15:32:57 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 96A0CEC2;
        Wed, 28 Oct 2020 17:46:25 +0000 (UTC)
Date:   Wed, 28 Oct 2020 11:46:24 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Theodore Ts'o" <tytso@mit.edu>, Andrew Lunn <andrew@lunn.ch>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.com>,
        Jean Delvare <jdelvare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 00/32] Documentation build fixes against v5.10-rc1
Message-ID: <20201028114624.4a65f35e@lwn.net>
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 10:51:04 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This series contain the patches from a previous series I sent:
> 
> 	[PATCH v2 00/24] Documentation build fixes against next-20201013
> 
> Plus other patches I sent later, against other versions of linux-next between
> 20201013 and v5.10-rc1.
> 
> It fixes most of the remaining documentation build warnings.
> 
> There were some changes from v2, as I changed some patches due to the
> feedback received, and added reviewed-by/acked-by to several of them.
> 
> After this series, there will be just 3 warnings at include/kunit/test.h, whose
> fixes were already applied by Shuah via her tree at linux-next. Hopefully, she
> will be sending it upstream anytime toon. So, I dropped the fix from my trees.
> 
> The vast majority of patches here are also on my linux-next tree, as my
> original plan were to send them upstream by the end of the merge window.
> I'll drop from it once they get merged.
> 
> As those patches are fixes, I guess it should be ok to get them merged for 
> -rc2 or -rc3.

I have tentatively applied these, minus the DRM/JBD patches that have been
picked up elsewhere.  If all looks good, I'll push them up in the
not-too-distant future.

Thanks,

jon
