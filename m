Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6701AB9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439298AbgDPHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438944AbgDPHd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:33:29 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC8C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:33:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b62so20327971qkf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qnap.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UUNY3ShQiEMlKdA2OtEmjXgSE2HQo1VpKsXAZEAB++8=;
        b=hAAkkXoJSeTZMtgLyumWdDpGnE/XBC+aHvFhGPPys8ToYyqHksL4ZpwqW5T+JaRcXl
         o43Nn1KGZaVBKhFR5FOvCjbaxWqLrHV8OuMXkvtnh//zZQZGZaqTPXCj5qByMUT5RFbh
         SJPoK/fhkM3ssd3iqshhMe81Lr0zwvKA7RXU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UUNY3ShQiEMlKdA2OtEmjXgSE2HQo1VpKsXAZEAB++8=;
        b=te7NaiGbIpNyIzz4bbuNq0JUyxzwZnZ4VdcyPSqgzm3WK/cZECLDrxSV+l4NBGm5cx
         y6anWvZ4hgEnICUnH1i2Kyv5ewLB79a30p9/6ntmzMbzIchZNT0i+BwCVNdA1SX9t6LE
         2E9XHm/ELniEbWNF7vS8uv09w1Y+XT5TGtMZFt87ndWXj05E4tJ8YDyXVWskR7I3UAm+
         U3R6qZowLhjzOJUplIhIE2QIWOv2prtAFe4Y40XoK+PZBVcj5YEu4+Q+r5wNyP3qZql+
         r6a6z6HAblehBBFDt1g2DyH4iepJlW35ipVrxrIBlnS6tNYKDnVvsIIhsrZcQY8t+cls
         yZKw==
X-Gm-Message-State: AGi0PuYQv9XT6xqXu92HTHV3nBq7lAZx8gYqrsiG6wDDb3lKUCWTET6D
        GUYV/Vw73q75XohYfB5UefjSaIZpvwoYUjleGQge3Q==
X-Google-Smtp-Source: APiQypLjMQQF6xFJgGIcXivLrWGvnotQ+D6p4pL53qIa6tvjRUBiKhdEepCEpb+H3UzPYGRtQEGOvPOSLCAH19n/LJg=
X-Received: by 2002:a37:8b04:: with SMTP id n4mr30253412qkd.222.1587022408701;
 Thu, 16 Apr 2020 00:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUGjKiLPQP9wp0AgLUvHgKBOe9We2a-RQaZ7cd7CvhnarwWiw@mail.gmail.com>
 <CAKywueT0Q9WkANNsg8cEDwGZSMaaE5c4LHuEeMhVDzJAzycroQ@mail.gmail.com>
 <CAEUGjKhSBNQboKOMFMgos9OQfxcLQZsXp8aBrUSFcaSe1saH2Q@mail.gmail.com>
 <CAH2r5mt1k5t8rSH1KizeSrcLaN1Fn3GWeMvDPwT2Kfq43UAWaQ@mail.gmail.com> <CAEUGjKhpgmhj9RzcGQXPuFUyoqsUnk2d3oCpOYBdR=EwCO21YQ@mail.gmail.com>
In-Reply-To: <CAEUGjKhpgmhj9RzcGQXPuFUyoqsUnk2d3oCpOYBdR=EwCO21YQ@mail.gmail.com>
From:   Jones Syue <jonessyue@qnap.com>
Date:   Thu, 16 Apr 2020 15:33:18 +0800
Message-ID: <CAEUGjKh5mj0rFUZPoguFh4G-_YfwACV+_jVK7TNi+jK_fE1dgQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: improve read performance for page size 64KB &
 cache=strict & vers=2.1+
To:     Steve French <smfrench@gmail.com>
Cc:     Pavel Shilovsky <piastryyy@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Samba Technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve

> Test read performance over 1GbE network with command:
Also test read performance over 10GbE network,
vers=3D2.1+ can reach over 600 MB/s with v2.patch.

