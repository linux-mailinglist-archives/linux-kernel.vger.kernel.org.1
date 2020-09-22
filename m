Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06E3273F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIVKBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIVKBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600768871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TilmuF3NABOtIHa4EkAnwA7L+b+pAv6qVaPXaLjKBSY=;
        b=ehQHH5lEkUdxrUkV+WNBuWVJSoKxLt+abhZLFhvDfgr3uCkwyF/woLB6NnjQD11yuWH28C
        aBb0+2XaaW1Qseg+wcZsBKAQ5ERRkMpYBwDoIJVuyWj4+itMPicpMpyfG815nuOIq10JIJ
        z61mqgx4xJH85GdbUJUC/8ftDAM+968=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-yKz6bfK1Mui8iIiKYPM4Ag-1; Tue, 22 Sep 2020 06:01:07 -0400
X-MC-Unique: yKz6bfK1Mui8iIiKYPM4Ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 806E21007465;
        Tue, 22 Sep 2020 10:01:06 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-108.ams2.redhat.com [10.36.114.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3891D5577B;
        Tue, 22 Sep 2020 10:01:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jonathan Wakely <jwakely@redhat.com>
Cc:     Alejandro Colomar <colomar.6.4.3@gmail.com>,
        Ville Voutilainen <ville.voutilainen@gmail.com>,
        gcc@gcc.gnu.org, libstdc++ <libstdc++@gcc.gnu.org>,
        Libc-alpha <libc-alpha@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-coord@lists.openwall.com
Subject: Re: Expose 'array_length()' macro in <sys/param.h>
References: <946e9377-0558-3adf-3eb9-38c507afe2d0@gmail.com>
        <874knr8qyl.fsf@oldenburg2.str.redhat.com>
        <dbcf5c85-c468-72f8-0f83-92ec2a6a2991@gmail.com>
        <875z875si2.fsf@oldenburg2.str.redhat.com>
        <20200921140100.GA449323@redhat.com>
        <e734429a-d543-7e75-48e9-a8297a94b035@gmail.com>
        <20200921220443.GP6061@redhat.com>
        <CAFk2RUbEtvgFb_FZmcM9L4-g1kG_E7S2p9gveM0Z5Fe=zEDm9w@mail.gmail.com>
        <34bae433-f67e-877d-f871-928cb55d2a87@gmail.com>
        <20200922094020.GS6061@redhat.com>
Date:   Tue, 22 Sep 2020 12:01:02 +0200
In-Reply-To: <20200922094020.GS6061@redhat.com> (Jonathan Wakely's message of
        "Tue, 22 Sep 2020 10:40:20 +0100")
Message-ID: <87k0wmyvtt.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonathan Wakely:

> I don't see much point in using std::size here. If you're going to
> provide the alternative implementation for when std::size isn't
> defined, why not just use it always?
>
> template<typename _Tp, std::size_t _Num>
> #if __cplusplus >= 201103L
> constexpr
> #endif
> inline std::size_t
> __array_length(const _Tp(&)[_Num]) __THROW
> {
>   return _Num;
> }
>
> This only requires <cstddef>, not <iterator>.

I agree that this is an advantage.  But the version without constexpr is
not sufficient because __array_length does not produce a constant
expression.

I've seen something like this used instead:

  template<typename _Tp, std::size_t _Num>
  char (&___array_length(const _Tp(&)[_Num]))[_Num];
  #define __array_length(v) (sizeof(___array_length(v)))

If the function type is too cute, a helper struct could be used instead.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

