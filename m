Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1327A200A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 15:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbgFSNhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 09:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgFSNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:37:51 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5A0C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:37:51 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id t26so3174134ual.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzzMT40vU3nueiT6DTpLBRPxebRBMtj1EnEAC0klTTQ=;
        b=lVieVKFHIMbkGfDsT0YsJFX6JvJ5/tl5Mcqj1yjwqAnYaMHyuiRLjnES4khXrwMv2R
         26/St6t75HDZ1mdPFMMUda1uJTm8an7A4TxxAUZjUHN5jp4gio8XMweS3SoktVO7yUwI
         oNm1nqAiAXpRbKm6CGu4Pf5wN/2XiuXYTrV/RuG81Id6nLi/1W4PfCZPm2RBSvVn4PAN
         odLO2RWclqOqmJh9ueiL1GOcE+NjhpOLXznaVpCuyfYsyRRvp43AeaXinRLNfjARg3o8
         PBo0nPTXwasf09Wrub66tUkO9FePfJ+j5f/isJNxG9u2i+MX8CESWrVdbxyRbBGN1WHc
         6VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzzMT40vU3nueiT6DTpLBRPxebRBMtj1EnEAC0klTTQ=;
        b=H17NvpvyD5EintDiYrWt/Rn+Sc48vxLzG3aBl+LAmJ3+Daq+rbTT98DyD8SIp5dZpw
         sVpvLZDlnbJWRHikHhLmr7svjr7XAMy9c660QA5Z8eFlZSIW2v9aL2orfBlnVg/JUI+h
         qr9Dv3wg89/Euaa4uh3087w2upXwmyINdscKvXHn9l4AwHnXSkmk2DIrPoIN7s52JDrz
         6dsHz8pEvj4g3sFsmOobz+I3jpY9u0/1byfzcj/+m+qeWOcIS3lQMAZdWdxb6owBeAR7
         pRt7ruzUXVEOYMVwcXnGCbqqjXjjkNNtpqiYtKIIWLzAqI26QhBnyuq/fNGa4Anwyjbl
         R9jA==
X-Gm-Message-State: AOAM530DtJaU8o5B0ufOG+87dqCPua8RxYWmB8Jju/hjtfKsFvU59HIS
        kSfW+0R/6LBAAbMbXVo4mZ8NERQUsTIw/Y/Qc+M=
X-Google-Smtp-Source: ABdhPJwqP4cpSQgvarPxYyjwPQGxxrCrpQXZojI2NIRRKdDcJEEr8HedRcOSMfFudxTnsQb7cw1+GTx84HgvyTzcGM0=
X-Received: by 2002:a9f:2375:: with SMTP id 108mr2738865uae.74.1592573869965;
 Fri, 19 Jun 2020 06:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com> <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <23babf62-00cb-cb47-bb19-da9508325934@intel.com> <CAD2FfiFbGdf5uKmsc14F4ZuuCUQYFwfnirn=Y0fu2F0=njvWug@mail.gmail.com>
 <80578b72-cb6f-8da9-1043-b4055c75d7f6@intel.com>
In-Reply-To: <80578b72-cb6f-8da9-1043-b4055c75d7f6@intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 14:37:38 +0100
Message-ID: <CAD2FfiG1BgYvR6wkeXGro8v6FQtVjKemmAOOf2W14z5KUWLqhw@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 14:33, Dave Hansen <dave.hansen@intel.com> wrote:
> On top of that, the kernel can just swap data out to unencrypted storage.

Right, but for the most part you'd agree that a machine with
functioning TME and encrypted swap partition is more secure than a
machine without TME?

> So, I really wonder what folks want from this flag in the first place.
> It really tells you _nothing_.

Can I use TME if the CPU supports it, but the platform has disabled
it? How do I know that my system is actually *using* the benefits the
TME feature provides?

Richard.
