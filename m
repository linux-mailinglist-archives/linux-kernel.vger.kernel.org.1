Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467F0302E52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbhAYVs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732824AbhAYViN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:38:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F41FC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:37:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h7so19962843lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNwBZ3uUnUb6Ispb11A6Ynn8ywRI2rWh9CboV8C5Qnk=;
        b=mQqP0hPmK8AL9hwA46BPP0fAkOQ+2S+3v8D+yIF1BGI64yaCzmtjet9Azij0dS+oag
         oQx/W4C2Q6+1Gi7L26OrkEc+pyBzLRv17WDCGEhCz3305HXkApZY7M63fmZHvb3S04HI
         hVsQgwlMCeOTHCNxLBQhMVi+/Dak8Yzu2HWA4mK2xSnSCL6H7WJpRpAkzPVg9beNMS3w
         3u6o2DhTZ82O2qcxvC2uz5FiHbe6S5PzSPTWmmohyTzI40jSz1RsifLSGH+rXtUQYHfN
         Cf3r8/f40Edkc1QImHhT0IKNeCx+9fqHTgdaYCjp8y5N2rQplEltM92lh6ZwaOaeXl3d
         In1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNwBZ3uUnUb6Ispb11A6Ynn8ywRI2rWh9CboV8C5Qnk=;
        b=plh1Z6uiQQwYvF+hSu4aocio+r1CluQ1cHPb7ln/vVryTSbx+VifLvLaKT9FPtb5kr
         fMepoO5YBBARcYTfjTjmNgiCfonl2oUqwgrX19juQkamyQD7taO5VIitBEibPdGtDFFA
         wPk+xIeYQD1y5Yc9OQVEcEc7tQS3VsCHnM25/AYT0sY1InnAXE6oQOGlxe7qvWL1VFMJ
         KXQwmC+9rw4R7RzB4+lBnxQyjPd4xbOCVRn0wN33loNuyQ9p5+teDMs8I4jFmGsjVfe0
         II850X+W0vvpS5RhgzzOxK9W5ZRqXdP1s0exdIOJJ6B0ZNEWH/l/YvYcveANhnKBKvcP
         41EQ==
X-Gm-Message-State: AOAM531KEqNHd6iWU9Im4HBkbNyxOsD/X2GZi/ER6CRGOMKStJY8QF6K
        YfjhAPGfJPj+lB+kP2VRA6UJyxxr3CZKySuD8a8=
X-Google-Smtp-Source: ABdhPJzI9r1h6MStmuIfDO08jOyhr0/Qd7bFRk1fQL8XaCinMVzX+rLNP6mlN9l3feMzj7VUszRNgy1j+rpnO4RQOjA=
X-Received: by 2002:a19:488c:: with SMTP id v134mr1093199lfa.229.1611610630782;
 Mon, 25 Jan 2021 13:37:10 -0800 (PST)
MIME-Version: 1.0
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
 <20210108214313.GA7979@ripley> <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley> <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
 <20210110200606.GD7264@ripley> <CAOMZO5DJUm4zutTB1oi5M0zj4_PFZEAbGzX6_LUAkX_dvEz=Qg@mail.gmail.com>
 <20210116124856.GA3406@portage> <CAOMZO5DKann0ojZrhjyXOqrRq9owtgrrZTGwttD_bU0-KO=aBg@mail.gmail.com>
 <20210125212917.GA4177@portage>
In-Reply-To: <20210125212917.GA4177@portage>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Jan 2021 18:36:59 -0300
Message-ID: <CAOMZO5DiTDQneYMtNBDpyqtYUYJ3AZ_fqWNSyfxWB5AfaNfULg@mail.gmail.com>
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

On Mon, Jan 25, 2021 at 6:29 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> Ok I fixed the pin conflict with regulator-gpio and added a 5V
> regulator node in my dts file. Now the display is working fine!

That's good news :-)

> I'll post the dts files soon and check if there is something to
> improve for this patch.

Did the panel patch I sent earlier work?
https://pastebin.com/raw/diTMVsh8

If it does, I can send it formally if you want.
