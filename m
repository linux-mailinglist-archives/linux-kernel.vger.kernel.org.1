Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CFD2B6E31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKQTNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKQTNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:13:09 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA61C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:13:09 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so4267755wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WNUVTXMmnykufcQ4Q8lOWcJVUiIN3QeGQB95A76tQ+8=;
        b=i0YBLj2HBs3hcsN/sjWp36dXpyzOLonq5s71qRK7+wGLc3Xp1HvfGP8JlWZH5JAY9H
         NAepCFPBk+/LY4QzQ+pSU0XFUCVkhBP7o5kblNYIG29TWf1zyq2gPuPh/f3PeMpk7tsa
         Qxeiz28OVxAkTt5us3nJPXFCdykpxw9J7ni2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WNUVTXMmnykufcQ4Q8lOWcJVUiIN3QeGQB95A76tQ+8=;
        b=eCzaGpaVgZJgAFRY1NtmTRNkRsnMrhxq5UCWRysSSeTQiqrJkpq0cYLtXxZ9G3ufNl
         GJI7XiMt27Z7ZBhCVbI9vk9DkJuhKxCDRa6tZ3Tmr64ttKl9Kl4ijW5LYcbzDj80VqmW
         kkU3Lq6WZsbECDd7jUIdk/bVI07dCR5q0VzZAOOqkZB9VEKo6wXiQm5kwyCxw5xu9bqg
         eIDWulIl8Q6L3CpbSFR/efjYZgxJYGro1VUWUtIfIfGTkq0S9KPnL5UcZBWdJBh7dfiw
         hEBV2CLDTk+0MWrJGkiAelzKkBPWUXsRaWkpaFWMzy6pe/LoDIHgf20oLvvqNWr8rmcn
         MxZQ==
X-Gm-Message-State: AOAM530q/n0KKxBrrC6Eiw01rCpvHpHEqBirRMgcrxsfbJk2Qd0t0vw1
        v3s0XY2+OtxdFX0B/TsEvGM5+Q==
X-Google-Smtp-Source: ABdhPJweuOOwDW8ob2fCJCgh19KgYC/5yerZWUwLSSEiJpkdEJlwJjHbZ0Lfpao9PySksN69RQprUg==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr590340wmg.27.1605640387840;
        Tue, 17 Nov 2020 11:13:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c5sm19496393wrb.64.2020.11.17.11.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:13:06 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:13:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch
Subject: Re: [PATCH 03/42] drm/drm_dp_mst_topology: Remove set but never used
 variable 'len'
Message-ID: <20201117191304.GS401619@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-4-lee.jones@linaro.org>
 <20201117172925.GN401619@phenom.ffwll.local>
 <20201117181250.GL1869941@dell>
 <20201117181340.GM1869941@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117181340.GM1869941@dell>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:13:40PM +0000, Lee Jones wrote:
> On Tue, 17 Nov 2020, Lee Jones wrote:
> 
> > On Tue, 17 Nov 2020, Daniel Vetter wrote:
> > 
> > > On Mon, Nov 16, 2020 at 05:40:33PM +0000, Lee Jones wrote:
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >  drivers/gpu/drm/drm_dp_mst_topology.c: In function ‘drm_dp_send_query_stream_enc_status’:
> > > >  drivers/gpu/drm/drm_dp_mst_topology.c:3263:6: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
> > > > 
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > Going to apply this, but I noticed that the return value of the
> > > build_query_stream_enc_status() is pointless. Can you pls follow up with
> > > an additional patch to change that to void?
> > 
> > I can.
> 
> Looks like you're getting dropped again!

I get it on list. So not lost.

tbh my personal cc: is such a disastrous mess it's actually easier to ping
me with an interesting subject on dri-devel here ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
