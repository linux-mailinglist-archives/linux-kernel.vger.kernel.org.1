Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B411A258792
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 07:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgIAFlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 01:41:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54417 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAFlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:41:03 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3280:1098:42a1:36db:233c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0815ef9C3468657
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 31 Aug 2020 22:40:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0815ef9C3468657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020082401; t=1598938841;
        bh=r9YQ/fVq4Hy6bpEZQpjEOilLVaBkiI7tGTe4iXQIuqo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UrJ6ytwnWC2Ikz1ItsGmyVHRqVPX3NnYugW1Ag90+9FGPTIrL9JUps40d5Is8vc6L
         hHRrbrNLWSdqLcPvOfnJ00r6uBtFpAlO0Ibnk1TKqxPyMnUJ8N5HJdZQJgDFL13YO3
         p99ApHZK9C+RHe5cEOrYYZznV0tU8OznR75HjPJWzZZWTjY7X9X7esuYZDFPPBuhqr
         HcR2Ksg/QNvlTaFo6XaK3kg36ZfRzUyzw/nfmtzDXOInBqBwc9xTiG50I1OoSmRd1y
         gh/KDar/7u4btSJR9/YyRHsVKG33KS5R2kMt0WCoJ9IZKymX8tgCC+u0p1X0PIN4fC
         jqFSKxQGOXZEA==
Subject: Re: [RFC PATCH 1/2] Documentation/admin-guide: README & svga: remove
 use of "rdev"
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20200901053822.9374-1-rdunlap@infradead.org>
 <20200901053822.9374-2-rdunlap@infradead.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b0acb801-5aa5-d781-b635-705face06a2b@zytor.com>
Date:   Mon, 31 Aug 2020 22:40:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901053822.9374-2-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-31 22:38, Randy Dunlap wrote:
>  
> --- linux-next-20200828.orig/Documentation/admin-guide/svga.rst
> +++ linux-next-20200828/Documentation/admin-guide/svga.rst
> @@ -12,7 +12,7 @@ Intro
>  This small document describes the "Video Mode Selection" feature which
>  allows the use of various special video modes supported by the video BIOS. Due
>  to usage of the BIOS, the selection is limited to boot time (before the
> -kernel decompression starts) and works only on 80X86 machines.
> +kernel decompression starts) and works only on 32-bit 80X86 machines.
>  

Incorrect. What controls if this is available is whether or not the kernel is
booted through BIOS firmware (as opposed to UEFI, kexec, etc.)

	-hpa

