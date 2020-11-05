Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689F02A87FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgKEUXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgKEUXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604607796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9s4iCxUrJy8sZ5v48BQSNzPK/NYW36txI5jTOwcIDbM=;
        b=IBcTBttQ5GURNoOwey+E4D3N9fbkCkzwn02NHwhRFTeI+gT3WyH35dNBlnVBN4XveFxonA
        8cCHjKYpRRK6CNiCg43BfpdEY7JxedZFmp6OfbNPYoJBJxoEPhBWLUIj1Mn5KKbxTpKUv4
        W03sNF22XTfrUXRO2oNLlAlqBV2/Eto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-6Wd1MxDIO4uff8JPsDYorw-1; Thu, 05 Nov 2020 15:23:15 -0500
X-MC-Unique: 6Wd1MxDIO4uff8JPsDYorw-1
Received: by mail-wm1-f70.google.com with SMTP id y1so1065816wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9s4iCxUrJy8sZ5v48BQSNzPK/NYW36txI5jTOwcIDbM=;
        b=e+23+Nz39I6KvDv0NEgBK+uhAdD/OPXrWW1fmkpn/1FBFakKFrCGSjrFbu+YiP7fOi
         j1KO/nJgbj20dq1YfXwawWBSB9/4V++rLbONbIAYB/LfX7sgq8qR042V2/zlIfnV92oh
         RNRvHgrd7/iBFxk0UcCkHodin7itlClJQZzGnZA9QRaOjqAtBySc0NNSf6obd5xH/IQQ
         pcUT0bet1UFEX/Ns8D/irs7SFiZXeBbprF3SzIuu/Efmw5wTqaYWTrX5ndp9eWqUKgEp
         XA8SH8nYyM/QSuAWbaYhAD/rKR6DggZr/W/C+ENsaFA5Xp30WqljMyZ8WS3hCP0ySqoS
         nFZg==
X-Gm-Message-State: AOAM530R9PUacS9KQsLZ1DWoWTfkS5U43DxkIjUNlwXMymaWpFoaNfbo
        H3V4KwbEfCzT8AYYGS4JioP8nDEIqB/tH42ugwVxpkoWpd0IFBKnUWDxYWJpMe7VPO0RTOt6PpB
        YWDfrzxegDLIYQguf9/LaYMUL
X-Received: by 2002:a1c:4302:: with SMTP id q2mr4738061wma.182.1604607793900;
        Thu, 05 Nov 2020 12:23:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfZY4A6bwP+dllFz/FodKmvN6b+11o3kRuijYOetoGQtenV8tTN+rczJKsN08Ftlb5Rvp0gA==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr4738050wma.182.1604607793741;
        Thu, 05 Nov 2020 12:23:13 -0800 (PST)
Received: from ?IPv6:2003:d8:2f34:7900:452f:9cb5:101f:444? (p200300d82f347900452f9cb5101f0444.dip0.t-ipconnect.de. [2003:d8:2f34:7900:452f:9cb5:101f:444])
        by smtp.gmail.com with ESMTPSA id e25sm4628068wrc.76.2020.11.05.12.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 12:23:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Regression: QCA6390 fails with "mm/page_alloc: place pages to tail in __free_pages_core()"
Date:   Thu, 5 Nov 2020 21:23:12 +0100
Message-Id: <C3FD015A-8E51-4752-AD76-6ABE4583E268@redhat.com>
References: <225718f1-c4b0-8683-427a-059148a39350@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
In-Reply-To: <225718f1-c4b0-8683-427a-059148a39350@gmail.com>
To:     Pavel Procopiuc <pavel.procopiuc@gmail.com>
X-Mailer: iPhone Mail (18A8395)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 05.11.2020 um 13:55 schrieb Pavel Procopiuc <pavel.procopiuc@gmail.com>=
:
>=20
> =EF=BB=BFOp 05.11.2020 om 12:13 schreef David Hildenbrand:
>> It depends in which order memory is exposed to MM, which might depend on o=
ther factors in some configurations.
>> This smells like it exposes an existing bug. Can you reproduce also with z=
one shuffling enabled?
>=20
> So just to make sure I understand you correctly, you'd like to see if the p=
roblem with ath11k driver on my hardware persists when I boot pristine 5.10-=
rc2 kernel (without reverting commit 7fef431be9c9ac255838a9578331567b9dba447=
7) and with page_alloc.shuffle=3D1, right?
>=20

Right, but as lists are randomized then it might take a couple of tries to r=
eproduce. I=E2=80=98ll have a look at the driver code / failing path on Mond=
ay, when back to work.

Cheers!=

