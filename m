Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8917C2B12DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 00:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKLXqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 18:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKLXqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:46:35 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442EC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 15:46:35 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so6052697pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fa/E3DW7b0urDfoi0YeY9KEHtV3uRQoZVbElwk5dEcM=;
        b=rKvgZH2YUHEYSLWvB8VQw9wZxW0yKjSzLvbQi3plyzSEeCU4oHP+HKDSV1lCGqpaF0
         ggs44CIOQv/nBALxdhzKNN/mnJLD0jyVH7V/zkxADpCGlRpG1knv9IkMjqcP8x+TntGK
         QoPx9Ysb52YQJRhZ4cQ8gQprI8hRWQ7lmQiT4zbHYsYk+DV7PT0iK03+w6sNtYEPFQkV
         iYnEKIt26KKf7YCNFdfF3OcRV6bfyowu5olxggw+2mKCbgyr1f6sNQGEUfUFu5MZmo75
         BvMY6Ta4TOBo94AVCvTfzR4sZUU89YP/kXTq2hyxDgmwiuAoNTHsTURE6BRIMmaDw0ZQ
         TMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fa/E3DW7b0urDfoi0YeY9KEHtV3uRQoZVbElwk5dEcM=;
        b=VMvI+xjke+qpMZmeia/nGiDjlHYt3Xa7aTmG1MyVoynsSh3SqPAXusip65E/SEVAeF
         V+M0bJbcnT1CgyPHgVsX0Sri0p2jQHE+xLHsqCqrWBmjXBIXdlVyXmI75iesnOGFrtXJ
         KsJkuQBlhm/hzMJ0gwDK28Knwk9m+iQz3e+TEPpC8oPqnsd1fxo72szEewHYzl+hQfsS
         ssWTbhjH+T+TL8ltC7rguDp0uHsp2NNByCPopTNem74kytXaI6A/Ygk15mjek5PlcLwo
         lFr1/+yj82RGNWc9tNchy7JsDklO7WY/YE7XuCq/b4mi9AQejp0N2J1YP17Z+0u3hSew
         YqFw==
X-Gm-Message-State: AOAM530BDXOk7y0lelwmZF0JOdwzqgh2+kKUdMjT8YFHnGc3PfUAcJo8
        CUb2EoTPGCu2UfNFE8Fu5KHbbKZO49w=
X-Google-Smtp-Source: ABdhPJyikdfvuAzHc+Q0Js+XU/Lqd5NlDAsaK6uTGqwWHzpS2JCRsjFCbYiRu+LVCx/vilzfparRXQ==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr238664pjb.142.1605224794234;
        Thu, 12 Nov 2020 15:46:34 -0800 (PST)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r205sm7828607pfr.25.2020.11.12.15.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 15:46:33 -0800 (PST)
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
To:     Stefan Agner <stefan@agner.ch>, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com
Cc:     akpm@linux-foundation.org, sjenning@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <a08ce295-30c9-524f-53d7-612222c382eb@gmail.com>
Date:   Thu, 12 Nov 2020 15:46:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 7:22 AM, Stefan Agner wrote:
> Most architectures define MAX_PHYSMEM_BITS in asm/sparsemem.h and don't
> include it in asm/pgtable.h. Include asm/sparsemem.h directly to get
> the MAX_PHYSMEM_BITS define on all architectures.
> 
> This fixes a crash when accessing zram on 32-bit ARM platform with LPAE and
> more than 4GB of memory:
>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   pgd = a27bd01c
>   [00000000] *pgd=236a0003, *pmd=1ffa64003
>   Internal error: Oops: 207 [#1] SMP ARM
>   Modules linked in: mdio_bcm_unimac(+) brcmfmac cfg80211 brcmutil raspberrypi_hwmon hci_uart crc32_arm_ce bcm2711_thermal phy_generic genet
>   CPU: 0 PID: 123 Comm: mkfs.ext4 Not tainted 5.9.6 #1
>   Hardware name: BCM2711
>   PC is at zs_map_object+0x94/0x338
>   LR is at zram_bvec_rw.constprop.0+0x330/0xa64
>   pc : [<c0602b38>]    lr : [<c0bda6a0>]    psr: 60000013
>   sp : e376bbe0  ip : 00000000  fp : c1e2921c
>   r10: 00000002  r9 : c1dda730  r8 : 00000000
>   r7 : e8ff7a00  r6 : 00000000  r5 : 02f9ffa0  r4 : e3710000
>   r3 : 000fdffe  r2 : c1e0ce80  r1 : ebf979a0  r0 : 00000000
>   Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>   Control: 30c5383d  Table: 235c2a80  DAC: fffffffd
>   Process mkfs.ext4 (pid: 123, stack limit = 0x495a22e6)
>   Stack: (0xe376bbe0 to 0xe376c000)
>   ...
>   [<c0602b38>] (zs_map_object) from [<c0bda6a0>] (zram_bvec_rw.constprop.0+0x330/0xa64)
>   [<c0bda6a0>] (zram_bvec_rw.constprop.0) from [<c0bdaf78>] (zram_submit_bio+0x1a4/0x40c)
>   [<c0bdaf78>] (zram_submit_bio) from [<c085806c>] (submit_bio_noacct+0xd0/0x3c8)
>   [<c085806c>] (submit_bio_noacct) from [<c08583b0>] (submit_bio+0x4c/0x190)
>   [<c08583b0>] (submit_bio) from [<c06496b4>] (submit_bh_wbc+0x188/0x1b8)
>   [<c06496b4>] (submit_bh_wbc) from [<c064ce98>] (__block_write_full_page+0x340/0x5e4)
>   [<c064ce98>] (__block_write_full_page) from [<c064d3ec>] (block_write_full_page+0x128/0x170)
>   [<c064d3ec>] (block_write_full_page) from [<c0591ae8>] (__writepage+0x14/0x68)
>   [<c0591ae8>] (__writepage) from [<c0593efc>] (write_cache_pages+0x1bc/0x494)
>   [<c0593efc>] (write_cache_pages) from [<c059422c>] (generic_writepages+0x58/0x8c)
>   [<c059422c>] (generic_writepages) from [<c0594c24>] (do_writepages+0x48/0xec)
>   [<c0594c24>] (do_writepages) from [<c0589330>] (__filemap_fdatawrite_range+0xf0/0x128)
>   [<c0589330>] (__filemap_fdatawrite_range) from [<c05894bc>] (file_write_and_wait_range+0x48/0x98)
>   [<c05894bc>] (file_write_and_wait_range) from [<c064f3f8>] (blkdev_fsync+0x1c/0x44)
>   [<c064f3f8>] (blkdev_fsync) from [<c064408c>] (do_fsync+0x3c/0x70)
>   [<c064408c>] (do_fsync) from [<c0400374>] (__sys_trace_return+0x0/0x2c)
>   Exception stack(0xe376bfa8 to 0xe376bff0)
>   bfa0:                   0003d2e0 b6f7b6f0 00000003 00046e40 00001000 00000000
>   bfc0: 0003d2e0 b6f7b6f0 00000000 00000076 00000000 00000000 befcbb20 befcbb28
>   bfe0: b6f4e060 befcbad8 b6f23e0c b6dc4a80
>   Code: e5927000 e0050391 e0871005 e5918018 (e5983000)
> 
> Fixes: 61989a80fb3a ("staging: zsmalloc: zsmalloc memory allocation library")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

BTW, I can confirm on behalf of a colleague here that this patch fixes
zsmalloc on a 32-bit platform with 4GB of DRAM and with a 3GB user/1GB
kernel split. Thanks!
-- 
Florian
