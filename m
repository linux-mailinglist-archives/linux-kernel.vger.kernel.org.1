Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E952DF531
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 12:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgLTLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 06:24:39 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:34809 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbgLTLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 06:24:38 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kqwoe-003U75-NG; Sun, 20 Dec 2020 12:23:56 +0100
Received: from dynamic-078-055-173-192.78.55.pool.telefonica.de ([78.55.173.192] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kqwoe-003wHr-Gd; Sun, 20 Dec 2020 12:23:56 +0100
Subject: Re: [PATCH] m68k: Enable seccomp architecture tracking
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <20201220085141.1573113-1-geert@linux-m68k.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <49a17a22-c657-8e26-6c84-36ef01264c5d@physik.fu-berlin.de>
Date:   Sun, 20 Dec 2020 12:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201220085141.1573113-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 78.55.173.192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On 12/20/20 9:51 AM, Geert Uytterhoeven wrote:
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Needed for CONFIG_SECCOMP_CACHE_DEBUG.
> Note that upstream doesn't have m68k seccomp support yet.

Have we added SECCOMP support for m68k to the kernel yet?

It's actually something I was hoping to do over the holidays ;-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

