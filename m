Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D952D436D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbgLINi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:38:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39931 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732122AbgLINi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:38:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id b10so33809ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IukETWfqH6ox1WbzVI/W4GyBftlO5/jzl1XbHNhzids=;
        b=h1pSfqRc8xy/kNvkcPJH9lzU0xu84E6WMq6Uqj+lbPC0xqLHPeJmTVykYS0EhpVLgY
         cOMmLdQukj9di3+vrnbB4Z6Sld8Ty/f8ZJ+PqWVyyxP76e9IJSgvHnXvm6l1gFb6QzTb
         N4LZklCUC0rbYUps6qVYwvo5tAwpvT3/GuUcBsKh2uSBn2GJkLfHyog3800ZHpPmoHZp
         instlO/skNeV/iHUFzWZKV/g6BSpMkXgOxrr6W9P4nHgmxdeXPdkAHg8NhS/iSffXee2
         iFHCa7pnXPxGEBVwtgA+k1CqwSseaD+pkNWFmQ4nSCfvCe4ZUd2dyP3+vk/fp/VqSVl5
         Ko7Q==
X-Gm-Message-State: AOAM53058lveOjXXP04+tsoqvMxrbXW4vRtgxeynqcyVKDPG8MSFE9yA
        2w7jebvPyX8w7hfqM8jzIA4=
X-Google-Smtp-Source: ABdhPJzpXh4/ZwCGPTjjjyDp7SEcDXSACHCaJ8Aowc6tdpacI7TnYh9VtFnKvju8bCpYY82NZUEvsw==
X-Received: by 2002:a2e:3a02:: with SMTP id h2mr1030942lja.137.1607521064729;
        Wed, 09 Dec 2020 05:37:44 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id j22sm176296lfr.6.2020.12.09.05.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:37:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmzfk-0003t3-7o; Wed, 09 Dec 2020 14:38:24 +0100
Date:   Wed, 9 Dec 2020 14:38:24 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: Re: [PATCH] x86/apic: Fix CPU devicetree-node lookups
Message-ID: <X9DTUIkBSfsfSQMR@localhost>
References: <20201124134247.2668-1-johan@kernel.org>
 <X89P7Bnw4x9i0y4Q@localhost>
 <87o8j32029.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8j32029.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 03:19:26AM +0100, Thomas Gleixner wrote:
> On Tue, Dec 08 2020 at 11:05, Johan Hovold wrote:
> 
> > On Tue, Nov 24, 2020 at 02:42:47PM +0100, Johan Hovold wrote:
> >> Fix CPU devicetree-node lookups by implementing
> >> arch_match_cpu_phys_id().
> >> 
> >> This allows using of_get_cpu_node() and of_cpu_device_node_get() to look
> >> up CPU devicetree nodes and specifically makes sure that CPU struct
> >> devices are linked to the correct devicetree nodes.
> >> 
> >> Note that CPUs are described in devicetree using their APIC ids and
> >> that those do not generally coincide with the logical ids (e.g. used by
> >> the default arch_match_cpu_phys_id() implementation).
> 
> Can you please explain why this is relevant for any of the existing few
> x86 DT users?

Let me try to break it down.

> The above is incoherent word salad TBH:
> 
>     1) Fix .....
> 
>        without any information what is broken

CPU device-tree node lookups are broken as the subject and introductory
paragraph indicates.

>     2) This allows ...
> 
>        It allows. Cool. Is it mandatory, desired or whatever?

It is mandatory in that any arch with devicetree support which does not
have an identity mapping between physical and logical CPU ids need to
override the default implementation of arch_match_cpu_phys_id().

Failing to do so breaks the lookups done using the above mentioned
helpers and also results in in the CPU struct devices pointing to the
wrong devicetree node (e.g. exported through sysfs).

>     3) Note ...
> 
>        That might be an actual problem decsription, but I can't say for
>        sure.

Yeah, that is why this is needed on x86 and also explains why this isn't
an issue on a UP system where the physical and logical id of CPU0
coincides.

I agree that this is unnecessarily terse.

> I still have no idea what this 'Fix' is fixing if it is fixing anything
> at all. Is is a fix which needs to be backported or is it a 'fix' which
> fixes something which got changed elsewhere and forgotten.

The only in-tree devicetree source for x86 is for a UP system where CPU0
has APIC id 0 and the initial code didn't even fetch the APIC id from
devicetree (even if the CPU was described in DT).

Support for SMP was later added by added by commit 4e07db9c8db8
("x86/devicetree: Use CPU description from Device Tree") and since then
we need to provide an arch_match_cpu_phys_id() implementation.

I'll resend with a better explanation.

Johan
