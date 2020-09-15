Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397F926AE11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgIOTuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgIORKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:10:50 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E019C0612F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:00:32 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id r78so990025vke.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AD44iUMYidPiEvY0GREEGObw8s+cZqGFqFLZt/WuWbY=;
        b=HXXdpEQu7Pg7iPzOEaa08AqlWK3FNqlZevxpAIv60vMGwoWlBshZDNmw3Sw33p+IJJ
         O5dG1xbSbC+g24gEX/HVlccbvpQBGBXG18HZA7mwmby4fM1dQJccbJvUHnfV8DIv6qA4
         qk36l5nqIP8fepYx0Nh2UYAGnOPjOQ8AYkQzw9kp2LZj2UOQWOunLTzXyMeT2CY3CGTT
         HkrpIOrWybwprMRsiBIaTH0f1nIUqMj/lGT4KtaapT1FRAxIRME1VX0rJCLObHBtHzYR
         mkO/hS0B2EEqdHG7sLsRQpNs1g9GuSId5vVjiInO5ySX9awBX2fZgdTYY6gYKw4ye8pe
         c3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AD44iUMYidPiEvY0GREEGObw8s+cZqGFqFLZt/WuWbY=;
        b=qn2Ah3asndoIHSv4v1JNnta67P7LWfBr8cyX5NkvgUcHKfxe3sZJ0JGrXOygJTjlVy
         I7Dsyra8X/HmOtQKF7Ufjhgddws6d7np2NPSpD/El5/AfWLgOqarB664GWn+CSdo+7UO
         bDU7GrGXGTAFqASTM+z8tZLoNGu4ZLz0lu1CD1B2vLW3l1DhOtey9Ct/+IJG/1DpobJ9
         6MV/Lz6AtK0nNvb2dNNBTQtlXeYCWBLvLywSObbxcmy3ztD6ll94/YcEQBa0LDkGLmeC
         qHXAsdANhmHxveATOHaT3MPXHAy7/HzRaRNqYPfDB2OghcQLaVQu9TPjAZIyLr0RJY3q
         fhAA==
X-Gm-Message-State: AOAM532MO6qiUyjOqkaaqfkYb4c5VdvTBHh0GCPOZ9eclZ+xnqdaQE/r
        4wdh5K4vnp+qUA5AaI0Ay61NtkrGuuFCq9xAieVhzw==
X-Google-Smtp-Source: ABdhPJxyiyh7xsUQINRaFa+K9y6YtLwuY9B97luN6UU9cNTRgWjfWfKwWmuV2bx1S55GGixSJn7HoJPKCiN/Z0lSV+A=
X-Received: by 2002:a1f:964c:: with SMTP id y73mr11317771vkd.8.1600189229548;
 Tue, 15 Sep 2020 10:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200901025927.3596190-1-badhri@google.com> <20200915133347.GK1139641@kuha.fi.intel.com>
In-Reply-To: <20200915133347.GK1139641@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 15 Sep 2020 09:59:53 -0700
Message-ID: <CAPTae5LbTO0MH6VasNXzHTR1UkiuR4Qw52V3nVus-7-e6UB4Tw@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] TCPM support for FRS and AutoDischarge Disconnect
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 6:33 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Aug 31, 2020 at 07:59:13PM -0700, Badhri Jagan Sridharan wrote:
> > First of all apologies for mixing up the patch version as noted by
> > Heikki and Greg. All of them were v1's but since I was manually adding
> > the version numbers I mixed them up. Using the --reroll-count option
> > now. Updating the patch version to v6 (highest version number in the
> > previous patchset + 1) to avoid confusion.
> >
> > I also rebased on to off of the recent usb-next tip:
> > 5fedf0d295d3 (origin/usb-testing, origin/usb-next) Merge 5.9-rc3 into usb-next
> > Which had the following changes causing merge conflict:
> > 3ed8e1c2ac99 usb: typec: tcpm: Migrate workqueue to RT priority for processing events
> > 6bbe2a90a0bb usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart
> >
> > Addressed comments from Heikki and Randy which have described in the
> > individual commit's change history as well.
>
> I'll try to study the AutoDischarge a bit before reviewing the last
> patches. They all appeared to be only about AutoDischarge. Sorry, I
> didn't have time for that yet. If Guenter is fine with those, then
> feel free to add my ACK to those patches. But Guenter really should
> review these in any case. Hope he has time.

Really appreciate you spending time on reviewing the patches. So
thanks for doing that.
I quickly went through the comments you have given. Will respond today.

Thanks & Regards,
Badhri

>
> Br,
>
> --
> heikki
