Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1892E8C44
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 14:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbhACNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 08:11:32 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37397 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbhACNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 08:11:31 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kw39l-001rwI-Ku; Sun, 03 Jan 2021 14:10:49 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kw39k-000OeZ-Tg; Sun, 03 Jan 2021 14:10:49 +0100
Subject: Re: [sparc64] running stress-ng and a sparc64 hardware / kernel woes
To:     Anatoly Pugachev <matorola@gmail.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>
References: <CADxRZqwARwrMeJZTWLeUtGyjStuz=ze2dwNqov0EyfHkRBM1fw@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <ff57237d-1e5b-9171-d320-eef57bc8d7c5@physik.fu-berlin.de>
Date:   Sun, 3 Jan 2021 14:10:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CADxRZqwARwrMeJZTWLeUtGyjStuz=ze2dwNqov0EyfHkRBM1fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anatoly!

On 1/3/21 1:56 PM, Anatoly Pugachev wrote:
> Running a simple stress-ng as a non-privileged (non root) user :
> 
> stress-ng --opcode 1 --timeout 60 --metrics-brief
> 
> will almost always bring the linux kernel to an unusable state,
> starting from "Unable to handle kernel NULL pointer dereference",
> "Bogus kernel PC [0000000000000000] in fault handler", "Kernel
> unaligned access at TPC", "Unable to handle kernel paging request at
> virtual address" and "rcu: INFO: rcu_sched detected stalls on
> CPUs/tasks"...

This looks very similar to the kernel crashes on SPARC that we saw on
the buildds for the GCC testsuite in the past (and other packages).

I wonder whether we can use stress-ng to provoke the kernel crash on
POWER when hosting big-endian VMs with high load on little-endian hosts [1].

Adrian

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206669

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

