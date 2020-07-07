Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02BA216A77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGGKhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:37:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44358C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:37:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so42755420wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mf3pdpNIYNXuepMWI1ZHXgBTgUZ+8BAmloxxPTENvW4=;
        b=N9v65sF4/0TFzZxvu1mwNmZUyPsKVIz1bvlkKprtt6x1BOWiWIsW6T9PJlF0Bro0Us
         mv5kif1e3dop0XL82JEO2Sycq7Ena5HyXwiOMYNWUxU6FARVX9tuEQw7+v1FXZb+r6Zy
         c+Ja9NnwvnSzNLPDLl1tb80wcWcNhEAglvbMpM/wQPfxLDly4hniWSgKnQvBiAHs4csm
         RxT69psZIJsDKuYEpbIUVCS7ghJ5iYDRjFqWrSB2uxm4qKon5cNJRxoaBRzUZfHPrAcN
         yqG7IYc+n57t0HzS5FYD9iPTxWn9fMNXsgguyMu2LO4i6tevw5p1ki7MvCyg7MkvxZxl
         J9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mf3pdpNIYNXuepMWI1ZHXgBTgUZ+8BAmloxxPTENvW4=;
        b=WrV6owLnHcJsUZk+XFM29MmovKVbVh/sipwzFDnqYehpN9PQSe6asW0LEHcmp1mfJL
         Rg9uVSnglJQfAdlIfOYC961XFG0RimemeBQSio1DwCruIVoX8OSdzZthqOcG/OmBdAVq
         LxAN/R4jCi7EwO3fvC+q7/A5iJT5wtfp0pZqrDKm9KOhiTv/bmJ1IhRMfVfuKO9/nqgR
         wh5/ui3uDhlubG7hBu2K/jSRWKDhtnJskZaS05n3OoJNTMrFrhKtocf2Tr+8oxoMu+us
         EVamHZPHH7EnitU6fd1gPga1Vl42TPrc8MEEpcK81DoWKe56dbvwAb/igoPW6TR1h/kJ
         CHiQ==
X-Gm-Message-State: AOAM532W5n48ap8LK6y1tkkMZtTSAwp72uT+sHYjMkKT+nVRsRsJd+eN
        b0qD5HKNz+7YvRKV6nJyrOoLUlDBhUc=
X-Google-Smtp-Source: ABdhPJzzy9gogmGmZPdl41qneqg70g9FMVK/Xo0I5AodHHhUPYLf7EJqRbWe7GoWHL8uThYGwnoLow==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr3398657wmi.130.1594118257863;
        Tue, 07 Jul 2020 03:37:37 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id j24sm510160wrd.43.2020.07.07.03.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:37:37 -0700 (PDT)
Date:   Tue, 7 Jul 2020 11:37:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/28] Clean-up ASoC's W=1 build warnings
Message-ID: <20200707103735.GG3500@dell>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
 <20200707101915.GC4870@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707101915.GC4870@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jul 2020, Mark Brown wrote:

> On Tue, Jul 07, 2020 at 11:16:14AM +0100, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> 
> Please coordinate with Pierre (CCed) who is also submitting patches for
> this issue, there's a whole bunch in flight already.

Well that's frustrating.

Some of these issues have been present for years.  It's quite the
coincidence that we both submitted these this week!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
