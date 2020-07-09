Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950CF21A94A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 22:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgGIUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:48:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274BAC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:48:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so1496966pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jTCvng34NAGF7sMyc3FbW/vYJ5gq3hAUCGDsqstPZWo=;
        b=YmgJb4OEbddjH0aFgvWclH8eux8u4VwcyedrNoJtrVQkfpTtpBm5hdY++YaXJujf75
         VbLGwBST0wWJ/+Rim4vPOWS+12yWlSQg+e/oV909bcXY9p2ivYnUl9iR1boNfefgAVMV
         vBS4/oLaiqntS4cu4W8SI9wkHy1Bb5CP0SljRkgeFIUaa2Pbw2h1sbt/Q6zAUqV0//nz
         PLo4PhVxOgUa3fGrGYML2CFqfL9W+yL49TBBzB01/r10q2/e5kuFdnVWNe+jc84HSqjV
         EMuCacfRJqDZ2WkUykLBKaKwOLoJ9PlSTwlO9qobcn4hogY4uyP+SbVYmSKHght1Q8hX
         Vf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jTCvng34NAGF7sMyc3FbW/vYJ5gq3hAUCGDsqstPZWo=;
        b=eeOLsypwY42+Q2eTuBFv4MnI5RYSRi5HVrCE5x0GrxuvhothHIrfz5IM/se+rNu17k
         wsJerk0wBs8ScBIFXGhErL5EVwTXzB8A66K7S7GzsOjeor7IyjlVl2bu/GtLk9HGFQkR
         Kw0yc98rYMUwDNCTm77BxwSqle0tMZXtOZcNL8S9ygJy1CATqr/p93Xv8Lgxn1rS1OgS
         3LMp7USyyAGELeDa23SsWAs+3mboAAyBREOGTLg5X5UlB+1HHnqmfaWUKWbajPcUOYoK
         5/9YBnjqqeoaakuEpsQYMYmx7ImIPWUsbus4mf5hvCweuy0M9cgVGcTEXOvTmOKwXgXY
         S6eg==
X-Gm-Message-State: AOAM532cz8qZFonmKm49hzjILp7bcXrCpIbUA/xR7tTRqYMiDpe/tXtu
        x7OwfaVOlbPGYwoTVXtyLihi8g==
X-Google-Smtp-Source: ABdhPJzD08leG5+HDEW9JWrbjTdvca8V3V6gw8P3OjNQsMeXQUduJQNOkbwOIjqGHIZryWcZESievw==
X-Received: by 2002:a63:4d3:: with SMTP id 202mr55805628pge.14.1594327686420;
        Thu, 09 Jul 2020 13:48:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r191sm3631054pfr.181.2020.07.09.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:48:05 -0700 (PDT)
Date:   Thu, 09 Jul 2020 13:48:05 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Jul 2020 13:47:53 PDT (-0700)
Subject:     Re: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
In-Reply-To: <mvmtuylcb4h.fsf@suse.de>
CC:     yash.shah@sifive.com, david.abdurachmanov@gmail.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>, anup@brainfault.org,
        lollivier@baylibre.com, linux-kernel@vger.kernel.org,
        green.wan@sifive.com, sachin.ghadi@sifive.com, robh+dt@kernel.org,
        deepa.kernel@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, bmeng.cn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@suse.de
Message-ID: <mhng-da95d8d4-c593-4c23-a543-bfe9d8c8e40b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jul 2020 01:15:42 PDT (-0700), schwab@suse.de wrote:
> On Jul 03 2020, Yash Shah wrote:
>
>> Yes, you are right. The userspace governor is the only one supported.
>
> That doesn't make sense to me.  How is the userspace governor different
> from any other governor?

It's not.

The issue here is that pretty much everything is on one clock, including all
the cores and the simple IO devices.  These IO devices have programmable clock
dividers that need to mesh up with the input clock rate in order to operate
correctly.  There's no way to do that atomicly WRT the device's clock, so we
have to pause device IO while messing with the clocks.

I bet there's some issue with 4cbd7814bbd5 ("tty: sifive: Finish transmission
before changing the clock") that's causing the serial to get corrupted, and I
guess I'd start with all the issues I pointed out in the patch text :).
Presumably we need to fix the SPI driver as well, in much the same fashion
(though hopefully with fewer hardware surprises to work around).  I'd be way
more worried about ChipLink, as I don't know how that's clocked.  IIRC Ethernet
has its own clock so it should be safe.

I'd be very skeptical about turning on dynamic frequency scaling for the HiFive
Unleashed, as it's probably just not worth chasing the long tail of bugs.  Even
allowing the userspace governor is a bit sketchy, but given that it's a very
early dev board I assume these sorts of problems are expected.

If we do ever turn dynamic frequency scaling on it's not going to default to
allowing 1.4GHz, from what I saw speeds much over 1GHz don't work for most
people.
