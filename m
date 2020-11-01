Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE722A1F79
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKAQUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:20:55 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C3C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 08:20:55 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c5so7679070qtw.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:message-id:date:subject
         :to;
        bh=NlI8bA9kSBOKCCQolvn/+d+88U2/TVkApy5GQTziez8=;
        b=V1YEuVX8loXLGcr0PK+3JndPyMOG/5NLmHpCz6GMBn5csQiaVSZxwliaTjzGxWN/pX
         /qWLRj9/+63Bhmq4GxHJlhk1tbYeKu2qE0KWmtldXkJlDxyfYeRTAkjia035i+I0H/ia
         AObJXJmyhcCVjsumzLNv0VRSeaDPFo78gxvF+AlZdbO4asRSJ/4/dp+cS3RfGWwcOqDZ
         QTwJUFqZenUIROB0sYG3dj287jlIue/jZtgl+OxSL6aF8bHTJYyUInnlElSJePk87d2s
         /41td9OkThFB/KyNioOdNJ/u1yClzsiErzwqq0/F3pW/E3PFfuNyRzX8upfA4FI8Ru3X
         ZyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :message-id:date:subject:to;
        bh=NlI8bA9kSBOKCCQolvn/+d+88U2/TVkApy5GQTziez8=;
        b=gckM6rxAGe9Y6TLmrf3ihmLq9x6zm7jCVYlaaScOEGKKHKv27ilHsQurhHLVCOCf79
         20lwH4gOHcvBXc8TQnIacFzE6sANS3+oUHA0ypK7IuEEKgWjsATSuiIYSDobLDHncPR/
         RqxYwV/pNaylJqfjcpJ/Gf/eNCA/oepLjzwdXpQcV6i/XpR0AVAV9mRIPcGgqnZ/Yx9I
         Jwrk78lDnPwoQFbkn3ynbhMoBm5OfozFxTFomVdptrcJ4s2dcUsIJo6HB5tp/x1nclt9
         T7ufK7Dwu1c/2kbzi4OJ7fuiRyKkRJDr4HSig7ohNs84WGsf0OnWeqGIBv60QrDSvvAY
         RB+A==
X-Gm-Message-State: AOAM533Q/Docl/GwykRbH6wD6At25tfMy3euJO8zspCnPk3trRdtY6RU
        r6/Vjg6nkLCNtgWPbRLg8FcixR8XML/zLg==
X-Google-Smtp-Source: ABdhPJyA/iZmHo/Kz9fQt5Iu2/8naRbvqXWD6CXmR+mfqdZbyRNiwOqCY1EO+SeAtPZJEnQVyWsnlA==
X-Received: by 2002:aed:3968:: with SMTP id l95mr10993518qte.302.1604247654025;
        Sun, 01 Nov 2020 08:20:54 -0800 (PST)
Received: from [10.200.10.3] ([114.141.194.12])
        by smtp.gmail.com with ESMTPSA id j125sm4117194qke.75.2020.11.01.08.20.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 08:20:53 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=utf-8
From:   NASA Jeff <tallboy258@gmail.com>
Mime-Version: 1.0 (1.0)
Received: from [10.200.10.20] ([114.141.194.12]) by smtp.gmail.com with ESMTPSA id p18sm3916040ile.72.2020.10.29.21.17.39 for <linux-kernel@vger.kernel.org> (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128); Thu, 29 Oct 2020 21:17:39 -0700 (PDT)
Message-Id: <439845F3-9262-4C90-8755-324FA36A28CE@gmail.com>
Date:   Sun, 1 Nov 2020 16:20:48 +0000
X-Mailer: iPhone Mail (16G201)
Subject: Freezing between .48 and .51 when hitting swap.
To:     linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have an issue on my laptop which is old but with 2.5gb of ram an ssd hdd a=
nd using zram compression I believe.
When ever it hits swap the system completely locks up and I have to reboot.
This only started occurring in .51
I only have access to my phone at the moment though I=E2=80=99ve looked at t=
he code and have what I believe is a workable solution that should mitigate a=
gainst and future issues. The code base looked a little old so was probably q=
uite stable but it really could do with some modernisation.
The issue was with the active app in user space.
What needs to be done is to swap out inactive pages in background user apps p=
rior to the active apps hitting the memory threshold which was causing the l=
ockup to occure.

An improvement on the existing code would be to swap in and out inactive pag=
es gradually so as to avoid any heavy system load.

It may also be an idea to set the up priority to near idel for such heavy io=
 background processes so that the overlapping io doesn=E2=80=99t cause issue=
s with user space io.

I believe this is similar to the main Linux scheduler since bfs because impl=
ementing a script to renice processes that started hitting higish cpu and th=
en again when their cpu dipped didn=E2=80=99t seem to make much difference. I=
t was unclear if this was also implemented for cocurent io as the window man=
agers now seem to queue io tasks instead of executing them concurrently. Con=
current io was at least a historic issue.

Kind regards,
Oliverthered=20

Sent from my iPhone=
