Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAAD2A18E9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 18:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgJaRLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgJaRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 13:11:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C9C0617A7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 10:11:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r3so4583429plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=f++XT0bktABv7g1C5u6aG7U5oVmsTzK16JLOUjfHcLQ=;
        b=blFzmQ83C38im2bR36vRX2qK8XzHldcqCkGMyrfR/L6I98IiKSBXqxSscVWqpViFpD
         wCKIEhofYwk1EXGKTQD86WkCLLFQ2q66pPmEccT38CAox7RIr0H/rno2ZaRGJeeRAffE
         8xkFOUYcS+ac4in9hL/cATAWctQnzjrCZ1Oru82u9Y166aWU9JKptwH2SzB4/Dd8bUAr
         kwLlhQM3hdKdOu7AU3FHq4bMGBT0V9Ux8DMy1iUn50b2BIrECAKPJjwJgE/mEPZddtz9
         u4RNeMGzWzJtX1TSgb1yTjqeUfMltWBAYejgLwTUSvDcVMqySU2YClSv4yzLskZbz1di
         C5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=f++XT0bktABv7g1C5u6aG7U5oVmsTzK16JLOUjfHcLQ=;
        b=dC8LAV7yvE+EOnjjrKOfTvNN/xc/pbz9VrZ/9DIqMTbZstokVn8zjD+729ALPpHa3D
         OgyxtZUySe4v93WZvAJe9xV8CAHm+jZSDqxaZtIxhVV6N9BpMQ0G0TVKKCq/NxrEUDBu
         QcyQYZNia62OQnHE37xbVoJ/rMXmwfbZ2XSBn6Tp8Vuhd0+J0GGNGyUS0LICg/OmAPL1
         tW4F/+7hlsV/idgffvzdHUnSznzxJsrjJp6mreT4wMiPUCRcz/jKOkNR24zjnKcjnn30
         m5FpfqjZl43f4Ovce7B53/M/JvRttEtOeW4GhRGxwx5YMcDObuYK2seGuIIS2mnmRzxe
         j1JA==
X-Gm-Message-State: AOAM531usTsCo053gU0qCJLpvNQOpp9Cgcp4PU1sS17p/Ab4vqfo3/A5
        JhWwJVim+LH3UwXX4Z6g3pfqzWgdYFUJ8Q==
X-Google-Smtp-Source: ABdhPJyDY1dwIQwlf8y56cq19DGJULncIIV8NetBS226a5OVhciYDSCPwxMYJRgHdsNu9kf6xcqZ1w==
X-Received: by 2002:a17:90a:ed97:: with SMTP id k23mr9442630pjy.100.1604164304371;
        Sat, 31 Oct 2020 10:11:44 -0700 (PDT)
Received: from debian ([171.49.162.97])
        by smtp.gmail.com with ESMTPSA id 205sm9223691pfy.35.2020.10.31.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 10:11:43 -0700 (PDT)
Message-ID: <ca2501e512973270c6b7b7cc05c7f50791541a66.camel@rajagiritech.edu.in>
Subject: Re: [PATCH 5.9 00/74] 5.9.3-rc1 review
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Date:   Sat, 31 Oct 2020 22:41:38 +0530
In-Reply-To: <20201031113500.031279088@linuxfoundation.org>
References: <20201031113500.031279088@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="=-6W/pfINf4HduZ83u5LLn"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6W/pfINf4HduZ83u5LLn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2020-10-31 at 12:35 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.9.3 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied,
> please
> let me know.
> 
> Responses should be made by Mon, 02 Nov 2020 11:34:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.9.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-
> stable-rc.git linux-5.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

hello,
i have build using ktest. but then i did the normal compile.
compiled and booted 5.9.3-rc1+ . dmesg -l err is clear.

some lines from dmesg output related  
----------x------------------x---------------------------x---
video: module verification failed: signature and/or required key
missing - tainting kernel
sdhci-pci 0000:00:1e.6: failed to setup card detect gpio
--------x-------------------------------x-----------------x---


Now something related to kernel build and install..
----------x---------------------x--------------------------x-------
WARNING: modpost: EXPORT symbol "copy_mc_fragile" [vmlinux] version
generation failed, symbol will not be versioned.
W: Possible missing firmware /lib/firmware/i915/rkl_dmc_ver2_01.bin for
module i915
-------------x-------------------x-------------------------x---------

Now one thing during boot..
-----------x------------x---- 
unable to start nftables
-x-----------------------x---

iam attaching a file....please see...

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


-- 
software engineer
rajagiri school of engineering and technology  - autonomous




--=-6W/pfINf4HduZ83u5LLn
Content-Disposition: attachment; filename="kcompile-warning-oct31-2020.txt"
Content-Type: text/plain; name="kcompile-warning-oct31-2020.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

bGQ6IGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9oZWFkXzY0Lm86IHdhcm5pbmc6IHJlbG9jYXRp
b24gaW4gcmVhZC1vbmx5IHNlY3Rpb24gYC5oZWFkLnRleHQnCiAgTEQgW01dICBkcml2ZXJzL25l
dC93aXJlbGVzcy9hdGgvYXRoOWsvYXRoOWtfaHcua28KbGQ6IHdhcm5pbmc6IGNyZWF0aW5nIERU
X1RFWFRSRUwgaW4gYSBQSUUK


--=-6W/pfINf4HduZ83u5LLn--

