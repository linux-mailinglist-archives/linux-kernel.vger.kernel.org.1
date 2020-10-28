Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F4A29E1D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgJ2CEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgJ1VnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grsrDmScQg/7CchDudKF7+xGExagB0pI7A6n0ZS4Tvs=;
        b=SUyGE1X3PyUn96+cLhV1kJm8OsK50lO8iLoWktCzU3ypz4UDba9Klri5ltJ5uycOD/+zC9
        aiIFoLJZ+Pn1qc0RT9J87J+yy0QdW8kuHuCJk+ewYldbWrJcjFz7PArGpY2/ZMjo/C51i8
        UhLTVBaueRetecjP2+YK1CU9b2a9qK8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-ipFmOg3GPGmuUhDsawEMvQ-1; Wed, 28 Oct 2020 17:42:59 -0400
X-MC-Unique: ipFmOg3GPGmuUhDsawEMvQ-1
Received: by mail-qv1-f72.google.com with SMTP id l1so560829qvr.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grsrDmScQg/7CchDudKF7+xGExagB0pI7A6n0ZS4Tvs=;
        b=ELwMRGUoNtI8oh63dAJKtxzGwXUep0Cmfg1vb/fmgP+pI0O5YIckXECw9Iq0mdPcdK
         QptK8FmTZBm051ozwVl6oRKyJM+vu/o0SaiOBP1ipUNNxQVWfHRKe8Ox6WlMQtWGLjBe
         c7fgMSwnve2xJCjHe4yb0N8A0pcbcpvVlLmBzLMyusfOIpm9g9C5KT7U+5TT5mhgzLBV
         la3isxeuKXOtbZfF8+EbDWeDAdye8bdyDit90yK+mwdN0QCxd8HN7WSZ0m/koNSS8rrP
         v55svONPVOOz81C3NtFxO6n+rxYseQ8IRFBCO+yZCTbIM4mY9e8TxjLJXS+DH9c6YC/h
         fMZw==
X-Gm-Message-State: AOAM533FV2EDJFRJAjpMbUafOs7TDNnMnsqOJwdFwtPOTPRSZ1Bd9HhJ
        VtztAM1g3E25kt0tY+KPMENp08jfjuCGqxK1LxtJNbAx4XUunpiXV6PhtU1bHBrv5SwCm7Tyo7t
        HDDh8SA5o1hG0/EaaCoKwZJryD7TPxWm0ttAqQzXD
X-Received: by 2002:a37:8542:: with SMTP id h63mr941206qkd.102.1603921378884;
        Wed, 28 Oct 2020 14:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbl4uDNWjzMTK3+styptRLBCtkBZ2fw1p+2J0J4m60L0jC7kvcirPiI4FpA37Rxh2PKX+RSbbSACEWMb0WJsA=
X-Received: by 2002:a37:8542:: with SMTP id h63mr941197qkd.102.1603921378676;
 Wed, 28 Oct 2020 14:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <202010092326.20482.linux@zary.sk> <CAKb7UvggVn2c=jUNSfjf6r529n89xfNgVBpn3jnXznVh8Gs4+w@mail.gmail.com>
 <CACO55tuAxbcXbC9zrT5rs34s=5uBugkbcikORU5868ka9bHdkw@mail.gmail.com> <202010282115.32811.linux@zary.sk>
In-Reply-To: <202010282115.32811.linux@zary.sk>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 28 Oct 2020 22:42:47 +0100
Message-ID: <CACO55tvqB0tEbHegRCn6WNdv-wzZz1+be=u5O0q9SrSj1x1tGw@mail.gmail.com>
Subject: Re: [Nouveau] nouveau broken on Riva TNT2 in 5.9.0-rc8: GPU not
 supported on big-endian
To:     Ondrej Zary <linux@zary.sk>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I sent a patch to the mailing list and wanted to have some review on
that from at least Ben, but no idea if Ben already picked it and if
it's good enough for sending it to stable yet.

