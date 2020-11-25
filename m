Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7308A2C3F17
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgKYL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgKYL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:29:00 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8AEC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:29:00 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so1898023ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2nOPkD46qA6zqYvfk5N1mr7k9F+AjAsV4itAgMMq35k=;
        b=UYz/jCqr2QvHnOp8GVH62QzciFhLIGNOUqAxPEPAMeNaYMIl9PjcgIpzya9CXKYaE/
         SQBBiQY5ovG8meLwtPVBh5u8PxOUXuIYTupgxrMdcqk9YSvndHs8R+iKqEa2HGcMnYP2
         CsXXhHkNkhMMx9d/wjgKRbFoGCu0pDX2G7cCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nOPkD46qA6zqYvfk5N1mr7k9F+AjAsV4itAgMMq35k=;
        b=XF5t/DpC0ejZx+SLpssanf/rvm7hIgVh4CFG6l9hYUkGOxG9gpVN2OBoquCSocyiKF
         NOIDi667RdiGCY1hetfgvAK5+9hSqIWMDhmXSNDkg+q3bkS+sytN/yTMfNh0kN9Zbmfk
         dRMicPatk5BZ7XSgC5wMNr2Jfj18VNWuVqquC3eldZIsNQ959Z6MJT4Ev/ObmMXD1UrQ
         S6afg2aSHBbNfy1hzndR5TQLKrFCDkYfWpqYWiPFRTMDcQsm/0XC6OItAYVJ4jnRTktZ
         4ZyXblSn8zGOJt3tuerQfvfgxw8Ye6GngNB1UR7z/O4G+3MTl6B+YxJIAe3RdqSHT9hG
         +11w==
X-Gm-Message-State: AOAM532gSC/VQMEt2Nfvsn6NNF9PtpLB6DkeLJn6DRBr4webBywnu3XK
        cZLtncWiVzRaCwxiafPATliLlVjQDuU8/lJ4
X-Google-Smtp-Source: ABdhPJyCq5xO2wZNRmlLGgQf5dAKnoqSpjqXWVKpeTKyUdDQkoKIi1YTlFQgeshQISWEByRpGZm5NA==
X-Received: by 2002:a2e:165c:: with SMTP id 28mr1196814ljw.355.1606303738144;
        Wed, 25 Nov 2020 03:28:58 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m6sm208464ljp.70.2020.11.25.03.28.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 03:28:57 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id t22so1935764ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:28:56 -0800 (PST)
X-Received: by 2002:a2e:b4c6:: with SMTP id r6mr1243590ljm.248.1606303735968;
 Wed, 25 Nov 2020 03:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20201013124428.783025-1-acourbot@chromium.org>
 <CAPBb6MVM81dQyLJANUH7j8b5uhpk8ERdm9gpsGkF4k1Y-ZkYDQ@mail.gmail.com> <20201124083925.GC3940@paasikivi.fi.intel.com>
In-Reply-To: <20201124083925.GC3940@paasikivi.fi.intel.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 25 Nov 2020 20:28:45 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVZshFO3kiHXeP4FAgJ7am_SjZfcHrbF8h4SXUz+MimVw@mail.gmail.com>
Message-ID: <CAPBb6MVZshFO3kiHXeP4FAgJ7am_SjZfcHrbF8h4SXUz+MimVw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] media: mtk-vcodec: fix builds when remoteproc is disabled
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 5:39 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Tue, Nov 24, 2020 at 08:56:00AM +0900, Alexandre Courbot wrote:
> > Gentle ping about this - we are already well into the 5.10 cycle so we
> > don't have much time left if we want to merge this build breakage
> > fix...
>
> Thanks for the ping.
>
> For the set:
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Ah, just saw these patches included in Mauro's latest pull request.
Seems all is good, thanks! :)
