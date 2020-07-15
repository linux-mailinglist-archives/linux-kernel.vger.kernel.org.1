Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB2220565
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 08:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgGOGru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 02:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:47:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754A3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:47:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so4398350wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pFEdwPrFAGXygP0PLmBw7h9OMC5JQetuJaGwPug3T84=;
        b=XGBsIWWQ4rQmBhLUNdm6ehB4cRfkZzVoo4evT3I5MZ7SfXhse4jI7tKro6tlGtAKvx
         vcNzSB6Y57nsLmW1KhHblZDArOxm5UCyl04aTLIywFjrAO6Bb420IPRy+hJfGCI/Nwjf
         IPzjST6rchSVPzMXhsSXZ/Bpx5vG4JxqkeYf57lar4VEG6Twy7oe/ew/R1EeWc5epv+O
         z9LPHPkZpbgNmnq/TAqRkLbGPBZgSqrF7GCZ4Km2IernIXhXtNVrqPi5Kc+j+Szq5/a1
         kvfGT3WcEan0m5hUkC2tLVzin5iVOaSvKqUYm+4lw1rjmisSWY35681iqCSc/NbwDyBq
         N08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pFEdwPrFAGXygP0PLmBw7h9OMC5JQetuJaGwPug3T84=;
        b=Br8QBm6U0yGDqgtymcyYzRJtpa4S+MNKcxy11FQ3H0vOnbVLggpJJj+ae2nF0lXdKf
         t27p3Wwd5jYRmDlP8/IliGzFWgrSHVdXfhlkj69HOwPP7DNGksGOKWPUGgVFLo0Q/3F2
         /08hU1jElMA58DrfDCBRNJK78r2T7a5VZlRogBGZnKbt086PN03jVVReA6jKbetjcE4h
         8BTX1PhEW5ExD1kPDm5Ahzhka+/lWj9Ud8ELRZL2PI10zf6yakOqYDRaSn/oosPIcBQ2
         InFmzW2wtwNVXgp8IHOYJMXmHkRHprgatBLXbeWd5LlUzgPxlDgTmBvTbk0WZTUgEt5F
         2tpQ==
X-Gm-Message-State: AOAM530beJ3MeSgDioPZ5Q10F2VEuaDd1M3aHF0e1oij9gnnjY1DMNGN
        kf7uNdWhNnYIRdXF0xS06c4hgg==
X-Google-Smtp-Source: ABdhPJx+NTfnG9znaTGAktM3qpcuI/D+Sz92/+h/drddXvIQvTwedXSgGSKR6+Zl3zCJHSv8iY4C9A==
X-Received: by 2002:a05:600c:2209:: with SMTP id z9mr7012030wml.178.1594795668190;
        Tue, 14 Jul 2020 23:47:48 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id r28sm2048595wrr.20.2020.07.14.23.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:47:47 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:47:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 13/13] cpufreq: amd_freq_sensitivity: Remove unused ID
 structs
Message-ID: <20200715064746.GU1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-14-lee.jones@linaro.org>
 <6101e041-41e9-22bc-488d-38124c139bc7@amd.com>
 <20200714210218.GH1398296@dell>
 <8f7f2325-8c6a-b005-1f27-67e4b640da31@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f7f2325-8c6a-b005-1f27-67e4b640da31@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Kim Phillips wrote:

> On 7/14/20 4:02 PM, Lee Jones wrote:
> > On Tue, 14 Jul 2020, Kim Phillips wrote:
> >> On 7/14/20 9:50 AM, Lee Jones wrote:
> >>> Can't see them being used anywhere and the compiler doesn't complain
> >>> that they're missing, so ...
> >>>
> >>> Fixes the following W=1 kernel build warning(s):
> >>>
> >>>  drivers/cpufreq/amd_freq_sensitivity.c:147:32: warning: ‘amd_freq_sensitivity_ids’ defined but not used [-Wunused-const-variable=]
> >>>  147 | static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
> >>>  | ^~~~~~~~~~~~~~~~~~~~~~~~
> >>>
> >>> Cc: Jacob Shin <jacob.shin@amd.com>
> >>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>
> >> Same comment as for patch 9/13: these are used automatic module loading.
> > 
> > How does that work?
> > 
> > Could you point me to the code which handles that please?
> 
> It's MODULE_DEVICE_TABLE magic.

I'll look into that.  Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
