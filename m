Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73929E1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgJ2CEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgJ1VjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:39:08 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB7C0613CF;
        Wed, 28 Oct 2020 14:39:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x1so1067490oic.13;
        Wed, 28 Oct 2020 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilRPL3DQy2H6Zk6HIeE59f6ZVzkXagVII22DPJDLAag=;
        b=oMgPjhgxZddy2MlRFdbHYzpkCf87TsiBUTX9Ks/FpT3aQndQx4GqWe2bP+n/EbYvLK
         G1tltXAUtW51uKPeWm+onBtFrW91UIbBqzugq8Yge5v2RSaqWZBehWsQj8RJtV73/pFL
         d6gkE0MOVrqCTFZ9MOCF8Vuw/OHrI8fmqJO0nwMxLplEKOEqIP6uE2tJ5wp6HfoZEmdd
         Cq8O68SQLUe86Aj1FuZB3sd2PzhWfvWAOn86z0G60wA3vX6KoB97+w3XzD08OI/asmn8
         jxuPOWBYul5ybPvb8jmYyUZiDSC5cNjKx0wg2DN1ileDgwWqwlqxtlcoUC4KMxA82yyA
         TMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilRPL3DQy2H6Zk6HIeE59f6ZVzkXagVII22DPJDLAag=;
        b=rUJZkvZ5Quz3XndDL/i801SxBLOkEmkcD+D1UUwzrTX4HGxHFWwSXEw8H6kXyfRSqd
         uvqyJXuv1eInY9pn5lgbKC2sdZDRuO+oASLHh4U9IE88A2tkR0HAGYr9JSIO96OppIL4
         3hkHafiTDKt1WzIOd50ks5bsZ5HnaDtGoKq8laiu41gw5qfPeGGuGDIzLq3bNQWhrxmj
         v+sbTrQQTWBHkXvCUx8OfUNYV/mTxBC/jZkSNSSwD0sAA8yxmgRzjrAWDtCi0g5ZlNcH
         YaHfNOaTkwkYW3bsve7o6ghbhW0EwrxknSSu21+dK0ZCVjJkVQYU2lNihpjCYmKgFD/C
         nmVQ==
X-Gm-Message-State: AOAM5316AIGgUg+H8TC30K4UK/4nwUV2WfBzVGkIUKB2u8CJsKPSb8vx
        xBjB3ybtSIwk8ux6/8LbcNwiR1zITlMi
X-Google-Smtp-Source: ABdhPJyLn0I7cW6/sgcaJEeTzSzspFyQyOpnfBVX38qqSHlqULuJKLLKtI8EzomBKUQCoIRROFr/3w==
X-Received: by 2002:a17:90a:14a4:: with SMTP id k33mr5177792pja.236.1603863795449;
        Tue, 27 Oct 2020 22:43:15 -0700 (PDT)
Received: from PWN (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id 10sm4008324pjt.50.2020.10.27.22.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 22:43:14 -0700 (PDT)
Date:   Wed, 28 Oct 2020 01:43:07 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Fonts: Make font size unsigned in font_desc
Message-ID: <20201028054307.GA1205568@PWN>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
 <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <20201027185058.GM401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027185058.GM401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 07:50:58PM +0100, Daniel Vetter wrote:
> On Tue, Oct 27, 2020 at 12:33:05PM -0400, Peilin Ye wrote:
> > It is improper to define `width` and `height` as signed in `struct
> > font_desc`. Make them unsigned. Also, change the corresponding printk()
> > format identifiers from `%d` to `%u`, in sti_select_fbfont().
> > 
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> 
> I'm not entirely sure of the motivation here ... height/width should never
> ever be even close to the limit here. Or have you seen integer math that
> could potentially go wrong if we go with unsigned instead of int?

Oh... No, I have not. I just thought we shouldn't represent a length
using a signed value. Also, width and height in console_font are
unsigned int - that shouldn't matter that much though.

[3/5] doesn't hunk properly without this patch, I'll send a v2 for [3/5]
soon.

Peilin

