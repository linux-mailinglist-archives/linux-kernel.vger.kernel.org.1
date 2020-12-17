Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E992DCE21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgLQJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLQJPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:15:43 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C9C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:15:03 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id bd6so12933876qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+LUeY1J08nuX4Bq5E5+c3ALMy1RM6+T7HOQCSOdCx20=;
        b=o3a4Nu4Fd4S2WSW1QhLDK6AYYwli5lTTnC0lRbCrL89CGDlo2/5XBi8KIbD4s9aVsh
         vgqZO417sZ3c6D/3TGqGo3Lhd/sLOHoKRfa0GkQYHfLBOxOFAQw9Nqo+f3Su2cQ5ogRA
         mPgb+QQUdQu4Mbq0d32XWcZTbbhDirwsk/7+pTjC4S9suEpj95Qj9xpTDhXAk2cNVT9y
         zhi1DBSfd8tw4TSHQaO44l1I0tlNz0LnFpjaEqIpfc5JFg5BHzRbOoOYkqxXtAAJbno/
         LEHBqMndhWauJ//oIkAcK2qXjGMQ1MC3EnROxzqYpEhS2YvFoxgMvkzZXHPeVTMCUSWZ
         0fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+LUeY1J08nuX4Bq5E5+c3ALMy1RM6+T7HOQCSOdCx20=;
        b=ubRFlLUMk8dViHEaY9GG/xYXzeGeuYz25ZeRztnuCuBi2+WAIJM+U/QiIyYhyIEheE
         9J+GT2fCfxRy05UgTaguTbFJ8x0Amy6N9mxKXevmP2tS4P/CZkZ7UnFfAtnRVEE/M8Lu
         vTB0lAM3Kw2Tr5KSlqwYgxbS6RcLPAdMm9khzdda1vkXzCmg5cdmcRsMaHsVoP4VEgJR
         WDkV6ocD8cuSPUMCR4D2hMVsgz254Y3sbdlYh/ra4w+nTxg01QHauJzo7/6DKkzcbSjQ
         7RCjSsuASh02MHwiXQqJpEZRa9sAurLm19A4NoI/m6PSMMcGvOD7FADOCxV61kVIYQuE
         MKYA==
X-Gm-Message-State: AOAM530V6cY44gL7NFbHFhxfr+sszNerlrEgiI54hZpttVE3GtrRn+SW
        nsYlY7v1oBCGszBJw2YqaglEqp7RSGyBEZw8oMNnoA==
X-Google-Smtp-Source: ABdhPJzn0swR8GnFh1ua9u4y9JH1ZK2RUNaxSPWDsLdZwF5sS4McqD5nSeGNIvmz9DkuSHwl55iG/ZM8E1jrr/NhFu4=
X-Received: by 2002:ad4:4e09:: with SMTP id dl9mr45831950qvb.44.1608196502281;
 Thu, 17 Dec 2020 01:15:02 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 17 Dec 2020 10:14:51 +0100
Message-ID: <CACT4Y+Z7WEM30RrZkQKc=_RYLGVjBh6vveSFBv8eza7tKAvgsg@mail.gmail.com>
Subject: KASAN: use-after-free Read in eth_type_trans
To:     syzbot+6745e272378d071cac7f@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        Greg Euteneier <geuteneier@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg claims this bug:
https://syzkaller.appspot.com/bug?extid=e0c166ed4b16ffd653e0
was fixed by the following commit, so let's close it.

#syz fix: tun: correct header offsets in napi frags mode
