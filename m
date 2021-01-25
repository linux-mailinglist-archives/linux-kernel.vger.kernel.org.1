Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F166302ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbhAYWS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbhAYWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:17:54 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDB0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:17:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bx12so17420335edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbl4vYmOplOA4Lq7CQdKDQ8xv1fDV6QEwMKrOn8OWpk=;
        b=RcDPBKKUsQj1Z4XdOLYXxLa+oM5qnvGoWPmrbT3/a8Lqu4Hm9ULliPRFkn92MsEbFp
         b8ymLVSD2SDV4OxZVZ5z+0f+HQ2rIRrjYZkvfozqtYSxMl5xuBnqc73lKMrVpOFNI0M6
         sBzTDv358rUoKKrBFzB37brJ1pT5I+WMzCbSJgF2LXqIKQqXdhgzOTXGFOHFE7hCjs0H
         ALFFown2sfzHL7FmiEaAeeYj8NGyIfCanYTrCLNb+ZXAANEFbrDfaKhwPL0VyhmaWjDF
         QHOk36DofKvLN5tisRFt0G0EcnHVSDqrcp2YZNGcFJzrL4JvMDKhgwYnnJ0MOVY/dnVB
         uI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbl4vYmOplOA4Lq7CQdKDQ8xv1fDV6QEwMKrOn8OWpk=;
        b=WaED4qvG5ijZPjFUy49TEtsgYX5j87Ot9/VAkWBJJxEfRDzV06YNO4AtEuBse/Y/Xo
         3Dx+JAS0ZkIk+fJuRORnaGFMc+54F+KsG8mj8jILXOGqANlykNynMU5eEFhb3R3bI+km
         jRJrYEwgnsMWV+GW2DBqc5YNRslLsVy3ntltREFRLsnY54XeF6nBqQWNVoc1+u1PQ+MH
         bXfXffgwKg8FB/eilSVPB7MZjvdtyRrDlgPltO7g8d+WQLKDAi/J8DlZFOGpGm9ApT1o
         YDfT7y0AMqWakFcjLrLdxpNlXtxnxbcCvEY7hN+SaEVfI/73dfnMgblmuPXQoT7z62TT
         +Q5g==
X-Gm-Message-State: AOAM531xvydz9zfhH2yn/J/cSpV1sm0iM9m12/sPBiRfiNHyM/MED9Gv
        KJ1++V6vO8QJUyQniKabOsY=
X-Google-Smtp-Source: ABdhPJwwLFj4N52eEZmA6AnsFi19fslG5VI/m8v0kLBGwk4tb/fd7PVbo1MDWSnDFifpo61Are6skw==
X-Received: by 2002:aa7:d0cf:: with SMTP id u15mr2250287edo.115.1611613031193;
        Mon, 25 Jan 2021 14:17:11 -0800 (PST)
Received: from localhost (ipbcc330a5.dynamic.kabel-deutschland.de. [188.195.48.165])
        by smtp.gmail.com with ESMTPSA id x9sm8872401ejd.99.2021.01.25.14.17.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 14:17:10 -0800 (PST)
Date:   Mon, 25 Jan 2021 23:17:01 +0100
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
Message-ID: <20210125221701.GA20107@ripley>
References: <20210108214313.GA7979@ripley>
 <CAOMZO5AXgeGYt4+4NMBRL1Hm-9M4X2DngdEBsJEAHq8+MRhQgQ@mail.gmail.com>
 <20210110153532.GA7264@ripley>
 <CAOMZO5C_hDWeVrCh7k+3OiA0jhQfawhGWE6hxnnFn=wA+dkTGQ@mail.gmail.com>
 <20210110200606.GD7264@ripley>
 <CAOMZO5DJUm4zutTB1oi5M0zj4_PFZEAbGzX6_LUAkX_dvEz=Qg@mail.gmail.com>
 <20210116124856.GA3406@portage>
 <CAOMZO5DKann0ojZrhjyXOqrRq9owtgrrZTGwttD_bU0-KO=aBg@mail.gmail.com>
 <20210125212917.GA4177@portage>
 <CAOMZO5DiTDQneYMtNBDpyqtYUYJ3AZ_fqWNSyfxWB5AfaNfULg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DiTDQneYMtNBDpyqtYUYJ3AZ_fqWNSyfxWB5AfaNfULg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21, Fabio Estevam wrote:
> Hi Oliver,
> 
> On Mon, Jan 25, 2021 at 6:29 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > Ok I fixed the pin conflict with regulator-gpio and added a 5V
> > regulator node in my dts file. Now the display is working fine!
> 
> That's good news :-)
> 
> > I'll post the dts files soon and check if there is something to
> > improve for this patch.
> 
> Did the panel patch I sent earlier work?
> https://pastebin.com/raw/diTMVsh8
> 
> If it does, I can send it formally if you want.

I would prefer mine, because I got a wrong colored penguin on bootup
with yours :-)

Best regards,

Oliver
