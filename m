Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60252E69A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgL1RRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgL1RRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:17:39 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E7C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:16:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t22so6599612pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xo85X2Ouvk2qmQnbe1sme7C4PzCQCpFco37fNwH/Scw=;
        b=Wni+jZvFm7AhNh6R/UDmCw93fnvISItY0FCW44F+YUw+sO/UbD4W259PR9P5/hzbyW
         vRr3cjrT2ez443blpaerWJoVACUjBl8KlDjB5FGByFUC+xDAml3CZdri6YbM5AGcpzlB
         uZ3aIwEmyebGp8PlA4u3jL9tupHhybz7bdolNVwZkNuckH/Us7Idxalz6DPXaq/zSf6d
         cSjo0lTIhflGk0gyeXDc6Qm4czM8wI59a8regxd/CNVHNm+3Dp8Mgn7iyAbHgw25+NqB
         JObnP5jMSLuN32Ws5qksu9JFA13k38Pm6GYL2wvtR4TVgR2TNXS/6hgpBGfVpnSVaTu4
         xs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xo85X2Ouvk2qmQnbe1sme7C4PzCQCpFco37fNwH/Scw=;
        b=e4EI09dKqQzg0qYEXX4qO4xLD4ar0az10ZUyHMSBP+hufDvxCiCgrgBDOEKBN09Mzv
         UlcpmZfda/qPUtuYADR5NDHdOMgUAqpAMqXY3Peo37Xmd4qbMqvhwqqMeM0ALkQVF1bs
         y2jHKf8sWflAyXeGCuAGF17l/gLPBC+fP99hAOECZDOgjnGZspMfURvkVTl2wFvJpq1l
         zmlVbDkgeInklglVSNV9P3u22fL4dgtUnptBfauBvcwCPsJ/U/6vpVvynuC0b8r802ko
         vg+CgtY5TmNElhKk4wJ5zWJkAQAtK86wh0kmAWSdjRbxsIYtgdE9S6redkELCdG8a8pK
         YpQg==
X-Gm-Message-State: AOAM530GLx4tjGopcLN7JypGJpUjvLQ1D3CAT1Am8plhsvJ1RUjZTBrE
        cvqN+PPsrK+EC10wZ45+tuDHcQ==
X-Google-Smtp-Source: ABdhPJyHL7IDMjv2S/3KB5CLVcRs50PUkjDv2aDSqBp8J/NyHY6MuTvlhp8nZjm+ft+SKa/PBJ7TGw==
X-Received: by 2002:a62:ca:0:b029:19e:67a9:f0f2 with SMTP id 193-20020a6200ca0000b029019e67a9f0f2mr41177784pfa.60.1609175817956;
        Mon, 28 Dec 2020 09:16:57 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id k25sm37172351pfi.10.2020.12.28.09.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:16:57 -0800 (PST)
Date:   Mon, 28 Dec 2020 09:16:50 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/19] x86/insn: Rename insn_decode() to
 insn_decode_regs()
Message-ID: <X+oTAiMqfoDe1GBg@google.com>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223174233.28638-2-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Rename insn_decode() to insn_decode_regs() to denote that it receives
> regs as param and free the name for a more generic version of the
> function.

Can we add a preposition in there, e.g. insn_decode_from_regs() or
insn_decode_with_regs()?  For me, "decode_regs" means "decode the register
operands of the instruction".
