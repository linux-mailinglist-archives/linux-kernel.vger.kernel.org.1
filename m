Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3061927D15C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgI2Oi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbgI2Oi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:38:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:38:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m12so4676214otr.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zibFhjEW+WLnSL0ei2CrzONpzhgPG74isgsMjUmZmfw=;
        b=iUhmU0GRhiOl+AeQuyPz21nFofYLKi0E9pXLJRGU33L4LmxpTcsA+UEe79zvUEJgPn
         Y/0mJ+LZZHPLzUE3oZcEUQuJzkfeqx9ReRVXNtww6Io/Re6YG5Kq6ojfFJimi7s1wce9
         cDER+doujAO1EigbshPz9ih4VAjR4TqPELu39f7a9S2km59gvoprMQa+62VUylz+eDiQ
         YScXPCBLYQQ7llSYgNgtV937wGqE0eh20SDRpTmk0pcseweqRME2Q4JfEMsJ0dQ0/XuX
         VZgzTQPfWXx400ShPrneFR61mJgHuWfTgwu7v+K9ycyyDtZQX8r3T0BNSNpZxlupcQ98
         B5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zibFhjEW+WLnSL0ei2CrzONpzhgPG74isgsMjUmZmfw=;
        b=hhYCJHhugpksdwbU0ZZHm9tVtzCCZOomrKZGRoS27rXzn05DTjFFQrbv/8sS97VolE
         Zf2O6gea6+4q9YzalOZDQP1PUbi04nH92SC0i83/IOt7BfbN2ahZ7eZwsIoxfSJ1AqBf
         8njX2/PHMnkr+cX5bgRdSuzyMolso6isVF5j4uoibfCknvxFKjj1+i/d4Gg6XlS3yGT1
         Sr5jNhprHtTTbv45FqBFbXV/7ihuJTir6SlvwOI8nfq69wHEIGYSLniuP2psGvl1JkKS
         9jdkdM/9ubjtfVEzxMnAKAC+f1VDaDDzhN2GnnT1/TawEWUDTlnODCFUgd54iKdCUzEm
         RTeg==
X-Gm-Message-State: AOAM531GaagUEK93GSA+EFrXnrUDaw3PmaxyfuypMkn16GdmSlXPiewf
        bmbE3Sc6yzLlKw+N5K/VwbtcVA==
X-Google-Smtp-Source: ABdhPJwMpQcgBCj3FnEYTCgI8hLMNY6ggO/B/xnKVEsHnMugEnuYF7ONsaz1QGquIAohGZzPGat5Uw==
X-Received: by 2002:a9d:32a1:: with SMTP id u30mr2957796otb.55.1601390305140;
        Tue, 29 Sep 2020 07:38:25 -0700 (PDT)
Received: from builder.lan (99-135-181-32.lightspeed.austtx.sbcglobal.net. [99.135.181.32])
        by smtp.gmail.com with ESMTPSA id c25sm2978185oot.42.2020.09.29.07.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:38:24 -0700 (PDT)
Date:   Tue, 29 Sep 2020 09:33:57 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "sidgup@codeaurora.org" <sidgup@codeaurora.org>
Subject: Re: [PATCH v6 0/3] Move recovery/coredump configuration to sysfs
Message-ID: <20200929143357.GE10036@builder.lan>
References: <1601331456-20432-1-git-send-email-rishabhb@codeaurora.org>
 <8222f5fa-2acc-a765-a728-6aad9ed88068@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8222f5fa-2acc-a765-a728-6aad9ed88068@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Sep 03:44 CDT 2020, Arnaud POULIQUEN wrote:

> 
> 
> On 9/29/20 12:17 AM, Rishabh Bhatnagar wrote:
> > From Android R onwards Google has restricted access to debugfs in user
> > and user-debug builds. This restricts access to most of the features
> > exposed through debugfs. 'Coredump' and 'Recovery' are critical
> > interfaces that are required for remoteproc to work on Qualcomm Chipsets. 
> > Coredump configuration needs to be set to "inline" in debug/test builds
> > and "disabled" in production builds. Whereas recovery needs to be
> > "disabled" for debugging purposes and "enabled" on production builds.
> > This patch series removes the recovery/coredump entries from debugfs
> > and moves them to sysfs. Also, this disables the coredump collection
> > by default as this is a requirement for production devices.
> > 
> > Changelog:
> > 
> > v6 -> v5:
> > - Disable coredump collection by default
> > - Rename the "default" configuration to "enabled" to avoid confusion
> > 
> > v5 -> v4:
> > - Fix the cover-letter of tha patch series.
> > 
> > v4 -> v3:
> > - Remove the feature flag to expose recovery/coredump
> > 
> > v3 -> v2:
> > - Remove the coredump/recovery entries from debugfs
> 
> Sorry i missed this and some associated discussion in V2...
> 
> I have also some concerns about the ABI breaks.

Debugfs is not an ABI...

> In ST and I suppose in several companies we have some 
> test environments that use the debugfs to generate and/or get
> the core dump.
> 

I do however acknowledge the inconvenience you're facing...

> Even if the stability of the debugfs is not guaranteed it would
> be nice to keep both interface.
> 

...and I wouldn't mind keeping the debugfs interface around, at least
for some time to allow people to transition their tools/muscle memory.

> It seems that it is possible to create symbolic link in the debugfs
> thanks to the "debugfs_create_symlink" function.
> This seems allowing to keep files in both place without duplicating the code.
> To be honest i have never used this function so I'm not 100% sure that this
> would do the job...
> But if you think that this could be a good compromise, i can test it.
> 

The duplicated code is rather simple, so I don't mind the duplication -
for now.


So, how about we add the sysfs pieces of Rishabh's patches, leave out
the debugfs and then in a while (e.g. one LTS) we remove the debugfs
code?

Regards,
Bjorn

> Regards,
> Arnaud
> 
> > - Expose recovery/coredump from sysfs under a feature flag
> > 
> > v1 -> v2:
> > - Correct the contact name in the sysfs documentation.
> > - Remove the redundant write documentation for coredump/recovery sysfs
> > - Add a feature flag to make this interface switch configurable.
> > 
> > Rishabh Bhatnagar (3):
> >   remoteproc: Move coredump configuration to sysfs
> >   remoteproc: Move recovery configuration to sysfs
> >   remoteproc: Change default dump configuration to "disabled"
> > 
> >  Documentation/ABI/testing/sysfs-class-remoteproc |  46 +++++++
> >  drivers/remoteproc/remoteproc_coredump.c         |   6 +-
> >  drivers/remoteproc/remoteproc_debugfs.c          | 168 -----------------------
> >  drivers/remoteproc/remoteproc_sysfs.c            | 120 ++++++++++++++++
> >  include/linux/remoteproc.h                       |   8 +-
> >  5 files changed, 173 insertions(+), 175 deletions(-)
> > 