aarch64, page size 64KB (CONFIG_ARM64_64K_PAGES=3Dy), linux-4.2.8,
cpu Annapurna Labs Alpine AL324 Quad-core ARM Cortex-A57 CPU @ 1.70GHz,
ram 8GB,
with patch,
vers=3D1.0,cache=3Dstrict: read throughput 110MB/s, max read IO size 16KB
vers=3D2.0,cache=3Dstrict: read throughput 106MB/s, max read IO size 16KB
vers=3D2.1,cache=3Dstrict: read throughput 667MB/s, max read IO size 1MB
vers=3D3.0,cache=3Dstrict: read throughput 639MB/s, max read IO size 1MB
without patch,
vers=3D1.0,cache=3Dstrict: read throughput 107MB/s, max read IO size 16KB
vers=3D2.0,cache=3Dstrict: read throughput 107MB/s, max read IO size 16KB
vers=3D2.1,cache=3Dstrict: read throughput 106MB/s, max read IO size 16KB
vers=3D3.0,cache=3Dstrict: read throughput 106MB/s, max read IO size 16KB

command:
mount -tcifs //<server_ip>/<share> /remote_strict
-overs=3D<x.y>,cache=3Dstrict,username=3D<uu>,password=3D<pp>
dd if=3D/remote_strict/10G.img of=3D/dev/null bs=3D1M count=3D10240

--
Regards,
Jones Syue | =E8=96=9B=E6=87=B7=E5=AE=97
QNAP Systems, Inc.

On Thu, Apr 16, 2020 at 11:46 AM Jones Syue <jonessyue@qnap.com> wrote:
>
> Hello Steve
>
> > Did you also test (at least briefly) with vers=3D1.0 since some of your
> > code affects that code path too?
>
> Yes test v2.patch on 2 platforms aarch64 (page size 64KB) and x86_64
> (page size 4KB), vers=3D1.0 read function works fine on both.
>
> Test read performance over 1GbE network with command:
> 'dd if=3D/remote_strict/10G.img of=3D/dev/null bs=3D1M count=3D10240'
>
> For read performance on aarch64 (page size 64KB), vers=3D[1.0|2.0] is not=
 as
> fast as vers=3D2.1+, max_read on both SMB 1 (16KB) and SMB 2.0 (64KB) are
> still smaller then page size 64KB plus packet header size, hence do not
> support readpages.
> aarch64, page size 64KB (CONFIG_ARM64_64K_PAGES=3Dy), linux-4.2.8,
> cpu Annapurna Labs Alpine AL324 Quad-core ARM Cortex-A57 CPU @ 1.70GHz,
> ram 8GB,
> with patch,
> vers=3D1.0,cache=3Dstrict: read throughput 40MB/s, max read IO size 16KB
> vers=3D2.0,cache=3Dstrict: read throughput 40MB/s, max read IO size 16KB
> vers=3D2.1,cache=3Dstrict: read throughput 115MB/s, max read IO size 1MB
> vers=3D3.0,cache=3Dstrict: read throughput 115MB/s, max read IO size 1MB
> without patch,
> vers=3D1.0,cache=3Dstrict: read throughput 40MB/s, max read IO size 16KB
> vers=3D2.0,cache=3Dstrict: read throughput 40MB/s, max read IO size 16KB
> vers=3D2.1,cache=3Dstrict: read throughput 40MB/s, max read IO size 16KB
> vers=3D3.0,cache=3Dstrict: read throughput 40MB/s, max read IO size 16KB
>
> For read performance on x86_64 (page size 4KB), all vers can support
> readpages because max_read is bigger than page size 4KB plus packet heade=
r
> size.
> x86_64, page size 4KB, linux-4.2.8,
> cpu AMD Embedded R-Series RX-421ND 2.10GHz,
> ram 4GB,
> without patch,
> vers=3D1.0,cache=3Dstrict: read throughput 109MB/s, read IO size 60KB
> vers=3D2.0,cache=3Dstrict: read throughput 115MB/s, read IO size 64KB
> vers=3D2.1,cache=3Dstrict: read throughput 117MB/s, read IO size 1MB
> vers=3D3.0,cache=3Dstrict: read throughput 117MB/s, read IO size 1MB
> with patch,
> vers=3D1.0,cache=3Dstrict: read throughput 110MB/s, read IO size 60KB
> vers=3D2.0,cache=3Dstrict: read throughput 115MB/s, read IO size 64KB
> vers=3D2.1,cache=3Dstrict: read throughput 117MB/s, read IO size 1MB
> vers=3D3.0,cache=3Dstrict: read throughput 117MB/s, read IO size 1MB
>
> > And if anyone figures out how to configure an x86_64 Linux to use
> > PAGE_SIZE of 64K or larger let me know...
> I am using physical platform with arm cpu and aarch64 toolchain,
> perhaps try qemu-system-aarch64 later.
>
> --
> Regards,
> Jones Syue | =E8=96=9B=E6=87=B7=E5=AE=97
> QNAP Systems, Inc.
