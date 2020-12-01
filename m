Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375722CAB74
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404275AbgLATJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbgLATJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:09:02 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE236C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:08:21 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u2so1666613pls.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QUWMr12jnZSwer44TsnGGGXMgplRPnA4naaqDE9IQLw=;
        b=WSqvrn9hLl3nPVeLn1YYv7Rbo3046kjzaOrkh0yX03fP/x3M6u/Anz3ZsMsFl+3kz1
         Ll3WuUo2zJqxr8Prc2TvksscpcxbIDUgmNupkHrmRkLL0tzH9B+gsayZWo/02Oa6eroS
         wM1eyxl/GcuxGJ0OW18DUdONXXSLhRhAzq9P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QUWMr12jnZSwer44TsnGGGXMgplRPnA4naaqDE9IQLw=;
        b=Lpl5FdKYi0UUdK0va73QWdZ8LZkMLvv8g4UKthJkVYQydJRLkBGkgLQRm2nbPwAGNr
         qVM5x0Z5CDteu3cUntXxijMYwvnLadfOkCV9ReA4z6VfMpCO7STkmbvPim9ogTej3ST7
         FjJ6aU+MwWNwQ8cSmFuQbIt7ZJjYf+dZtpELC0nGM9W6dBrEG9R8H6Tl5v/IbqG+L6vG
         Km42d7MZtAXqEsBEAAnykBOaM6JJmEncQ0c59NvI2eHkI2/YUDCNGxHysxy+wNwm/hPd
         As64QBij4+AbIAA1QC1n+X2rXieFukdpuWEI6seP9hWcWtFkdhKM3GduqpHWxSKaOJqP
         XRDQ==
X-Gm-Message-State: AOAM532FdlPGzvhE4y//vqJ/HGWcWJJ8MMn/KOXz1TvsA8m/w6cT386m
        MY2xX2Lz4fBBInYkzi7m1m6bqCqG8DRU1rAU
X-Google-Smtp-Source: ABdhPJy5He4iO506Jp84UD+OP8wHM+ZtcLYwEHTm4UsD6KUvJxD42DZsDb4YdfBhXBSowhDhjdCiMg==
X-Received: by 2002:a17:902:aa84:b029:da:1c29:b965 with SMTP id d4-20020a170902aa84b02900da1c29b965mr4204444plr.36.1606849701452;
        Tue, 01 Dec 2020 11:08:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o29sm530289pfp.66.2020.12.01.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:08:20 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:08:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] pstore/zone: cap the maximum device size
Message-ID: <202012011107.49D5ACF0B@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:39PM +0200, Christoph Hellwig wrote:
> Introduce an abritrary 128MiB cap to avoid malloc failures when using
> a larger block device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, this seems reasonable. I'm always worried about arbitrary size
limits, but if 128M is needed for pstore, something is likely very very
wrong. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
