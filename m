Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC412D41C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgLIMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731350AbgLIMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:09:07 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F047FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 04:08:26 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id d189so1431469oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 04:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lH2aIPfGReG41oXFiTar8tydTSQbukFakurAPPWGMXA=;
        b=AkyDU2MLEg2Ckg19uqmebMIu3iOIaW0Eg+HXBF2aHuu+PIh24fXm4VlH0AxHXe6ubn
         b2/VGR2A7LtTAH8jMaxQiGwbCXjO50F0ySd+DRDV0jIAO8vwWOe0sSgWC2SmoUUeDLiK
         rhk+Vwhzuq+RH3VLrRYQdxXKoih79/Rb5GORk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lH2aIPfGReG41oXFiTar8tydTSQbukFakurAPPWGMXA=;
        b=AQUyBFcEApf8P65YslE7KIol1lleMiHYXfbV9TMawLUx69X8FBjrrR6AQW2CF/XIW9
         6+w2nKHxA4xz7vne2YW4H9cfhzIrMX45Zgr9o4enX+21/roXHKzYK00k9F4vVyRhLWf+
         6pAOzHn8WqoNGJRbAEtWmEJGWyWKMTEujkT0e71rpZixo3N5RutJbaz0ax7ycMSH9fkf
         FRs4Aa0ciIIlc4QuR99LrVS9XhTUcnvugbZGOmJfq8LUteaARfzAQdup2wM9mx9Telpj
         IE8XgIkfXxDQCXM8fJpb/m2lYQEo7c1Xrkx2l94GQvSESflbTtCmep8eYo6K3kRQEX1i
         PqwQ==
X-Gm-Message-State: AOAM531aCH+Dtf7MNV+iYBloBvd6zwh7cAHboAUePGmur6XetQN3Dyfb
        uKFnOsS5ceUaJZRPZryx8E14hXLJqqSBsskhMu29lQ==
X-Google-Smtp-Source: ABdhPJwoW0k/Ycf4RkiHqchEKdArbJsk2wgrBa641oQiDnlhnZB0lgPOzYGPaAay2fQ/XrCgU9Xx5nSGPQu7cs4taaU=
X-Received: by 2002:aca:54d8:: with SMTP id i207mr1425847oib.101.1607515706418;
 Wed, 09 Dec 2020 04:08:26 -0800 (PST)
MIME-Version: 1.0
References: <1607413859-63365-1-git-send-email-tiantao6@hisilicon.com>
 <20201209004828.GN401619@phenom.ffwll.local> <06c1dee7-488d-8a74-a55c-74043cb060cd@ti.com>
 <CAKMK7uFsDPH3+CHGwkgtnDOc6pJY=_SocyaghETZda+RgjAJnQ@mail.gmail.com> <327508b7-2c63-8f2c-36a7-362c83b4243d@ti.com>
In-Reply-To: <327508b7-2c63-8f2c-36a7-362c83b4243d@ti.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 9 Dec 2020 13:08:15 +0100
Message-ID: <CAKMK7uH25qMZy0fLVTAu+Um5r0A-iCQtGc5yFFwNHXd3KZ3VBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tidss: Use the new api devm_drm_irq_install
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, Jyri Sarha <jsarha@ti.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 1:06 PM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 09/12/2020 13:56, Daniel Vetter wrote:
> > On Wed, Dec 9, 2020 at 12:29 PM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >>
> >> On 09/12/2020 02:48, Daniel Vetter wrote:
> >>> On Tue, Dec 08, 2020 at 03:50:59PM +0800, Tian Tao wrote:
> >>>> Use devm_drm_irq_install to register interrupts so that
> >>>> drm_irq_uninstall is not needed to be called.
> >>>>
> >>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> >>>
> >>> There's another drm_irq_install in the error path. But I'm not sure this
> >>> is safe since you're chaning the order in which things get cleaned up now.
> >>> So leaving this up to Tomi.
> >>
> >> Right, I don't think this works. tidss irq_uninstall uses runtime_get/put, which needs to happen
> >> before pm_runtime_disable. With devm_drm_irq_install that's not the case.
> >
> > Hm I don't spot devm_ versions of these, surely we're not the only
> > ones with this problem?
>
> drm-misc-next has these. hisilicon uses it, but doesn't have an irq_uninstall hook, so possibly late
> uninstall is fine there.

I meant a devm_ version of pm_runtime_enable. Or some other way to
make this just work.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
