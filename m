Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4842818EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbgJBRPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388246AbgJBRPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:15:17 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF139221E8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601658917;
        bh=s7udygt1CSVMxxOampKOALpJgvQrS3aEcCihXqlqlcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M7B7nr137Eex0sRlGHrGJJFThN1B5IyaQ6ET1EP7ZtS91XZGiJNdNMt14KsWvrDdl
         K60GAhwlBXIExhcKu8R0+NLS7NGp34MBqWidENJ2AobYPb1KOjpJ3W3g2afuwT0gUt
         OOdYuI0Yv6T/2QIPymFU+wNqZWfB7RQPCQLiGI+I=
Received: by mail-wr1-f41.google.com with SMTP id x14so2596306wrl.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 10:15:16 -0700 (PDT)
X-Gm-Message-State: AOAM530yJOdQbRo8Wdr3we8ZcMbYQL+D8nbJU472oZfx4rQQW+EiSPOY
        ytqPXMjJBYmFGjzDTqngz7O3ikx9Ze0xnMd8rO0d8A==
X-Google-Smtp-Source: ABdhPJxSeT1LG5BuIfj2lWUE/FaaIuRdO3qUd0fuuANd5iiyQhbNOnYWg2scwTOk6LtbOLBq8Wzv1BUhyOpC64hZLmM=
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr4104651wrw.75.1601658915437;
 Fri, 02 Oct 2020 10:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201001203913.9125-1-chang.seok.bae@intel.com> <20201001203913.9125-23-chang.seok.bae@intel.com>
In-Reply-To: <20201001203913.9125-23-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 2 Oct 2020 10:15:04 -0700
X-Gmail-Original-Message-ID: <CALCETrVToTrLQEbmXugja_Aif8LcZ7kX8Shu0Gg-FOx6w0p48A@mail.gmail.com>
Message-ID: <CALCETrVToTrLQEbmXugja_Aif8LcZ7kX8Shu0Gg-FOx6w0p48A@mail.gmail.com>
Subject: Re: [RFC PATCH 22/22] x86/fpu/xstate: Introduce boot-parameters for
 control some state component support
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, jing2.liu@intel.com,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:43 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> "xstate.disable=0x6000" will disable AMX on a system that has AMX compiled
> into XFEATURE_MASK_USER_SUPPORTED.

Can we please use words for this?  Perhaps:

xstate.disable=amx,zmm

and maybe add a list in /proc/cpuinfo or somewhere in /proc or /sys
that shows all the currently enabled xsave states.

>
> "xstate.enable=0x6000" will enable AMX on a system that does NOT have AMX
> compiled into XFEATURE_MASK_USER_SUPPORTED (assuming the kernel is new
> enough to support this feature).

This sounds like it will be quite confusing to anyone reading the
kernel code to discover that a feature that is not "SUPPORTED" is
nonetheless enabled.
