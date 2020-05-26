Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37881B50BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDVXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgDVXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:14:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD88C08C5F2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:14:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s63so4449245qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yutIE/3Yrasa++aWOCa3PZNUoPlrlPERr3vYpXHco/M=;
        b=roi6w8e5qBgfrEAFnX0ITcdhSDL8WSk9M0K+Pi5JsvodaNNOas+t0Q1f3de9phX1r3
         zH9nNHarNQ5F0bPzz7BOwaRNKmtglTqtN0NM6aiRDb1o0ARGr4RLUKq2Ljipggfzmq4f
         4lue9ey15OIgipQe2SFDgP3Zg483GPNPRk1b8P8tkH8JOTSig5IAtEHFk48/ttXK/xW3
         HXoY6IUYmJ/pTBF9GpTUhyyw7weiMGNPNlwjMBnBqpgI6X0Q/tR6jaPPDUnk4ojUthH4
         sJ/35wr3LbgYPfPQAvyDm9c7nFllFe/TQ0modirFmWgoD/qWXe5K3H06giTotm5Z7P3Z
         jarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yutIE/3Yrasa++aWOCa3PZNUoPlrlPERr3vYpXHco/M=;
        b=P/dVEks00fLVe7uxli5Aj49+V0/M4srPXYwNspGzwYoaXSPix+9ha4GRe86K95Uqi1
         U3FtfDcxY96406arCh4fZQ9sqUaN0m538FelBvvf7xVEkeI82ABHf6TsqdrR2mbvtUe7
         UghPrhir3XO8+RddmlhrNtllFit9pumBC7/FvjIInXKhcwhLgVpa+XVa2h2IZKG3exdW
         QAN895XAhEX33aNz+kPpYhSg/lHbG02UVzhhL9bcDl0Iunc2AAieO93uVh6VRsKfUXMP
         ZXMY9uPl3uGFugEpNgNTL+RNssUC+CJogeOORragg2zhIt2JJVi/0i5fhQ7yfTkAD3gv
         Y3MQ==
X-Gm-Message-State: AGi0Pub/MvAd6dPNvGyFP47f4Gy49KLQ9zxVHPDnBqjkMj/G+Fh1Py7G
        hpfTFsze9I7Vm7z4rcZyW5FrBA==
X-Google-Smtp-Source: APiQypKpwv318za6PvBDHu/CmZW2XLyq7lRBmFefrk1Y5QT6hBrl33XFhRuafmp5OdsdRdB+WGIptg==
X-Received: by 2002:a37:6415:: with SMTP id y21mr792941qkb.258.1587597263810;
        Wed, 22 Apr 2020 16:14:23 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::1:af35])
        by smtp.gmail.com with ESMTPSA id q6sm534297qtd.61.2020.04.22.16.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 16:14:23 -0700 (PDT)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvme@vger.kernel.org" <linux-nvme@vger.kernel.org>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>
From:   Josef Bacik <josef@toxicpanda.com>
Subject: LSFMMBPF 2020 Cancellation announcement
Message-ID: <0b6d3d6f-99de-3603-4b42-c3db5113633d@toxicpanda.com>
Date:   Wed, 22 Apr 2020 19:14:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each year, we look forward to gathering at Linux Storage, Filesystem, Memory
Management, and BPF Summit to share information, collaborate, and learn
together. Due to continual assessments and growing concerns around COVID-19, we
have made the decision to cancel Linux Storage, Filesystem, Memory Management,
and BPF Summit this year. Next year the summit will be held in Palm Springs, on
May 12-14, 2021 at the Riviera Palm Springs.  A new CFP and registration will be
held again, along with a new round of invites.  The program committee will
remain the same, and next year we will choose new members.

Event Registration

The Linux Foundation will take care of canceling all event registrations - you
do not need to do anything.

We thank you for your patience and understanding while we work through this very
fluid situation. A great deal of work and preparation has gone into the
information and content planned to be delivered at LSFMMBPF and we look forward
to sharing it all with our community next year.

Thank you again for your support. Our sincere sympathies are with all those
being affected and we wish for good health and safety for all.

Thank you on behalf of the program committee:

         Josef Bacik (Filesystems)
         Amir Goldstein (Filesystems)
         Martin K. Petersen (Storage)
         Omar Sandoval (Storage)
         Michal Hocko (MM)
         Dan Williams (MM)
         Alexei Starovoitov (BPF)
         Daniel Borkmann (BPF)
