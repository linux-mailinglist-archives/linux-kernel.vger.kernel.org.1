Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26CC29D6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgJ1WSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732257AbgJ1WSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:18:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D0CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:18:00 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id y17so1094625ilg.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaMeZWP6qzxq2+1qSUMa2h3pJmFR05HnJ0hcGdrwgY4=;
        b=bMsuz/hCOh51wQ5U2qp0O4kDC0rrCywK3j94rKux8pSj4EIXX1yqJRfFb1CNR6A0HA
         VFnA5BUcjgpQk1hEo60ArrNHpOfocU9hlPXpfhM92IuYmbw/kp6V9FMY1Bc2LJCKvexB
         hby3ZjjWDPxGKuVDadZKpLlifIRV+p03cHpxsNcKuubDqGzsMneFkrPDj1MVKKTI5l2P
         sKbhuYRm6dmj3Donk4FOe34w4yMvhuwmCVuNulBVG5a42Oaa83dJyAnI2WjH2gsdkvaH
         cVViBHc8b/UKjNk2NRYbnUxgY4jLefpQexGBeLGNb3alcZBWc7FeXcdNEyNXEHwQyxvM
         mMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CaMeZWP6qzxq2+1qSUMa2h3pJmFR05HnJ0hcGdrwgY4=;
        b=OS2a9sMmZS6xM8Ha167Zo05LZC/ZZsX2dG9tGm8oxM8CcHr6lstpSvygz6jnKF8Te8
         CGqRTU50rDKLnAlDsm0bF7tBvLb+LJzRAaziUZiSpGcfYczSNF6Tq5aX65sVG35nKwM1
         GnO76vns8ltDHZtpwJylA5V9hY/U4kqFB5HIJCK3THp08agwvVvdKeEHzzDpZ3bgo6K0
         kqdTLp/uzlpnUowLCKNVbBEa04XrKyUn/b8cfLDUUmBF0O9cDggkzrhrcgQuI+dhthuz
         jhDdCKeUu+IeDZb76w7HzFOCNLPhQtSXsGTS/+TH8q6VJucJ8iM15knIwCT03zjMmXmS
         SpPQ==
X-Gm-Message-State: AOAM530UeprBrGvliqAReI66++laezzoLJEK9PYDxlWiw6t8hc8mrojF
        g2Y+Je2Ht8RPktZ8IcQytx8OLmf9c3wEqmrY
X-Google-Smtp-Source: ABdhPJz2btr46T/LIivXmMrQgP37FQwug9BPjp4bPXh9chcE/sE7TuJhkpxDWW7CjrSgq72wcpBHvg==
X-Received: by 2002:a63:f74c:: with SMTP id f12mr570874pgk.434.1603909212958;
        Wed, 28 Oct 2020 11:20:12 -0700 (PDT)
Received: from hermes.local (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id ca5sm99959pjb.27.2020.10.28.11.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:20:12 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:19:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org, andreyknvl@google.com,
        dvyukov@google.com, elver@google.com, rdunlap@infradead.org,
        dave.taht@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        syzbot+ec762a6342ad0d3c0d8f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] netem: fix zero division in tabledist
Message-ID: <20201028111959.6ed6d2c2@hermes.local>
In-Reply-To: <20201028170731.1383332-1-aleksandrnogikh@gmail.com>
References: <20201028170731.1383332-1-aleksandrnogikh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 17:07:31 +0000
Aleksandr Nogikh <aleksandrnogikh@gmail.com> wrote:

> From: Aleksandr Nogikh <nogikh@google.com>
> 
> Currently it is possible to craft a special netlink RTM_NEWQDISC
> command that can result in jitter being equal to 0x80000000. It is
> enough to set the 32 bit jitter to 0x02000000 (it will later be
> multiplied by 2^6) or just set the 64 bit jitter via
> TCA_NETEM_JITTER64. This causes an overflow during the generation of
> uniformly distributed numbers in tabledist(), which in turn leads to
> division by zero (sigma != 0, but sigma * 2 is 0).
> 
> The related fragment of code needs 32-bit division - see commit
> 9b0ed89 ("netem: remove unnecessary 64 bit modulus"), so switching to
> 64 bit is not an option.
> 
> Fix the issue by keeping the value of jitter within the range that can
> be adequately handled by tabledist() - [0;INT_MAX]. As negative std
> deviation makes no sense, take the absolute value of the passed value
> and cap it at INT_MAX. Inside tabledist(), switch to unsigned 32 bit
> arithmetic in order to prevent overflows.
> 
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> Reported-by: syzbot+ec762a6342ad0d3c0d8f@syzkaller.appspotmail.com

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
