Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7F2A99DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKFQyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:54:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:54:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h62so1946706wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F+Vt+4TSvdy8WlC4sGQnfJ5XRS32FKrs7NXD/c6LwWA=;
        b=GlCcA6UHHoieTNyiZ1/cpN4zXsbXTEkHsxM1XA7Q2LT+o9L2id9zdc8DOKrVNPkOXq
         kLKz5JhU8YOpXKwoi9cGU0uj0VnmyTcZCHvx40WNG1ZcB0KCoHwvShL9rImWKk5Iblhw
         El/nFbCGs9eX082IlAs/kb9rM4cdmTxDUBRlvzsSeXFSLnKegLjma49IBFJiJFowsGx4
         IzoCpCAMJVCKAgqT6/CLtyUGg7xvhNGe2pFhgys4AE6gGewG/IVRx8uUrWwBILWbd7g6
         MpETBAuRT58+HArQvzU9CTY/HS3trxfU/fYRJb1Us7NyoMvLYypmrHrMMB9TleNnFfSr
         0MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F+Vt+4TSvdy8WlC4sGQnfJ5XRS32FKrs7NXD/c6LwWA=;
        b=J+e2gqlDFiu79X0cXbUmY8pq3sG2guwcobtC9bA3Ti+5XWjw5oTF8Zybg4tALsc6iG
         KOVvTuU4Nxq7JyWBqt9FwkIfxjO1F1Hq/4A96S1VUmXowNvxo01StHc+Ph116N8yeI+4
         pa6p0etNaVWc4VYFOArOPdaLTNATQwBeuasMfsCfNs6GZSDY8iuinJGk717Li7/KXVR8
         R3kZhrRZj2eXYAVg8r9m5vq1a5LXBP5f/WZWtj757As4aPaibukhta4S8HTe790J1uN3
         pzK2qQEuGBo2xOTH2kCMtxEiA04tcfxFWhczYRbPikJRbMqxzwnYxzH47CmP0w2XBJjZ
         meiQ==
X-Gm-Message-State: AOAM5338UE/6s0ecx5W+40wFHpt5oylzZLS4IadAYMgA4s6rVBmqFJ6H
        JfAsIqLQOZQ49/i+C2Vu7qZDCzuKdLoErmQO
X-Google-Smtp-Source: ABdhPJw7CI79ie5Q1Ax/Xf8IJpGNiVB6Pub1As6gH+nRUX3HuWeQ3zj6MELYc8olGfedqWMaIpCyMQ==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr465744wmi.131.1604681681197;
        Fri, 06 Nov 2020 08:54:41 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u6sm3107686wmj.40.2020.11.06.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:54:40 -0800 (PST)
Date:   Fri, 6 Nov 2020 16:54:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 16/19] gpu: drm: panel: panel-ilitek-ili9322: Demote
 non-conformant kernel-doc header
Message-ID: <20201106165438.GN2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-17-lee.jones@linaro.org>
 <20201105211742.GD216923@ravnborg.org>
 <20201106074323.GV4488@dell>
 <20201106161109.GA625131@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106161109.GA625131@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Sam Ravnborg wrote:

> Hi Lee,
> > > 
> > > Applied to drm-misc-next.
> > 
> > Thanks for all these Sam.
> > 
> > Any idea what happens to the other patches?
> > 
> > Do they go in via a different Maintainer?
> 
> I expect the respective drm maintaines to take them.
> Give them a few days to take action.
> 
> I look forward for the next set that you said would kill 2000+ warnings.

Just testing it now.  I hope to send it this evening.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
