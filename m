Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B16276B07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgIXHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:41:48 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIXHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:41:48 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MnItm-1kkojW25RM-00jJjV for <linux-kernel@vger.kernel.org>; Thu, 24 Sep
 2020 09:41:46 +0200
Received: by mail-qk1-f177.google.com with SMTP id o5so2389223qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:41:46 -0700 (PDT)
X-Gm-Message-State: AOAM532xeV1lg5kwmy8dpfsUomsdiXVlWJGZIr+v8QhLPi8bgH6MX/Zt
        RRJK/cWsmOnINNhB2KBqHbYYFfNl4zMTqptt+bg=
X-Google-Smtp-Source: ABdhPJxM2pDsMTKQfH8hTCM5WXvnJ6sEPs++KqK+Q2tfdBXNS0dmo7GzjWYSudq5koXbP/6NrtYWQKHllCSeasmcPZE=
X-Received: by 2002:a37:a483:: with SMTP id n125mr3539206qke.286.1600933305400;
 Thu, 24 Sep 2020 00:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com> <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
 <cfed1f74-653c-565b-ea91-877c4e1f63a0@gmail.com> <CAK8P3a0_i=wHnQmfbjCdMgFRSD0eGjEM2uMFft5FJ4M1GSUbHg@mail.gmail.com>
 <5d470a61-bf4d-7ea2-b41f-1163006b1956@gmail.com>
In-Reply-To: <5d470a61-bf4d-7ea2-b41f-1163006b1956@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Sep 2020 09:41:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3HWjyaxwN3gyFEcJ9P=iHPvYXsL=C2kEg1hDmJvNm1tQ@mail.gmail.com>
Message-ID: <CAK8P3a3HWjyaxwN3gyFEcJ9P=iHPvYXsL=C2kEg1hDmJvNm1tQ@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JbUla8JeM7TxTu+ox1J1UfA/wY+RcVXyZTTXvAkvE3Za6rZ9knz
 OZdO4aqJHAJm2LTnun9RpqqBE3q7eqRqXGnZ+psmm/DQ6LVUr+C8j7vAJloNRB+NtT9jTCi
 TvYkBo7or67wAEO7mZZ497Ka7nequjDCE9IyPvAep9FHGxcZheFkdUv/o+rioa9LHAizZ3K
 713u1vZkxJ9oC1+YxM5RQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Zf7aTsGbu8=:APPVZUM52dakK5tGC52SWN
 MiCo3/OrcMoQkom/YmMYqb1fZpVciMhtZBHgJm8micDA7coMhtBSSpWopr3R9adKy6M1TQDx9
 7S+SQcDFabk/nKz+GHueTakCHtJYLFRjoeE80eyMLO8ztcUirCehs4v5/arAbP+DGK/KmrhEY
 88YRElooQ/aPxWCh2q2N+100BSqwtebPB0FEptz0qzKFvnOc5iauS8TZJXTPV4bniWJT4FSmp
 hgYuxeGLixclqEA8bhwOHCdf1uz8otK71gXfNNhJsfYoQSyAk8HCWML4GG4oXItd0d1AGdgYV
 YuVZS2hC8a1oaelWCNEP9hcrEQjQdEAChDX09HdzDUTwY3jM+Ycm7kBImSZsVNFmWFSg87nQB
 /5YTtXX6o9EwPJ4fReL3oWIZgjgcL0DUP0cJB7kZehqBDjw4OMncABCc2YrwsDPXITHEl9b6U
 E/AKnZBS4vmMxCgIsDl1WDGTlXU9M9R0TtOgkKFtPCy4XOw701wm+RntssOilWpNKRbrSZWS7
 5lZdZ+9Z3FVR91UPg+L5EW+oM8sgCtDVEqBDrSeQJT8O5MVdNt2Fh/ga85p80y0dxTY7Sabfd
 2CI9lvlSaGOVvZGihBvkvFX7xmswYqtJWZUWbGn2i/4VfEN/imM2/OdZArPvStCvdlGIWKURl
 6Ano4YkLtM3c8wbSQzQAN/Sa5K8LXAJi3tIpK4fnlpwfFu4HaZ5MtzVVAGdZ4OSOGTVwDYPLZ
 5M98mexj5e4hzjmdwyCg/3lQGgWIVoZN8sVXTScnTpsFqCdXL1kXi6JGsZWHj8UgHtnpkYF3l
 dT9VNPSN0nJT5CWQiHC1MjZuCQcDv2sjnWF1QTemOCGWv5vimWnpzccH8Vscz/1MxQro8he
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:23 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> On 9/23/20 8:51 PM, Arnd Bergmann wrote:
> > On Wed, Sep 23, 2020 at 8:29 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> >> On 9/23/20 6:48 PM, Arnd Bergmann wrote:
> >
> > The version I showed avoids the pointers and is compatible with
> > 32-bit user space.
>
> I'm not completely convinced yet that the read/write approach is the way
> I want to do it, especially with Greg suggesting a misc device, but I'll
> keep your solution in mind.

In case of a character device, I'd go with an ioctl to keep it extensible.

The read/write based interface is what I'd use in debugfs.

      Arnd
