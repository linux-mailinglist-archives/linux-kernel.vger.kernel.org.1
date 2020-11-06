Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08BE2A8D20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKFCsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgKFCsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:48:42 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:48:42 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so2788751pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=F2AiGZp1uqHXPouYXcihh3F/4x1p3xsqrhRr5wZQbtE=;
        b=oql2ad5QP+xoxzrHLCaslsMAsIKZTe4gZMbVwQt1j0IgKK5Y14ZrDA9lrFh2xVowiv
         lTz9dPM2ggERDcIA8M5Mbzj7fxyoGNubE4nEjuDUCEz3D+vSdLe8UO61jQgF2ni7Fxgp
         smRhJIT24wM0de6iH4qdTG9kTPQ2k+BUTbo+snntV0rCX3wEPuEFX+VA8Z9lXF6p9T5K
         HpaqB+f6sVfD7rvwSOgHVJmG+zKQ2LEniu6VWXZ9wRd8hEItFjpeEMbq8iB9t41C38pu
         x+y031ilRtpyJEYIxLw8MFuU5Hs8FhNscmtKQNchIUBOhTHtoCPH+zhTKCmVGQuHezCF
         WQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=F2AiGZp1uqHXPouYXcihh3F/4x1p3xsqrhRr5wZQbtE=;
        b=Srz8DZU2RJkTNm9Zu+1aASBOAufQBoNEHrtHdVQK7TkVfNt70g79+b5Gd6yYu8PHkV
         nwZKH75PFMcmt6WfRLl5LmwGHmGO3LIlTB4xA/s1MyFalM2pOfSGOXSQgEtmFpSOIBC2
         gklaTHxhrCIt/kqJxCyabU0Pmr3XvioTLj9u8lRNLRt563GRAtR3p6MNzAm1ceJd328Y
         ufYxSwU9Ne4yCsQzo3SHF9uPOahqtm6ONV/HYhPHtYoWieilNsO0K8gnVmlFNCzdrmZK
         ArnLlti+3R0vsoRRdaxmZZ9miqUSWngydMSdcmi6d/pmXDJqPdJKY7fhuzTMSlzCGMd2
         YVvQ==
X-Gm-Message-State: AOAM533qJlyvLFdC6OolfB1dHZBP7zlariIruTq+VjGH+HfUQRFeL5zg
        iucBTC2rJal0HsKSvTXKraBhJw==
X-Google-Smtp-Source: ABdhPJzb0ySUx7p49GpcZ24AE8UZ1ipz0Iieo4vNLFeBSbJKQ4/gC/qW4L6VKOJXD4zqh3IDcV2gZA==
X-Received: by 2002:a17:90a:de5:: with SMTP id 92mr39433pjv.179.1604630922178;
        Thu, 05 Nov 2020 18:48:42 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n72sm4374603pfd.202.2020.11.05.18.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:48:41 -0800 (PST)
Date:   Thu, 05 Nov 2020 18:48:41 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 18:24:54 PST (-0800)
Subject:     Re: [PATCH] arm64: Fix a broken copyright header in gen_vdso_offsets.sh
In-Reply-To: <20201020113207.GB16084@willie-the-truck>
CC:     Will Deacon <willdeacon@google.com>, catalin.marinas@arm.com,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     will@kernel.org
Message-ID: <mhng-0fb8c6a4-9c20-4cdb-87c6-8b27950c1b45@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 04:32:08 PDT (-0700), will@kernel.org wrote:
> On Fri, Oct 16, 2020 at 05:26:37PM -0700, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> I was going to copy this but I didn't want to chase around the build
>> system stuff so I did it a different way.
>
> How did you end up doing it? I remember trying to parse the ELF object at
> one time of day and not getting very far.

Mine really isn't any cleaner: I use nm and sed to produce an assembler file
full of absolute symbols, which I compile to produce the object.  That way I
don't need a header file, which means I don't need to mess around with build
ordering or change any of the other code (which was already using symbols).

I don't really like this whole thing we do where we just assume that symbols
with a small offset from absolute address zero.  We're sort of depending on
that for undefined weak symbols, but that's only for actually zero not almost
zero.  Given that, I figured it'd be easier to just do it this way rather than
trying to mess with build stuff.

I probably wouldn't bother changing unless there's something actively bad about
that build stuff (I didn't really look).
