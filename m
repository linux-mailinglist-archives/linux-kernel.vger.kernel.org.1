Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8628A25B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgJJW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59549 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732150AbgJJTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602358828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wwQE5/V+tTnlQFbR3/c5B+uBVj5zhNMofQYLJJXLZM=;
        b=jRuFZPQU7+RANTn9J3EZ/oIh08RQ4oHV0gzPpTmTKf6OETJWGMvzi9gwEBMaJ8AgbvFEPO
        jFwgT4ZS6pKsq5lIfBnsyY0CAmIV7aMzs87f9Ph6N9vsd6hgKqF/Z9v4itj5UZ21NulYgs
        KtN8bs6wOyAJ94BQsaUurC7l3GId7Xs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-tAX3cr5cOyqPjKObzOKM8w-1; Sat, 10 Oct 2020 08:56:10 -0400
X-MC-Unique: tAX3cr5cOyqPjKObzOKM8w-1
Received: by mail-ej1-f71.google.com with SMTP id z25so4786255ejd.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 05:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9wwQE5/V+tTnlQFbR3/c5B+uBVj5zhNMofQYLJJXLZM=;
        b=bFH9OHA34yAttwsZDgCjKcBJMOCEu2odlVGSd+Iu8SvJtnqw99z6gBDMr1SZ+oszqx
         q7QGjxSI6VmbPuJLYvWM5yIJPytLgDrjH2AlGe+qdYpxgB4pcM0Qe7U7gsjBPWOFIl0a
         AmM0l9v8ljgPMZKqjD1B4FWm2+mptLTAn3U+1lVilTEYGGZp8ZtN1hyL41PsYuMvp/3F
         EqjerTVke6p/1a3Ot0yK526KzcZvitKE9CnzotID5bWoDOS9w/VPVIbo3Rc2b5wmq3Mc
         mqd0INMj4hhaBerYJS/D4PHfRfvUpU1Oh16dAd1JEk3hEluNMesSRv8EhV8i/ZZU5vpw
         aW9Q==
X-Gm-Message-State: AOAM531ep4t25H6E9OzUDXcNS5JXEcR6ZhavkV1QxQH5rpUKmlSPki2H
        PGQJJ/tcdfNpJxMZxbMiFo/Rlv7UKYXf4AbILqD6R1T2ny5yi8+Lt3hpgPFRLbL/yp1XmvVP8Dg
        6zGS+61uHyVtvFpD8AiZXs9II
X-Received: by 2002:a17:906:3e48:: with SMTP id t8mr18688301eji.104.1602334568808;
        Sat, 10 Oct 2020 05:56:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqGeOno+BRBV/rlg+E0aBfjPQLf1z7K/9GnhxG9dgxP1+VtVJne21zT5kM6ItQDINM3N3XdQ==
X-Received: by 2002:a17:906:3e48:: with SMTP id t8mr18688280eji.104.1602334568601;
        Sat, 10 Oct 2020 05:56:08 -0700 (PDT)
Received: from [10.149.91.9] (tmo-096-9.customers.d1-online.com. [80.187.96.9])
        by smtp.gmail.com with ESMTPSA id vr3sm1929820ejb.124.2020.10.10.05.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 05:56:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] page-flags: Remove unused __[Set|Clear]PagePrivate
Date:   Sat, 10 Oct 2020 14:56:07 +0200
Message-Id: <95A41DBA-4ED2-4049-A94D-E07E9DAF174E@redhat.com>
References: <e8b85ab4a7ff4a84b4081ba05ce76061@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, ziy@nvidia.com,
        alexander.h.duyck@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, steven.price@arm.com, ying.huang@intel.com,
        yang.shi@linux.alibaba.com
In-Reply-To: <e8b85ab4a7ff4a84b4081ba05ce76061@huawei.com>
To:     linmiaohe <linmiaohe@huawei.com>
X-Mailer: iPhone Mail (18A393)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 10.10.2020 um 03:53 schrieb linmiaohe <linmiaohe@huawei.com>:
>=20
> =EF=BB=BFDavid Hildenbrand <david@redhat.com> wrote:
>>> On 09.10.20 15:59, Miaohe Lin wrote:
>>> They are unused anymore.
>>=20
>> -EINVAL, sentence does not make sense :)
>>=20
>> "They are not used anymore."
>> "They are unused ."
>=20
> My poor English. ;) Will change it in v2 soon. Many Thanks.

You got it right in the subject :)

No need to resend - Andrew can fixup when applying!

Cheers!

>=20
>>=20
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>=20

