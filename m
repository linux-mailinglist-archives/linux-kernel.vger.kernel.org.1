Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8501B6FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDXI1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgDXI1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:27:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A0C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:27:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b62so9369054qkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SsQ+D2rI1OnPTwHjFUheQipBCCDl58vu5wq2m4lDT2k=;
        b=Llm0euZ0Odzy+9/UCDfssAY4EUmGFNo2iyGP7Tvhxb9yvATgfncYVYHLxXK8xV4z6f
         IczPS0zgkcs67iw3o+ClCyLQg2z+r3gU9X+9V6pJEnkro+ITPaR6K6nqlAd09Iw3nRlY
         THAVE5P4FFhrIyrXwW+NnlTxDMRnQSimXPkixlcIjnm9+PT81T7ACgqvoiIBwlhcYGYw
         T0rQQ+obUaDaDb5WKS7ArKNVCUZiclWLuVElfmICvDdifJJ5MHiSCUNgKVCZgnYJ4Uug
         DME7AKMsiKsCdV5mTqu4K6boiQHmFoGr+aOyteuRnSV0Cl43KNgIhGidzlywuPnP/ixY
         kEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SsQ+D2rI1OnPTwHjFUheQipBCCDl58vu5wq2m4lDT2k=;
        b=VsnwZ4o0AUSb9RHbXiaKc9rdOPhx92lQlcrph4rZwM5IiP7nAUXkbia0FEhlR5yr9K
         80V0F0GA+sAHa6JX7yXfD0v8JniM0qKC7kPxbRj6HltI6jAd8d7vhv6B3gxrUXc4yi0H
         JjmnliLMZBWwXUinp4G8Iq2ashpLN5Ggt2ARybGdqnIdNMoN+rQtVuOxcI9rDziiWshl
         0TUn5xGyo07WB77YFsh8tLcppljYOA6ye9yZg1EdtGA4re7/GkrkDd9vMztKJjfihToz
         YfQObC5baXt/hctBwyXAxVf2G422i1LITVn7jvJTcs3Z7io/cue4psmeZYJbGCszq3ml
         uZ3g==
X-Gm-Message-State: AGi0PuYE3f+ZB0NMcc5AD1wfwcBuLwEWSXVhpIF/LvFFQiAXFvbXH4kJ
        q4H8KhN5VQssrIKr9NhOcgshR7PBZ71FgtAK71MB2Q==
X-Google-Smtp-Source: APiQypJYn4PIi9liTr/E5NwZJztu5rgiBU/MpVcLd2iyDNpYpEC7B7NprZz1yYl0wEXmVUEDLwL+wWuuOspoH4eQkEc=
X-Received: by 2002:a05:620a:12b6:: with SMTP id x22mr1017966qki.8.1587716856576;
 Fri, 24 Apr 2020 01:27:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 24 Apr 2020 10:27:25 +0200
Message-ID: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
Subject: selinux_netlink_send changes program behavior
To:     Paul Moore <paul@paul-moore.com>, stephen.smalley.work@gmail.com,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SELinux maintainers,

We've hit a case where a developer wasn't able to reproduce a kernel
bug, it turned out to be a difference in behavior between SELinux and
non-SELinux kernels.
Condensed version: a program does sendmmsg on netlink socket with 2
mmsghdr's, first is completely empty/zeros, second contains some
actual payload. Without SELinux the first mmsghdr is treated as no-op
and the kernel processes the second one (triggers bug). However the
SELinux hook does:

static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
{
    if (skb->len < NLMSG_HDRLEN) {
        err = -EINVAL;
        goto out;
    }

and fails processing on the first empty mmsghdr (does not happen
without SELinux).

Is this difference in behavior intentional/acceptable/should be fixed?

Thanks

FTR, the C program is:
https://gist.githubusercontent.com/dvyukov/dda1c547ca9121817159d29afa72aea2/raw/41b021d722947df4d8c48e2fc783591b44671ceb/gistfile1.txt
kernel config:
https://gist.githubusercontent.com/dvyukov/08bf2c2fd873a84a2c4c771740716183/raw/78fb3b1063b7ae37625468f32868869edbd1bd19/gistfile1.txt
on upstream commit 50cc09c1 it triggers a KASAN bug without SELinux,
but does not with SELinux.
