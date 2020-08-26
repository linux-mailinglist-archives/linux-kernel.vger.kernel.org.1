Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D306C2529F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHZJ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 05:26:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728061AbgHZJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598433975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agp/hO3HA0Z0hfUFtsmDs9RtARVSFqoaGKCQpLnO2Ok=;
        b=N3JpjTIMh+iF8460yynV+pLkmnMcPXdYwvu19bISB5HwlBZPmWa0piNz6Z5meC4FQ1dfhQ
        KomH+Kb/Ih9TdITv+90qXk7kCQ39nn4NCMohXWk98o/MtJjIK5J5zxn+ALU8SKG6ZP06vH
        FIJYIdSmxfHRNed6d9eyC6Sz7upxdCQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-o_C6btwHNUWyGY7NW-PatA-1; Wed, 26 Aug 2020 05:26:13 -0400
X-MC-Unique: o_C6btwHNUWyGY7NW-PatA-1
Received: by mail-wr1-f71.google.com with SMTP id e14so307987wrr.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=agp/hO3HA0Z0hfUFtsmDs9RtARVSFqoaGKCQpLnO2Ok=;
        b=mFZ6E+EqZo+KvyRri1JOSrQmUhNqfTpLqeqrN4RdyRV/Rf1nHHH+BX9q2EgSYIzEYh
         gece/J9YcATNw8lLpw+uMhU5Mlmz1Cifdo38Ayrm5uspAgjwk3b2PFyjKNffF8yGirx/
         9lBmUa+A4kcXmVnhTU6ZkMX8QvL9lfEASU4zD9ht2xtp4dOE8HIDlQg7tu2ZmQAov4dY
         oMuG12tcv37Sintl6rDr1n5zbSN4WMChm6rEx/cCtWlckYQb2zmAvjXky5KLShyyVtez
         17iHFe6tieuTeAZEyZG74Kjbt1k84AYTV8DmIQY2tO7dA2Hg6Kwhgjp4EBvEHtTtZAn8
         bEpQ==
X-Gm-Message-State: AOAM533uyLA8BQ+otHgxVDwE5nivVcsP+NYa8l2QeFijfAaIdQVWJEnr
        GGqdSRy578qlcYVSzD9OAAq8r+4LY9UGQMWGk3WROqq1PGFuE3QwjvWxJWHNbSsMIWgXmHYBvhs
        yALFHGX6+oyx12mIiZl2pFR/y
X-Received: by 2002:a1c:f402:: with SMTP id z2mr5905014wma.87.1598433972524;
        Wed, 26 Aug 2020 02:26:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjBNfA0JkDm5pSERTTkgDewo1suo1L4gWLGvbKyUyxju95Q1RgGFF9tew89G/0ciNae8pP+A==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr5904993wma.87.1598433972345;
        Wed, 26 Aug 2020 02:26:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j8sm4780813wrs.22.2020.08.26.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:26:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 638F2182B6D; Wed, 26 Aug 2020 11:26:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Udip Pant <udippant@fb.com>, Udip Pant <udippant@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/4] bpf: verifier: use target program's
 type for access verifications
In-Reply-To: <20200825232003.2877030-1-udippant@fb.com>
References: <20200825232003.2877030-1-udippant@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Aug 2020 11:26:11 +0200
Message-ID: <87wo1lwyfg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Udip Pant <udippant@fb.com> writes:

> This patch series adds changes in verifier to make decisions such as gran=
ting
> of read / write access or enforcement of return code status based on
> the program type of the target program while using dynamic program
> extension (of type BPF_PROG_TYPE_EXT).
>
> The BPF_PROG_TYPE_EXT type can be used to extend types such as XDP, SKB
> and others. Since the BPF_PROG_TYPE_EXT program type on itself is just a
> placeholder for those, we need this extended check for those extended
> programs to actually work with proper access, while using this option.
>
> Patch #1 includes changes in the verifier.
> Patch #2 adds selftests to verify write access on a packet for a valid=20
> extension program type
> Patch #3 adds selftests to verify proper check for the return code
> Patch #4 adds selftests to ensure access permissions and restrictions=20
> for some map types such sockmap.

Thanks for fixing this!

For the series:
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

