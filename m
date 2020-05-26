Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2901DF578
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 09:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgEWHTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 03:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387627AbgEWHTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 03:19:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F3C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 00:19:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so6070993pgm.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQpwDorfwvq+V62PfvwOYJvrHs3QMzFsZXgFJo18jk4=;
        b=MSrBnupi+5YHYIwS9y2RbUaGZ+TCSJcSu1bQ5t995mrwnPtUwyNeHzimkw3adTJCXH
         TaKBt18aHyJ9P8w3pjxzliEmQ1b7kQZ46QssUwJBAfUqLfNiws0JdQPs93NWG0kxVE3x
         uaJGm00uYa8KC7gpxNnpYix0fh+2eauT3zeSgFZ3wk2pD06Om/E402x9vAa639q68p4b
         LRrH3rCbfinfjERxe8qqBRejbiGwQ1oSi/6CjN60NPl9sBlLZW3NUa/Vef/zLGm+r6wz
         2tZY+UPo96qmeCB3PT6R/srJXa3q1q0S8irkCs9F/nA6Ki7B1Cwz72RdQq7Vi4pTBcCw
         WCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQpwDorfwvq+V62PfvwOYJvrHs3QMzFsZXgFJo18jk4=;
        b=CYvc3YGBhD/IyYryVgMTmITwvvzn3VhXFUS+nM8TcDXH46MAwL2stzb2V3mafpmyZg
         1dv9eTfrHoMlUibR2vAIvckenlEURtoQ8pcbp3tN/0BLovdG7CkcetfAbqtQivTvs4DT
         ABNxLpOkMENlCu8tWgswznv0z/TFB7Q055CyinQYr4BghQ2izH6jGBbCV7ML4S4cYIOr
         yHkLHP+mBRm5DuCT85ojd6Q1fjWE2Ikn6SApW9DE5qqwfB58Sll0aGPALJypsAtGjwoA
         xZ+dZRJ+sB+XdA3xoDsvWmwMIZPNfcQPLZIL/FLUwcxKpbjzNO1i/JhnPBDVdet9nU7Q
         56OQ==
X-Gm-Message-State: AOAM532m55swPjxk2H/vQ1ctFn0uTTs4+JCqpq1ZmZD0GzBd8WePCOkI
        dLYrbRuxiLH1mu+cLEPyWX6wkg==
X-Google-Smtp-Source: ABdhPJxqFZXbgyrGG2llkCELkJ4vr8owyGAmFuNdn5IWKK4N2BoHTIjn1LpADdQE5iBYiIrZ/JTh+w==
X-Received: by 2002:a63:e50f:: with SMTP id r15mr4250466pgh.192.1590218378840;
        Sat, 23 May 2020 00:19:38 -0700 (PDT)
Received: from dragon ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id d21sm3969329pfd.109.2020.05.23.00.19.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 May 2020 00:19:38 -0700 (PDT)
Date:   Sat, 23 May 2020 15:19:26 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Drew Davenport <ddavenport@chromium.org>,
        Enrico Weigelt <info@metux.net>, Eric Anholt <eric@anholt.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Takashi Iwai <tiwai@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tongtiangen <tongtiangen@huawei.com>,
        zhengbin <zhengbin13@huawei.com>
Subject: Re: [PATCH v1 0/3] drm/msm: Cleanups ahead of per-instance pagetables
Message-ID: <20200523071925.GA28198@dragon>
References: <20200522220316.23772-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522220316.23772-1-jcrouse@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 04:03:13PM -0600, Jordan Crouse wrote:
> These are three cleanup and reorganization patches that were originally
> part of one of my many per-instance pagetable stacks [1] [2] but make life
> better in general and can stand on their own. Send them now to get them
> out of my other stack and make that processs ever so easier.
> 
> [1] https://patchwork.kernel.org/patch/11355255/
> [2] https://patchwork.kernel.org/patch/11355259/
> 
> Jordan Crouse (3):
>   drm/msm: Attach the IOMMU device during initialization
>   drm/msm: Refactor address space initialization
>   drm/msm: Update the MMU helper function APIs

FWIW, on A405 with glmark2:

Tested-by: Shawn Guo <shawn.guo@linaro.org>
