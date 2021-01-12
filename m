Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449632F39B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406721AbhALTKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406476AbhALTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:10:05 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1526DC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:09:25 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b64so2855723qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CPfEryF2bxPOdgxHkNjvHkSKCpA8G96wI04AOG3xMSg=;
        b=Ph1/Gxgy/41uF4BAAfVDKy7+imzx904TvEw+Eu/WblDKtQtdri1X4MDaStPM7awQ7I
         sOI/tgXlhTD39bLtKzCH3BBetYGzwkHWCn420dJExppM8vIn63xtrRpMg2cfcnmmhuKC
         rruw5KY6mTE53Wkxicns7eEBwcy2BPkue5zB0u3bN/gZOYSLNuHc94DIZoqWz4bdnCnm
         osZp+ndQyIlh3Zqfh8yn/oQgYOgWayRSBaeczRwJjpsm/qa1CI6ReZDOmnulR63X/ATQ
         fHCWmB74oiCx5teGkpmHMmgnXFa53TQVBafdSCGjtJk3YnEsf8id6sWiWMyADr+7fFrb
         f8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CPfEryF2bxPOdgxHkNjvHkSKCpA8G96wI04AOG3xMSg=;
        b=YIagY/eQUozZYMioSIvxtFL9JGA6Rorlyj+KbmFl4z+Xyd3/jXyYqPiYHJwzzM/4sz
         eqBxpvtYotTAaOtwXSzyx9hd+cMkqNfUQVB41U5FQVnJIA3FO1SlV+iQ6lDKhQDdWbjs
         fX0IMAEtzej5DD8OQnY9BNK0f5Dmvka9DufRSytomLzu4u8Rh5Byf3igByLZbIFTY8Pa
         73Xi4t7Pa+OKVvGWVpKUqRgoiE4SUIV/lqv5BAclc+RiNdq25AB/Wap6RVkk5MLorl73
         c0kV+XM6ANUECkKCbH8u962QsStPRYydRfm0Eq3NgP290sFNc9dNFfsIMmul2FfuUDN9
         HRbA==
X-Gm-Message-State: AOAM530Zeb7t8ZCcrl42S80NDbB413sNId0YiEOW+f/TQF8eQzn1Ax4c
        JKzqY+7798aAcKHFVF8DcqSU2fJnR1cOVw==
X-Google-Smtp-Source: ABdhPJzPgfw/zVoqhZTuXj+3LsvbWpph1NVpC1slqYO+oR5yTcVJwoUscYt3sisXvbLe7akxa/MdDg==
X-Received: by 2002:a05:620a:10a8:: with SMTP id h8mr821484qkk.315.1610478564017;
        Tue, 12 Jan 2021 11:09:24 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id v4sm1629295qth.16.2021.01.12.11.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:09:23 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:09:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20210112190921.GA3561911@ubuntu-m3-large-x86>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
 <20210112181949.GA3241630@ubuntu-m3-large-x86>
 <20210112184848.GG4646@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112184848.GG4646@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 06:48:48PM +0000, Mark Brown wrote:
> This is a random warning fix, why would you expect it to be sent as a
> bug fix?  This is the first indication I've seen that anyone is seeing
> it in mainline, in general the people who report and fix warnings are
> doing so based on -next and the patch seems to be from a month ago.  I
> don't have this in my inbox so I assume it's applied already or needs to
> be resubmitted anyway.

Well, I consider compiler warnings bugs. I have had plenty of my
compiler warning patches sent as bug fixes for an -rc. Furthermore, this
patch was sent three times by different people, that should give you some
indication that people are tripping over it.

https://lore.kernel.org/alsa-devel/X9NGQaF4pmK8oUAF@mwanda/
https://lore.kernel.org/alsa-devel/1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com/
https://lore.kernel.org/alsa-devel/20201230154443.656997-1-arnd@kernel.org/

The first version was sent on December 11th, it looks like your pull for
5.11 went on the December 14th, then the second version was applied on
December 16th so I figured it might be destined for 5.11 but I could not
tell (your for-next branch is a merge of your for-5.11 and for-5.12):

https://lore.kernel.org/alsa-devel/160813397775.31838.8934909997692637790.b4-ty@kernel.org/

Cheers,
Nathan
