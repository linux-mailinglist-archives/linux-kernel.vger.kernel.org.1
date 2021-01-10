Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29242F0825
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbhAJPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 10:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbhAJPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 10:36:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6BC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 07:35:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id n26so21186085eju.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=naEHngvAfFaWU0qNEz4MsGy5SHtJ4Fc1pZjtZRQ/R7A=;
        b=SKhejTHVrnmvxoi96I8oG2caR7ZKzOGKmjQdwbghyOYz7IJgq4zgEnak1joV2x0XwI
         RSsMuDayu4oe6gizQfKuvkl0EouzfypKjiq6nAVWS9i87pd0th4TUG7zK/BQYEMnpmCH
         VN/VpDZnDVAR7MqpaPgXovwhPKdUdV6YTdz6oQafe+LBMHGuxV1UDWIftC0Rqze1wCfk
         65RC/VZ4g/Jc0O9wzQOnfVm3JPoqnisJ/ETz/61rdTAdjiOBsRkKCycWbmw8uIK3dlAk
         Kd0YnnI/cdheVRrRTEvaXOa5ShTyVJ8xKR6RiTVse5K3TXb/tJGHJ7H59qVg5kIV9SMP
         uNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=naEHngvAfFaWU0qNEz4MsGy5SHtJ4Fc1pZjtZRQ/R7A=;
        b=qnkb3c8LTzfvgEHTp+EPgz0Tgmx+Xvwno9o6i8YsbkTDBdy76ZDSwbluBkfh/6GDcq
         3MFjQzn3/vA2ypgrETdh9j9NXdlKX/FXcRytZ6fupKeJOPMnVao+q1aMhqx8ZJcJ32lB
         ZGw8jRPFllCFlQdXwZB0v38v8Xxjgs4LXy7EnOOtUMNSkdwD16ro7pi/P6ur7Elk6w+D
         o+zmgiqCGqWiz2Xk3Us1Uu+Y9VN/uKuRT4vbeMdbq5Xg2Ard0j6Fm9Ctwzdsu7sXk3Lr
         uy7y1/+WLwv6/zd4nF61E6AQJKtTXQsOdAvMCdAykjtPk+XuOEmJyZtaUUtlU8tauLlG
         3Smg==
X-Gm-Message-State: AOAM531uEuYraliy3JZTvNVAl3iap+bNfGVN6bkobGT0ADtAf/QAulkS
        SCTg/DE7pUqQtPmd2T/gX7E=
X-Google-Smtp-Source: ABdhPJzxnXR0a06rh8Z9nCUeV/eMkVI5BFMVGBdQyXJx+wfhB71QZy4bXa+FxYNnU6mD+fRauHWPLA==
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr8083162ejc.431.1610292942807;
        Sun, 10 Jan 2021 07:35:42 -0800 (PST)
Received: from localhost (ip1f10d3e8.dynamic.kabel-deutschland.de. [31.16.211.232])
        by smtp.gmail.com with ESMTPSA id a2sm5852660ejt.46.2021.01.10.07.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 07:35:41 -0800 (PST)
Date:   Sun, 10 Jan 2021 16:35:32 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210110153532.GA7264@ripley>
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
 <20210108214313.GA7979@ripley>
 <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/21, Fabio Estevam wrote:
> Hi Oliver,
> 
> On Fri, Jan 8, 2021 at 7:24 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> >
> > On 19/12/20, Oliver Graute wrote:
> > > Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
> > > to panel-simple.
> > >
> > > The panel spec from Variscite can be found at:
> > > https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf
> >
> > some clue what bus_format and bus_flags I have to use?
> >
> > [   42.505156] panel-simple panel-lcd: Specify missing bus_flags
> > [   42.511090] panel-simple panel-lcd: Specify missing bus_format
> > [   42.615131] mxsfb 21c8000.lcdif: Cannot connect bridge: -517
> 
> Does this patch work?
> https://pastebin.com/raw/diTMVsh8

the first two errors are gone. But I still get this:

[   42.387107] mxsfb 21c8000.lcdif: Cannot connect bridge: -517

The panel is still off perhaps I miss something else. 

Best Regards,

Oliver
