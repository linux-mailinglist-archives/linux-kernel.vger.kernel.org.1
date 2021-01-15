Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FD2F710B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbhAODfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbhAODfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:35:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D8C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:34:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cq1so4288153pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W07ZLPVszbueA12F97uxqmYwsZjLziE6s+z1n5bz+MA=;
        b=wzlU1v608Bp/5Fbh2LlphjOSHK6mVDaFC9eNHaDC2tGh7ihu4qx096kwF8127c89Ll
         jthd9Pm03WUosaLQezx/FRs71g/jon1IpEWnRmEIJEaa3/RqTfuKh6EMgw46I8CXq3D9
         /yeQBRNBhq99IYpe4/dgheqrWnGGRqaYp/pD0KqlsmA1/e3f3WRIf+s3I5FSkj6zEi7s
         mSj3ocJxC5OWg1FORIgSX/GK+xHgCI/Dhp8fJw5qax5XWl3Z/oGS5Gv9uAB9MWHMXIod
         s7Jvto4y8yKloaXd1xK705vZEuAc5yfmVaCbXy26Vk1daNcozz+ePsuEWmbi/gaCCTJB
         l6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W07ZLPVszbueA12F97uxqmYwsZjLziE6s+z1n5bz+MA=;
        b=IWbnntyDZB2ItGu6NNQOkC53ybCHVQOfgbQM2Gs62cTFqhO9KN33sSypZSfnhCyy/P
         VszkfEnArZG7Pb76w4IlP5+KPUzNEx4yIIppCNswrcwG6XReam8d0E8BYMZ+chnfAInh
         buG7Qve/89FAZD0GB2Ux+QI3lSEZznQP2OkxnHovsV0XzPgvwQpkgh0RUDdwvbU6Z6pc
         jNwuLD7qCCvoexPPHK98xUZYGp2lqFCfRBP8dpI5yXyXxwrdNPviP3jMy2mUfyGDkjqw
         9mc1G9pQUSSpHj3POadfHnUAtQ8soXzRE6lmIdQulMFXeeQ/P223ADS1AvLhN7ynJyly
         UYLQ==
X-Gm-Message-State: AOAM532Swbt5n0VDlSyqV5noOqWbfnZzllTquJQU9b8QJan5aZdHcsCL
        9of+Y8fJxvZuOCiaGsQHh1diQA==
X-Google-Smtp-Source: ABdhPJyYdlMuN2pkKJ7RYKVFFcTi9PZ8+oVHWdgcn5YANMzdEyqNgbQgng2M+wNGbbyh/9Rvip/U2A==
X-Received: by 2002:a17:90a:4cc5:: with SMTP id k63mr8252416pjh.202.1610681673757;
        Thu, 14 Jan 2021 19:34:33 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id w19sm6454293pgf.23.2021.01.14.19.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 19:34:32 -0800 (PST)
Date:   Fri, 15 Jan 2021 09:04:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "anmar.oueja@linaro.org" <anmar.oueja@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/18] arch: arc: Remove CONFIG_OPROFILE support
Message-ID: <20210115033430.rzyja2diwp7lbmni@vireshk-i7>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <906d9d40746bb1b60823a288d00820cb50d29138.1610622251.git.viresh.kumar@linaro.org>
 <16e1ec02-e6da-b49d-ee21-c98660605cf8@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e1ec02-e6da-b49d-ee21-c98660605cf8@synopsys.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-21, 17:51, Vineet Gupta wrote:
> On 1/14/21 3:35 AM, Viresh Kumar wrote:
> > The "oprofile" user-space tools don't use the kernel OPROFILE support
> > any more, and haven't in a long time. User-space has been converted to
> > the perf interfaces.
> >
> > Remove the old oprofile's architecture specific support.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> 
> I presume this doesn't need to go through ARC tree.

Yes.

-- 
viresh
