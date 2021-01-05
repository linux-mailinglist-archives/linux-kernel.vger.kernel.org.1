Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1802EA875
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbhAEKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbhAEKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:19:05 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 02:18:24 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id a6so20493882qtw.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4NDv1UZv2zMgV+yu94pAwHUIKVWpRmw03FgM0AuSodw=;
        b=vZdF2Pp3CXA/w5gKdb9xboVx6coOC6i6VR5Ouc7xR/jtA8A0K25swjHf9rJaSl9Hhp
         yKv/gabdlU4sDWiej01WFLtgGvJoO1+nhARvo7CV7O9fWDU/U1vLTqmDu1rZiesnvkWb
         CEZWqkp9l5hPE+bX5UItsNWgqGAavcYpDn4wkFqoLGDFMUdx+8hPHShlrbfV2scm2Um6
         s9KKs0yopW20f+drfzBCwv5ZpTFqMNGrTAo9i1yMvcJRiX9WttimXfIzOTIV05qgl4LQ
         m5yWRnsnZXk6Yl1bc8O0woGXsFwByE13gfCC0gHoHlTbboa81Kuw/2FsfsNqxo6L2Oh5
         N+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4NDv1UZv2zMgV+yu94pAwHUIKVWpRmw03FgM0AuSodw=;
        b=UlxvuBgOM3p1X20wXZzg/cU3pfRqI4fhxXBjc3+MOowQftzGmyXFr94S3M+s3qgEoY
         A5r7TVNx638tVq3Sujq5sv6B2l+0CqwwlW/5/HqErE21bRVMeoYUZLoEOoDK/8GuD/sv
         MrTkSE667I357Yd8o4oz8ZahMIG87qjVjBRp+3IdJtOZ4/+Bn58IQ3N1X/fWT7bP1YIy
         KLOwKIzuIQkSMt9JthubwdPujXWcAhbhm7W+QYvR2zkYSwUCqMz0rNsODpk3vDVcwqje
         Mgzz2ARqdcOvZSNKfuFCGkgVf/9KO2FY8O8Ai31S/kV3+xsoGYQocDaFWdOEOFcpzNOA
         feaw==
X-Gm-Message-State: AOAM532z8MEF80alEdvaAeOcJNEf2IgnCes62SPHrWfH37fCW5K12Bv2
        akf7DcMHqoP9Va919z3ARPPsku3ueZE7RaAgpaOdFg==
X-Google-Smtp-Source: ABdhPJwa4ngQLOIQJ3Brg6rBad6CLKWn7X2+x1RCmpYkitHZuGurlFLyuwaCUtBUCvZmnVmlDSLeEpqrsvvR7Q23y/8=
X-Received: by 2002:aed:2827:: with SMTP id r36mr74531375qtd.337.1609841903477;
 Tue, 05 Jan 2021 02:18:23 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 Jan 2021 11:18:12 +0100
Message-ID: <CACT4Y+aarD_zG1t=OzwHYc3PxFTv4=MTEksb5hYdWcszXn30jg@mail.gmail.com>
Subject: WARNING: kernel stack regs has bad value (2)
To:     syzbot+adcfacd9eff46da50187@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably obsolete by now based on when it happened:
https://syzkaller.appspot.com/bug?id=0afc6db1b73dfa1659778cf6d03184bc5e4c2120

#syz invalid
