Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2202D49FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbgLITS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbgLITSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:18:55 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7ADC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 11:18:15 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so4635854lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOdxg1NYtVXt5G5UnjVeP8cr61+u8IQ69hUIDhx99vI=;
        b=Z9p/tmKsmOC83zvCFtHtvphx12PkgBTkQDx5VUQMHPKdW/yXt4ZVKmDtW3EHXknybH
         3ttqK6IydOkQMKlbM7Ps646F0xkUlhv/kD2h2saS2KzzTX0xNXxEMDzkP09sKpOOhv6G
         hQacjVksK2YnSqwF/GbSYU1xxowa8yAnv12pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOdxg1NYtVXt5G5UnjVeP8cr61+u8IQ69hUIDhx99vI=;
        b=l1z+31GW5es5p7SnOAWrNbLWBhNPMiDzmLlvcK2bdvcJa0nKWtoj74b4m3b8O/YOj8
         EKk9P35i/6IEibWEWUY+BBS4DQ6bzpCCTq3doAoW7bcKYtcCN9YsZ3+Eut5yHDCPqbER
         1+pI0KAkIngx8P/zyRX2T1clddaxF9q5AyyVvt4hqSYj6qoD/+EkW1mlYrsZ6IxnSd5F
         d/r7vq/MAsleA5O1g0pITz/OedA5xjPa2amxzbsN/Pw7ULojDYN11JYu4S/AJ6yDudA/
         YYLGtN+/iPrNbHm24ehHLdGQSv6mFYkJYKKRBtcqDtyldmAAI18/QNMht50a/aGe84ZW
         6oPA==
X-Gm-Message-State: AOAM533bMD4+tfTGDLXQrX6Num2t/ASwKbE783BS6brcUN37yzigZFJw
        RHZGC6HRo7t+5hGd4pI9imTUgyonIsKyfw==
X-Google-Smtp-Source: ABdhPJwKp7YLZKyddxcK6CuYH/eJpOr+oIabOs8kaIYYamolCK8Kjn1Fk7gCLX6Qds29aYaOD6Q6xA==
X-Received: by 2002:a19:7d2:: with SMTP id 201mr784207lfh.518.1607541493623;
        Wed, 09 Dec 2020 11:18:13 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f3sm333833ljn.129.2020.12.09.11.18.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 11:18:12 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id l11so4686118lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 11:18:12 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr1412125lfi.377.1607541492434;
 Wed, 09 Dec 2020 11:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20201209141237.GA8092@willie-the-truck> <CAHk-=wht4inbTVVMt2TNDxR_cVjSNaBU3JYyKtRMVovWePb65g@mail.gmail.com>
 <20201209185020.GC8778@willie-the-truck> <87tusulrog.fsf@redhat.com>
In-Reply-To: <87tusulrog.fsf@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 11:17:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
Message-ID: <CAHk-=wg370+69ZoXFdUABwwqNaej3hrjcqAsb56J++h2oXKJpg@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU fix for 5.10 (-final)
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 11:12 AM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>
> Since the field in the device table entry format expects it to be n
> where there are 2^n entries in the table I guess it should be:
>
> #define DTE_IRQ_TABLE_LEN 9
> #define MAX_IRQS_PER_TABLE (1 << DTE_IRQ_TABLE_LEN)

No, that "DTE_IRQ_TABLE_LEN" is not the size shift - it's the size
shift value in that DTE field, which is shifted up by 1.

That's why the current code does that

   #define DTE_IRQ_TABLE_LEN       (9ULL << 1)

there..

Which was why I suggested that new #define that is the *actual* shift
value, and then the DTE thing and the MAX_IRQS_PER_TABLE values would
depend on that.

           Linus
