Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8282563E5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 03:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgH2BKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 21:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgH2BKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 21:10:43 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787D3C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 18:10:43 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id y30so181970ooj.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 18:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vNDWgtZHnxmTtUwsp4qvK6VBvN2wXYvglPJIQ/V711k=;
        b=PVr1T4+ThF7cElqiicVNR/AuE8Hq4ux4jbF/ctMlKN4ozU1fVXiKFcPhvl1ki4wZsr
         aKh5pmjD/X7lzmn71wDxuSiWvw8gflXBKQJIb9K29xFSZpiQ1dla3eWonTeHUB34raYu
         o1tmNrJoUED53WbqEmtU5CkbFoAqCv6cU5K5tjOicn9eijD/RsHd43e2exWqwOjzescv
         pkMG+q7ipLmgVImJEjmrRTnpf5g847uhUqAvgKSQXahhfdx+ugqVTd2B0MHpAX8jvGXN
         aedaKI/VaHweyY8RM0ZUAwwFYrCphLxWXqkez4S0XIkcD4r/c1QhFBpu3CCmkt3tVhYI
         mxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=vNDWgtZHnxmTtUwsp4qvK6VBvN2wXYvglPJIQ/V711k=;
        b=DKgprXNeTW1phKmXu6gtxjoCBsQ4YvTV2ZA1UduAuGRIK4leGDntUQVrkfsOI5x7VU
         Q9LduB69RVfmFh+aAkU5fuo0KefGjfUj3LyZWcOJ4TPZ/0WN49AwO8qXrEew+aPKwtb5
         1CgXcHWQ9OdcwcReactRTreNFI3hJEE/H8Wc6L1GktIgG4j5KxCQVoili/HZWdC7SMFt
         03S2NkaVvdrzzqKiqq5ciZR3iT60N00E8oMQHq/cjc+rO3PEr+x8sbtpHPO/ZjhRaYIK
         IEsMJ2M+qgOTyZ3A/+0KySQqpfs0kJy4Laz14eJi5MuLoHGiSXMlmcWRR5Yq0X7TxFtL
         SNyw==
X-Gm-Message-State: AOAM531GkS0xpXG/MZaUI5fK+8Eoxtz15xMvapT16vIXwcOfqDi84lAN
        cXz5W5hq7vVrE1Jes4x4aPXG9/Oi95M=
X-Google-Smtp-Source: ABdhPJyWgUWnXra24Fi/IdwaOx6S/n3bKj/mD87pNouv6aC97pFCKL2kzYiYoLBzJeHQ6u3IQ/bJIQ==
X-Received: by 2002:a4a:b80b:: with SMTP id g11mr899318oop.13.1598663442696;
        Fri, 28 Aug 2020 18:10:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id p24sm210202oip.2.2020.08.28.18.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 18:10:42 -0700 (PDT)
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Warning on Kernel 5.9.0-rc1 on PowerBook G4 (ppc32), bisected to
 a5c3b9ffb0f4
Message-ID: <dffc63e4-5554-822e-268e-92f9327bd056@lwfinger.net>
Date:   Fri, 28 Aug 2020 20:10:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 5.9.0-rc1 on a PowerBook G4 (ppc32), several warnings of the following 
type are logged:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at arch/powerpc/mm/pgtable.c:185 set_pte_at+0x20/0x100
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper Not tainted 5.9.0-rc2 #2
  NIP:  c002add4 LR: c07dba40 CTR: 00000000
  REGS: f1019d70 TRAP: 0700   Not tainted  (5.9.0-rc2)
  MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22000888  XER: 00000000

    GPR00: c07dba40 f1019e28 eeca3220 eef7ace0 4e999000 eef7d664 f1019e50 00000000
    GPR08: 007c2315 00000001 007c2315 f1019e48 22000888 00000000 c00054dc 00000000
    GPR16: 00000000 00000000 2ef7d000 000007c2 fffffff0 eef7b000 000004e8 eef7d000
    GPR24: eef7c5c0 00000000 007c2315 4e999000 c05ef548 eef7d664 c087cda8 007c2315
  NIP [c002add4] set_pte_at+0x20/0x100
  LR [c07dba40] debug_vm_pgtable+0x29c/0x654
  Call Trace:
  [f1019e28] [c002b4ac] pte_fragment_alloc+0x24/0xe4 (unreliable)
  [f1019e48] [c07dba40] debug_vm_pgtable+0x29c/0x654
  [f1019e98] [c0005160] do_one_initcall+0x70/0x158
  [f1019ef8] [c07c352c] kernel_init_freeable+0x1f4/0x1f8
  [f1019f28] [c00054f0] kernel_init+0x14/0xfc
  [f1019f38] [c001516c] ret_from_kernel_thread+0x14/0x1c
  Instruction dump:
  57ff053e 39610010 7c63fa14 4800308c 9421ffe0 7c0802a6 81250000 bfa10014
  7cbd2b78 90010024 552907fe 83e60000 <0f090000> 3d20c089 83c91280 813e0018
  ---[ end trace 4ef67686e5133716 ]---

Although the warnings do no harm, I suspect that they should be fixed in case 
some future modification turns the warning statements into BUGS.

The problem was bisected to commit a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests 
validating advanced arch page table helpers") by Anshuman Khandual 
<anshuman.khandual@arm.com>

Thanks,

Larry

