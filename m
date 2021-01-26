Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F357B303AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404460AbhAZKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731803AbhAZCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:30:21 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9638C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:29:40 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id k8so14893066otr.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lAYAXdMyLMF5Dni72sepi97NFATWAZD2AbjHY6swVm8=;
        b=CcS/D9NYwdQ83fLVPXbVOa8dHEiLDjVWhXD5iVQcTt5NkLBV2p9xrtPlZxbI5GJuJe
         Po1TUdy5wIw3j7feqh/MRefNJC9HlKeXAHWXiO1jHSS4rYl1kLQ5jolMmqh09kJqT7Tm
         6/Sa/BC9euXhqruJ2zLiFxKx6TWkabU+XvAXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lAYAXdMyLMF5Dni72sepi97NFATWAZD2AbjHY6swVm8=;
        b=hpC3qJfYeoEFSIKepkawetG/5Pt+LFCv4TJop7ZTzMEsdtpKr8Q52a5cX2NWUvP2v/
         25LYou8GBi0hfOmk5+7Rzl4nxa5NdW6JBnFTz96j0tEzLmJToV+knSwBasU9QHttWbbG
         mLi6GtfgCPysKQR/TO0Ii/5kjCY+gY8/y6FpDJ8cKRKTcESuXW3JHUgcdsVFKaVEhO8n
         OR9KAyZ/OyZScII54g0sGRL4RVCgBHMgVbVMEJN+Ka03h23Uh39HjvvP36QAl3AD/arQ
         cdj06oT8a1NQv6zKnjXs8HSBE2Giv0KU69wnWSUWpSqN9NU8/ZWr7J9z2XYg+oHkQqKh
         NW0g==
X-Gm-Message-State: AOAM533wQQ0036QAN2XE7QuTbIIhKguEmVIcZTgpLd5/BJ0L6m/3qbYS
        QEcFCAn9BgU3U3j9ufHrCSR86rav05wckA==
X-Google-Smtp-Source: ABdhPJz/pOcPf+yb6NTBlCxWWwe5knLtz3pztlTTJOrzTMo1iTpSWl6cF4uwKk4M+ZIIh+LW5qKEGg==
X-Received: by 2002:a9d:4587:: with SMTP id x7mr1736935ote.274.1611628180134;
        Mon, 25 Jan 2021 18:29:40 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o16sm3851831ote.79.2021.01.25.18.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 18:29:39 -0800 (PST)
Subject: Re: [PATCH v4 05/17] selftests/resctrl: Add a few dependencies
To:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
 <20201130202010.178373-6-fenghua.yu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b4f84985-8c98-3b56-3ecc-8258361302d4@linuxfoundation.org>
Date:   Mon, 25 Jan 2021 19:29:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130202010.178373-6-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 1:19 PM, Fenghua Yu wrote:
> Add a couple of sanity checks and the config file for test dependencies.
> 
> Running any resctrl unit test involves writing to resctrl file system
> and only a root user has permission to write to resctrl FS. Resctrl
> test suite before running any test checks for the privilege of the
> user and if it's not a root user, the test suite prints a warning
> and continues attempting to run tests.
> 
> Attempting to run any test without root privileges will fail as below
> 
> TAP version 13
> ok kernel supports resctrl filesystem
> .................
> not ok mounting resctrl to "/sys/fs/resctrl"
> not ok MBA: schemata change
> 
> Hence, don't attempt to run any test if the user is not a root user and
> change the warning message to a bail out message to comply with TAP 13
> standards.
> 
> Regarding the second check, check_resctrlfs_support() checks if the
> platform supports resctrl file system or not by looking for resctrl
> in /proc/filesystems and returns a boolean value. The main function
> of resctrl test suite calls check_resctrlfs_support() but forgets to
> check for it's return value. This means that resctrl test suite will
> attempt to run resctrl tests (like CMT, CAT, MBM and MBA) even if the
> platform doesn't support resctrl file system.
> 
> Fix this by checking for the return value of check_resctrlfs_support() in
> the main function. If resctrl file system isn't supported on the platform
> then exit the test suite gracefully without attempting to run any of
> resctrl unit tests.
> 

Please use kselftest.h instead of adding TAP stuff. This way if updates
to newer TAP will not require changes.

thanks,
-- Shuah

