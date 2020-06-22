Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626D204261
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 23:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgFVVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 17:03:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43943 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgFVVDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:03:37 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 05ML3Thf2226929
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 22 Jun 2020 14:03:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 05ML3Thf2226929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020052301; t=1592859810;
        bh=gAcZN4K7tT3pEj35SQPfJTCFHlhgLEiloeNEA/llr4s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WB45ecVUjRtw8PwoaMRFLGLB1PDEauV6BytnSxQEy+Q6XX6ooRSoxKZJ9glj0sELV
         gpKAsS3Smj0ORekCdN2DYhROWDOpcry2Scx3Xt9bwLjTA6u9gchCocNsAhsUWKy1EK
         Ulnj4JsNBs4fBdItRnbrJWLokrXNT+JgCye18U6/XGtRRUX/gol7wK2CAzvRQVEHvc
         k6khjt38AC+0YVqPvRuP3M5ye/mt9KLnLHhmdqb1jwPtkXnyc1mmVaO1b7iq1vj9+P
         oPsMxA+Db6bsjYlGpa5iFHc+yXNxNp/5JogJEtMHarJpOdy/rcIczEPVZjFxnhaBws
         2J7qoF9KNqazg==
Subject: Re: [PATCH] initrd: Remove erroneous comment
To:     Tom Rini <trini@konsulko.com>, ron minnich <rminnich@gmail.com>
Cc:     lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
References: <20200619143056.24538-1-trini@konsulko.com>
 <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
 <20200622204034.GL27801@bill-the-cat>
 <CAP6exYLd0uFbVSbn28iS1OV=jULtg2f+7t1DAn-fvGoRSd5dng@mail.gmail.com>
 <20200622210145.GM27801@bill-the-cat>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5d6dbaf4-26bf-d71a-595e-0b665d4ae614@zytor.com>
Date:   Mon, 22 Jun 2020 14:03:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622210145.GM27801@bill-the-cat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 14:01, Tom Rini wrote:
> 
> I'm picky here because, well, there's a whole lot of moving parts in the
> pre-kernel world.  In a strict sense, "UEFI" doesn't do anything with
> the kernel but based on hpa's comments I assume that at least the
> in-kernel UEFI stub does what Documentation/x86/booting.rst suggests to
> do and consumes initrd=/file just like "initrd /file" in extlinux.conf,
> etc do.  And since the EFI stub is cross-platform, it's worth noting
> this too.
> 

For what it's worth, normally boot loaders don't strip this from the
kernel command line passed to the kernel, although there might be ones
which do so. In general this is bad practice; it is better to let the
initrd show in /proc/cmdline.

	-hpa

