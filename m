Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4329FCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 05:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJ3ERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 00:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3ERm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 00:17:42 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7CDC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:17:41 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k1so5362170ilc.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:date:subject:message-id
         :to;
        bh=NlI8bA9kSBOKCCQolvn/+d+88U2/TVkApy5GQTziez8=;
        b=aRayF8g+Uq34C6nr2uUThPcfW+mKNwyzNmPYX+lLVV+SMas0273a7ZokoEZi4wBdr1
         PNLypQCKT2JZN82qAKnqQtJWWfuatbex6P6HaXdnYSDjeTNa85dwkUH3fbGQ3FI18GUW
         +5390OyK+IcKpO1d4H7PVb4kiuXkkOqYZFH23I3ki8Q+8Ww+gRJAPNyHpAUk9/eTfErH
         RjFNY3SSnRyLO8vOxkVsK6bJhZk/h5h7RG0KokqBDIXcGSR68mIqvSolMNIS6wR0VbLJ
         YwQ+avaWWR7wfQoAkauS8habC8Vyc2brlt5bdY6U2sxvVCLnKsHPLX+8ZaMSGK9m+eoO
         BFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version:date
         :subject:message-id:to;
        bh=NlI8bA9kSBOKCCQolvn/+d+88U2/TVkApy5GQTziez8=;
        b=pOczlf0kZPONC6syJj085cstAtBtwI0XSrIn+Ir9/lbTOKcS5fxNNxpLWdl017gzCh
         qJt3Mhnir6r15gSlxOtG6S96w4tD/vGkaGj28zRnbh/ldC9X7dSy5eDS9BXyQLofUfzc
         7IHNLc1lP6uyJt+WkeR+SEUft16kv4V6aT0q+MxTkHbMis6NPR9DdqO0E/MKDI50p6Mn
         D9B/lrCcL9zY61+/naM6kdiPohpsYd+2SvhQ47uWyFdSM7+yHvrbweiYBenRuFcakYY3
         hL2xl+a9QtXojjAAk67oEBTrs+gtkFrkbYHO/kA+S4Z7/2c2HohXge0yUfFuj06q2G0q
         XYsQ==
X-Gm-Message-State: AOAM533wY2p7KZnXKifRvIz7Hw3zbudKQUzLtWBgkjYpmg/CGfiud/LU
        zpAPxW1mFfqsG0+vUlxO0B5sSP0P7xQ=
X-Google-Smtp-Source: ABdhPJwjcV/1Z5m/yuANyOI397hPBazw52icUjswf55wPE8h15+qAt7BcGUHNZBi/Q18ftTMcEiuZA==
X-Received: by 2002:a92:5b54:: with SMTP id p81mr576694ilb.290.1604031460686;
        Thu, 29 Oct 2020 21:17:40 -0700 (PDT)
Received: from [10.200.10.20] ([114.141.194.12])
        by smtp.gmail.com with ESMTPSA id p18sm3916040ile.72.2020.10.29.21.17.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 21:17:39 -0700 (PDT)
From:   NASA Jeff <tallboy258@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date:   Fri, 30 Oct 2020 04:17:07 +0000
Subject: Freezing between .48 and .51 when hitting swap.
Message-Id: <9FF0D29F-1282-4F96-8C80-05D5D45B6935@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (16G201)
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
