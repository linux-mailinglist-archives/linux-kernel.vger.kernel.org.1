Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E219F7B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgDFONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 10:13:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48684 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728558AbgDFONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586182387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2MelgTXjhlw+4fjd+9b4cGKMxMyBiqW0h/JEEsI35s=;
        b=csvfltUQK7MBBWfZHkW6BICUzzertUmsIFVafuhkIJM9rKp/DzdBkEAv4MOlMVmi9pkrZi
        MYs4PolmjoW6g3lBr8QeUGs8qidLT6Olh2I4RzO8Hto6BSDZTHCK5jvGX7ymLeSFtitiWy
        kLhXo0yjtXN52QFk/39RDFzCxeAxGmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-RKD7ZMzPMS2c2KNW3jdqbQ-1; Mon, 06 Apr 2020 10:13:03 -0400
X-MC-Unique: RKD7ZMzPMS2c2KNW3jdqbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C83201935780;
        Mon,  6 Apr 2020 14:13:02 +0000 (UTC)
Received: from [10.72.12.191] (ovpn-12-191.pek2.redhat.com [10.72.12.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 937DD2637B;
        Mon,  6 Apr 2020 14:12:58 +0000 (UTC)
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20200405081355.2870-1-mst@redhat.com>
 <20200406130927.GA20291@infradead.org>
 <20200406095931-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0f4f2502-e810-e87a-2fba-dc887d2f4272@redhat.com>
Date:   Mon, 6 Apr 2020 22:12:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200406095931-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/6 =E4=B8=8B=E5=8D=8810:02, Michael S. Tsirkin wrote:
> On Mon, Apr 06, 2020 at 06:09:27AM -0700, Christoph Hellwig wrote:
>> Pleae just drop the code - we should not add new drivers with custom
>> DMA ops.
> I'm not sure there's another way to do this: this not a driver, it's a
> software emulator that pretends to be an actual device. We can't
> have the platform supply DMA ops here since the platform is a regular
> x86 or whatever.


Yes, actually vdpa-sim does not depends on HAS_DMA. Maybe we can do=20
shortcut like dev->dma_ops =3D vdpasim_dma_ops;

Thanks


>

