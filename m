Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740352EFB37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAHWYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAHWYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:24:52 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349CDC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 14:24:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cm17so12748050edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 14:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=65lMCw2uLUBcxYvJ/e5V4811Ykn625B5GYTiXJBwVCc=;
        b=fUnUfac1TebvsWYtVx6JiOuQQ2Q0vwir+MVCI775OppsK29eCxhqfK8nXL9hw+gBHi
         aoOGmHqRnAP7xWQ8aCb3yFRXyDtQiu7PYKqHYCXiDYifi0ARulI2D/QvDh5WtZ9BETCL
         Bd2jsca2cw9iwKhkqRXSpuiT+xTINkNa/Cd66Ic9U0kaQ2v6g3rCulNepnd6cllKoCpZ
         OuVG4JgKHtR7IoqnBQXy2LrCQGLs9pcbiiCai6IC1IdRIJEXijVgzraKe5r198R/oEdS
         fMYzsYfI4WJy0UcMx0N+W/IVhQCdtZchhwpNr54Ejo8lFiJ5jIS5fje8FOjf/K9GVGmB
         ZJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=65lMCw2uLUBcxYvJ/e5V4811Ykn625B5GYTiXJBwVCc=;
        b=aIxqqySQdQkBXiJK+ugbvCmXRs6MW2Sfg9aUjZUy/q89NRFLp3INz6yuWccFFw1JxN
         1CSBZ2Y6fwHrLRAwhPlqSsX+tzX79RODUYIG3hfY+eD2UGmfX+vmfLxrqxrt5VpQPYGm
         GNGwWQB0lAilViW+SPcAqLAHS8W02ZrV4l8xfUt3NURkn6K2a/KZaemSZrrLwBsKT74I
         egJwWRBebhe3kGhn9+0qf8j0gC5ArEZpnr/iDuTuJS16z92u6s1Uz+LROPUHACYsvsVi
         80ukX0O4CGCwz7Lrvn0ll/8JF2B/Nh3c3XdoFUG+YOntYF2GGKmR7OJKBGKW3nOc1Ogy
         9wzQ==
X-Gm-Message-State: AOAM532FvjwADBvtTCnZUGNX0yS9fhwAwyLXxSuoSz6S5WOVnKXHVZpO
        cliIJa83n+IES4sTs3P9AdA=
X-Google-Smtp-Source: ABdhPJzfi+ZwjvmV+AKMuKu0DVkAOqm+JXTdJeAkMOWoDE+DSlijmTqiLaOmjcMDfUDOvGGJCKwQQQ==
X-Received: by 2002:a05:6402:4c1:: with SMTP id n1mr6744966edw.66.1610144650846;
        Fri, 08 Jan 2021 14:24:10 -0800 (PST)
Received: from localhost (ip1f10d3e8.dynamic.kabel-deutschland.de. [31.16.211.232])
        by smtp.gmail.com with ESMTPSA id h15sm4027718ejq.29.2021.01.08.14.24.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 14:24:10 -0800 (PST)
Date:   Fri, 8 Jan 2021 22:43:13 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, m.felsch@pengutronix.de, festevam@gmail.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/panel: simple: add SGD GKTW70SDAD1SD
Message-ID: <20210108214313.GA7979@ripley>
References: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608381853-18582-1-git-send-email-oliver.graute@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/20, Oliver Graute wrote:
> Add support for the Solomon Goldentek Display Model: GKTW70SDAD1SD
> to panel-simple.
> 
> The panel spec from Variscite can be found at:
> https://www.variscite.com/wp-content/uploads/2017/12/VLCD-CAP-GLD-RGB.pdf

some clue what bus_format and bus_flags I have to use?

[   42.505156] panel-simple panel-lcd: Specify missing bus_flags
[   42.511090] panel-simple panel-lcd: Specify missing bus_format
[   42.615131] mxsfb 21c8000.lcdif: Cannot connect bridge: -517

Best Regards,

Oliver
