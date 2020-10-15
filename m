Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548A828FAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgJOVq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgJOVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:46:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488F4C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:46:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m20so357423ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9gZ8lYF2EW505x+JyXeny8rTd7MbNGj3JLfR6MUhlo=;
        b=kuR/AbH7x+hmbwvGfJ5+8q4/+6pF2yz6W0LrrDltCJUDKHZM4Kb1EVMuMgO0AhgfQa
         uZBJJpPlTf/0SRt4QiehnBvwkPrbC0GAFy3B5Xgk/Ua8utj/kVRiVlF6fbaRf2eSRtUl
         7Rj/ldq3FRLQKZIirGmFiNaBvaROil0RQll1Yxh8/A+A6xu2zsR+uEJNJTyMK+oUNHjR
         J6y5b1EHXob+75GNg13CkosgyJ2vA5djfl0VnJZM6I7orPWjr/jqAYs93o0iJg1Oc27D
         /JbrAMxE1d1c4ZXhRl/YTMtAI+D6AqMMK6LBu/b8wodBPRhZWw6Gf8GFu8eusJheDeqI
         Gdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9gZ8lYF2EW505x+JyXeny8rTd7MbNGj3JLfR6MUhlo=;
        b=sTFBS/5LlXm39PwfXEiqPI8OEC0COWqp6mT7ouevqQrTD1hhIEULjODPbPKYiTVzWn
         SMFKVwpjInboUZ0ShrinVHZi+qmVmFnWZKZMiB6EFF15HKRDh4bHs7UQMWgTEZ7k6K1a
         66TliXathYsE1EvP2OzsLrkL373rcTI6Teyc5GryzmN55rFnoPALM2xm3fwqhECgETx9
         8J4bjdm6bYvYeT3fZ+uaXKiYUpcxo0evWd39ErzfgD+SiIBh7lefd5RwMu+iFeQZEZcB
         bUWEUla/dGsoEsdTVpMJhCfArQve0VLkd4790DLCxTNz/goxMDkqhNgNpn9iJCmbliL0
         14DQ==
X-Gm-Message-State: AOAM531/uCydFmt3sedgZpNQGeU0rVxrriYnznUTPK8UhX1nT5kWcK95
        Og8YIbfe7YZ2HrA8TN74JLSGy3e1RQJT6onG2ckoIA==
X-Google-Smtp-Source: ABdhPJyzFrqu+sIWzpcIUx+uZBYMlQO3PmR/MAulNcxE1w150usYa/yZy5hTFe1IovBsXMrDQikCbAjUEBSsWCj5kog=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr269106ljk.160.1602798412476;
 Thu, 15 Oct 2020 14:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <202010160523.r8yMbvrW-lkp@intel.com>
In-Reply-To: <202010160523.r8yMbvrW-lkp@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 15 Oct 2020 23:46:26 +0200
Message-ID: <CAG48ez3VixjDrMnz6+7JjGW_ZLZCD4+dTYWUD_tNOcfEfpu1Bg@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-5.4.y 665/2391] drivers/android/binder.c:3776:
 Error: unrecognized keyword/register name `l.lwz
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+openrisc folks

On Thu, Oct 15, 2020 at 11:28 PM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> head:   85b0841aab15c12948af951d477183ab3df7de14
> commit: c5665cafbedd2e2a523fe933e452391a02d3adb3 [665/2391] binder: Prevent context manager from incrementing ref 0
> config: openrisc-randconfig-r002-20201014 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=c5665cafbedd2e2a523fe933e452391a02d3adb3
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-5.4.y
>         git checkout c5665cafbedd2e2a523fe933e452391a02d3adb3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/android/binder.c: Assembler messages:
> >> drivers/android/binder.c:3776: Error: unrecognized keyword/register name `l.lwz ?ap,4(r25)'
>    drivers/android/binder.c:3781: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

binder is basically doing this:

u64 data_ptr;
if (get_user(data_ptr, (u64 __user *)ptr))
  return -EFAULT;

and GCC complains that that doesn't turn into valid assembly on
openrisc, where get_user() of size 8 expands into this:

#define __get_user_asm2(x, addr, err)                   \
{                                                       \
        unsigned long long __gu_tmp;                    \
        __asm__ __volatile__(                           \
                "1:     l.lwz %1,0(%2)\n"               \
                "2:     l.lwz %H1,4(%2)\n"              \
                "3:\n"                                  \
                ".section .fixup,\"ax\"\n"              \
                "4:     l.addi %0,r0,%3\n"              \
                "       l.addi %1,r0,0\n"               \
                "       l.addi %H1,r0,0\n"              \
                "       l.j 3b\n"                       \
                "       l.nop\n"                        \
                ".previous\n"                           \
                ".section __ex_table,\"a\"\n"           \
                "       .align 2\n"                     \
                "       .long 1b,4b\n"                  \
                "       .long 2b,4b\n"                  \
                ".previous"                             \
                : "=r"(err), "=&r"(__gu_tmp)            \
                : "r"(addr), "i"(-EFAULT), "0"(err));   \
        (x) = (__typeof__(*(addr)))(                    \
                (__typeof__((x)-(x)))__gu_tmp);         \
}

and apparently the "l.lwz %H1,4(%2)" and "l.addi %H1,r0,0" don't turn
into valid assembly when %H1 expands to "?ap"?

I don't know anything about OpenRISC, but this seems like it's
probably an issue in the get_user() implementation.
