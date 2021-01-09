Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC22F032A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbhAIT2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAIT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:28:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED436C061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 11:27:56 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id v67so2972498lfa.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMzmhqsb6O+Y/sweUwnfBNP0O+DIAXIGp9pSoa4SyH4=;
        b=uTzq5h8Iuv77HAntNbpwm3FVUhayYhlLptY5pCwOcZhQJvXxtLAcVx3TSaL9+pd6H8
         owZv7e8MLunROZacxEtvuF6quKWIH5vg5D9bzbXFnrZXKZbnmctX7t4FasG6gKel5VPe
         WT/AonhPx3CAFj/BtYDm9TJmLehdYX35pmZohneqWaYd+u0YTVfZrlHOALecGguQqgnX
         5oNmWeKmEcaW5ILp2AsuBz9WoMcIVCqAX5/HrIMeQRzLGLSor1rvXHe43yGFNwAEH68I
         qo+BELRNYgcZhf9ftsoVf4vFOZY1A9elnizxClPpYEYfhhMq9J51TFYNmL946+b5NKjH
         9Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMzmhqsb6O+Y/sweUwnfBNP0O+DIAXIGp9pSoa4SyH4=;
        b=eILvZRD57y0d9Rw6kZq7HjPorNHxHVD9QCbKkDFnPnxufcSOxEgKIlo9wpDpd7qnAA
         gQJpKBewckVXZKUyvzd4h6gj5C1/1kT6xbovFceImj8VGFPJKQUhGFYnmCsSd83Zx0eD
         b4cFt0p/0Rl9bVLy/J/P317kYv1hrnLcmaMq4uwXY9jbH4EUHGUN7iCTvXaEmR8pAFQG
         T3PdCg6umzqZqXmCwdejerHEsXtOAneep/qGNbsGnnwcq1wihUVHTSePmInwgeJ3n/2c
         /UoOZQASxzH3fyL6FMxlLYx6AIDiAhDR3y+Jwcf9aM2GpaAKzFXHjleydLL5bSXNRFzW
         vrmg==
X-Gm-Message-State: AOAM533sXKOP9DyljfH4CXuJS2gFfJaTVPAB81nlmflMcOCcDtFHpVG8
        mgHwnowr6TnBzrkZ1p0IoAoiFiavzvr1r1Jco05Vo3OoZ4YLzw==
X-Google-Smtp-Source: ABdhPJz/XGrE9hd0zKsEMiVyUZ/CPfFqRBSJ6A2xplHL+kAVBy/n3LREY6+X4uxsW4ba7wL1gySV+a0S/UaR9okmkwg=
X-Received: by 2002:a2e:bc05:: with SMTP id b5mr4273065ljf.444.1610220475326;
 Sat, 09 Jan 2021 11:27:55 -0800 (PST)
MIME-Version: 1.0
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com> <20210108214313.GA7979@ripley>
In-Reply-To: <20210108214313.GA7979@ripley>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 9 Jan 2021 16:27:43 -0300
Message-ID: <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Fri, Jan 8, 2021 at 7:24 PM Oliver Graute <oliver.graute@gmail.com> wrote:
>
> On 19/12/20, Oliver Graute wrote:
> > Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
> > to panel-simple.
> >
> > The panel spec from Variscite can be found at:
> > https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf
>
> some clue what bus_format and bus_flags I have to use?
>
> [   42.505156] panel-simple panel-lcd: Specify missing bus_flags
> [   42.511090] panel-simple panel-lcd: Specify missing bus_format
> [   42.615131] mxsfb 21c8000.lcdif: Cannot connect bridge: -517

Does this patch work?
https://pastebin.com/raw/diTMVsh8
