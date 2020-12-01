Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74C32C9806
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgLAHUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgLAHUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:20:23 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECADC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:19:42 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so982393wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s4ekWG5Da7x/WlqkOj8PSgRoz7W2Hb23UEfpBiqdERA=;
        b=wYn5nmN58j3YBAM9oJ5NUmD1F8klWgjde92i623Ca9RiWgIL534fcOA9Lcia4oFz7M
         x24kwbi7GXajtELQDnw9ywTpPG4SALWUKaVDvQufJFEwwdF8t2fqxaNlWz2adxyEaHbJ
         2pSxZ4Xjlpz8L8qW1jDu4HypSuOHQ8W5JrOyuS8FjadVBt02HmwBHKFIBn+xWQXKgh40
         f2dxx5VOX6lnnFanIo+gDKf5PbUB+ZS5JWYFzDdfl1tWEd1QYcUwW61KERHnB3LtqBYF
         zQm4Sxc6OSLyQ1envR7P1rWBRGelrL4nRnx67y5sU9uRYO0I972UzWur4fIGGtmvJtRm
         +eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s4ekWG5Da7x/WlqkOj8PSgRoz7W2Hb23UEfpBiqdERA=;
        b=uoVFdJ0TlpKi4LRZDrY8YzgWXcB8WNWQXKoMKNIIy0bHCnwhlkYwXoPwaUlk6KJWgf
         FdZ0D3DlSTW0YqvbgORdblzclSivoCAVvERs/JyRdduVW/m9+Q37qZ5+n0TV/HV5KCmi
         Zjzz6HHKIqTzF0ig5b4H4lrVVZlBO6gfVHsBrul92tSOZ6JLxUnu6a0Qy7M5QYy4ZJKX
         R9UjOwHlB6JscCOUfKA6Pu/zvG/yJ6RtaGl1LaLP+ZuvLfpTNJZ2rU1N3YbpfiByIsZj
         c0jbv2QT0RLcjs7i67R/CZynjfkxHtYd58RzwM3FHEzs7J8sS6/rgJBXtKO74q0guW24
         MmwQ==
X-Gm-Message-State: AOAM530KjEK4l8Z8gmCJIe/BH1ZWVOwCLOyi0WqnYmc+pPi31s2GWLHp
        zi5mSNmLQW4NRt/4qttb2dC8Og==
X-Google-Smtp-Source: ABdhPJwJbBZx5ZXK6i3ydIfLDhrA0aJazi5AXeSMM1z90NtAPx49uDK1U9w9yKnMbSGOf8DJupBADw==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr1951722wrn.207.1606807181485;
        Mon, 30 Nov 2020 23:19:41 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id z21sm1264690wmk.20.2020.11.30.23.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:19:40 -0800 (PST)
Date:   Tue, 1 Dec 2020 07:19:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 32/40] drm/amd/display/amdgpu_dm/amdgpu_dm: Mark
 'link_bandwidth_kbps' as __maybe_unused
Message-ID: <20201201071938.GE4801@dell>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-33-lee.jones@linaro.org>
 <CADnq5_PtZRwNNV-EvMjkV9k2sYj9jdYBT3oqtS3-hm-pTsaaew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PtZRwNNV-EvMjkV9k2sYj9jdYBT3oqtS3-hm-pTsaaew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020, Alex Deucher wrote:

> On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > 'link_bandwidth_kbps' is always obtained, but only used if
> > CONFIG_DRM_AMD_DC_DCN is defined.
> 
> Probably better to just move this under CONFIG_DRM_AMD_DC_DCN.  I'll
> send a patch.

I considered that, but thought there would have been good reason for
the clause break just for dc_link_bandwidth_kbps().

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
