Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591382A64B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgKDMyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgKDMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:54:30 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AABC0613D3;
        Wed,  4 Nov 2020 04:54:29 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id w5so9792376qvn.12;
        Wed, 04 Nov 2020 04:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaoPyHQr0cPiwfyXd4SwqQlNAqewngLFSD71o+gpBk0=;
        b=EsKUCE7bDFIOK1XZpuqDzoKCBG9T1Es4UOF9Iqi2bIg355tXglj7fBqIFX+EzBkFZ7
         UVx9OslU+s2wfLngSY7l1Hrzt+TuETf46RnONfTQW97S8Ox/jRkfAUPYrE4GANlYNUw0
         V9yUPyrNUUYQxxReCyYeONUt7UvZdr4bSUKjPsL4vIZ55wSLqmURvfGoyjJ5pl8x65Tf
         T2oicz0Uq4RuSgBxmNIbwsEsuj3DJ/ZkZi0PUpVBEl5P3eCVwvaslovGcj/GstHmeVUN
         DmgQZi2bGkpgU4RGrG0cRIiNAQ+zTLRjxKoVwPVAgIbwVreeW6rw7WEdoyygVmo5jhe1
         TKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaoPyHQr0cPiwfyXd4SwqQlNAqewngLFSD71o+gpBk0=;
        b=L/QuRUFwYSvmJNafnD+AEyz7gHeHvgxvluiB6xCWtJkYpP8Gh4oj/PGBE5DNxPfEkG
         XZs3wd1lQi28onQOe/Sc6Vt/hKTXMYMTXx3VqXWp6zovqrOxucU966AuKapNMCUcEjpq
         4CGq/SW1R4ZVOUxMhf5iJJk5uUUSL94uBxuwVCdP4H/50O/8KL6btD0x0g5a+lfO8Bm2
         hq5w3AV1/rNcLkB6+R85WRsujMaFq/jJWvB8UjXCjTINQN/K366X2Yq/Tsjl+zb5mDPy
         /wQuGx75vAffFl7SOQu71JN6KZgibEAQANScvFasGpo5fJa0Zm/H0l5uwKh4apQtvMJr
         nIjg==
X-Gm-Message-State: AOAM532kXCvMWtqLUnTuFmwwoE79CrtTttXIfKlqw1PHTr6mz/4q8iA+
        9UO7HrRBKyFv0Dj8QF8ChwU=
X-Google-Smtp-Source: ABdhPJxDLgFqKpH/7d5VPCNisMEYINH8ux0fRiQaomKXpe5N+o8eCyaMoJSxd/3QJMDqxdgWjbRsWQ==
X-Received: by 2002:a0c:e346:: with SMTP id a6mr33477974qvm.9.1604494469117;
        Wed, 04 Nov 2020 04:54:29 -0800 (PST)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id o19sm2465010qko.3.2020.11.04.04.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:54:28 -0800 (PST)
Date:   Wed, 4 Nov 2020 07:54:26 -0500
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: BCM5301X: Linksys EA9500 add fixed
 partitions
Message-ID: <20201104125426.GA3470@ubuntu>
References: <e64d76cc-90bb-5b54-04de-fde21542e4fe@gmail.com>
 <20201101200804.2460-1-npcomplete13@gmail.com>
 <20201104034159.565501-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104034159.565501-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 07:41:59PM -0800, Florian Fainelli wrote:
> On Sun,  1 Nov 2020 15:08:03 -0500, Vivek Unune <npcomplete13@gmail.com> wrote:
> > This router has dual paritions to store trx firmware image and
> > dual partitions for nvram. The second one in each of these cases acts
> > as a backup store.
> > 
> > When tested with OpenWrt, the default partition parser causes two issues:
> > 
> > 1. It labels both nvram partitions as nvram. In factory, second one is
> > labeled devinfo.
> > 2. It parses second trx image and tries to create second 'linux' partition
> > and fails with - cannot create duplicate 'linux' partition
> > 
> > The following patch works around both of these issues.
> > 
> > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> > ---
> 
> Applied to devicetree/next, thanks!
> --
> Florian

Thanks Florian
