Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AE72881A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 07:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgJIFPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 01:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgJIFPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 01:15:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206CC0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 22:15:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so5885275pfk.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8Nv66WyfzDbZb96ZzpHY2rCT/XGW71eFKJ/39nR8TI=;
        b=XCoNHHpR6Vhu0dp1FPc+9nNkBsd5828pOu6BwS+P8s2Vdorubxx2Y2IAtZsi/nMaca
         e+TkRySMistYnVoFo5Z9bLk7QRa4W6weIKbFGeJH0Vz5orS5mNhLXq3Hxd9Fa5Tgf1sI
         NhlYxCX+6eRYUbGun4XXVlbz7e6EjJaYRoKlddaptvY/bK1P1mXBltBbFfrGjZpRJxNo
         8xmC36xR0mcZ2Hjz/k2WlRrVCyu5dIOr9dlLZQKsLf81SC+yNk2TPlU20njb/v3X2Szc
         S2LTCV6AQnPdmhhH3HzZywkVzzDzkuiRUNg86ydh+cG09bU/omt0wDu3NEc9XYv88M89
         xn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8Nv66WyfzDbZb96ZzpHY2rCT/XGW71eFKJ/39nR8TI=;
        b=dkIBTaOraGQuCc3i7sI9if+3MyhwWmYbUI0VNwE7iaqgoVljWSBOsYVdeB50dSnpz9
         T7J1/TeZXp7SQ4aM4/hP0NfKXVhyF21DubKCzW6EjNwVJXmCOLhEjR4LiRnFzj3Sj72V
         Ww9ZnIodCo3mTnL/5BmU66p1ZU1JXKKGToXz17n9631Mo/P5sQ0fM/rxIJqT6uTWl2A6
         K23393dfKa8CfHsHgppU4MysuFDuJPkcjrf9YT8aIxbFuOoNRCRL1/z2G4AxBURUqaT0
         kNtsMRZ/lN3bK67Zk9VYTl0osNfARwZfj//K0Fj582OFlr6XSDcgzFEAfj9dbwMJD/iW
         rYAA==
X-Gm-Message-State: AOAM531LbzSLWiHBzC0gf0j5aCIX9wLqsAUOvsaYLiJDnNeyvFRnTWbs
        QlwpgppmZUtVGlp4JUAqBfrbsA==
X-Google-Smtp-Source: ABdhPJwMAbt3m8tzVuwutYCoq9Ex4jJiYU6jAHGkyZslmrwAEnxhVZ77mlrygUBEez+RF7uvOzZPlg==
X-Received: by 2002:a63:d046:: with SMTP id s6mr2103311pgi.76.1602220534209;
        Thu, 08 Oct 2020 22:15:34 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id gd14sm9188455pjb.31.2020.10.08.22.15.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2020 22:15:33 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:45:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Register EM power table
Message-ID: <20201009051531.gmlpv4wnpbtyqldt@vireshk-i7>
References: <1602159204-13756-1-git-send-email-hector.yuan@mediatek.com>
 <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
 <20201009041912.nzhvubzmfox2twxg@vireshk-i7>
 <1602218579.21446.57.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602218579.21446.57.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-20, 12:42, Hector Yuan wrote:
> On Fri, 2020-10-09 at 09:49 +0530, Viresh Kumar wrote:
> > On 08-10-20, 20:13, Hector Yuan wrote:
> > > From: "Hector.Yuan" <hector.yuan@mediatek.com>
> > > 
> > > Register CPU power table to energy model framework
> > > 
> > > Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> > > ---
> > >  drivers/cpufreq/mediatek-cpufreq-hw.c |   50 +++++++++++++++++++++++++--------
> > >  1 file changed, 38 insertions(+), 12 deletions(-)
> > 
> > I don't see this file in mainline. What am I missing ?
> > 
> Hi, Viresh:
> 
> Yes, I base on my patches which is currently reviewed by Rob for the
> Device tree part.
> As I mentioned in cover letter.
> 
> This patch depends on Mediatek cpufreq HW driver patch submitted by
> Hector Yuan.
>  https://lkml.org/lkml/2020/9/10/13
> 
> I have asked your approval for sending my new patches based on it and
> you said it's okay to you.
> I will stop sending new patches if you have any concerns.
> Thank you so much.

Sorry about that, I failed to see the details in the cover-letter.

-- 
viresh
