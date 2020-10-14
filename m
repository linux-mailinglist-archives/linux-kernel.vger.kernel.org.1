Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB728DCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbgJNJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbgJNJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE6C0A88AB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:11:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w21so895712plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 18:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Av0sc24i6lEFhIAnbFGzZuUEOiE1zUu95DhFP+t05mI=;
        b=lbJSJHY/T/sf3n00RFb4Anqy7341XAb2OH1+6dgS+1b7uE+qssx0RXYhLX1nzdZ4AA
         i3sq37VHoJqeSJHfUIOVwbgnVd3UX87aancDK5X/JB/FXc1tbWCBPCx4udj6QnmkDDn6
         TIiUvwJ0dGfSH9DLT5vsU10ZG4WPueSef65ydYWmzAXciBWYNkQ+viqcTQi9izPyp7mV
         Cf4orD9ionuvIiBWY0pTkYAxlHWBkm7eTbl0nGJ92weERTCrs3UPCFKWP0SIfxhfrGOU
         ia15GddIa+ZpOE9I0hVcFm87Lk02c8RTURGuwMpqooxblgtWTKclB96xafe9myfmUhVz
         e1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Av0sc24i6lEFhIAnbFGzZuUEOiE1zUu95DhFP+t05mI=;
        b=ZMNK10wbH6BCcy9WjYnERznKUBtqAHyCpCnjo93klWysJioIp/ef4l7fu57thJlTKS
         W7pcZoJOTP2opsvjnwg8kRlv00114QAaYzquUnjHft7tnjBTaqqx8Bub5kScpHR7gbpg
         YLf1lnO4E8uBWnKs7aClv0KRqLRpvuM5OhwvDfBUTVV5Gmd1TXObj5V0iKipSKz0/O9z
         5YDBDHNRePzO03w5rOiP5M4nm2FSMPgoID63zlzd6tl6k0zikZ8hBNLiDTsh7J9Av2/8
         snGbHpr+VQYtzx3EyHS5/GFfSz8NXJ2dBGMZrTkU46NBEi/c+b/HA065Ax4ef+zi0ZNS
         pjBg==
X-Gm-Message-State: AOAM533LhavPzqwcOudZ7m9SnhnCwuf5YDeSeG2HBCGbbSVnnCoq3YW0
        1nHr9zwLhuHi5Qcbu3+ON8Tp2w==
X-Google-Smtp-Source: ABdhPJw2OLUmmzB62nzgQa4UFjuOB9DXZuivQ12f8SyW7c+JRkR5SjZ94Rh05ZP3z3U7hzfMJQHy/g==
X-Received: by 2002:a17:90b:438c:: with SMTP id in12mr1068864pjb.32.1602637917349;
        Tue, 13 Oct 2020 18:11:57 -0700 (PDT)
Received: from ?IPv6:2600:1010:b055:a6b7:fd8a:19ca:e5b3:189e? ([2600:1010:b055:a6b7:fd8a:19ca:e5b3:189e])
        by smtp.gmail.com with ESMTPSA id j11sm941451pfh.143.2020.10.13.18.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 18:11:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 13/22] x86/fpu/xstate: Expand dynamic user state area on first use
Date:   Tue, 13 Oct 2020 18:11:55 -0700
Message-Id: <78F221DB-CB61-40DB-9C6F-6C86D0F1BCDF@amacapital.net>
References: <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <c4669d5f-11b8-3879-562c-78a791b86229@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 13, 2020, at 3:44 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 10/13/20 3:31 PM, Brown, Len wrote:
>> vmalloc() does not fail, and does not return an error, and so there is no=
 concept
>> of returning a signal.
>=20
> Well, the order-0 allocations are no-fail, as are the vmalloc kernel
> structures and the page tables that might have to be allocated.  But,
> that's not guaranteed to be in place *forever*.  I think we still need
> to check for and handle allocation failures, even if they're not known
> to be possible today.
>=20
>> If we got to the point where vmalloc() sleeps, then the system
>> has bigger OOM issues, and the OOM killer would be on the prowl.
>=20
> vmalloc() can *certainly* sleep.  Allocation failures mean returning
> NULL from the allocator, and the very way we avoid doing that is by
> sleeping to go reclaim some memory from some other allocation.
>=20
> Sleeping is a normal and healthy part of handling allocation requests,
> including vmalloc().
>=20
>> If we were concerned about using vmalloc for a couple of pages in the tas=
k structure,
>> Then we could implement a routine to harvest unused buffers and free them=
 --
>> but that didn't seem worth the complexity.  Note that this feature is 64-=
bit only.
>=20
> IMNHO, vmalloc() is overkill for ~10k, which is roughly the size of the
> XSAVE buffer for the first AMX implementation.  But, it's not overkill
> for the ~66k of space that will be needed if some CPU implementation
> comes along and uses all of the architectural space AMX provides.

I have no problem with vmalloc(), but I do have a problem with vfree() due t=
o the IPIs that result. We need a cache or something.

I have to say: this mechanism is awful. Can we get away with skipping the dy=
namic XSAVES mess entirely?  What if we instead allocate however much space w=
e need as an array of pages and have one percpu contiguous region. To save, w=
e XSAVE(S or C) just the AMX state to the percpu area and then copy it.  To r=
estore, we do the inverse.  Or would this kill the modified optimization and=
 thus be horrible?=
