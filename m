Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3D2AC2FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgKIR6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgKIR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:58:36 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F7C0613CF;
        Mon,  9 Nov 2020 09:58:36 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id z17so797769qvy.11;
        Mon, 09 Nov 2020 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3UZgyu+3oKM3r5zc4rdsvwvYvFM1/i4w1UNXGNg+hlc=;
        b=QJD9LBVQvDa5P61QK2aUMymniL/35kv+JobCg8H4Wbb95vsiIl5UbqGAH5esDuBIms
         BCkHtYjO2SABMVjq7qqFBfdQW/bGmOf/amhLre1XfbTERkJGtTUhXaPfLWjaXlff76XA
         Y7weJJGrHWLIYXgAc/hl2Ep8G4S7lL+OhDyusg4ptVUZkO5iSv3Iwdps2edfy1b8QqRM
         HmFchdn5UQaDjRNhtW3ixoQgk4kMST6N8dXZ+hyMN/cFlKkhXiCm71oG0JnHm/XoBsMY
         XH1wT1AuiPGlJAUvCnTZtofzOUYH1bPpzDteqQF1PI8b9YxrLThp4N1QHmKX34ukIKvi
         R2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3UZgyu+3oKM3r5zc4rdsvwvYvFM1/i4w1UNXGNg+hlc=;
        b=Zidl79heivTeYaisyrXH5YR84W0R3vmehwDvk6RXwRuD3K4SlmhvmJRdgTRN7MHXyw
         Mh673c5YiBTn4+HebTMWpwdzEpf/zBB6xZEBGQmtykKQlqcURUb5IAs7zrtl3H1sBMuw
         VMfII+ioKvTRA8kF2qY+R+mA8MYRxfBrk1VCWmgBssOAAwKUYn6+Qb92VCMmsiwz4ptW
         CxHsZTLmaJsoATyP23O1U9SH827fcDzqByi7IZLWMT6sFRA7o99rlKkUs05nYFVZAU9H
         wjK/LSexykzNQfuuJTbYyX8mQ8fM61RkGNfU3+4HW5WFlgLn/2OMmtoC8OYpWPPeVqgt
         4xEA==
X-Gm-Message-State: AOAM5325pSZgEdbSfOLXKIcss8XRVt/bQS/tKHpQcfF+tRSd5j07s88O
        UMz2ibtj4rnFQGHhwKTzpWc=
X-Google-Smtp-Source: ABdhPJx39OtlroD2N2vPRb5/O6gHmi4vqWSyQ9dTkJpCA/XtfFA7Pv5k3eRSUt1Z/Yv6rXNT6YkuJA==
X-Received: by 2002:a0c:9021:: with SMTP id o30mr15759829qvo.1.1604944715946;
        Mon, 09 Nov 2020 09:58:35 -0800 (PST)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id d188sm6630280qkb.10.2020.11.09.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:58:35 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:58:31 -0500
From:   Vivek Unune <npcomplete13@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     florian.fainelli@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: BCM5301X: Linksys EA9500 add fixed
 partitions
Message-ID: <20201109175831.GA790352@ubuntu>
References: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
 <20201101200804.2460-1-npcomplete13@gmail.com>
 <b69adfa6-c867-816a-1f1d-d67fbfbd5f42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b69adfa6-c867-816a-1f1d-d67fbfbd5f42@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 06:28:38PM +0100, Rafał Miłecki wrote:
> On 01.11.2020 21:08, Vivek Unune wrote:
> > This router has dual paritions to store trx firmware image and
> > dual partitions for nvram. The second one in each of these cases acts
> > as a backup store.
> 
> I'm quite sure CFE is supposed to flash new firmware to the backup
> partition and then mark it as main one. The old firmware partition becomes a
> new backup then.
>
> That means you need to check which partition bootloader used to handle
> partitioning properly.
> 
> 
> > +		partition@200000 {
> > +			label = "firmware";
> > +			reg = <0x0200000 0x01D00000>;
> > +			compatible = "brcm,trx";
> > +		};
> > +
> > +		partition@1F00000 {
> > +			label = "failsafe";
> > +			reg = <0x01F00000 0x01D00000>;
> > +			read-only;
> > +		};
> 
> Here you assume CFE always boots from the first firmware partition.
> 
> Unless EA9500 CFE does sth stupid it seems like a 50% - 50% guess.

Hi Rafał,

Indeed, my assumption is to only boot using first partition.

If we ever want to support true dual partitions in future, we need to:

1. Read the boot flag 'bootpartition' and skip the backup partition parsing
2. Updagrading firmware will write to backup partition and flip the bootpartition


Thanks,

Vivek
