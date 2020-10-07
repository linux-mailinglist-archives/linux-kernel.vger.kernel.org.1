Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E169D285B68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgJGI61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgJGI61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:58:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB95FC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 01:58:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p13so1331732edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1Q/c93gwRC8NWIcrpGbHmBEju9vpCDDgwD1JgJaJq08=;
        b=ylBQHpMP2pFOFG12L/UhwucDzzYkPeIKpSso1EgYfgIxpaXHY3e49jfOGGUbweDdL0
         inCT10noh2vAiB4SahKIf2sudLsIeX7wERHu9zIvNcfnfTNy/0j3NofQU8kA2QY8d1Gj
         RYKdjCL0bs8Ld0r/9XqdRqGyuppIPqvml2e1kq+1JANoLP4dRbfs+cllDXcxFf8RIa3C
         3eSFDQY78tgAmWzzm1bTvtETvtD886xiidxC4NX0yvrnI7hOfaQdlLnZy4gASILx+VoO
         7wBjUXxEnEuumkm4LhQUE/2A7TyXwJ6Wk0Kdx0AT+uuDez9YhkAS43cHUeLt0V3ti6+J
         GNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1Q/c93gwRC8NWIcrpGbHmBEju9vpCDDgwD1JgJaJq08=;
        b=tecF2RsNp8Ue345fAvFzpvJFqxbTeT5jIXgTOwnY6gKXEgnloNpNss9H0z2eQ3Jvnm
         T9ocG2KQCdnM36ms6mN5fCgyqh3isMNqly1TXyaCPtmpGtij+p30t4S0kYX6NpAOBOQx
         48Un4lG3MwFYd6fjDdqAdgFWMlj6MUPvOttI0OMwJxNTcUhynDGy9oQY4f7Xwwk+So3e
         q4twQ5n5Z+c4CTP+epKioKhJ0s7weUL+mISnZbkLjwZ9thlemYH7vPLt2ZG+2dCMIupd
         T9vJgyBMERMgNBHI14uS3Cnu7jloPC33CMVthwj009wW8NtFWJ8/MqcrNtjRr4s4mY7h
         xdYw==
X-Gm-Message-State: AOAM532+5NiMww0UKBEtTzVzxZdWPA9O8aa2cEJR4G+tUgrA1jsr7kaX
        CjQqsWRKtVUJ7h8HO3dplWkk4P8LIZMa2A==
X-Google-Smtp-Source: ABdhPJzH1LMp1BGoH1cYQM/+3ZO6mN7SDBhi6tBQX2tWNpCMNrFL75KTHr0pJB3Kj2Vs4c4M6Je2/A==
X-Received: by 2002:a05:6402:289:: with SMTP id l9mr2467806edv.294.1602061104914;
        Wed, 07 Oct 2020 01:58:24 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id n4sm1041372ejj.19.2020.10.07.01.58.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 01:58:24 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id n6so920918wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 01:58:24 -0700 (PDT)
X-Received: by 2002:adf:f5c1:: with SMTP id k1mr2460780wrp.271.1602061103725;
 Wed, 07 Oct 2020 01:58:23 -0700 (PDT)
MIME-Version: 1.0
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date:   Wed, 7 Oct 2020 10:58:12 +0200
X-Gmail-Original-Message-ID: <CAAObsKCP+ve2ZdXQk62aTo70G9i9Vo17dh6k-fcY23NC=EYZxg@mail.gmail.com>
Message-ID: <CAAObsKCP+ve2ZdXQk62aTo70G9i9Vo17dh6k-fcY23NC=EYZxg@mail.gmail.com>
Subject: devfreq and panfrost on Allwinner H6
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cl=C3=A9ment,

Have just noticed that my Pine H64 board hangs when I try to set the
performance governor for the GPU devfreq.

Is this a known bug?

Thanks,

Tomeu
