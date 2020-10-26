Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5412999A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394404AbgJZW1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:27:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35455 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394392AbgJZW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:27:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so14753969wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WMbMX3sYFZTiJxDi6iVMxqXLQXyV4ObR+OkEErhzWA4=;
        b=V6y8gYz2uGh3oaHY97GwUW2s1K/w8PS0UsgPgXbieiH1dISczKtT5DxdG6OL70eZpw
         CQE3lwb/M0LbX9jLqdrNgyLQG0Y99JNuZvlXCqzICU8GviVnmC+xoOK9Phx1MkU80zvX
         sekY8eEravQlxRqhh8NAGEJt/iFxEZnfSXOH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WMbMX3sYFZTiJxDi6iVMxqXLQXyV4ObR+OkEErhzWA4=;
        b=F/oyIo46RyDxMSiRaMj6drJDvZnPJDA0UGNJOX+GBVpbfMat/570MkwjgdjWrl1Qco
         R63K2N6PWE3HJ8Ndo3D5H1mZDBaWpas0s5oc7s8ZjnvEz8dUwUvy7oa15zChePJ0TiD/
         tYYkrX0behs0TU7EfTU3ZMV5yqCsnibc7QFHTBpVFq8m7Z/Fda4ZFYTuJfWVgy7fLU1c
         viOSUlBqsrQ/J1dyRIMwXJ1SNaDLk569CEt8B1HGNhLuLErAQxqKQ52uXodS+tcG7tks
         hseEYqbLZPB0VrBjzYdEdarDbfqcXKMCIEs6ht7MB5SNmkfYv4qM/QF4OKuot0QagmLF
         ya5Q==
X-Gm-Message-State: AOAM532MIKcd/QGoYPd7dlWhzFPvxU08RP0LynjvjFYjboJSVkLH0hzT
        mxfw/Axp2mqwpgQPos7IZGdJow==
X-Google-Smtp-Source: ABdhPJyzFE0ncLcgFAJvvEYWHlsKTBfl+UVWKA2K4j/MUCo1aOoPDSIeht7MXSnGCzK8nfdetUXT2w==
X-Received: by 2002:adf:bbcb:: with SMTP id z11mr19957431wrg.130.1603751269585;
        Mon, 26 Oct 2020 15:27:49 -0700 (PDT)
Received: from chromium.org (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id o5sm23230396wrw.76.2020.10.26.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 15:27:49 -0700 (PDT)
Date:   Mon, 26 Oct 2020 22:27:47 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, cujomalainey@chromium.org,
        =?utf-8?Q?=C5=81ukasz?= Majczak <lmajczak@google.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Fix kabylake_ssp_fixup
 function
Message-ID: <20201026222747.GD2802004@chromium.org>
References: <20201014141624.4143453-1-tfiga@chromium.org>
 <20201014190226.GE4580@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014190226.GE4580@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 08:02:26PM +0100, Mark Brown wrote:
> On Wed, Oct 14, 2020 at 02:16:24PM +0000, Tomasz Figa wrote:
> 
> > Fixes a boot crash on a HP Chromebook x2:
> > 
> > [   16.582225] BUG: kernel NULL pointer dereference, address: 0000000000000050
> > [   16.582231] #PF: supervisor read access in kernel mode
> > [   16.582233] #PF: error_code(0x0000) - not-present page
> > [   16.582234] PGD 0 P4D 0
> > [   16.582238] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   16.582241] CPU: 0 PID: 1980 Comm: cras Tainted: G         C        5.4.58 #1
> > [   16.582243] Hardware name: HP Soraka/Soraka, BIOS Google_Soraka.10431.75.0 08/30/2018
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Okay, I'll trim things down next time. Somehow I was convinced it's a
common practice.

Best regards,
Tomasz
