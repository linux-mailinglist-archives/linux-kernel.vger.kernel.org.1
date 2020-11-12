Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5442AFE41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgKLFgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgKLDYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 22:24:37 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69315C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 19:24:36 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q5so3199267pfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 19:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dw/+kFxf0Z+g4MLtsKdkPTZO5yvgI1LNaLgdeBQhODY=;
        b=hMjAkFbLmvhmNmWj8c38O1RbEN6io/uZBkvFy3oaiEzVVhZmT59cp1la/7zJMTKI6f
         uQmt2wNeWPya1XFlXHPe4QvjXuk9v+ale6VWl55D059j6swlRLmuHVYWJqnLLK3/a0L5
         yqQluUVAhavAi8Y6Zdsxxo+VZJF8EGe6e7x4M79xf5f0w2+EGRBRyXLuuP5Gmu+nV3lC
         ck6qjLLh3lmY3pugNiWausNJdpJ3RxcB/VYPzkeG+o+gvIgGnP1jIlN6bWgYW7ex0rGt
         /WC7F12K0ghEcem2IO35Sf2Y3iHHOkFQa5zWL6tdNCziHMRXzl8Xw/GgAvdRXaVpUEXD
         1Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dw/+kFxf0Z+g4MLtsKdkPTZO5yvgI1LNaLgdeBQhODY=;
        b=gbMCmXg47QlwDJvGcVrZ57CqKA4PjysBTMmmRBFoI7IKCvGfHmjYnSySonreGj/G19
         CzFVOnLgU3UIpJpLpazxKJ24Ph6+buNFoaKEWjb4GoDMCIpg17HY0WHOpMe1skQdG77H
         B3u8NXw3ivmn+UiJ4+YZiMit5QCCX1dHF9koYczbUprO8/4r8Dw41GJWNOqC4/hmXSu7
         +LZHRG3F8EnRkTmhZr80KuC+YXHPc1EE8/XwOYvk0gF+UTL2AmlLe+pl6Hcil6qbZ4Fi
         4P4A2aliUA9M9z39KP1neuccPAORYA5ZTdmK2/3AUrcirCLL65hFYpEfO+hIcZL/w+YM
         E/NQ==
X-Gm-Message-State: AOAM532Ml2ci2+P6E/qdeE2ltFmBn9lQPiHteuzjSWuM7eDpxqVwNmrj
        9nqXF18WMDImgoQ1axTVA4wB8gEJvZB1
X-Google-Smtp-Source: ABdhPJx8gOPqki6mKuDTjXfwgqpoZ88hW49qoB7413DCug8EolMYL0aK6FTP56mUNd69MdaQ7duJcQ==
X-Received: by 2002:a17:90b:3781:: with SMTP id mz1mr525724pjb.229.1605151475720;
        Wed, 11 Nov 2020 19:24:35 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:639b:9d11:cd64:b750:3a8a:63e7])
        by smtp.gmail.com with ESMTPSA id n1sm4063033pgl.31.2020.11.11.19.24.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 19:24:34 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:54:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] bus: mhi: core: Add support to pause or resume
 channel data transfers
Message-ID: <20201112032426.GB2491@Mani-XPS-13-9360>
References: <1604961850-27671-1-git-send-email-bbhatt@codeaurora.org>
 <1604961850-27671-4-git-send-email-bbhatt@codeaurora.org>
 <CAMZdPi_dwT+hj26sxJdMS1v-X-MNd1ys34QD=Bf_O+dvmjOD2Q@mail.gmail.com>
 <3710a3051c480bf9d125362303815831@codeaurora.org>
 <CAMZdPi_b7U1iW79mWq7ikxE4jTr+n+-8Y+EZz8i1xro-UcJhjA@mail.gmail.com>
 <c56fa0e7dcbe43d65bbe93cf287372a3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56fa0e7dcbe43d65bbe93cf287372a3@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 10:11:37AM -0800, Bhaumik Bhatt wrote:
> Hi Loic,
> 

[...]

> > > > Look like it is stop and start, not pause and resume?
> > > I wanted to keep it pause and resume because it could get confusing
> > > for
> > > someone
> > > looking at this pair of APIs, that a client driver would also need to
> > > "start"
> > > channels after "preparing" them. Since that is not that case, and the
> > > mhi_prepare_for_transfer() API itself is supposed to also start the
> > > channels, it
> > 
> > Yes, because prepare_for_transfer is actually init_and_start. I'm not
> > in favor of hiding what is really done at mhi_core level, start is
> > start and stop is stop, if it's correctly documented that should not
> > be confusing. just saying (stop moves channels in stop state, start in
> > enabled state), but other opinions are welcome.
> > 
> I can rename it and have it documented in the mhi_prepare_for_transfer() API
> that we actually already start the channel, so it is not required to be used
> at first. I can improve this documentation in mhi.h as a separate patch.
> 
> Later, if a client driver wants to issue stop and start commands, it can do
> so.
> I'm not too picky with the name. Maybe Mani or someone else may have more
> comments.
> 

Please use start and stop to match what the function is doing. We should always
name the APIs with respect to their function.

Thanks,
Mani

