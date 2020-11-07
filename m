Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2E2AA76C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 19:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgKGSdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 13:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 13:33:23 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68C0C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 10:33:23 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id y197so4308269qkb.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:content-transfer-encoding
         :date:message-id;
        bh=LdNZ1hytR60ERmAo8ZVr1UceLPjztqJkcYauyWcik/Q=;
        b=cMzGdSD0uqAaw7ytwDxRJUiWvBsyxKkkaw9js/i+qYS1TVLIYqN2/zGOe7dTgXJDBO
         R0Y11jUmekKAPCmk6TiwxErct8RvG6ejO8I6hxfB77MMVW6P7ockKbqHjVupKWThhZLv
         2I/lpAppJONXx59+Sp6t4whOdrrGQ0CXqbeQTmB0qBsa1y3bNdEPvNFiRDR4kgPq2KqH
         lLEYvn5MrQL02v3iNP/m7V3Krp+G3LLy/JfLlgkCyOZO7Fu8PDdsNDH0Ww5DNhSyBVhW
         YpVS/5CmVJfcPd2SoElFGTAvtKnwCUyh81MF8dZENUxW0EfVfWwHr7K2sVuglPcG0wkT
         6lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=LdNZ1hytR60ERmAo8ZVr1UceLPjztqJkcYauyWcik/Q=;
        b=TyQv4THdVNHJ+GdS2NfRuEOCBIUIZe05XHF0cQV15zvRzOI4a3sH8Fsea0FyAfsN9I
         8o8Gc97AxS+BhcXDs2ZkbhM0PNO1jWbFUHIq6nuwGx8bMgm8/rtMe7qCZIA4pgTrhdc/
         FIwnP8FytGfKq1WrK1V8AvuJGkw+nurmNfBzh66pC/2umyy7TfwMeJJaa7Z/SsLjXh4q
         yQ378RwHfOzYQQclI3ZyrOwwkOqKBQIZbG+CJGpEzxBM+gOvSR9qtpjyaXSXKaBrRIV9
         mofpKk0VF0D8g3KTRgaO8r5w/0AK7hlGMp5ELH3s2P7H5qK2khfreo7D5XfyAuSbsTGH
         ftSw==
X-Gm-Message-State: AOAM531I4PP+0v0SmeqkgGGJLLV0/LLXoBKbDyeNQ4Zl1ixGaQF0b8su
        pvC0kbPlTj944UayX+OWvYaPRieGtJYo/w==
X-Google-Smtp-Source: ABdhPJxGxccln6FiDc+LiryEp/VjwE7Z4OVOUCa5gbu+5tida5RsYA83pqi22EHm2Rg9sKFbH48zLg==
X-Received: by 2002:a05:620a:208b:: with SMTP id e11mr2324842qka.380.1604774002815;
        Sat, 07 Nov 2020 10:33:22 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id d133sm2967493qke.106.2020.11.07.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 10:33:21 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: next-20201105 - build issue with KASAN on ARM
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1604774000_2373P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 07 Nov 2020 13:33:20 -0500
Message-ID: <7021.1604774000@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1604774000_2373P
Content-Type: text/plain; charset=us-ascii

commit d6d51a96c7d63b7450860a3037f2d62388286a52
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Sun Oct 25 23:52:08 2020 +0100

    ARM: 9014/2: Replace string mem* functions for KASan

I'm trying to figure out why this has 3 Tested-By: tags but blows up for fairly obvious
reasons on ARM.....

  CC      arch/arm/boot/compressed/string.o
arch/arm/boot/compressed/string.c:24:1: error: attribute 'alias' argument not a string
 void *__memcpy(void *__dest, __const void *__src, size_t __n) __alias(memcpy);
 ^~~~
arch/arm/boot/compressed/string.c:25:1: error: attribute 'alias' argument not a string
 void *__memmove(void *__dest, __const void *__src, size_t count) __alias(memmove);
 ^~~~
arch/arm/boot/compressed/string.c:26:1: error: attribute 'alias' argument not a string
 void *__memset(void *s, int c, size_t count) __alias(memset);
 ^~~~
make[2]: *** [scripts/Makefile.build:283: arch/arm/boot/compressed/string.o] Error 1
make[1]: *** [arch/arm/boot/Makefile:64: arch/arm/boot/compressed/vmlinux] Error 2


--==_Exmh_1604774000_2373P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX6bobwdmEQWDXROgAQLytRAAlfukYdEjIdAVL0xo1AJrWXsAwbpnbLAf
AZa6JGSJEvlt7mfokYZ0ankJC60Vkyr947CvsvMk3RoVG6t2SwMPPqfCvZLKXxC6
WCJfc4iAZgF1Jzor7K5RUtHfNCdPYpC+DsiduZCSGAZx4GcM+vRCarDhS/yBKdI2
BrFJ4kgnjt0nx2uIlMhO8gnan19EcYNaOJezwZkZm6u04PCNCPB6DwjIYPht6VAP
1Y4qO4r7EXqlnCJRJRsqiviX2EKGurRYq0PcCx4hk6uD6cb5yfXRbe9F1n9QEg65
EQGMvnfmZ0iHzVcEjLs9YOdgnQBciOr43GxnEnl1eBy7DpitVKGY3ofEm4Lz1THO
lTM2JwFeQXM5U3t3jOe8/EegLFYcGD73fWJwgdznw0QQTlrCg2MI6JVMd6txg8Tj
Kn9NOjMy0N9KqKAUvp6mDjLwvGm7pIfj129zwe3xSbTxY7m8pY/Ni2T8JArbFimB
Ki9ES8ab6399G1bXo0JtH9uvddapVSUEJmfmvXXT84anMB3TUPstvlfF0LpFLmPV
kck9m+FZwXCXVXKal10rd3PfuGuSSapdIEpepAZaWQ6AvHKZ823kwAohwJnJ6UAy
muZDcQ7b/eTKmmBCrYWQjj2OSYRtOwt+hjwyqz2SV3g7eXXM1BG+pAYcDFhN/eis
7G1haGGxhk8=
=wZ+n
-----END PGP SIGNATURE-----

--==_Exmh_1604774000_2373P--
