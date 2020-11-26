Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C059C2C5531
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbgKZNZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389829AbgKZNZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:25:11 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45419C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:11 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id es6so897202qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=MNcQv1d1aoirYTMBX9DjnG1i0iErg2wQNhH4EnUPrCs=;
        b=NAQ/wmKBSatGWRRjdbdgE5ILpOl5Jib+Aipexo3Gurn8R43lHXaJkv5TJWRYlfDUJf
         tXRakTkh1cM7iHM7sxYWLQ7hnBow14LSPbPVets73zmqo+uSJOfkD8JeOgRr76VRe4I/
         JLpcQUFqGDb+yl1Hy6ps2M2Iv/aoZ2h4zXKP22lqQhtwPFedWI8pUG4WEdk5WvXK/6eS
         VLCoIrFZL+Tc4ncCrZWb6ZGR84NIf1URBOscpxH+mbBUFXKN5BP07hsxCV1GCYSBIr00
         7ivbsuVesLW0pH+D7vozi+7UNg36yvRqqtZuBafuTulbr3hEiNYmSAFp+C/almaJ0q/o
         fhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=MNcQv1d1aoirYTMBX9DjnG1i0iErg2wQNhH4EnUPrCs=;
        b=UKW7PF11zGmWZuVXJWH/AN0UC5vdC1CgrrMdwET7o3p+yEVviIl4mpt/ah4GdcV9QW
         oMVoiVHlkbcIF2m8k67+SWwNSHu9ckDCjGp/3CKcbeg+8VbS1U8Je+3Xqwur8aYIt0RK
         v2drGB74PFBVrnpbV9l1GOSn9FY8vD253A++ChXoAbOUiNrkaBgZPoBxf8HtDLRaj99g
         PNkakkZO9W6ImuVu8vWIGcy+qDGwAVipMznWkJEVn4v1b5iM4rrY0+cPzEF7F4yrFYtS
         qSYQKOryRZo3BIDzydOMi1xIxxQBtu6XZ9FZCzux1VRdcSZFe+9xA+F+zduqYF5cBmy+
         3SCQ==
X-Gm-Message-State: AOAM532TtohOTkeVZDD2w2P3s+n2qn6gcx0PB5KtiLh/vqu6TlZG0+yo
        lhRtwog+WS3Etm2h5OigFIuu/A==
X-Google-Smtp-Source: ABdhPJwL2F5X0wRb3VCf0Wov84+VQqd/IP4+aAKP2Y5/xFxhIr5YBWsz4vDmAzdbLll9UQe4Ts57pA==
X-Received: by 2002:ad4:4743:: with SMTP id c3mr3126157qvx.31.1606397105649;
        Thu, 26 Nov 2020 05:25:05 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id t133sm2418736qke.82.2020.11.26.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:25:03 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: linux-next 20201126 - build error on arm allmodconfig
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1606397102_2385P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Nov 2020 08:25:02 -0500
Message-ID: <24105.1606397102@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1606397102_2385P
Content-Type: text/plain; charset=us-ascii

Seems something is giving it indigestion regarding asmlinkage...

  CC      arch/arm/mm/kasan_init.o
In file included from ./include/linux/kasan.h:15,
                 from arch/arm/mm/kasan_init.c:11:
./arch/arm/include/asm/kasan.h:26:11: error: expected ';' before 'void'
 asmlinkage void kasan_early_init(void);
           ^~~~~
           ;
make[2]: *** [scripts/Makefile.build:283: arch/arm/mm/kasan_init.o] Error 1
make[1]: *** [scripts/Makefile.build:500: arch/arm/mm] Error 2
make: *** [Makefile:1803: arch/arm] Error 2

Git bisect points at:

commit 2df573d2ca4c1ce6ea33cb7849222f771e759211
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Tue Nov 24 16:45:08 2020 +1100

    kasan: shadow declarations only for software modes

Looks like it's this chunk:

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 59538e795df4..26f2ab92e7ca 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -11,7 +11,6 @@ struct task_struct;

 #ifdef CONFIG_KASAN

-#include <linux/pgtable.h>
 #include <asm/kasan.h>

Testing shows putting that #include back in makes it compile correctly,
but it's not obvious why putting that back makes 'asmlinkage' recognized.

"You are in a twisty little maze of #includes, all different"... :)

--==_Exmh_1606397102_2385P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX7+srgdmEQWDXROgAQJW4Q/9GFUDqf7hgecXDcL2yFy34oKrqxn9gXoZ
V1dpisivWhfbQiLZwIhhIkrs52LoWt58FgtTQ0RuCIcn1S2yKyg94MVylREcjK8X
iw9jMuWZW86ZdjSO3n7fLJBVWQG2pSuQWlV/5DpimEeheFCpYA0mee3V6uNjoJzV
3LRU/DDY6wP9tA15WlYIf3AlincoI3jt4n9MgWudCNqWr5veKnlpM7dOfB/2VAIU
KJ2QeUBhDk41QNFLR1siHH0BQ3gY1eSubv0Na1Rs6hfAGlbcV2CkidKkVq8YBb4m
gQKbpT55dH7xyYXiM/FFR6APCPj9NRHgpVby2/FzZMS8tZHC6kp0Mjq+EKF9Cx1p
IZbZJe4BQJynvj8uXR5ua04gLHBsRrDMsDN5ArzJkBW5C9twSOyCQVRDKZbdgQQO
S3V4NUI3SU/nG/hYA/c91hLtV4+B7PqvV994atnd5m9VTqLfI+pcgbUcNtahln9b
18TZH6/dBsCuWi4ecvqB9WIyNBNV8JxhtCZVp32aww/0D4VJSzjFPDesAAoc6bf7
8R6oA3klD3CUb1CEBB5i0jcFiNrz+vesXNs77JCe5twlTuD4zLr9Y0xccmMbWLJh
P1825oVnWJG/cJQfSxuvYvmNyC/isqk7DGTgNi0Lpd6q2uo/w9kqXCtauSmx0ggH
yJPa5fxc3DU=
=edQj
-----END PGP SIGNATURE-----

--==_Exmh_1606397102_2385P--
