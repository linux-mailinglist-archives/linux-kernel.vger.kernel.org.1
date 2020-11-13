Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD62B1EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKMPiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgKMPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:38:07 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4926CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:38:07 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so8482332wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=57krU+NCAgGExjwCBwh+1UXaHAkBn07nSnJKylJjuGM=;
        b=wvk2SAsnBz1AqRznm6MHeicgMLWvf+oOvhW5mWJqCxX3Ap/wvECXGNAeUffJeSteSy
         6yVy7TBo1KAMRAH6kZiUR2kHTBigQz/2F5ozKsDvHJSvy45IvRUgUvrJJr8VRv+KrNj7
         B5fj/5jzoNMWXUgGLkiN/l/e+eDvBIqRn+OMryFaYGnHWa2R8kfS/GjPWBt1eDI56usk
         qEHh0YJxM/AIY3Q1mwNcS+gW4cvotXg5VSGtcEeG5EFZ5A7s/0TrznC7aAkWs/+FvmYR
         iDex9aTS2wBcHmilbplmnnvLn0yjHYf66r2xOErSxuzuUg36GqAeNEQb/kOpAr5iyAx/
         UpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=57krU+NCAgGExjwCBwh+1UXaHAkBn07nSnJKylJjuGM=;
        b=QtJTGQMc9aca/0ZwScz3BYnYJFJmCsGO51BXU7vzaMC7FmTxIbyoTFu/m0dhqnZtxw
         bLoWYt437F2zkWrxK0VjRWXz24tj3sMRzfACA6ksxooTzH/y/pOGXUfMuQfF8AZvYa2m
         1VDO7EkgCPvdoq1FLAG2aeOiE7PRWhG3bf4Wj1nFf9yIh9/YHq3kPBC33VIeJUCVdCLY
         UARg4FbCY66MbxZbK2+cSuIb906OSfHG1+27fVAV+RNEIEr3+Husk79vIncF6vWLKaYD
         3TQAaKm3YdH0jrgAJ4FAQoXGbMnFopqdett7QPIz1yvDhHpYu8O78GwYD6tcicAEf+UZ
         l3RQ==
X-Gm-Message-State: AOAM533kf9HxfHnDfzfN/4Jx6LY/Yz+BfBKhEIz7R19BTAYjglQnsQrg
        ue4z0L7wZpWuXVsISRwE7LD+tQ==
X-Google-Smtp-Source: ABdhPJw/w0xhz0igmXwp0dWR2Xj5eHRrCOia2mdOHn2WNy0yqwhxY5Ys95iE19FcJiIDKasYbhXR1w==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr3245377wmg.161.1605281881173;
        Fri, 13 Nov 2020 07:38:01 -0800 (PST)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id f11sm11435902wrs.70.2020.11.13.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:38:00 -0800 (PST)
Date:   Fri, 13 Nov 2020 15:38:00 +0000
From:   Jamie Iles <jamie@nuviainc.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
Subject: Re: [PATCH 00/24] x86/resctrl: Merge the CDP resources
Message-ID: <20201113153800.GA2754@poplar>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Oct 30, 2020 at 04:10:56PM +0000, James Morse wrote:
> Hi folks,
> 
> This series re-folds the resctrl code so the CDP resources (L3CODE et al)
> behaviour is all contained in the filesystem parts, with a minimum amount
> of arch specific code.
> 
> Arm have some CPU support for dividing caches into portions, and
> applying bandwidth limits at various points in the SoC. The collective term
> for these features is MPAM: Memory Partitioning and Monitoring.
> 
> MPAM is similar enough to Intel RDT, that it should use the defacto linux
> interface: resctrl. This filesystem currently lives under arch/x86, and is
> tightly coupled to the architecture.
> Ultimately, my plan is to split the existing resctrl code up to have an
> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
> MPAM can be wired up.
> 
> x86 might have two resources with cache controls, (L2 and L3) but has
> extra copies for CDP: L{2,3}{CODE,DATA}, which are marked as enabled
> if CDP is enabled for the corresponding cache.
> 
> MPAM has an equivalent feature to CDP, but its a property of the CPU,
> not the cache. Resctrl needs to have x86's odd/even behaviour, as that
> its the ABI, but this isn't how the MPAM hardware works. It is entirely
> possible that an in-kernel user of MPAM would not be using CDP, whereas
> resctrl is.
> Pretending L3CODE and L3DATA are entirely separate resources is a neat
> trick, but doing this is specific to x86.
> Doing this leaves the arch code in control of various parts of the
> filesystem ABI: the resources names, and the way the schemata are parsed.
> Allowing this stuff to vary between architectures is bad for user space.
> 
> 
> This series collapses the CODE/DATA resources, moving all the user-visible
> resctrl ABI into the filesystem code. CDP becomes the type of configuration
> being applied to a cache. This is done by adding a struct resctrl_schema to
> the parts of resctrl that will move to fs. This holds the arch-code resource
> that is in use for this schema, along with other properties like the name,
> and whether the configuration being applied is CODE/DATA/BOTH.
> 
> This lets us fold the extra resources out of the arch code so that they
> don't need to be duplicated if the equivalent feature to CDP is missing, or
> implemented in a different way.
> 
> 
> The first two patches split the resource and domain structs to have an
> arch specific 'hw' portion, and the rest that is visible to resctrl.
> Future series massage the resctrl code so there are no accesses to 'hw'
> structures in the parts of resctrl that will move to fs, providing helpers
> where necessary.
> 
> 
> Since anyone last looked at this, the CDP property has been made per-resource
> instead of global. MPAM will need to make this global in the arch code, as
> CODE/DATA closid are based on how the CPU tags traffic, not how the cache
> interprets it. resctrl sets CDP enabled on a resource, but reads it back on
> each one.
> The attempt to keep closids as-used-by-resctrl and closids as-written-to-hw
> appart has been dropped.
> There are two copies of num_closid. The version private to the arch code is
> the value discovered from hardware. resctrl has its own version, which it
> may write to, which is exposed to user-space. This lets resctrl do its
> odd/even thing, even if thats not how the hardware works.
> 
> This series adds temporary scaffolding, which it removes a few patches
> later. This is to allow things like the ctrlval arrays and resources to be
> merged separately, which should make is easier to bisect. These things
> are marked temporary, and should all be gone by the end of the series.
> 
> This series is a little rough around the monitors, would a fake
> struct resctrl_schema for the monitors simplify things, or be a source
> of bugs?
> 
> This series is based on v5.10-rc1, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v1
> 
> Parts were previously posted as an RFC here:
> https://lore.kernel.org/lkml/20200214182947.39194-1-james.morse@arm.com/

Reviewed-by: Jamie Iles <jamie@nuviainc.com>

Jamie
