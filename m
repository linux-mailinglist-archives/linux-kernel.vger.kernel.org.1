Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7159A1D2C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 12:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgENKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 06:08:34 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:39853 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:08:34 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1jZAmy-003Ewj-La; Thu, 14 May 2020 12:08:28 +0200
Received: from p5b13a426.dip0.t-ipconnect.de ([91.19.164.38] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1jZAmy-002NqO-De; Thu, 14 May 2020 12:08:28 +0200
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
 <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
 <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
 <20200514074606.vkc35syhdep23rzh@wittgenstein>
 <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
 <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
 <20200514100459.pt7dxq2faghdds2c@wittgenstein>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <2e22b0d2-b9ce-420d-48a0-0d9134108a5c@physik.fu-berlin.de>
Date:   Thu, 14 May 2020 12:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514100459.pt7dxq2faghdds2c@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.38
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 12:04 PM, Christian Brauner wrote:
> So that's interesting because systemd doesn't support itanium correctly afaict.
> They have a raw_clone() function that they use which is not tailored to
> ia64. __NR_clone should be defined as so to hit clone2() but they don't
> pass a stack size argument down which is invalid on ia64:
Ah, I wasn't aware of this limitation. I'm surprised the systemd testsuite passes
then on ia64.

On sparc64, Michael Karcher provided the hand-written assembly you quoted to
fix the raw_clone() on this architecture.

I assume we could do the same on ia64?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
