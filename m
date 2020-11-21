Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED12BC16D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgKUS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:29:07 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:35967 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726662AbgKUS3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:29:06 -0500
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id CB0B61AB142
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 11:29:04 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id gXdAkTCMGeMJHgXdAkbNgJ; Sat, 21 Nov 2020 11:29:04 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=T72iscCQ c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=_jlGtV7tAAAA:8
 a=cVLmmrZ5nNubQtdbMK8A:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WERaUIfmHQF75+9YsbUyCzDuYF0iuOfj6cexs/noDIQ=; b=QQMGnWvvG/Ly6Sr4TqPiuCZK95
        ICOrQWWrGeEDxErDVFyem5TW0sTHeMuYStd+kED/ghQ3DZVo1Aq5rPDqQi/Ul4/69rXr94JUmMkBG
        qur54PW6cJaQM1WP9Cn0kiII7wvfPrmYtgBnv9RegBY2Hv2VVD60Nx7WKGL/KXe62ZLa1APFvaYvs
        ODJ7WKLU7QKu7e7CC9oYlqsDWJaDSfcEcNyYIz2rbVKdDtnnD0YWrOcv0Ldca87EeDIWBGweT3CWV
        adWsDKAJC9K6RmHMBi1ps5GdKKFhbkhrROsDpbBBoFp1aaG9GxMvZvIcanIuwEV/NI6PO4MziJ0hN
        Z85fb8oA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40902 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgXd9-0035yW-NU; Sat, 21 Nov 2020 18:29:03 +0000
Date:   Sat, 21 Nov 2020 10:29:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/15] 4.4.245-rc1 review
Message-ID: <20201121182903.GB111877@roeck-us.net>
References: <20201120104539.534424264@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201120104539.534424264@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgXd9-0035yW-NU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:40902
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:02:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.245 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2020 10:45:32 +0000.
> Anything received after that time might be too late.
> 
Build results:
	total: 165 pass: 164 fail: 1
Failed builds:
	powerpc:ppc64e_defconfig
Qemu test results:
	total: 328 pass: 323 fail: 5
Failed tests:
	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd
	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:sdhci:mmc:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs	

Failure in all cases is:

In file included from arch/powerpc/kernel/ppc_ksyms.c:10:0:
arch/powerpc/include/asm/book3s/64/kup-radix.h:11:29: error: redefinition of ‘allow_user_access’
 static __always_inline void allow_user_access(void __user *to, const void __user *from,
                             ^~~~~~~~~~~~~~~~~
In file included from arch/powerpc/include/asm/uaccess.h:12:0,
                 from arch/powerpc/kernel/ppc_ksyms.c:8:
arch/powerpc/include/asm/kup.h:12:20: note: previous definition of ‘allow_user_access’ was here
 static inline void allow_user_access(void __user *to, const void __user *from,
                    ^~~~~~~~~~~~~~~~~
In file included from arch/powerpc/kernel/ppc_ksyms.c:10:0:
arch/powerpc/include/asm/book3s/64/kup-radix.h:16:20: error: redefinition of ‘prevent_user_access’
 static inline void prevent_user_access(void __user *to, const void __user *from,
                    ^~~~~~~~~~~~~~~~~~~
In file included from arch/powerpc/include/asm/uaccess.h:12:0,
                 from arch/powerpc/kernel/ppc_ksyms.c:8:
arch/powerpc/include/asm/kup.h:14:20: note: previous definition of ‘prevent_user_access’ was here
 static inline void prevent_user_access(void __user *to, const void __user *from,
                    ^~~~~~~~~~~~~~~~~~~

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
