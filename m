Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB7279669
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 05:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgIZDfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 23:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZDfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 23:35:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:35:44 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so4223669otb.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 20:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=r41cvb1N5LxHmvk4/Z1u+DVLxLHsiY0eJOMeFd/1FUI=;
        b=H5Ew1dx9RWLp2Zv3wrDGwnWJ9kvtovj/or5SuxWG5TW34gvkP1WCt38X0STzwaQApU
         GKIaAcgUbc9S4lHb9nOf889CwIuOKJOqT/pKmtmDVU6d/IznJ0qhGPtt73jl4KZcWqG3
         wg3392eGxhSA0yu4/NnqKGS9Dm8qg4tcbOaMof9vZpTWjIW/Ps6wT2W7EWq5XIHg+b1V
         hycKIor7N599PF/QigzHhsI2clYn1/SbwHkBorQeZExOShoxPuizepodAY0E6CL6/SE7
         XHfiBtHiD+MmTIXfeJLKzgiaLRmNmqrNQ+F5gZSV9PAk4+aRZ87p5S06Jx7vzLMJqg9H
         IrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r41cvb1N5LxHmvk4/Z1u+DVLxLHsiY0eJOMeFd/1FUI=;
        b=RDI3czG1L6ytlZxwNxDw/hoWvFPve/NxwmPzIKqx59PZkCPsA9zBpKGAvZELvmNPJI
         2cHymQJaLGrow0wcYKDIvoecguBLkE+7WiMk5NRzh+xs6wPV7AT2FZFQYxWPsKPPvnX4
         eWl3qe8rx0TYpbKsdQPBH5kLcJDGGb0/gqMosUzP7AQSTAUJjBZEBY8WpBPeRRJU3idv
         6T23r0eOJoUTeI8aEJsqaWYLrdtGBEDlhcI4zJM+8YizXIAY6/vFliGRSYZZq5ROO7DM
         Znpx9Ank3Sm5kaU+hiO1YIGzjEHzl5VguViMqOHbCnYsM88pJkj2ROL9+ybwOO3S5Svb
         +kzQ==
X-Gm-Message-State: AOAM531mrIw7HyKN2upoCY8o81PKg4k2qf2gxJnUku87x2mqcyOyybqI
        H3CMStFMptGxx/zXvo8hi/jA0Q==
X-Google-Smtp-Source: ABdhPJxELpmDLw4ZXIMOtwbj8cask50ql1SmQRWsp4jnor195OOSpBobecmfpIme80ehkBSEJrmehw==
X-Received: by 2002:a9d:6a8b:: with SMTP id l11mr2433175otq.273.1601091343437;
        Fri, 25 Sep 2020 20:35:43 -0700 (PDT)
Received: from builder.lan (99-135-181-32.lightspeed.austtx.sbcglobal.net. [99.135.181.32])
        by smtp.gmail.com with ESMTPSA id z20sm333543oor.3.2020.09.25.20.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 20:35:42 -0700 (PDT)
Date:   Fri, 25 Sep 2020 20:31:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "sidgup@codeaurora.org" <sidgup@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Expose recovery/coredump configuration from sysfs
Message-ID: <20200926033109.GA10036@builder.lan>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <7ad40d80-5ac4-97a5-5e05-c83dc08896a2@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ad40d80-5ac4-97a5-5e05-c83dc08896a2@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Sep 02:51 PDT 2020, Arnaud POULIQUEN wrote:

> Hi Rishabh,
> 
> On 8/27/20 9:48 PM, Rishabh Bhatnagar wrote:
> > From Android R onwards Google has restricted access to debugfs in user
> > and user-debug builds. This restricts access to most of the features
> > exposed through debugfs. This patch series adds a configurable option
> > to move the recovery/coredump interfaces to sysfs. If the feature
> > flag is selected it would move these interfaces to sysfs and remove
> > the equivalent debugfs interface. 'Coredump' and 'Recovery' are critical
> > interfaces that are required for remoteproc to work on Qualcomm Chipsets.
> > Coredump configuration needs to be set to "inline" in debug/test build
> > and "disabled" in production builds. Whereas recovery needs to be
> > "disabled" for debugging purposes and "enabled" on production builds.
> 
> The remoteproc_cdev had been created to respond to some sysfs limitations.

The limitation here is in debugfs not being available on all systems,
sysfs is present and I really do like the idea of being able to change
these things without having to compile a tool to invoke the ioctl...

> I wonder if this evolution should not also be implemented in the cdev.
> In this case an additional event could be addedd to inform the application
> that a crash occurred and that a core dump is available.
> 

Specifically for userspace to know when a coredump is present there's
already uevents being sent when the devcoredump is ready. That said,
having some means to getting notified about remoteproc state changes
does sounds reasonable. If there is a use case we should discuss that.

> Of course it's only a suggestion... As it would be a redesign.

A very valid suggestion. I don't think it's a redesign, but more of an
extension of what we have today.

Regards,
Bjorn

> I let Björn and Mathieu comment.
> 
> Regards,
> Arnaud
> 
> > 
> > Changelog:
> > 
> > v1 -> v2:
> > - Correct the contact name in the sysfs documentation.
> > - Remove the redundant write documentation for coredump/recovery sysfs
> > - Add a feature flag to make this interface switch configurable.
> > 
> > Rishabh Bhatnagar (3):
> >   remoteproc: Expose remoteproc configuration through sysfs
> >   remoteproc: Add coredump configuration to sysfs
> >   remoteproc: Add recovery configuration to sysfs
> > 
> >  Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++++
> >  drivers/remoteproc/Kconfig                       |  12 +++
> >  drivers/remoteproc/remoteproc_debugfs.c          |  10 +-
> >  drivers/remoteproc/remoteproc_sysfs.c            | 126 +++++++++++++++++++++++
> >  4 files changed, 190 insertions(+), 2 deletions(-)
> > 
