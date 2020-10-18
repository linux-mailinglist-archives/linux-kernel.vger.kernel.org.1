Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5EE29185C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 18:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgJRQe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 12:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgJRQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 12:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603038866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OQ9GqIpXNZUq0RyT7/UOYX7bWD6BBz65MJ1fbErdN4=;
        b=Q1sgl47OPsgkY7tAd5SBx8NdrIqryqwshMH5QUZSxFzdbUc22ywzPGzbm6wn0rQ+32SVlm
        CAKSNR7JenCwHVFAEmEatDJF3xIbAtawjoOoDpc05U3agZqyFm5ejFv/Ekk6XTs8CWhyj5
        3S9WdAtGZbAtk51qh5FOVIw/YMRCgx0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-ichgYefaMhyLwZIHNVeFdw-1; Sun, 18 Oct 2020 12:34:24 -0400
X-MC-Unique: ichgYefaMhyLwZIHNVeFdw-1
Received: by mail-ej1-f72.google.com with SMTP id c10so3691271ejm.15
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 09:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5OQ9GqIpXNZUq0RyT7/UOYX7bWD6BBz65MJ1fbErdN4=;
        b=CgKcLTfadr6EGogwj/pAXFTvu0qaJ0usTQHNucdFRLVltynARpMswviJNThAKzB9se
         4vQeFSgDmPPEunJ4sFFx3hRuZo7GdFwZRvcY9g6l0MxDUl9lF0B97XUdoBZ+28on8DGY
         0kGZohKUDJaj9G2guubYA2qKM0asa1gAR//jU1pU9sljOFRPl2alzW7wBq4u2pzpGJnJ
         SoGhibwuOmFFHfGWl3CVOFABrnjWW+4ZcgJe+ltG2ropBIuwO50ZZ6tmovzd3nIPDMKv
         1TagiBxxRFoddau9ISzJwldR//pU9Nydu7f2xQDndAActTQ3Tu5RRbvz6AsjZlJ9De6Q
         4ToQ==
X-Gm-Message-State: AOAM5330UYG/hLykrNowE/+Z9mgcP9IrOEwKlOWJYZHNsDRKCZXCm6p3
        /0UcouIJMAlzPPhXnl37/2XWWBHFQBcqbGwlzuU8t5PWzP9lzb7ddnfV8qY863nUaq/b2og9mHY
        Le+6L8tIsw0TRl95WiQDcaETB
X-Received: by 2002:a50:8e5a:: with SMTP id 26mr14602827edx.161.1603038863244;
        Sun, 18 Oct 2020 09:34:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyuH9POxrGvtu+LMKcbrcV/4vICqK4liEhBDN37HvQGacvH9EfF3s6tT5q2bHufDhLBfH4Wg==
X-Received: by 2002:a50:8e5a:: with SMTP id 26mr14602809edx.161.1603038863027;
        Sun, 18 Oct 2020 09:34:23 -0700 (PDT)
Received: from [192.168.3.114] (p4ff233d0.dip0.t-ipconnect.de. [79.242.51.208])
        by smtp.gmail.com with ESMTPSA id v14sm7677245ejh.6.2020.10.18.09.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 09:34:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 00/29] virtio-mem: Big Block Mode (BBM)
Date:   Sun, 18 Oct 2020 18:34:21 +0200
Message-Id: <ED93C2B5-67F0-4FFA-8FF1-4545B86456FA@redhat.com>
References: <20201018112849-mutt-send-email-mst@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
In-Reply-To: <20201018112849-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 18.10.2020 um 17:29 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Mon, Oct 12, 2020 at 02:52:54PM +0200, David Hildenbrand wrote=
:
>> virtio-mem currently only supports device block sizes that span at most
>> a single Linux memory block. For example, gigantic pages in the hyperviso=
r
>> result on x86-64 in a device block size of 1 GiB - when the Linux memory
>> block size is 128 MiB, we cannot support such devices (we fail loading th=
e
>> driver). Of course, we want to support any device block size in any Linux=

>> VM.
>>=20
>> Bigger device block sizes will become especially important once supportin=
g
>> VFIO in QEMU - each device block has to be mapped separately, and the
>> maximum number of mappings for VFIO is 64k. So we usually want blocks in
>> the gigabyte range when wanting to grow the VM big.
>=20
> I guess it missed this Linux right? There's an mm change which did not
> get an ack from mm mainatiners, so I can't merge it ...

No issue, I was targeting 5.11 either way! I=E2=80=98ll resend based on linu=
s=E2=80=98 tree now that all prereqs are upstream.=

