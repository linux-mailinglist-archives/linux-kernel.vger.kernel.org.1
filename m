Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8C72D09C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 05:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgLGEnk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Dec 2020 23:43:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49142 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgLGEnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:43:39 -0500
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1km8MU-0005Ej-8z
        for linux-kernel@vger.kernel.org; Mon, 07 Dec 2020 04:42:58 +0000
Received: by mail-pg1-f198.google.com with SMTP id c4so7790845pgb.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 20:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=dRTRoGxZQjf5VfvQ9QuIyncdiTUdvBDf3dsatRDVAPg=;
        b=RTSBB7Inyew509N8VMgZKwMCcwsd5bm/YQbuG2+MsAARSRTqz1mkk0taQ2WDi57ALr
         ieQoS8iLOTZhlCvnYM34UI9rWaniOtJzOjtUL3ku47tdUUTHXBb1jyG0RsMPAMd3gljb
         +3mPisIpqPQLwxxVQJ6xeBCbJ5i7MrFqbsWeP6cKa77yNxRg7PnrjGjtYf7jx5VE+hOZ
         f5pSxURVkq1sKrnJ4tPp5MP3QpjTRAePXX0oDMampoEcuJTnJzHrN3URUVBMQw+FoS5n
         +4J9kKV+9lG5DiGaAtRI0+Hn03D/nE43mW73wcEu4hPxtK1v9brr1VVbOGfshnLVeAMm
         w3dQ==
X-Gm-Message-State: AOAM530Gk26wWxRj1MN6JMWFgzUc1h+t5lcbI2Gh1yPuGdubSctwqhol
        8eaAKLzWEygFhZb1JeJgrvkfVXwIOvlKwucYLdVYXYc36ubO44Xg68Zax1NE064h5SoVHGZ4ZTx
        PkoepHMhVMYFBX6o2Z5HFXU/luT+I5ap8oLwe6Bh5nA==
X-Received: by 2002:a62:2cc3:0:b029:197:dda8:476a with SMTP id s186-20020a622cc30000b0290197dda8476amr14074265pfs.37.1607316176709;
        Sun, 06 Dec 2020 20:42:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcuP2lNMdUlH6UM9n5vr/FUv5lVhwMXHQSz4F1MIyvm218sS3P3QzvWgVdfMzSLSxeSqIrNA==
X-Received: by 2002:a62:2cc3:0:b029:197:dda8:476a with SMTP id s186-20020a622cc30000b0290197dda8476amr14074254pfs.37.1607316176412;
        Sun, 06 Dec 2020 20:42:56 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q35sm8987011pjh.38.2020.12.06.20.42.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 20:42:55 -0800 (PST)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: [Regression] Can only do S3 once after "tpm: take TPM chip power
 gating out of tpm_transmit()"
Message-Id: <7E60C7F0-85C6-4A9A-B905-904D37A5E67B@canonical.com>
Date:   Mon, 7 Dec 2020 12:42:53 +0800
Cc:     linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

A user report that the system can only do S3 once. Subsequent S3 fails after commit a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()").

Dmesg with the issue, collected under 5.10-rc2:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/14

Dmesg without the issue, collected under 5.0.0-rc8:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/16

Full bug report here:
https://bugs.launchpad.net/bugs/1891502

Kai-Heng
